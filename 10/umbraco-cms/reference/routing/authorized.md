---


meta.Title: "Routing Requirements for Backoffice authentication"
description: "Requirements for authenticating requests for the backoffice"
---

# Backoffice authentication

In order for Umbraco to authenticate a request for the backoffice, the routing needs to be specific. Any URL that routes to:

> /umbraco/backoffice/*

will be authenticated. If you have a controller that is not routed within the prefix, it will not be authenticated for backoffice use.

You do not have to worry about routing if you are using `Umbraco.Cms.Web.BackOffice.Controllers.UmbracoAuthorizedApiController` (or any inherited controller) since these are auto routed. All implementations of `UmbracoAuthorizedApiController` (which includes `UmbracoAuthorizedJsonController`) are auto-routed with the default route:

> `/umbraco/backoffice/api/{controller}/{action}`

In the case that an Umbraco Api Controller is a 'Plugin Controller', then the route would be:

> `/umbraco/backoffice/{pluginname}/{controller}/{action}`

{% hint style="info" %}
The {area} specified by the [PluginController] attribute replaces the /api/ area for the route.
{% endhint %}

## MVC controllers for the backoffice

Depending on the type of controller used (MVC or WebAPI), the controller is not auto-routed. You will need to declare a custom route and register it with the Umbraco DI container to make it work.

For more information on authenticated/authorized controllers & attributes see the [Controllers Documentation](../../implementation/controllers.md).

## Defining a route

Defining a route is done with the standard .NET Core MVC routing practices, however there is a handy extension method on the `IEndpointRouteBuilder` to help you.

When creating custom routes you can either do it directly in the `Startup.cs` files, or with a pipeline filter in a composer which looks something like:

```csharp
public class MyControllerComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.Configure<UmbracoPipelineOptions>(options =>
        {
            options.AddFilter(new UmbracoPipelineFilter(nameof(MyController))
            {
                Endpoints = app => app.UseEndpoints(endpoints =>
                {
                    var globalSettings = app.ApplicationServices
                        .GetRequiredService<IOptions<GlobalSettings>>().Value;
                    var hostingEnvironment = app.ApplicationServices
                        .GetRequiredService<IHostingEnvironment>();
                    var backofficeArea = Constants.Web.Mvc.BackOfficePathSegment;

                    var rootSegment = $"{globalSettings.GetUmbracoMvcArea(hostingEnvironment)}/{backofficeArea}";
                    var areaName = "MyPackageName";
                    endpoints.MapUmbracoRoute<MyController>(rootSegment, areaName, areaName);
                })
            });
        });
    }
}
```

The signature of `MapUmbracoRoute<T>` is as follows

```csharp
public static void MapUmbracoRoute<T>(
            this IEndpointRouteBuilder endpoints,
            string rootSegment,
            string areaName,
            string? prefixPathSegment,
            string defaultAction = "Index",
            bool includeControllerNameInRoute = true,
            object? constraints = null)
```

* The generic type argument is the contoller you wish to route, in this case `MyController`.
* `rootSegment` - The first part of the pattern, since this is an authorized controller it has to be `umbraco/backoffice`.
* `areaName` - The name of the area the controller should be routed through, an empty string signifies no area.
* `prefixPathSegment` - Prefix to be applied to the rootSegment, we know this from api controllers where the prefix is `api`, in this case since the controller is in an area we will also prefix the area name to the URL, so the final path pattern will be `umbraco/backoffice/mypackagename/{controllerName}/{action}/{id?}`.
* `defaultAction` - If this is not null or an empty string the request will automatically be routed to the specified action, so in this case `umbraco/backoffice/mypackagename/{controllerName}` will route to the index action.
* `includeControllerNameInRoute` - If this is false the controller name will be excluded from the route, so in this case the route would be `umbraco/backoffice/mypackagename/{action}/{id?}` if this was set to false.
* `constraints` - Any routing constraints passed to this will be used when mapping the route see [Microsoft documentation](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/routing?view=aspnetcore-5.0#route-constraint-reference) for more information.

Using the `MapUmbracoRoute` extension method is optional though, it's a neat helper to ensure controllers get routed in the same way. If your controller uses an area, like in this example, you need to specify this using the `Area` attribute. In this example the controller looks like this:

```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Web.Common.Controllers;

namespace Umbraco.Cms.Web.UI.NetCore
{
    [Area("MyPackageName")]
    public class MyController : UmbracoAuthorizedController
    {
        public IActionResult Index()
        {
            return Content("Hello from authorized controller");
        }
    }
}
```


{% hint style="info" %}
The route must be prefixed with the Umbraco path, which is configurable and resolved with `GetUmbracoMvcArea()` from `IGlobalSettings`. Then, it should be followed by "/backoffice" in order for Umbraco to check user authentication.
{% endhint %}

### What about Surface Controllers?
Surface Controllers should not be used in the backoffice. Surface Controllers are not designed to work with the backoffice. They are not meant to be used there and will not be supported being used there.
