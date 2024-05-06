function New-HelpDoc {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'Does not alter state')]
    [CmdletBinding()]
    [OutputType('System.Collections.Hashtable')]
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