#! /usr/bin/pwsh

[CmdletBinding()]
param (
    [Parameter(Position = 0)]
    [ValidateSet('clean', 'build', 'test', 'changelog', 'publish', 'docs')]
    [string[]]
    $Task,

    [Parameter(Position = 1)]
    [int]
    $Major,

    [Parameter(Position = 2)]
    [int]
    $Minor,

    [Parameter(Position = 3)]
    [int]
    $Build,

    [Parameter(Position = 4)]
    [int]
    $Revision,

    [Parameter(Position = 5)]
    [string]
    $Prerelease
)

if ( (Get-Command 'nbgv' -CommandType Application -ErrorAction SilentlyContinue) ) {
    if (!$PSBoundParameters.ContainsKey('Major')) { $Major = $(nbgv get-version -v VersionMajor) }
    if (!$PSBoundParameters.ContainsKey('Minor')) { $Minor = $(nbgv get-version -v VersionMinor) }
    if (!$PSBoundParameters.ContainsKey('Build')) { $Build = $(nbgv get-version -v BuildNumber) }
    if (!$PSBoundParameters.ContainsKey('Revision')) { $Revision = $(nbgv get-version -v VersionRevision) }
}

$module = 'Build-Docs'
$parent = $PSScriptRoot
$parent = if ([string]::IsNullOrEmpty($parent)) { $pwd.Path } else { $parent }
$src = Join-Path $parent -ChildPath "src"
$docs = Join-Path $parent -ChildPath "docs"
$publish = [System.IO.Path]::Combine($parent, "publish", $module)

Write-Host "src: $src"
Write-Host "docs: $docs"
Write-Host "publish: $publish"
Write-Host "dotnet: $([Environment]::Version)"
Write-Host "ps: $($PSVersionTable.PSVersion)"

$manifest = @{
    Path                 = Join-Path -Path $publish -ChildPath "$module.psd1"
    Author               = 'Chris Hunt'
    CompanyName          = 'Chris Hunt'
    Copyright            = '(c) Chris Hunt. All rights reserved.'
    CompatiblePSEditions = @("Desktop", "Core")
    Description          = 'Helper for building markdown docs from PowerShell Command Help.'
    GUID                 = 'c03aab87-384b-400f-88ac-c0d1ed494e66'
    LicenseUri           = "https://github.com/cdhunt/$module/blob/main/LICENSE"
    FunctionsToExport    = @()
    ModuleVersion        = [version]::new($Major, $Minor, $Build, $Revision)
    PowerShellVersion    = '5.1'
    ProjectUri           = "https://github.com/cdhunt/$module"
    RootModule           = "$module.psm1"
    Tags                 = @('development')
    RequiredModules      = @()
    CmdletsToExport      = ''
    VariablesToExport    = ''
    AliasesToExport      = ''
}

function Clean {
    param ()

    if (Test-Path $publish) {
        Remove-Item -Path $publish -Recurse -Force
    }
}

function Dependencies {
    param ()

    Foreach ($mod in $manifest.RequiredModules) {
        if ($null -eq (Get-Module -Name $mod.ModuleName -ListAvailable | Where-Object { [version]$_.Version -ge [version]$mod.ModuleVersion })) {
            Install-Module $mod.ModuleName -RequiredVersion $mod.ModuleVersion -Scope CurrentUser -Confirm:$false -Force
        }
    }

}

function Build {
    param ()

    New-Item -Path $publish -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

    Copy-Item -Path "$src/$module.psm1" -Destination $publish
    Copy-Item -Path @("$parent/LICENSE", "$parent/README.md") -Destination $publish -ErrorAction SilentlyContinue

    $privateFunctions = Get-ChildItem -Path "$src/private/*.ps1" -ErrorAction SilentlyContinue
    $publicFunctions = Get-ChildItem -Path "$src/public/*.ps1"

    New-Item -Path "$publish/private" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
    foreach ($function in $privateFunctions) {
        Copy-Item -Path $function.FullName -Destination "$publish/private/$($function.Name)"
        '. "$PSSCriptRoot/private/{0}"' -f $function.Name | Add-Content "$publish/$module.psm1"
    }

    New-Item -Path "$publish/public" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
    foreach ($function in $publicFunctions) {
        Copy-Item -Path $function.FullName -Destination "$publish/public/$($function.Name)"
        '. "$PSSCriptRoot/public/{0}"' -f $function.Name | Add-Content "$publish/$module.psm1"
        $manifest.FunctionsToExport += $function.BaseName
    }

    if ($PSBoundParameters.ContainsKey('Prerelease')) {
        $manifest.Add('Prerelease', $PreRelease)
    }

    New-ModuleManifest @manifest

}

function Test {
    param ()

    if ($null -eq (Get-Module Pester -ListAvailable)) {
        Install-Module -Name Pester -Confirm:$false -Force
    }

    Invoke-Pester -Path test -Output detailed
}


function ChangeLog {
    param ()
    "# Changelog"

    # Start log at >0.1.11
    for ($m = $Minor; $m -ge 1; $m--) {
        for ($b = $Build; $b -gt 11; $b--) {
            "## v$Major.$m.$b"
            nbgv get-commits "$Major.$m.$b" | ForEach-Object {
                $hash, $ver, $message = $_.split(' ')
                $shortHash = $hash.Substring(0, 7)

                "- [$shortHash](https://github.com/cdhunt/potel/commit/$hash) $($message -join ' ')"
            }
        }
    }
}

function Commit {
    param ()

    git rev-parse --short HEAD
}

function Publish {
    param ()

    <# Disabled for now
    $docChanges = git status docs -s

    if ($docChanges.count -gt 0) {
        Write-Warning "There are pending Docs change. Run './build.ps1 docs', review and commit updated docs."
    }
    #>

    $repo = if ($env:PSPublishRepo) { $env:PSPublishRepo } else { 'PSGallery' }

    $notes = ChangeLog
    Publish-Module -Path $publish -Repository $repo -NuGetApiKey $env:PSPublishApiKey -ReleaseNotes $notes
}

function Docs {
    param ()

    if ($null -eq (Get-Module Build-Docs -ListAvailable | Where-Object { [version]$_.Version -ge [version]"0.2.0.2" })) {
        Install-Module -Name Build-Docs -MinimumVersion 0.2.0.2 -Confirm:$false -Force
    }

    Import-Module $publish -Force

    $help = Get-HelpModuleData $module

    # docs/README.md
    $help | New-HelpDoc |
    Add-ModuleProperty Name -H1 |
    Add-ModuleProperty Description |
    Add-HelpDocText "Commands" -H2 |
    Add-ModuleCommand -AsLinks |
    Out-HelpDoc -Path 'docs/README.md'

    # Individual Commands
    foreach ($command in $help.Commands) {
        $name = $command.Name
        $doc = New-HelpDoc -HelpModuleData $help
        $doc.Text = $command.ToMD()
        $doc | Out-HelpDoc -Path "docs/$name.md"
    }

    ChangeLog | Set-Content -Path "$parent/Changelog.md"
}

switch ($Task) {
    { $_ -contains 'clean' } {
        Clean
    }
    { $_ -contains 'build' } {
        Clean
        Build
    }
    { $_ -contains 'test' } {
        Dependencies
        Test
    }
    { $_ -contains 'changelog' } {
        ChangeLog
    }
    { $_ -contains 'publish' } {
        Dependencies
        Publish
    }
    { $_ -contains 'docs' } {
        Dependencies
        Docs
    }
    Default {
        Clean
        Build
    }
}