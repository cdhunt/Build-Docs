function New-HelpDoc {
    [CmdletBinding()]
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