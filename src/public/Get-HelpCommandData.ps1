function Get-HelpCommandData {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName)]
        [String]
        $Name
    )

    begin {
        $commandToMd = [scriptblock] {
            param([string]$heading = '#')

            '{0} {1}{2}' -f $heading, $this.Name, [System.Environment]::NewLine

            $this.Description

            '{1}{0}# Parameters' -f $heading, [System.Environment]::NewLine

            $this.ParameterSet.ToMD()

            if ($this.Example.Count -gt 0) {
                '{1}{0}# Examples{1}' -f $heading, [System.Environment]::NewLine

                $this.Example.ToMD()
            }

            if ($this.Link.Count -gt 0) {
                '{1}{0}# Links{1}' -f $heading, [System.Environment]::NewLine

                $this.Link.ToMD()
            }
        }
    }

    process {

        $helpSource = Get-Help -Name $Name -Category Function

        $commandData = [PSCustomObject]@{
            PSTypeName   = 'HelpCommandData'
            Name         = $Name
            Synopsis     = $helpSource.Synopsis
            Description  = Get-Description $helpSource $helpSource.Synopsis
            ParameterSet = Get-ParameterSet $helpSource
            Example      = Get-Example $helpSource
            Link         = Get-Link $helpSource
        }

        $commandData | Add-Member -MemberType ScriptMethod -Name ToMD -Value $commandToMd
        $commandData | Write-Output
    }

    end {

    }
}