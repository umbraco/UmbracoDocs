#Partial View Macro's

Partial view macro's have the same functionality than  MacroScripts.  The most important (and only) difference is that they do not share the same Model.  This means that they can not be changed to a new folder.

By default Partial View Macro's are stored in the View/MacroPartials folder.  

They are Razor scripts and have the cshtml extention.

Each partial view model inherits from 
Umbraco......


## Accessing properties
The systax is 100% on par with the [MVC View](../../Mvc/views.md) syntax.

You can use @CurrentPage, @Model.Content, @Umbraco, ...

## Convert Macroscripts to Partial View Macro's
1. Create a new Partial Macro View
2. Copy the content of the old macro script to the partial view macro.
3. change the 

    @inherits umbraco.MacroEngines.DynamicNodeContext

 to

    @inherits Umbraco.Web.Macros.PartialViewMacroPage

4. replace each reference to `Model` to `CurrentPage`
5. change the reference in the CMS back-end (under Developer/Macros) using the partial view macro instead of the macro script.