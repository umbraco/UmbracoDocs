---
keywords: textbox property editors v7.4 version7.4
versionFrom: 7.4.0
versionTo: 7.5.14
---

# Textbox

`Alias: Umbraco.Textbox`

`Returns: String`

Textbox is an HTML input control for text.

## Data Type Definition Example

![Textbox Data Type Definition](images/7/Textbox-DataType.png)

## Settings

## Content Example

![Textbox Content Example](images/7/Textbox-Content.png)

## MVC View Example

```csharp
@{
    if (Model.Content.HasValue("pageTitle")){
        <p>@(Model.Content.GetPropertyValue<string>("pageTitle"))</p>
    }
}
```


### Dynamic (Obsolete)

See [Common pitfalls](../../../../../Reference/Common-Pitfalls/index.md#dynamics) for more information about why the dynamic approach is obsolete.

```csharp
@{
    if (CurrentPage.HasValue("pageTitle")){
        <p>@CurrentPage.pageTitle</p>
    }
}
```
