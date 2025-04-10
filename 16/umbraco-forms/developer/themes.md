---
description: Documentation on how to apply custom themes to Umbraco Forms
---

# Themes

Umbraco Forms supports Themes, allowing forms to be customized in a much simpler manner.

## Creating a Theme

To create a theme, you need to create a folder at `/Views/Partials/Forms/Themes/`. The name of the folder is the name of theme that will be visible in the backoffice when choosing it.

Copy the explicit files you wish to override in your theme, it may be a single file or all files from the `default` theme folder. Make the necessary changes you desire to CSS class names, markup etc.

### Obtaining the Default Theme Files

For Umbraco 9 and previous, it's straightforward to copy the files you need from the default theme folder. We highly recommend that you never customize any files found in the `default` themes folder. There is a risk that any customizations to these files will be lost with any future upgrades you do to Umbraco Forms.

Umbraco 10+ distributes these files as part of a Razor class library, so you won't find them on disk. Instead you should download the appropriate zip file for your Forms version and extract the ones you need.

You can obtain the latest versions of the default theme for each Forms major version from the following links:

* [Forms 10 Default Theme](https://umbra.co/umbraco-forms-default-theme) (for 10.5.5 and above)
* [Forms 11 Default Theme](https://umbra.co/umbraco-forms-default-theme-11) (for 11.1.0 and above)
* [Forms 12 Default Theme](https://umbra.co/umbraco-forms-default-theme-12) (for 12.2.4 and above)
* [Forms 13 Default Theme](https://umbra.co/umbraco-forms-default-theme-13) (for 13.2.2 and above)
* [Forms 14 Default Theme](https://umbra.co/umbraco-forms-default-theme-14) (for 14.1.4 and above)

If you are using a lower minor version of Forms than those listed, you should download an older version of the default theme.

The default theme for minor versions are available from the "Source Code" tab available at the bottom of [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/). Only versions where changes were made are available.

You should use the theme available for the highest version that's less or equal to the version of Forms you have installed.

For example, when using Umbraco Forms 10.4, and no file for that version is available use version 10.3 instead.

### Amending Theme Files

{% hint style="info" %}
Umbraco Forms conditional JavaScript logic depends on some CSS classes currently and it is advised that you add any additional classes you require but **do not remove those already being set**.
{% endhint %}

If adding or amending client-side scripts, you need to copy the `Script.cshtml` file from the `default` themes folder. In your copy, amend the `.js` references to reference your own script files.

### Shipping Themes in a Razor Class Library

Umbraco Forms provides it's built-in themes as part of a Razor Class Library for ease of distribution. This can be useful for custom themes, particularly those used in multiple solutions or released as an Umbraco package.

It is also possible to do this for custom themes.

1. Create a new Razor Class Library project to hold the theme.
2. Create the necessary Partial Views for your theme within `Views\Partials\Forms\Themes\<my-custom-theme>`.
3. Provide the names of the files in your theme via an implementation of `ITheme`.
  * For example, if only overriding a single file, your class would look like the code snippet below:

```csharp
using Umbraco.Forms.Core.Interfaces;

public class MyCustomTheme : ITheme
{
    private const string FilePathFormat = "{0}/{1}/{2}.cshtml";

    public virtual string Name => "my-custom-theme";

    public virtual IEnumerable<string> Files =>
        [
            string.Format(FilePathFormat, Core.Constants.System.ThemesPath, Name, "FieldTypes/FieldType.Textfield"),
        ];
}
```

4. Register the themes you want to use via a composer:

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
      builder.Themes()
          .Add<MyCustomTheme>();
    }
}
```

Your theme will now be available in the Theme Picker and the partial view files will be used when rendering forms.

#### Email Templates

Email templates provided for the send email workflow can be provided in a Razor Class Library similar to the Theme files.

The partial view will be created in `Views\Partials\Forms\Emails`.

It's made available via an implementation of `IEmailTemplate`:

```csharp
using Umbraco.Forms.Core.Interfaces;

public class MyCustomEmailTemplate : IEmailTemplate
{
    public virtual string FileName => "My-Custom-Email-Template.cshtml";
}
```

And registered with:

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
      builder.EmailTemplates()
          .Add<MyCustomEmailTemplate>();
    }
}
```

##### Removing the Default Email Template

If providing custom email templates, you may want to remove the one provided with Forms. You can do that via the same `EmailTemplates` collection.

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
      builder.EmailTemplates()
          .Exclude<DefaultEmailTemplate>();
    }
}
```

## Using a Theme

When rendering a form in a view file, you can specify which theme to use with the form.

Learn more about how to render a form with a theme in the [Rendering Forms](./rendering-forms.md) article.

## Theme Fallbacks

When using a theme, Umbraco Forms will try to use a view from the theme folder, but then fallback to the same view in the default theme folder if it can't be found. This allows you to create a theme by only modifying the files necessary to make your customizations.

Files which can be overridden:

* Render.cshtml (overrides the entire form - usually not needed)
* Form.cshtml (overrides the generation of the fields on the current page)
* Script.cshtml (overrides the way files are included with the form)
* /Fieldtypes/FieldType.\*.cshtml (overrides a specific view for a field)

## Helper Methods

### SetFormThemeCssFile

Sets the primary form theme stylesheet path. This overrides an already assigned stylesheet and will be rendered out when inserting the form into the page

```csharp
Html.SetFormThemeCssFile(Model, "~/App_Plugins/UmbracoForms/Assets/Themes/Default/style.css")
```

### AddFormThemeScriptFile

Add a JavaScript file path to include on form render

```csharp
Html.AddFormThemeScriptFile("~/App_Plugins/UmbracoForms/Assets/themes/default/umbracoforms.js");
```

### SetFormFieldClass

Adds a class to the form field HTML element of a given type. If no type is given, it will add the class to all fields

```csharp
// Applies the CSS class 'form-control' to all fields that GetFormFieldClass uses in FieldType views
@Html.SetFormFieldClass("form-control")

// Applies the CSS class 'some-other-class' for the FieldType of the name 'Password'
@Html.SetFormFieldClass("some-other-class", "Password")
```

### GetFormFieldClass

Retrieves all classes for a given field type, used when rendering form fieldtype partial views

```csharp
class="@Html.GetFormFieldClass(Model.FieldTypeName)"
```

### SetFormFieldWrapperClass

Adds a class to the div element wrapping around form fields of a given type. If no type is given, it will add the class to all fields

```csharp
// Applies the CSS class 'form-group' around all fields, labels & help texts
@Html.SetFormFieldWrapperClass("form-group")

// Applies the CSS class 'some-other-class' for the FieldType of the name 'Password'
@Html.SetFormFieldWrapperClass("some-other-class", "Password")
```

### GetFormFieldWrapperClass

Retrieves all wrapper classes for a given field type, used when rendering form fields. This class wraps both label, help-text and the field itself in the default view

```csharp
class="@Html.GetFormFieldWrapperClass(f.FieldTypeName)"
```
