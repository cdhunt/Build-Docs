# Build-Docs

Helper for building markdown docs from PowerShell Command Help.

## CI Status

[![PowerShell](https://github.com/cdhunt/Build-Docs/actions/workflows/powershell.yml/badge.svg)](https://github.com/cdhunt/Build-Docs/actions/workflows/powershell.yml)

## Install

[powershellgallery.com/packages/Build-Docs](https://www.powershellgallery.com/packages/Build-Docs)

`Install-Module -Name Build-Docs` or `Install-PSResource -Name Build-Docs`

## Docs

[Full Docs](docs)

### Getting Started

This module will walk the properties and help for each command in a given module and add a `.ToMD()` ScriptMethod that applies some opinionated markdown formatting.
The is entirely based on the output of [Get-Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-help?view=powershell-7.4) so the help data can be XML-based or comment-based.

This module adds the `.ToMD()` method to the following command help properties.
Only properties that are defined are rendered into markdown so you won't have a bunch of empty sections if not defined.

- `Description`
- `ParameterSet` _(each)_: Adds an H3 header for each parameter set which contains a unordered list of parameters.
- `Example` _(each)_: All of the text before an empty newline is considered part of the code and will be fenced in a code block. Text after an empty newline is considered the Remarks.
- `Link` _(each)_: Format as a HREF link. If the link text is an existing command in the module it will link to `{commandname}.md`.
- `Note`
- `Output`

### Example Usage

This is the basic snippet I use in my `build.ps1` scripts to generate all the files under `/docs`.

```powershell
$help = Get-HelpModuleData $module

# docs/README.md
$help | New-HelpDoc |
Add-ModuleProperty Name -H1 |
Add-ModuleProperty Description |
Add-HelpDocText "Commands" -H2 |
Add-ModuleCommand -AsLinks |
Out-HelpDoc -Path 'docs/README.md'

# Individual Commands
foreach ($command in $help.Commands) {
    $name = $command.Name
    $doc = New-HelpDoc -HelpModuleData $help
    $doc.Text = $command.ToMD()
    $doc | Out-HelpDoc -Path "docs/$name.md"
}
```


