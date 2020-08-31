---
versionFrom: 8.0.0
---

# Textbox

`Alias: Umbraco.Textbox`

`Returns: String`

Textbox is an HTML input control for text. It can be configured to have a fixed character limit. The default maximum amount of characters is 500 unless it's specifically changed to a lower amount.

## Data Type Definition Example

### Without a character limit

![Textbox Data Type Definition](images/Textbox-Setup-v8.png)

## Settings

## Content Example

### Without a character limit

![Textbox Content Example](images/Textbox-Content-v8.png)

### With a character limit

![Textbox Content Example Without a Character Limit](images/Textbox-Content-Limit-v8.png)

## MVC View Example

```csharp
@{
    // Perform an null-check on the field with alias 'pageTitle'
    if (Model.HasValue("pageTitle")){
        // Print the value of the field with alias 'pageTitle'
        <p>@(Model.Value("pageTitle"))</p>
    }
}
```
