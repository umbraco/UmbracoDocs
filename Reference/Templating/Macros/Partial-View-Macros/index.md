#Partial View Macros

Partial view macros are the recommended macro type to use in Umbraco. They work in both MVC and Webforms and use the unified query syntax that is available via the [UmbracoHelper](../../../Querying/UmbracoHelper/index.md)

##File information

By default Partial View Macros are stored in this folder: 

> ~/Views/MacroPartials 

However if you are bundling up Partial View Macros as part of a package, they can also exist in this folder:

> ~/App_Plugins/[YourPackageName]/Views/MacroPartials

Since Partial View Macros are just a normal MVC partial view, their file extension is **cshtml**. All Partial View Macro views inherit from the view class

	Umbraco.Web.Macros.PartialViewMacroPage

Therefore all files will contain this header (which is done automatically for you if creating Partial View Macros via the Umbraco back office):

	@inherits Umbraco.Web.Macros.PartialViewMacroPage

## Accessing content

The syntax in Partial View Macros is 100% on par with the **[MVC View](../../Mvc/views.md)** syntax, in fact they are driven by the exact same engine as MVC Views.

You can use @CurrentPage, @Model.Content, @Umbraco, ...

## Converting a Partial View Macro from a legacy Razor Macro Script

Partial view macros have superceded Razor macro scripts and offer more functionality. Converting to Partial View Macros from razor macro scripts is fairly easy since content traversing is similar between them.

The differences to note are:

* The view classes expose different objects
	* To access macro information in Partial View Macros, use: `Model.MacroName`, `Model.MacroAlias`, `Model.MacroId`, `Model.MacroParameters`
	* Partial View Macros do not expose the objects: `MacroModel`, `INode` or `RazorLibraryCore`, they expose `UmbracoHelper` which can be used instead.
* The Models are different
	* The Partial View Macro model is of type `Umbraco.Web.Models.PartialViewMacroModel` whereas razor macro script's model is purely a dynamic representation of the content item.
	* To access the content item in Partial View Macros, use `Model.Content` which exposes an instance of `IPublishedContent` or use `CurrentPage` which exposes the dynamic representation of the content item (similar to how razor macro scripts work)

Quick conversion guide:

1. Create a new Partial Macro View
2. Copy the content of the old macro script to the Partial View Macro.
3. Change the 

		@inherits umbraco.MacroEngines.DynamicNodeContext

	to

    	@inherits Umbraco.Web.Macros.PartialViewMacroPage

4. Replace each reference from `Model` to `CurrentPage`
5. Change the reference in the CMS back-end (under Developer/Macros) using the Partial View Macro instead of the macro script.
