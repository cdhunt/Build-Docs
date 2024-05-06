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