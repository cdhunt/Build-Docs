function Get-Output ([PSCustomObject]$Help) {

    $outputToMd = [scriptblock] {
        param()

        $desc = if ($null -ne $this.Description) { ': {0}' -f $this.Description } else { [string]::Empty }
        '- `{0}`{1}' -f $this.Type, $desc
    }

    if ($help.returnValues.returnValue.count -gt 0) {


        foreach ($output in $help.returnValues.returnValue) {
            $outputData = [PSCustomObject]@{
                PSTypeName  = 'HelpCommandNoteData'
                Type        = $output.type.name
                Description = $output.description.Text
            }


            $outputData | Add-Member -MemberType ScriptMethod -Name ToMD -Value $outputToMd
            $outputData | Write-Output
        }
    }
}