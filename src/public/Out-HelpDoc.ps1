<#
.SYNOPSIS
    Output the Markdown formatted HelpDoc.
.DESCRIPTION
    Output the Markdown formatted HelpDoc and optionally write to the provide file path.
.PARAMETER HelpDoc
    A HelpDoc object with a populated Text property.
.PARAMETER Path
    Write the output to a `.md` file.
.LINK
    New-HelpDoc
.EXAMPLE
    Get-HelpModuleData build-docs | New-HelpDoc | Add-ModuleProperty -Property Name -H1 | Out-HelpDoc
    # build-docs

    Get the help data for the build-docs module, add an H1 header of the module name, then output the Markdown.
#>
function Out-HelpDoc {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 1, ValueFromPipeline)]
        [PSCustomObject]
        $HelpDoc,

        [Parameter(Position = 0)]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    begin {

    }

    process {
        if ($PSBoundParameters.ContainsKey('Path')) {
            $givenExt = [System.IO.Path]::GetExtension($Path)
            if ($givenExt -ne '.md') {
                $Path = $Path.Replace($givenExt, '.md')
            }
            $HelpDoc.Text | Set-Content -Path $Path
        } else {
            $HelpDoc.Text | Write-Output
        }

    }

    end {

    }
}