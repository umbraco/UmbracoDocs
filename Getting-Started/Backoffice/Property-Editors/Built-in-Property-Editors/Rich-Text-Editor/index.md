---
versionFrom: 8.0.0
---

# Rich Text Editor

`Alias: Umbraco.TinyMCE`

`Returns: HTML`

The Rich Text Editor is based on [tinymce](https://www.tinymce.com/) and is highly configurable.

## Data Type Definition Example

![Rich Text Editor - Data Type](images/rte-datatype.png)

## Content Example

![Rich Text Editor - Content](images/rte-content.png)

## MVC View Example

```csharp
@{
    if (Model.HasValue("mainContent")){
        <p>@(Model.Value("mainContent"))</p>
    }
}
```