function Get-Example ([PSCustomObject]$Help) {

    $exampleToMD = [scriptblock] {
        param([string]$Heading = '###', [bool]$ShowHeading = $true)

        if ($ShowHeading) {
            '{0} Example {1}{2}' -f $Heading , $this.Number, [System.Environment]::NewLine
        }

        '{0}{1}' -f $this.Remarks, [System.Environment]::NewLine

        '```powershell'
        $this.Code
        '```'
    }

    $exNum = 1

    foreach ($example in $help.examples.example) {
        $exampleData = [PSCustomObject]@{
            PSTypeName = 'HelpCommandExampleData'
            Number     = $exNum++
            Remarks    = ($example.remarks | Where-Object Text | Select-Object -ExpandProperty Text)
            Code       = $example.code
        }

        $exampleData | Add-Member -MemberType ScriptMethod -Name ToMD -Value $exampleToMD
        $exampleData | Write-Output
    }

}