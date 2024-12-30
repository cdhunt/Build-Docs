# Add-ModuleProperty

Return the value for the given property optionally formatted as a Header.

## Parameters

### Parameter Set 1

- `[PSObject]` **HelpDoc** _A HelpDoc object._ Mandatory, ValueFromPipeline
- `[String]` **Property** _A top level property from the Help object. Valid values are `'Name'`, `'Author'`, `'Description'`, `'HelpInfoUri'`, `'LicenseUri'`, `'ProjectUri'`, and `'Version'`._ Mandatory

### Parameter Set 2

- `[PSObject]` **HelpDoc** _A HelpDoc object._ Mandatory, ValueFromPipeline
- `[String]` **Property** _A top level property from the Help object. Valid values are `'Name'`, `'Author'`, `'Description'`, `'HelpInfoUri'`, `'LicenseUri'`, `'ProjectUri'`, and `'Version'`._ Mandatory
- `[Switch]` **H3** _Format the property value as an H3 header._ 

### Parameter Set 3

- `[PSObject]` **HelpDoc** _A HelpDoc object._ Mandatory, ValueFromPipeline
- `[String]` **Property** _A top level property from the Help object. Valid values are `'Name'`, `'Author'`, `'Description'`, `'HelpInfoUri'`, `'LicenseUri'`, `'ProjectUri'`, and `'Version'`._ Mandatory
- `[Switch]` **H2** _Format the property value as an H2 header._ 

### Parameter Set 4

- `[PSObject]` **HelpDoc** _A HelpDoc object._ Mandatory, ValueFromPipeline
- `[String]` **Property** _A top level property from the Help object. Valid values are `'Name'`, `'Author'`, `'Description'`, `'HelpInfoUri'`, `'LicenseUri'`, `'ProjectUri'`, and `'Version'`._ Mandatory
- `[Switch]` **H1** _Format the property value as an H1 header._ 

## Examples

### Example 1



```powershell
Get-HelpModuleData build-docs | New-HelpDoc | Add-ModuleProperty -Property Name -H1
Name                           Value
----                           -----
Text                           # build-docs…
PSTypeName                     HelpModuleReadme
HelpModuleData                 @{Name=build-docs; Commands=System.Object[]; Author=System.Object[]; Description=System.Object[]; …
```

## Links

- [New-HelpDoc](New-HelpDoc.md)
- [Get-HelpModuleData](Get-HelpModuleData.md)

## Notes

If no Header switch is provided, the default is no formatting.
