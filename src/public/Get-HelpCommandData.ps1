function Get-HelpCommandData {
    [CmdletBinding(DefaultParameterSetName = 'byName')]
    param (
        [Parameter(Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName, ParameterSetName = 'byName')]
        [String]
        $Name,

        [Parameter(Mandatory,
            Position = 0,
            ValueFromPipeline,
            ParameterSetName = 'byObject')]
        [PSCustomObject]
        $HelpSource
    )

    begin {
        $commandToMd = [scriptblock] {
            param([string]$heading = '#')

            '{0} {1}{2}' -f $heading, $this.Name, [System.Environment]::NewLine

            if ($null -ne $this.Description) {
                $this.Description

                '{1}{0}# Parameters' -f $heading, [System.Environment]::NewLine
            }

            if ($null -ne $this.ParameterSet) {
                $this.ParameterSet.ToMD()

                if ($this.Example.Count -gt 0) {
                    '{1}{0}# Examples{1}' -f $heading, [System.Environment]::NewLine

                    $this.Example.ToMD()
                }
            }

            if ($this.Link.Count -gt 0) {
                '{1}{0}# Links{1}' -f $heading, [System.Environment]::NewLine

                $this.Link.ToMD()
            }

            if ($this.Note.Count -gt 0) {
                '{1}{0}# Notes{1}' -f $heading, [System.Environment]::NewLine

                $this.Note.ToMD()
            }

            if ($this.Output.Count -gt 0) {
                '{1}{0}# Outputs{1}' -f $heading, [System.Environment]::NewLine

                $this.Output.ToMD()
            }
        }
    }

    process {

        if ($PSBoundParameters.ContainsKey('Name')) {
                $helpSource = Get-Help -Name $Name -Category Function
            }

        $commandData = [PSCustomObject]@{
            PSTypeName   = 'HelpCommandData'
            Name         = $Name
            Synopsis     = $helpSource.Synopsis
            Description  = Get-Description $helpSource $helpSource.Synopsis
            ParameterSet = Get-ParameterSet $helpSource
            Example      = Get-Example $helpSource
            Note         = Get-Note $helpSource
            Link         = Get-Link $helpSource
            Output       = Get-Output $helpSource
        }

        $commandData | Add-Member -MemberType ScriptMethod -Name ToMD -Value $commandToMd
        $commandData | Write-Output
    }

    end {

    }
}