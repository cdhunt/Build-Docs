function Get-ParameterSet ([pscustomobject]$Help) {
    $setNum = 1

    $parameterToMD = [scriptblock] {
        param([string]$formatString = '- `[{0}]` **{1}** _{2}_ {3}')

        return $formatString -f $this.Type, $this.Name, $this.Description, ($this.attributes -join ', ')
    }

    $parameterSetToMd = [scriptblock] {
        param([string]$Heading = '###', [bool]$ShowHeading = $true)

        if ($ShowHeading) {
            '{2}{0} Parameter Set {1}{2}' -f $Heading, $this.Number, [System.Environment]::NewLine
        }

        $this.Parameter.ToMD()
    }

    $parameterToString = [scriptblock] {
        param()

        $type = if ($this.Type -eq 'Switch') { [string]::Empty } else { '<{0}>' -f $this.Type }
        $syntax = '[-{0}] {1}' -f $this.Name, $type

        if ($this.Attributes -contains 'Mandatory') {
            $syntax = '[{0}]' -f $syntax
        }

        return $syntax
    }

    $parameterSetToString = [scriptblock] {
        param()

        return ($this.Parameter | ForEach-Object { $_.ToString() }) -join ' '
    }

    foreach ($set in $help.syntax.syntaxItem) {
        $parameterSet = [PSCustomObject]@{
            PSTypeName = 'HelpParameterSetData'
            Number     = $setNum++
            Parameter  = @()
        }

        foreach ($param in $set.Parameter) {

            $attributes = @()
            if ($param.required -eq 'true') { $attributes += 'Mandatory' }
            if ($param.pipelineInput -like '*ByValue*') { $attributes += 'ValueFromPipeline' }

            $parameter = [PSCustomObject]@{
                PSTypeName  = 'HelpParameterData'
                Type        = (Get-Text $param.parameterValue 'Switch')
                Name        = $param.Name
                Description = (Get-Description $param 'Parameter help description')
                Attributes  = $attributes
            }
            $parameter | Add-Member -MemberType ScriptMethod -Name ToMD -Value $parameterToMD
            $parameter | Add-Member -MemberType ScriptMethod -Name ToString -Value $parameterToString -Force
            $parameterSet.Parameter += $parameter
        }

        $parameterSet | Add-Member -MemberType ScriptMethod -Name ToMD -Value $parameterSetToMD
        $parameterSet | Add-Member -MemberType ScriptMethod -Name ToString -Value $parameterSetToString -Force
        $parameterSet | Write-Output
    }

}