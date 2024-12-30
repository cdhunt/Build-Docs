# Out-HelpDoc

Output the Markdown formatted HelpDoc and optionally write to the provide file path.

## Parameters

### Parameter Set 1

- `[PSObject]` **HelpDoc** _A HelpDoc object with a populated Text property._ Mandatory, ValueFromPipeline
- `[String]` **Path** _Write the output to a `.md` file._ 

## Examples

### Example 1

Get the help data for the build-docs module, add an H1 header of the module name, then output the Markdown.

```powershell
Get-HelpModuleData build-docs | New-HelpDoc | Add-ModuleProperty -Property Name -H1 | Out-HelpDoc
# build-docs
```

## Links

- [New-HelpDoc](New-HelpDoc.md)
