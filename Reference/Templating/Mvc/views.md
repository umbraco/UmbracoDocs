# Working with MVC Views in Umbraco

_Working with MVC Views and Razor syntax in Umbraco_

## Properties available in Views

All Umbraco views inherit from `Umbraco.Web.Mvc.UmbracoTemplatePage` which exposes many properties that are available in razor:

* @Umbraco (of type `Umbraco.Web.UmbracoHelper`) -> contains many helpful methods, from rendering macros and fields to retreiving content based on an Id and tons of other helpful methods. [See UmbracoHelper Documentation](../../Querying/UmbracoHelper/index.md)
* @Html (of type `HtmlHelper`) -> the same HtmlHelper you know and love from Microsoft but we've added a bunch of handy extension methods like @Html.BeginUmbracoForm
* @CurrentPage (of type `DynamicPublishedContent`) -> the dynamic representation of the current page model which allows dynamic access to fields and also dynamic Linq
* @Model (of type `Umbraco.Web.Mvc.RenderModel`) -> the model for the view which contains a property called `Content` which gives you access to the typed current page (of type `IPublishedContent`). 
* @UmbracoContext (of type `Umbraco.Web.UmbracoContext`)
* @ApplicationContext (of type `Umbraco.Core.ApplicationContext`)
* @Members (of type `Umbraco.Web.Security.MemberShipHelper`) [See MemberShipHelper Documentation](../../Querying/MemberShipHelper/index.md)

## Rendering a field with UmbracoHelper
This is probably the most used method which simply renders the contents of a field for the current content item.

	@Umbraco.Field("bodyContent")
	
If you're using the Field method from within a partial view then be aware that you will need to pass the context so the Field method knows where to get the deisred value from. For instance you can pass "CurrentPage" like this:

	@Umbraco.Field(CurrentPage, "bodyContent")

You will also need to pass the "Context" to the @Umbraco.Field() method if you're looping over a selection like this where we pass the "item" variable.

	@{
		var selection = Model.Content.Site().FirstChild("events").Children("event").Where(x => x.IsVisible());
	}
	<ul>
		@foreach(var item in selection){
        		@Umbraco.Field(item, "eventLink")
		}
	</ul>

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
	

## Rendering a field with Model

The UmbracoHelper method provides many useful parameters to change how the value is rendered. If you however simply want to render value "as-is" you can use the @Model.Content property of the view. For example:

	@Model.Content.Properties["bodyContent"].Value

Or alternatively:

	@Model.Content.GetPropertyValue("bodyContent")

You can also specify the output type that you want from the property. If the property editor or value does not support the conversion then an exception will be thrown. Some examples:

 	@Model.Content.GetPropertyValue<double>("amount")
	@Model.Content.GetPropertyValue<RawXElement>("xmlContents")

## Rendering a field using @CurrentPage (dynamically)

The UmbracoHelper method provides many useful parameters to change how the value is rendered. If you however simply want to render value "as-is" you can use the @CurrentPage property of the view. The difference between @CurrentPage and @Model.Content is that @CurrentPage is the dynamic representation of the model which exposes many dynamic features for querying. For example, to render a field you simply use this syntax:

	@CurrentPage.bodyContent

*NOTE: When accessing content dynamically you will not get intellisense if you are using Visual Studio to edit your templates.*

## <a name="renderingMacros"></a>Rendering Macros

Rendering a macro is easy using UmbracoHelper. There are 3 overloads, we'll start with the most basic:

This renders a macro with the specified alias without any parameters:

	@Umbraco.RenderMacro("myMacroAlias")

This renders a macro with some parameters using an anonymous object:

	@Umbraco.RenderMacro("myMacroAlias", new { name = "Ned", age = 28 })

This renders a macro with some parameters using a dictionary

	@Umbraco.RenderMacro("myMacroAlias", new Dictionary<string, object> {{ "name", "Ned"}, { "age", 27}})


[UmbracoHelper Documentation](../../Querying/UmbracoHelper/index.md)


## Accessing Member data

`@Members` is the gateway to everything related to members when templating your site. [MemberShipHelper Documentation](../../Querying/MemberShipHelper/index.md)

	@if(Members.IsLoggedIn()){
	   var profile = Members.GetCurrentMemberProfileModel();
	   var umbracomember = Members.GetByUsername(profile.UserName);
	   
	    <h1>@umbracomember.Name</h1>
	    <p>@umbracomember.GetPropertyValue<string>("bio")</p>
	}

## Models Builder

Models Builder allows you to use strongly typed models in your views.
Properties created on your document types can be accessed with this syntax:

	@Model.BodyText

When Models Builder resolve your properties it will also try to use value converters to convert the values of your data into more convenient models allowing you to access nested objects as strong types instead of having to rely on dynamics and risking having a lot of potential errors when working with these.

[Models Builder documentation](../Modelsbuilder/)
