# New-HelpDoc

Returns an empty HelpModuleReadme object that is the object representation of your documentation.

## Parameters

### Parameter Set 1

- `[PSObject]` **HelpModuleData** _A HelpModuleData object._ Mandatory, ValueFromPipeline

## Examples

### Example 1



```powershell
Get-HelpModuleData build-docs | New-HelpDoc
Name                           Value
----                           -----
Text
PSTypeName                     HelpModuleReadme
HelpModuleData                 @{Name=build-docs; Commands=System.Object[]; Author=System.Object[]; Description=System.Object[];
```

## Links

- [Get-HelpModuleData](Get-HelpModuleData.md)
- [Out-HelpDoc](Out-HelpDoc.md)

## Outputs

- `HelpModuleReadme`
