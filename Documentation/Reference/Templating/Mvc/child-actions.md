#Using MVC Child Actions in Umbraco

**Applies to: Umbraco 4.10.0+**

_This section will demonstrate how to use MVC Child Actions when rendering a page in Umbraco_ 

##What is an MVC Child Action?

A Child Action in ASP.Net MVC is kind of similar to that of a User Control in ASP.Net web forms. It allows for a controller to execute for a portion of the rendered area of a view, just like in Web Forms where you can execute a UserControl for a portion of the rendered area of a page.

There is quite a lot of documentation on MVC Child Actions on the net, for example: http://[stackoverflow.com/questions/8886433/asp-net-mvc-child-actions](http://stackoverflow.com/questions/8886433/asp-net-mvc-child-actions)

Child Actions can be very powerful especially when you want to have re-usable controller code to execute that you otherwise wouldn't want executing inside of your view. This also makes unit testing this code much easier since you only have to test controller code, not code in a view.

##Creating a Child Action

This documentation is going to use [SurfaceControllers](surface-controllers.md) to create child actions but if you want to create child actions with your own custom controllers with your own custom routing that will work too. Once you've created a SurfaceController, you just need to create an action (Note the ChildActionOnly attribute, this will ensure that this action is not publicly routable via a URL):

	public class MySearchController : SurfaceController 
	{
		[ChildActionOnly]
		public ActionResult SearchResults(QueryParameters query)
		{		
			SearchResults result;
			//TODO: do some searching (perhaps using Examine) 
			//using the information contained in the custom class QueryParameters
	
			//return the SearchResults to the view
			return PartialView("SearchResults", result);
		}
	}

*NOTE: In this example we have used a SurfaceController to create the ChildAction and so long as you are using this Child Action in the context of rendering an Umbraco view, you will then have available all of the handy SurfaceController properties such as UmbracoHelper, UmbracoContext, etc...*

###Action name conflicts

MVC allows you to have the same overloaded action names on your controllers, however in some cases when POST-ing data and rendering a child action in the response, this can cause issues when MVC is trying to determine which action to use. If you have named both an `[HttpPost]` action and a `[ChildActionOnly]` action with the same name you may also need to attribute your `[HttpPost]` action with the attribute `[NotChildAction]` so that MVC doesn't get confused. 

##View Locations

The same view locations apply to Partial Views returned from Child Actions as the ones listed here: [Partial Views](partial-views.md)

Also not that since this example is using a Surface Controller and if we were shipping this controller as part of a package, then the ~/App_Plugins view location will work too. See  [SurfaceControllers](surface-controllers.md) documentation under the heading *Plugin based controllers*.

##Rendering a Child Action
To render a child action in your view is really easy, call the Html.Action method, pass in the Action name and your controller's name and the route values including your model. In this case we are passing in a new instance of a custom QueryParameters class and using a current 'search' query string from the Http request:

	@Html.Action("SearchResults", "MySearch", 
		new { query = new QueryParameters(Request.QueryString["search"]) })

*NOTE: notice that we are creating an anonymous object with a property called 'query', that is because our Child Action method accepts a parameter called 'query', these must match in order to work.*

This syntax becomes slightly different for Child Actions contained in Surface Controllers that are plugin based. The reason for this is because plugin based Surface Controllers are routed to an MVC Area, so we need to add the 'area' route parameter to this syntax. For an example, suppose we have the same class but it is marked to be a plugin based SurfaceController:

	[SurfaceController("MyCustomSearchPackage")]
	public class MySearchController : SurfaceController 
	{
		[ChildActionOnly]
		public ActionResult SearchResults(QueryParameters query)
		{		
			SearchResults result;
			//TODO: do some searching (perhaps using Examine) 
			//using the information contained in the custom class QueryParameters
	
			//return the SearchResults to the view
			return PartialView("SearchResults", result);
		}
	}

Now the syntax to render a Child Action becomes:

	@Html.Action("SearchResults", "MySearch", 
		new {
			area = "MyCustomSearchPackage", 
			query = new QueryParameters(Request.QueryString["search"]) 
		})

the only thing that is changed is that we've told it to route to the 'area' called "MyCustomSearchPackage". If this syntax seems strange to you please note that this routing logic and syntax is standard and very common practice in ASP.Net MVC.

More documentation regarding Child Actions and how to render them can be found on the net, a nice write up can also be found here: [http://haacked.com/archive/2009/11/18/aspnetmvc2-render-action.aspx](http://haacked.com/archive/2009/11/18/aspnetmvc2-render-action.aspx)