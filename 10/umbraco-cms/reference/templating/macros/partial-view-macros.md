# Partial View Macros

Partial View Macros are the recommended macro type to use in Umbraco. They work in both MVC and Webforms and use the unified query syntax that is available via the `UmbracoHelper`.

## View/Model Type

All Partial View Macro views inherit from `Umbraco.Cms.Web.Common.Macros.PartialViewMacroPage` and the header of each Partial View Macro file will contain:

```csharp
@inherits Umbraco.Cms.Web.Common.Macros.PartialViewMacroPage
```

The model type for a Partial View Macro is `Umbraco.Cms.Core.Models.PartialViewMacroModel`. This contains all of the properties you need to render out content alongside some additional properties about the macro itself:

* MacroName
* MacroAlias
* MacroId
* MacroParameters

## File Information

By default, Partial View Macros are stored in this folder:

> \~/Views/MacroPartials

However, if you are bundling up Partial View Macros as part of a package, they can also exist in this folder:

> \~/App\_Plugins/\[YourPackageName]/Views/MacroPartials

Since Partial View Macros are a normal MVC partial view, their file extension is **cshtml**. All Partial View Macro views inherit from the following view class:

```csharp
Umbraco.Cms.Web.Common.Macros.PartialViewMacroPage
```

Therefore, all files will contain the header (which is done automatically for you if creating Partial View Macros via the Umbraco backoffice):

```csharp
@inherits Umbraco.Cms.Web.Common.Macros.PartialViewMacroPage
```

## Accessing Content

The syntax in Partial View Macros is similar to the [**MVC View**](../mvc/views.md) syntax. In fact, they are driven by the exact same engine as MVC Views.

You can use @CurrentPage, @Model.Content, @Umbraco, ...

## Accessing Macro Parameters

You can access the macro's parameters using the:

*   `MacroParameters` property on the model which is of type `IDictionary<string, object>`:

    ```csharp
    var myParam = Model.MacroParameters["aliasOfTheMacroParameter"];
    ```
*   Typed GetParameterValue method in `Umbraco.Cms.Core.Models` namespace:

    ```csharp
    @using Umbraco.Cms.Core.Models;
    var myParam = Model.GetParameterValue<string>("aliasOfTheMacroParameter");
    ```
*   Typed GetParameterValue method with the default value fallback:

    ```csharp
    @using Umbraco.Cms.Core.Models;
    var myParam = Model.GetParameterValue<string>("aliasOfTheMacroParameter", "default value if parameter value has not been set");
    ```
