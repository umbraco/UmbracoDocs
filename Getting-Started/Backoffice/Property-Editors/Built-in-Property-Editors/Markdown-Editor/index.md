---
versionFrom: 8.0.0
---

# Markdown editor

`Alias: Umbraco.MarkdownEditor`

`Returns: System.Web.HtmlString`

This built-in editor allow the user to use the markdown formatting options, from within a tinyMCE-type interface.
Behind the scenes, Umbraco uses the Markdown NuGet package.

## Data Type Definition Example

![Definition Example](images/definition-example.png)

There are two settings available for manipulating the DateTime property.

* **Preview** toggles if a preview of the markdown should be displayed beneath the editor in the content view. 
* **Default value** is inserted if no content has been saved to the document type using this property editor.

## Content Example

![Content Example](images/content-example.png)

## MVC View Example

### With Modelsbuilder

```csharp
@Model.MyMarkdownEditor
```

### Without Modelsbuilder

```csharp
@Model.Value("MyMarkdownEditor")
```
