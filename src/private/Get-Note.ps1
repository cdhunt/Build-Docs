function Get-Note ([PSCustomObject]$Help) {

    $noteToMd = [scriptblock] {
        param()

        foreach ($t in $this.Text) {
            $t
        }

    }

    if ($help.alertSet.count -gt 0) {


        foreach ($note in $help.alertSet) {
            $noteData = [PSCustomObject]@{
                PSTypeName = 'HelpCommandNoteData'
                Text       = $note.alert.Text
            }


            $noteData | Add-Member -MemberType ScriptMethod -Name ToMD -Value $noteToMd
            $noteData | Write-Output
        }
    }
}