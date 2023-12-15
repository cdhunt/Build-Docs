function Get-Link ([PSCustomObject]$Help) {

    $linkToMd = [scriptblock] {
        param()

        if ($this.IsCommand) {
            '- [{0}]({0}.md)' -f $this.Text
        } else {
            if ([string]::IsNullOrWhiteSpace($this.Text)) {
                '- [{0}]({0})' -f $this.Uri
            }
        }
    }

    if ($help.relatedLinks.count -gt 0) {

        foreach ($link in $help.relatedLinks.navigationLink) {
            $linkData = [PSCustomObject]@{
                PSTypeName = 'HelpCommandLinkData'
                Uri        = $link.uri
                Text       = $link.linkText
                IsCommand  = $false
            }

            if ($linkData.Text -match '\w{3,}-\w{3,}') {
                $linkData.IsCommand = ($Commands -contains $link.linkText)
            }

            $linkData | Add-Member -MemberType ScriptMethod -Name ToMD -Value $linkToMd
            $linkData | Write-Output
        }
    }
}