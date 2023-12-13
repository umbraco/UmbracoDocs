---
description: Learn the different ways of rendering a form on your website when using Umbraco Forms.
---

# Rendering Forms

There are three options available for rendering a form.

## Rendering Using a View Component

To display a form in your view, you can make a call to a view component:

```cshtml
@await Component.InvokeAsync("RenderForm", new { formId = Guid.Parse("<form guid>"), theme = "default", includeScripts = false })
```

Four parameters can be provided:

- `formId` is the GUID of a form.
- `theme` is the name of a theme. If not provided, the default theme is used (see [Themes](./themes.md)).
- `includeScripts` indicates whether scripts should be rendered with the form (see [Rendering Scripts](./rendering-scripts.md).
- `recordId` is an optional existing record GUID, used if editing records via the website is [enabled in configuration](../developer/configuration/README.md#alloweditableformsubmissions)

Usually, rather than hard-coding the form's GUID, you'll use a form and/or theme picker property on your page:

```csharp
@await Component.InvokeAsync("RenderForm", new { formId = @Model.Form, theme = @Model.Theme, includeScripts = false })
```

## Rendering Using a Tag Helper

If you prefer a tag helper syntax, you can use one that ships with Umbraco Forms.

Firstly, in your `_ViewImports.cshtml` file, add a reference to the Umbraco Forms tag helpers with:

```cshtml
@addTagHelper *, Umbraco.Forms.Web
```

Then in your view you can use:

```csharp
@if (Model.Form.HasValue)
{
    <umb-forms-render form-id="@Model.FormId.Value" theme="@Model.FormTheme" exclude-scripts="true" />
}
```

## Rendering Using a Macro

With a grid or Rich Text Editor, you need to use a macro. This is also available as an option to display a form in your view, where you provide three parameters:

```cshtml
@await Umbraco.RenderMacroAsync("renderUmbracoForm", new { FormGuid = "<form guid>", FormTheme = "default", ExcludeScripts = "1" })
```

- `FormGuid` is the GUID of a form.
- `FormTheme` is the name of a theme. If not provided, the default theme is used.
- `ExcludeScripts` takes a value of 0 or 1, indicating whether scripts should be excluded from rendering.

Similarly, you can reference a form picker property on your page:

```cshtml
@if (Model.FormId is Guid formId)
{
    @await Umbraco.RenderMacroAsync("renderUmbracoForm", new { FormGuid = formId, FormTheme = Model.FormTheme, ExcludeScripts = "1" })
}
```