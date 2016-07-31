#Routing requirements for back office authentication

In order for Umbraco to authentication a request for the back office, the routing needs to be specific. Any URL that routes to :

> /umbraco/backoffice/*

will be authenticated. If you have a controller that is not routed within the prefix, it will not be authenticated for back office use.

You do not have to worry about routing if you are using WebApi and using `Umbraco.Web.WebApi.UmbracoAuthorizedApiController` (or any inherited controller) since these are auto routed. All implementations of `UmbracoAuthorizedApiController` (which includes `UmbracoAuthorizedJsonController`) are auto-routed with the default route:

> `/umbraco/backoffice/api/{controller}/{action}`

In the case that an Umbraco Api Controller is a 'Plugin Controller', then the route would be:

> `/umbraco/backoffice/{pluginname}/{controller}/{action}`

_Note:_ the {area} specified by the [PluginController] attribute replaces the /api/ area for the route.


##MVC controllers for the back office

If you are using MVC in the back office then you would normally inherit from `Umbraco.Web.Mvc.UmbracoAuthorizedController`. This type of controller is not auto-routed like Umbraco Api controllers so will require a custom route declaration to make it work.

For more information on authenticated/authorized controllers & attributes see the [Controllers Documentation](../../../Implementation/Controllers/index.md).

##Defining a route
When you create a controller that inherits from `Umbraco.Web.Mvc.UmbracoAuthorizedController` you need to explicitly define a route.  
Defining a route is done with the standard ASP.Net MVC routing practices. In Umbraco, you will normally create custom routes in `Umbraco.Core.ApplicationEventHandler.ApplicationStarted` event similar to the following:


    protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext    
    applicationContext)
    {
      RouteTable.Routes.MapRoute(
      name: "cats",
      url: "backoffice/cats/{action}/{id}",
      defaults: new
      {
        controller = "Cats",
        action = "Meow",
        id = UrlParameter.Optional
      });
    }

_NOTE the route must be prefixed with `backoffice` in order for Umbraco to check user authentication._

###What about Surface Controllers?
Surface Controllers should not be used in the back office.  Surface Controllers are not designed to work with the back office, they are not meant to be used there and will not be supported being used there.

##Special back office routes for user authentication
There are some special routes Umbraco checks to determine if the authentication should check a member of a user.

If any route has an extension in the path like `.aspx` or the below are always back office routes:

*  /Umbraco/RestServices
*  /Umbraco/BackOffice

If the route is not any of the above, and there's no extension then Umbraco cannot determine if it's back office or front-end - so front-end is assumed. This will occur if a `UmbracoApiController` is used rather than `UmbracoAuthorizedApiController` and the `[IsBackOffice]` attribute is not used.

In all of the above user authentication will be used.
