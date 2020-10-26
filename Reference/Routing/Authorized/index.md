---
versionFrom: 8.0.0
---

# Routing requirements for backoffice authentication

In order for Umbraco to authentication a request for the backoffice, the routing needs to be specific. Any URL that routes to :

> /umbraco/backoffice/*

will be authenticated. If you have a controller that is not routed within the prefix, it will not be authenticated for backoffice use.

You do not have to worry about routing if you are using WebApi and using `Umbraco.Web.WebApi.UmbracoAuthorizedApiController` (or any inherited controller) since these are auto routed. All implementations of `UmbracoAuthorizedApiController` (which includes `UmbracoAuthorizedJsonController`) are auto-routed with the default route:

> `/umbraco/backoffice/api/{controller}/{action}`

In the case that an Umbraco Api Controller is a 'Plugin Controller', then the route would be:

> `/umbraco/backoffice/{pluginname}/{controller}/{action}`

:::note
The {area} specified by the [PluginController] attribute replaces the /api/ area for the route.
:::

## MVC controllers for the backoffice

If you are using MVC in the backoffice then you would normally inherit from `Umbraco.Web.Mvc.UmbracoAuthorizedController`. This type of controller is not auto-routed like Umbraco Api controllers so will require a custom route declaration and be registered with the Umbraco DI container to make it work.

For more information on authenticated/authorized controllers & attributes see the [Controllers Documentation](../../../Implementation/Controllers/index.md).

## Defining a route
When you create a controller that inherits from `Umbraco.Web.Mvc.UmbracoAuthorizedController` you need to explicitly define a route.
Defining a route is done with the standard ASP.NET MVC routing practices. In Umbraco, you will normally create custom routes in the initialize() method of a c# class implementing `Umbraco.Core.Composing.IComponent` similar to the following:

```csharp
    public class RegisterCustomBackofficeMvcRouteComponent : IComponent
    {
        private readonly IGlobalSettings _globalSettings;

        public RegisterCustomBackofficeMvcRouteComponent(IGlobalSettings globalSettings)
        {
            _globalSettings = globalSettings;
        }

        public void Initialize()
        {
            RouteTable.Routes.MapRoute("[yourPluginName]", 
                _globalSettings.GetUmbracoMvcArea() + "/backoffice/[yourpluginname]/{controller}/{action}/{id}", 
                new
                {
                    controller = "[yourpluginname]",
                    action = "Index",
                    id = UrlParameter.Optional },
                constraints: new { controller="[yourcontrollername]" });
        }

        public void Terminate()
        {
            // Nothing to terminate
        }
    }
```

:::note
the route must be prefixed with Umbraco path which is configurable and resolved with `GetUmbracoMvcArea()` from `IGlobalSettings` and then by "/backoffice" in order for Umbraco to check user authentication.
:::
### Registering the Component + Controller with Umbraco

In order for the Component above to be considered by Umbraco it needs to be added to the Umbraco Composition's list of Components, and our custom CatsController needs to be registered with the underlying Umbraco DI Container:
```csharp
    public class RegisterCustomBackofficeMvcRouteComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.Register<CatsController>(Lifetime.Request);
            composition.Components().Append<RegisterCustomBackofficeMvcRouteComponent>();

        }
    }
```

### What about Surface Controllers?
Surface Controllers should not be used in the backoffice.  Surface Controllers are not designed to work with the backoffice, they are not meant to be used there and will not be supported being used there.

## Special backoffice routes for user authentication
There are some special routes Umbraco checks to determine if the authentication should check a member of a user.

If any route has an extension in the path like `.aspx` or the below are always backoffice routes:

*  /Umbraco/BackOffice

If the route is not any of the above, and there's no extension then Umbraco cannot determine if it's backoffice or front-end - so front-end is assumed. This will occur if a `UmbracoApiController` is used rather than `UmbracoAuthorizedApiController` and the `[IsBackOffice]` attribute is not used.

In all of the above user authentication will be used.
