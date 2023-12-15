function Get-HelpModuleData {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName)]
        [String]
        $Name
    )

    begin {
        $moduleToMd = [scriptblock] {
            param([string]$heading = '#')

            '{0} {1}{2}' -f $heading, $this.Name, [System.Environment]::NewLine



            '{0}# Commands{1}' -f $heading, [System.Environment]::NewLine

            foreach ($command in $this.Commands) {
                '- [{0}]({0}.md) {1}' -f $command.Name, $command.Synopsis
            }
        }
    }

    process {
        $module = Get-Module -Name $Name
        $commands = $module.ExportedFunctions.Keys

        $moduleData = [PSCustomObject]@{
            PSTypeName      = 'HelpModuleData'
            Name            = $Name
            Commands        = $commands | Get-HelpCommandData
            Author          = $module.Author
            Description     = $module.Description
            HelpInfoUri     = $module.HelpInfoUri
            LicenseUri      = $module.LicenseUri
            ProjectUri      = $module.ProjectUri
            RequiredModules = $module.RequiredModules
            Tags            = $module.Tags
            Version         = $module.Version
        }

        $moduleData | Add-Member -MemberType ScriptMethod -Name ToMD -Value $moduleToMd
        $moduleData | Write-Output

    }

    end {

    }
}