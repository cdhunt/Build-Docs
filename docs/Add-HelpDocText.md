# Add-HelpDocText

Return the given string optionally formatted as a Header.

## Parameters

### Parameter Set 1

- `[PSObject]` **HelpDoc** _A HelpDoc object._ Mandatory, ValueFromPipeline
- `[String]` **Text** _A string to add to the HelpDoc._ Mandatory

### Parameter Set 2

- `[PSObject]` **HelpDoc** _A HelpDoc object._ Mandatory, ValueFromPipeline
- `[String]` **Text** _A string to add to the HelpDoc._ Mandatory
- `[Switch]` **H3** _Format the text as an H3 header._ 

### Parameter Set 3

- `[PSObject]` **HelpDoc** _A HelpDoc object._ Mandatory, ValueFromPipeline
- `[String]` **Text** _A string to add to the HelpDoc._ Mandatory
- `[Switch]` **H2** _Format the text as an H2 header._ 

### Parameter Set 4

- `[PSObject]` **HelpDoc** _A HelpDoc object._ Mandatory, ValueFromPipeline
- `[String]` **Text** _A string to add to the HelpDoc._ Mandatory
- `[Switch]` **H1** _Format the text as an H1 header._ 

## Examples

### Example 1

Add a level 1 header with the text "My Module Help".

```powershell
Get-HelpModuleData build-docs | New-HelpDoc | Add-HelpDocText -Text "My Module Help" -H1 | Out-HelpDoc
# My Module Help
```

## Links

- [New-HelpDoc](New-HelpDoc.md)
- [Get-HelpModuleData](Get-HelpModuleData.md)

## Notes

If no Header switch is provided, the default is no formatting.
