---
keywords: textbox property editors v7.6 version7.6
versionFrom: 7.6.0
---

# Textbox

`Alias: Umbraco.Textbox`

`Returns: String`

Textbox is an HTML input control for text. It can be configured to have a fixed character limit. The default maximum amount of characters is 500 unless it's specifically changed to a lower amount.

## Data Type Definition Example

### Without a character limit

![Textbox Data Type Definition](images/7_6/textbox-setup.png)

### With a character limit

![Textbox Data Type Definition With a Character Limit](images/7_6/textbox-setup-limit.png)

## Settings

## Content Example

### Without a character limit

![Textbox Content Example](images/7_6/textbox-content.png)

### With a character limit

![Textbox Content Example Without a Character Limit](images/7_6/textbox-content-limit.png)

## MVC View Example

```csharp
@{
    if (Model.Content.HasValue("pageTitle")){
        <p>@(Model.Content.GetPropertyValue<string>("pageTitle"))</p>
    }
}
```


### Dynamic (Obsolete)

See [Common pitfalls](https://our.umbraco.com/documentation/reference/Common-Pitfalls/#dynamics) for more information about why the dynamic approach is obsolete.

```csharp
@{
    if (CurrentPage.HasValue("pageTitle")){
        <p>@CurrentPage.pageTitle</p>
    }
}
```
