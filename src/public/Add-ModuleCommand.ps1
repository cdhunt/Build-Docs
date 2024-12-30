<#
.SYNOPSIS
    Generate a Markdown list of the commands in the module and their summary.
.DESCRIPTION
    Generate a Markdown list of the commands in the module and optionally format as links.
.PARAMETER HelpDoc
    A HelpDoc object.
.PARAMETER AsLinks
    Format each list item as a link to a `{commandname}.md`.
.LINK
    New-HelpDock
.EXAMPLE
    Get-HelpModuleData build-docs | New-HelpDoc | Add-ModuleCommand -AsLinks | select -exp Text
    - [Add-HelpDocText](Add-HelpDocText.md) _Return a markdown formatted text._
    - [Add-ModuleCommand](Add-ModuleCommand.md) _Generate a Markdown list of the commands in the module._
    - [Add-ModuleProperty](Add-ModuleProperty.md) _Return a markdown formatted value for the given property._
    …

    Generate a list of commands with links to the commands' help documents.
#>
function Add-ModuleCommand {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [PSCustomObject]
        $HelpDoc,

        [Parameter()]
        [switch]
        $AsLinks
    )

    begin {
        $formatString = if ($AsLinks) { '- [{0}]({0}.md) _{1}_{2}' } else { '- {0} _{1}_{2}' }
    }

    process {
        foreach ($command in $HelpDoc.HelpModuleData.Commands) {
            $name = $command.Name
            $desc = if ($command.Synopsis -match $name) { 'No help description' } else { $command.Synopsis }
            $HelpDoc.Text += $formatString -f $name, $desc, [System.Environment]::NewLine
        }
        $HelpDoc | Write-Output
    }

    end {

    }
}