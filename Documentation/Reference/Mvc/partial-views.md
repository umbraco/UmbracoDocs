#Using MVC Partial Views in Umbraco

**Applies to: Umbraco 4.10.0+**

_This section will show you how to use MVC Partial Views in Umbraco. Please note, this is documentation relating to the use of native MVC partial views, not the soon to come 'Partial View Macros'_ 

##Overview

Using Partial Views in Umbraco is exactly the same as using Partial Views in a normal MVC project. There is detailed documentation on the Internet about creating and using MVC partial views, for example:

* [http://www.asp.net/mvc/videos/mvc-2/how-do-i/how-do-i-work-with-data-in-aspnet-mvc-partial-views](http://www.asp.net/mvc/videos/mvc-2/how-do-i/how-do-i-work-with-data-in-aspnet-mvc-partial-views)

##View Locations

The locations to store Partial Views when rendering in the Umbraco pipeline is:

	~/Views/Partials

The standard MVC partial view locations will also work:

	~/Views/Shared
	~/Views/RenderMvc

The ~/Views/RenderMvc location is valid because the controller that performs the rendering in the Umbraco codebase is the: `Umbraco.Web.Mvc.RenderMvcController`

If however you are 'Hijacking an Umbraco route' and specifying your own controller to do the execution, then your partial view location can also be:

	~/Views/{YourControllerName}

##Example

A quick example of a content item that has a template that renders out a partial view template for each of it's child documents:

The MVC template markup for the document:

	@inherits Umbraco.Web.Mvc.RenderViewPage
	@{
	    Layout = null;
	}
	
	<html>
	<body>
		
		@foreach(var page in Model.Content.Children.Where(x => x.IsVisible())){
			<div>
				@Html.Partial("ChildItem", page)
			</div>
		}
		
	</body>	
	</html>

The partial view (located at: `~/Views/Partials/ChildItem.cshtml`)

	@model IPublishedContent
	
	<strong>@Model.Name</strong>

