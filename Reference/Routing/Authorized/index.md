# Routing requirements for backoffice authentication

In order for Umbraco to authentication a request for the backoffice, the routing needs to be specific. Any URL that routes to :

> /umbraco/backoffice/*

will be authenticated. If you have a controller that is not routed within the prefix, it will not be authenticated for backoffice use.

You do not have to worry about routing if you are using WebApi and using `Umbraco.Web.WebApi.UmbracoAuthorizedApiController` (or any inherited controller) since these are auto routed. All implementations of `UmbracoAuthorizedApiController` (which includes `UmbracoAuthorizedJsonController`) are auto-routed with the default route:

> `/umbraco/backoffice/api/{controller}/{action}`

In the case that an Umbraco Api Controller is a 'Plugin Controller', then the route would be:

> `/umbraco/backoffice/{pluginname}/{controller}/{action}`

_Note:_ the {area} specified by the [PluginController] attribute replaces the /api/ area for the route.


## MVC controllers for the backoffice

If you are using MVC in the backoffice then you would normally inherit from `Umbraco.Web.Mvc.UmbracoAuthorizedController`. This type of controller is not auto-routed like Umbraco Api controllers so will require a custom route declaration to make it work.

For more information on authenticated/authorized controllers & attributes see the [Controllers Documentation](../../../Implementation/Controllers/index.md).

## Defining a route
When you create a controller that inherits from `Umbraco.Web.Mvc.UmbracoAuthorizedController` you need to explicitly define a route.  
Defining a route is done with the standard ASP.NET MVC routing practices. In Umbraco, you will normally create custom routes in `Umbraco.Core.ApplicationEventHandler.ApplicationStarted` event similar to the following:


    protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext    
    applicationContext)
    {
      RouteTable.Routes.MapRoute(
      name: "cats",
      url: GlobalSettings.UmbracoMvcArea + "/backoffice/cats/{action}/{id}",
      defaults: new
      {
        controller = "Cats",
        action = "Meow",
        id = UrlParameter.Optional
      });
    }

_NOTE the route must be prefixed with Umbraco path which is configurable and resolved with `GlobalSettings.UmbracoMvcArea` and then by "backoffice" in order for Umbraco to check user authentication._

### What about Surface Controllers?
Surface Controllers should not be used in the backoffice.  Surface Controllers are not designed to work with the backoffice, they are not meant to be used there and will not be supported being used there.

## Special backoffice routes for user authentication
There are some special routes Umbraco checks to determine if the authentication should check a member of a user.

If any route has an extension in the path like `.aspx` or the below are always backoffice routes:

*  /Umbraco/RestServices
*  /Umbraco/BackOffice

If the route is not any of the above, and there's no extension then Umbraco cannot determine if it's backoffice or front-end - so front-end is assumed. This will occur if a `UmbracoApiController` is used rather than `UmbracoAuthorizedApiController` and the `[IsBackOffice]` attribute is not used.

In all of the above user authentication will be used.
