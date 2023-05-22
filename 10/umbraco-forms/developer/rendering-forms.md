# Rendering Forms

There are two options for rendering a form.

## Rending Using a Macro

To display a form in your view, you use a macro and provide three parameters:

```csharp
@await Umbraco.RenderMacroAsync("renderUmbracoForm", new { FormGuid = "", FormTheme = "", ExcludeScripts = "0|1" })
```

- `FormGuid` is the GUID of a form
- `FormTheme` is the name of a theme. If not provided, the default theme is used (see [Themes](./themes.md))
- `ExcludeScripts` takes a value of 0 or 1, indicating whether scripts should be excluded from rendering (see [Rendering Scripts](./rendering-scripts.md).

Usually, rather than hard-coding the form's GUID, you'll use a form picker property on your page:

```csharp
@await Umbraco.RenderMacroAsync("renderUmbracoForm", new { FormGuid = @Model.Form, ExcludeScripts = "1" })
```

## Rending Via a Tag Helper

As an alternative, you can use a [tag helper](https://learn.microsoft.com/en-us/aspnet/core/mvc/views/tag-helpers/intro?view=aspnetcore-7.0).

Firstly, in your `_ViewImports.cshtml` file, add a reference to the Umbraco Forms tag helpers with:

```csharp
@addTagHelper *, Umbraco.Forms.Web
```

Then in your view you can use:

```csharp
<umb-form form-guid="@Model.Form" theme="@Model.THeme" exclude-scripts="true" />
```

