---
description: Learn the different ways of rendering a form on your website when using Umbraco Forms.
---

# Rendering Forms

There are two options available for rendering a form.

## Rendering Using a View Component

To display a form in your view, you can make a call to a view component. You can use a forms GUID directly or add a form dynamically by referencing a form selected via a Forms Picker.

When selecting a theme, it can be added directly as a string or dynamically by referencing a theme picked via a Theme Picker.

{% tabs %}

{% tab title="Dynamic" %}

```csharp
@await Component.InvokeAsync("RenderForm", new { formId = @Model.Form, 
                                                 theme = @Model.Theme,
                                                 includeScripts = false })
```

This example uses a Forms Picker with `form` as alias, and a Theme Picker with `theme` as alias.

{% endtab %}

{% tab title="Static" %}

```csharp
@await Component.InvokeAsync("RenderForm", new { formId = Guid.Parse("<form guid>"), 
                                                 theme = "default", 
                                                 includeScripts = false })
```

This example hard-codes the GUID of a form and the name of the theme.

{% endtab %}

{% endtabs %}

Six parameters can be provided:

- `formId` is the GUID of a form.
- `theme` is the name of a theme. If not provided, the default theme is used (see [Themes](./themes.md)).
- `includeScripts` indicates whether scripts should be rendered with the form (see [Rendering Scripts](./rendering-scripts.md).
- `recordId` is an optional existing record GUID, used if editing records via the website is [enabled in configuration](../developer/configuration/README.md#alloweditableformsubmissions)
- `redirectToPageId` is an optional GUID for a content page that, if provided, is redirected to once the form has been submitted. It will be used in preference to post-submission behavior defined on the form itself.
- `additionalData` is an optional dictionary of string values. When provided it will be used as a source for ["magic string" replacements](./magic-strings.md). The data will be associated with the created record and made available for custom logic or update within workflows.

The following example shows how the `additionalData` parameter is used:

{% code wrap="true" %}

```csharp
var additionalData = new Dictionary<string, string> { { "foo", "bar" }, { "buzz", "baz" } };
@await Component.InvokeAsync("RenderForm", new { formId = @Model.Form, theme = @Model.Theme, includeScripts = false, additionalData })
```

{% endcode %}

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
    <umb-forms-render form-id="@Model.FormId.Value" 
                      theme="@Model.FormTheme" 
                      exclude-scripts="true" 
                      additional-data="@additionalData" />
}
```
