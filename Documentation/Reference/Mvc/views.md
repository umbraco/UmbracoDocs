#Using MVC in Umbraco
_This section will focus on how to use the MVC rendering engine in Umbraco such as the syntax to use in your Views, creating forms and creating your own custom controllers_ 

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

	@Umbraco.Field("bodyContent", insertBefore = "<h2>", insertAfter = "</h2>")


##Rendering a field with Model

The UmbracoHelper method provides many useful parameters to change how the value is rendered. If you however simply want to render value "as-is" you can use the @Model.CurrentContent property of the view. For example:

	@Model.CurrentContent.Properties["bodyContent"].Value

Or alternatively:

	@Model.CurrentContent.GetProperty("bodyContent")

##Rendering a field using @CurrentPage (dynamically)

The UmbracoHelper method provides many useful parameters to change how the value is rendered. If you however simply want to render value "as-is" you can use the @CurrentPage property of the view. The difference between @CurrentPage and @Model.CurrentContent is that @CurrentPage is the dynamic representation of the model which exposes many dynamic features for querying. For example, to render a field you simply use this syntax:

	@CurrentPage.bodyContent


