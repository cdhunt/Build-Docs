# Add-HelpDocText


Add-HelpDocText [-Text] <string> [-HelpDoc] <psobject> [<CommonParameters>]

Add-HelpDocText [-Text] <string> [-HelpDoc] <psobject> [-H3] [<CommonParameters>]

Add-HelpDocText [-Text] <string> [-HelpDoc] <psobject> [-H2] [<CommonParameters>]

Add-HelpDocText [-Text] <string> [-HelpDoc] <psobject> [-H1] [<CommonParameters>]


## Parameters

### Parameter Set 1

- `[string]` **Text** _Parameter help description_ Mandatory
- `[psobject]` **HelpDoc** _Parameter help description_ Mandatory, ValueFromPipeline

### Parameter Set 2

- `[string]` **Text** _Parameter help description_ Mandatory
- `[psobject]` **HelpDoc** _Parameter help description_ Mandatory, ValueFromPipeline
- `[Switch]` **H3** _Parameter help description_ 

### Parameter Set 3

- `[string]` **Text** _Parameter help description_ Mandatory
- `[psobject]` **HelpDoc** _Parameter help description_ Mandatory, ValueFromPipeline
- `[Switch]` **H2** _Parameter help description_ 

### Parameter Set 4

- `[string]` **Text** _Parameter help description_ Mandatory
- `[psobject]` **HelpDoc** _Parameter help description_ Mandatory, ValueFromPipeline
- `[Switch]` **H1** _Parameter help description_ 

## Outputs

- `System.Object`
