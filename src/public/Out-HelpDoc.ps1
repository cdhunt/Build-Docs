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