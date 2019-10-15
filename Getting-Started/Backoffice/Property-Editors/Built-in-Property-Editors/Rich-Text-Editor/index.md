---
versionFrom: 8.0.0
---

# Rich Text Editor

`Alias: Umbraco.TinyMCE`

`Returns: HTML`

The Rich Text Editor is based on [tinymce](https://www.tinymce.com/) and is highly configurable.

## Data Type configuration

### Toolbar
You have full control over which options should be available when using the Rich Text Editor on content. See a full list of toolbar options in the [Data Type example](#data-type-example).

### Stylesheets
It's possible to define specific styles that can be used when editing content using the Rich Text Editor.

These styles are defined in stylesheets which can be created in the **Settings** section. Read the [Rich Text Editor Stylesheets]() article to learn more about this feature.

### Dimensions
Define `height` and `width` of the editor displayed in the content section.

### Maximum size for inserted images
Define the maximum size for images added through the Rich Text Editor.

If inserted images are larger than the dimensions defined here, the images will be resized automatically.

* Mode
* Hide Label
* Ignore User Start Nodes
* Image Upload Folder

### Data Type Example

![Rich Text Editor - Data Type](images/rte-datatype.png)

## Content Example

![Rich Text Editor - Content](images/rte-content.png)

## MVC View Example

```csharp
@{
    if (Model.HasValue("richText")){
        <p>@(Model.Value("richText"))</p>
    }
}
```