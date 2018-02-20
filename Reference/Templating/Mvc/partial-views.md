#Using MVC Partial Views in Umbraco

_This section will show you how to use MVC Partial Views in Umbraco. Please note, this is documentation relating to the use of native MVC partial views, not '[Partial View Macros](../Macros/Partial-View-Macros/index.md)'_

##Overview

Using Partial Views in Umbraco is exactly the same as using Partial Views in a normal MVC project. There is detailed documentation on the Internet about creating and using MVC partial views, for example:

* [http://www.asp.net/mvc/videos/mvc-2/how-do-i/how-do-i-work-with-data-in-aspnet-mvc-partial-views](http://www.asp.net/mvc/videos/mvc-2/how-do-i/how-do-i-work-with-data-in-aspnet-mvc-partial-views)

Partial views allow you to easily re-use components between your views (templates).

##View Locations

The locations to store Partial Views when rendering in the Umbraco pipeline is:

	~/Views/Partials

The standard MVC partial view locations will also work:

	~/Views/Shared
	~/Views/RenderMvc

The ~/Views/RenderMvc location is valid because the controller that performs the rendering in the Umbraco codebase is the: `Umbraco.Web.Mvc.RenderMvcController`

If however you are [Hijacking an Umbraco route](custom-controllers.md) and specifying your own controller to do the execution, then your partial view location can also be:

	~/Views/{YourControllerName}

##Example

A quick example of a content item that has a template that renders out a partial view template for each of its child documents:

The MVC template markup for the document:

	@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
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

#Strongly typed Partial Views

Normally you would create a partial view by simply using the `@model MyModel` syntax. However, inside of Umbraco you will probably want to have access to the handy properties available on your normal Umbraco views like the Umbraco helper: `@Umbraco` and the Umbraco context: `@UmbracoContext`. The good news is that this is completely possible. Instead of using the `@model MyModel` syntax, you just need to inherit from the correct view class, so do this instead:

	@inherits Umbraco.Web.Mvc.UmbracoViewPage<MyModel>

By inheriting from this view, you'll have instant access to those handy properties and have your view created with a strongly typed custom model.

Another case you might have is that you want your Partial View to be strongly typed with the same model type (`RenderModel`) as a normal template if you are passing around instances of IPublishedContent. To do this, just have your partial view inherit from `Umbraco.Web.Mvc.UmbracoTemplatePage` (just like your normal templates).  When you render your partial, a neat trick is that you can just pass it an instance of `IPublishedContent` instead of a new instance of `RenderModel`. For example:

	@foreach(var child in Model.Content.Children())
	{
		@Html.Partial("MyPartialName", child)
	}

The partial view can still inherit from `Umbraco.Web.Mvc.UmbracoTemplatePage`, which has a model of `RenderModel`, but you can still just pass it an instance of `IPublishedContent` and a new `RenderModel` will be created and applied automagically for you. Of course you can always create your own `RenderModel` too:

	@foreach(var child in Model.Content.Children())
	{
		@Html.Partial("MyPartialName",
			new global::Umbraco.Web.Models.RenderModel(child, Model.CurrentCulture))
	}

Both of these will achieve the same result.

##Caching

You don't normally need to cache the output of Partial views, just like you don't normally need to cache the output of User Controls, but there are times when this is necessary. Just like macro caching, we provide caching output of partial views. This is done simply by using an HtmlHelper extension method:

	@Html.CachedPartial("MyPartialName", new MyModel(), 3600)

The above will cache the output of your partial view for one hour (3600 seconds). Additionally, there are a few optional parameters you can specify to this method. Here is the full method signature:

	IHtmlString CachedPartial(
		string partialViewName,
		object model,
		int cachedSeconds,
		bool cacheByPage = false,
		bool cacheByMember = false,
		ViewDataDictionary viewData = null,
		Func<object, ViewDataDictionary, string> contextualKeyBuilder = null)

So you can specify to cache by member and/or by page and also specify additional view data to your partial view. If your view data is dynamic (meaning it could change per page request) you can tell Umbraco to cache multiple versions based on parameter values.  The Model however will not do the same so the result will be the cached result of the first execution.  If the Model is simply the current page and cacheByPage is enabled then there is no problem.

To create multiple versions based on one or more viewData parameters you can do something like this:

	@Html.CachedPartial("MediaGallery", Model, 3600, true, false, new ViewDataDictionary { { "year", Request.QueryString["year"] } }, (model, viewData) => viewData["year"].ToString() + viewData["Parameter2"].ToString() )

Or using a custom helper function:

	public static Func<object, ViewDataDictionary, string> CacheBy(this HtmlHelper htmlHelper, params string[] keys)
	{
		return (model, viewData) => String.Join("", keys.Select(s => viewData[s].ToString()));
	}
	
	@Html.CachedPartial("MediaGallery", Model, 3600, true, false, new ViewDataDictionary { { "year", Request.QueryString["year"] } }, Html.CacheBy("yer", "Parameter2") )
	
Or even bassed off the Model, though is Model is just the current page then cacheByPage should be used instead:

	@Html.CachedPartial("MediaGallery", Model, 3600, true, false, new ViewDataDictionary { }, (model, viewData) => model.myField )

Regardless of the complexity here the contextualKeyBuilder function needs to return a single string value.
