<#
.SYNOPSIS
    Return a markdown formatted value for the given property.
.DESCRIPTION
    Return the value for the given property optionally formatted as a Header.
.PARAMETER HelpDoc
    A HelpDoc object.
.PARAMETER Property
    A top level property from the Help object. Valid values are `'Name'`, `'Author'`, `'Description'`, `'HelpInfoUri'`, `'LicenseUri'`, `'ProjectUri'`, and `'Version'`.
.PARAMETER H1
    Format the property value as an H1 header.
.PARAMETER H2
    Format the property value as an H2 header.
.PARAMETER H3
    Format the property value as an H3 header.
.NOTES
    If no Header switch is provided, the default is no formatting.
.LINK
    New-HelpDoc
.LINK
    Get-HelpModuleData
.EXAMPLE
    Get-HelpModuleData build-docs | New-HelpDoc | Add-ModuleProperty -Property Name -H1
    Name                           Value
    ----                           -----
    Text                           # build-docs…
    PSTypeName                     HelpModuleReadme
    HelpModuleData                 @{Name=build-docs; Commands=System.Object[]; Author=System.Object[]; Description=System.Object[]; …
#>
function Add-ModuleProperty {
    [CmdletBinding(DefaultParameterSetName = "NoH")]
    param (
        [Parameter(Mandatory, Position = 1, ValueFromPipeline, ParameterSetName = "NoH")]
        [Parameter(Mandatory, Position = 1, ValueFromPipeline, ParameterSetName = "H1")]
        [Parameter(Mandatory, Position = 1, ValueFromPipeline, ParameterSetName = "H2")]
        [Parameter(Mandatory, Position = 1, ValueFromPipeline, ParameterSetName = "H3")]
        [PSCustomObject]
        $HelpDoc,

        [Parameter(Mandatory, Position = 0, ParameterSetName = "NoH")]
        [Parameter(Mandatory, Position = 0, ParameterSetName = "H1")]
        [Parameter(Mandatory, Position = 0, ParameterSetName = "H2")]
        [Parameter(Mandatory, Position = 0, ParameterSetName = "H3")]
        [ValidateSet('Name', 'Author', 'Description', 'HelpInfoUri', 'LicenseUri', 'ProjectUri', 'Version')]
        [string]
        $Property,

        [Parameter(ParameterSetName = "H1")]
        [Switch]
        $H1,

        [Parameter(ParameterSetName = "H2")]
        [Switch]
        $H2,

        [Parameter(ParameterSetName = "H3")]
        [Switch]
        $H3
    )

    begin {

    }

    process {
        $heading = [string]::Empty
        switch ($true) {
            $H1 { $heading = '# ' }
            $H2 { $heading = '## ' }
            $H3 { $heading = '### ' }
            Default {}
        }

        $HelpDoc.Text += '{0}{1}{2}{2}' -f $heading, $HelpDoc.HelpModuleData.$Property, [System.Environment]::NewLine
        $HelpDoc | Write-Output
    }

    end {

    }
}