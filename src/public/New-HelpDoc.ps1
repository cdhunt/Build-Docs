<#
.SYNOPSIS
    Returns an empty HelpModuleReadme object.
.DESCRIPTION
    Returns an empty HelpModuleReadme object that is the object representation of your documentation.
.PARAMETER HelpModuleData
    A HelpModuleData object.
.LINK
    Get-HelpModuleData
.LINK
    Out-HelpDoc
.EXAMPLE
    Get-HelpModuleData build-docs | New-HelpDoc
    Name                           Value
    ----                           -----
    Text
    PSTypeName                     HelpModuleReadme
    HelpModuleData                 @{Name=build-docs; Commands=System.Object[]; Author=System.Object[]; Description=System.Object[];
#>
function New-HelpDoc {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'Does not alter state')]
    [CmdletBinding()]
    [OutputType('HelpModuleReadme')]
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [PSCustomObject]
        $HelpModuleData
    )

    begin {

    }

    process {
        @{
            PSTypeName     = 'HelpModuleReadme'
            Text           = [string]::Empty
            HelpModuleData = $HelpModuleData
        }
    }

    end {

    }
}