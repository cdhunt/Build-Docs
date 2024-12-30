# Get-HelpModuleData

Returns an object representation of the help available for the given module. This includes the help for each command in the module.

## Parameters

### Parameter Set 1

- `[String]` **Name** _The name of the module to interrogate for help data._ Mandatory, ValueFromPipeline

## Examples

### Example 1

Returns an object representation of the help available for the given module.

```powershell
Get-HelpModuleData build-docs
Name            : build-docs
Commands        : {@{Name=Add-HelpDocText; Synopsis=
                Add-HelpDocText [-Text] <string> [-HelpDoc] <psobject> [<CommonParameters>]
                Add-HelpDocText [-Text] <string> [-HelpDoc] <psobject> [-H3] [<CommonParameters>]
                Add-HelpDocText [-Text] <string> [-HelpDoc] <psobject> [-H2] [<CommonParameters>]
                …
```

## Links

- [New-HelpDoc](New-HelpDoc.md)
