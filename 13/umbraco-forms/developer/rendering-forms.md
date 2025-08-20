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

Six parameters can be provided:

- `formId` is the GUID of a form.
- `theme` is the name of a theme. If not provided, the default theme is used (see [Themes](./themes.md)).
- `includeScripts` indicates whether scripts should be rendered with the form (necessary to use conditional fields, see [Rendering Scripts](./rendering-scripts.md)).
- `recordId` is an optional existing record GUID, used if editing records via the website is [enabled in configuration](../developer/configuration/README.md#alloweditableformsubmissions)
- `redirectToPageId` is an optional GUID for a content page that, if provided, is redirected to once the form has been submitted. It will be used in preference to post-submission behavior defined on the form itself.
- `additionalData` is an optional dictionary of string values. When provided it will be used as a source for ["magic string" replacements](./magic-strings.md). The data will be associated with the created record and made available for custom logic or update within workflows.

Usually, rather than hard-coding the form's GUID and other details, you'll use a form, theme or content picker on your page:

```csharp
var additionalData = new Dictionary<string, string> { { "foo", "bar" }, { "buzz", "baz" } };
@await Component.InvokeAsync("RenderForm", new { formId = @Model.Form, theme = @Model.Theme, includeScripts = false, additionalData })
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
    var additionalData = new Dictionary<string, string> { { "foo", "bar" }, { "buzz", "baz" } };
    <umb-forms-render form-id="@Model.FormId.Value" theme="@Model.FormTheme" exclude-scripts="true" additional-data="@additionalData" />
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
- `RedirectToPageId` is an optional picked content item that, if provided, is redirected to once the form has been submitted. It will be used in preference to post-submission behavior defined on the form itself.


Similarly, you can reference a form picker property on your page:

```cshtml
@if (Model.FormId is Guid formId)
{
    @await Umbraco.RenderMacroAsync("renderUmbracoForm", new { FormGuid = formId, FormTheme = Model.FormTheme, ExcludeScripts = "1" })
}
```
