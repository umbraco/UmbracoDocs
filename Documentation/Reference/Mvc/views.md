#Working with MVC Views in Umbraco

**Applies to: Umbraco 4.10.0+**

_This section will focus on how to use the MVC rendering engine in Umbraco such as the syntax to use in your Views, creating forms and creating your own custom controllers_ 

##Properties available in Views

All Umbraco views inherit from `Umbraco.Web.Mvc.UmbracoTemplatePage` which exposes many properties that are available in razor:

* @Umbraco (of type `Umbraco.Web.UmbracoHelper`) -> contains many helpful methods, from rendering macros and fields to retreiving content based on an Id and tons of other helpful methods. This is essentially the replacement for the 'library' object in the old codebase.
* @Html (of type `HtmlHelper`) -> the same HtmlHelper you know and love from Microsoft but we've added a bunch of handy extension methods like @Html.BeginUmbracoForm
* @CurrentPage (of type `DynamicPublishedContent`) -> the dynamic representation of the current page model which allows dynamic access to fields and also dynamic Linq
* @Model (of type `Umbraco.Web.Mvc.RenderModel`) -> the model for the view which contains a property called Content which gives you accesss to the typed current page (of type IPublishedContent). 
* @UmbracoContext (of type `Umbraco.Web.UmbracoContext1)
* @ApplicationContext (of type `Umbraco.Core.ApplicationContext`)

##Rendering a field with UmbracoHelper
This is probably the most used method which simply renders the contents of a field for the current content item.

	@Umbraco.Field("bodyContent")

There are several optional parameters. Here is the list with their default values:

* altFieldAlias = ""
* altText = ""
* insertBefore = ""
* insertAfter = ""
* recursive = false
* convertLineBreaks = false
* removeParagraphTags = false
* casing = RenderFieldCaseType.Unchanged
* encoding = RenderFieldEncodingType.Unchanged

The easiest way to use the Field method is to simply specify the optional parameters you'd like to set. For example, if we want to set the insertBefore and insertAfter parameters we'd do:

	@Umbraco.Field("bodyContent", insertBefore : "<h2>", insertAfter : "</h2>")


##Rendering a field with Model

The UmbracoHelper method provides many useful parameters to change how the value is rendered. If you however simply want to render value "as-is" you can use the @Model.Content property of the view. For example:

	@Model.Content.Properties["bodyContent"].Value

Or alternatively:

	@Model.Content.GetProperty("bodyContent")

##Rendering a field using @CurrentPage (dynamically)

The UmbracoHelper method provides many useful parameters to change how the value is rendered. If you however simply want to render value "as-is" you can use the @CurrentPage property of the view. The difference between @CurrentPage and @Model.Content is that @CurrentPage is the dynamic representation of the model which exposes many dynamic features for querying. For example, to render a field you simply use this syntax:

	@CurrentPage.bodyContent

##Rendering Macros

Rendering a macro is easy using UmbracoHelper. There are 3 overloads, we'll start with the most basic:

This renders a macro with the specified alias without any parameters:

	@Umbraco.RenderMacro("myMacroAlias")

This renders a macro with some parameters using an anonymous object:

	@Umbraco.RenderMacro("myMacroAlias", new { name = "Ned", age = 28 })

This renders a macro with some parameters using a dictionary

	@Umbraco.RenderMacro("myMacroAlias", new Dictionary<string, object> {{ "name", "Ned"}, { "age", 27}})

