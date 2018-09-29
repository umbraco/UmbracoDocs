# Partial View Macros

_Partial view macros are the recommended macro type to use in Umbraco. They work in both MVC and Webforms and use the unified query syntax that is available via the `UmbracoHelper`_

## View/Model Type

All partial view macro views inherit from `Umbraco.Web.Macros.PartialViewMacroPage` and as such, the header of each partial view macro file will have this syntax:

	@inherits Umbraco.Web.Macros.PartialViewMacroPage
	
The model type for a partial view macro is `Umbraco.Web.Models.PartialViewMacroModel` which contains all of the properties you will need to
render out content as well as some additional properties about the macro itself: `MacroName`, `MacroAlias`, `MacroId`, and `MacroParameters`. 

## File information

By default Partial View Macros are stored in this folder: 

> ~/Views/MacroPartials 

However if you are bundling up Partial View Macros as part of a package, they can also exist in this folder:

> ~/App_Plugins/[YourPackageName]/Views/MacroPartials

Since Partial View Macros are just a normal MVC partial view, their file extension is **cshtml**. All Partial View Macro views inherit from the view class

	Umbraco.Web.Macros.PartialViewMacroPage

Therefore all files will contain this header (which is done automatically for you if creating Partial View Macros via the Umbraco backoffice):

	@inherits Umbraco.Web.Macros.PartialViewMacroPage

## Accessing content

The syntax in Partial View Macros is 100% on par with the **[MVC View](../../Mvc/views.md)** syntax, in fact they are driven by the exact same engine as MVC Views.

You can use @CurrentPage, @Model.Content, @Umbraco, ...

## Accessing macro parameters

You can access the macro's parameters using the `MacroParameters` property on the model which is of type `IDictionary<string, object>`

    var myParam = Model.MacroParameters["aliasOfTheMacroParameter"];

or via the typed GetParameterValue method in Umbraco.Web.Models namespace

    var myParam = Model.GetParameterValue<string>("aliasOfTheMacroParameter");

and with default value fallback

    var myParam = Model.GetParameterValue<string>("aliasOfTheMacroParameter", "default value if parameter value has not been set");
