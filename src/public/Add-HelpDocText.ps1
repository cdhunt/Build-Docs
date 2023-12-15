function Add-HelpDocText {
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
        [string]
        $Text,

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

        $HelpDoc.Text += '{0}{1}{2}{2}' -f $heading, $Text, [System.Environment]::NewLine
        $HelpDoc | Write-Output
    }

    end {

    }
}