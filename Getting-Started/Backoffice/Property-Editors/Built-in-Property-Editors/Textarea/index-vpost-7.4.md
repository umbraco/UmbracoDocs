---
keywords: textarea property editors v7.4 version7.4
versionFrom: 7.4.0
versionTo: 7.5.14
---

# Textarea

`Alias: Umbraco.TextboxMultiple`

`Returns: String`

Textarea is an HTML textarea control for multiple lines of text.

## Data Type Definition Example

![Textarea Data Type Definition](images/7/textarea-setup.png)


## Settings

## Content Example

![Textarea Content Example](images/7/textarea-content.png)


## MVC View Example

```csharp
@{
    if (Model.Content.HasValue("description")){
        <p>@(Model.Content.GetPropertyValue<string>("description"))</p>
    }
}
```
