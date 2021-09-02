---
versionFrom: 9.0.0
meta.Title: "Surface Controllers"
meta.Description: "Information about Surface Controllers in Umbraco"
state: complete
verified-against: beta-4
update-links: true
---

# Surface controllers

_A surface controller is an MVC controller that interacts with the front-end rendering of an Umbraco page. They can be used for rendering view components and for handling form data submissions. Surface controllers are auto-routed, meaning that you don't have to add/create your own routes for these controllers to work._

## What is a surface controller?

It is a regular ASP.NET Core MVC controller that:

* Is auto-routed, meaning you don't have to setup any custom routes to make it work
* Is used for interacting with the front-end of Umbraco (not the backoffice)

Since any surface controller inherits from the `Umbraco.Cms.Web.Website.Controllers.SurfaceController` class, the controller instantly supports many of the helper methods and properties that are available on the base `SurfaceController` class including `UmbracoContext`. Therefore, all surface controllers have native Umbraco support for:

* Interacting with Umbraco routes during HTTP POSTs (i.e. `return CurrentUmbracoPage();` )
* Rendering forms in Umbraco (i.e. `@using (Html.BeginUmbracoForm<MyController>(...)){}` )
* Rendering of ASP.NET Core MVC view components

## Creating a surface controller

Surface controllers are plugins, meaning they are found when the Umbraco application boots. There are 2 types of surface controllers: **locally declared** & **plugin based**. The main difference between the two is that a plugin based controller gets routed via an MVC area, which is defined in the controller (see below). Because a plugin based controller is routed via an MVC area, it means that the views can be stored in a custom folder specific to the package it is being shipped in. This can be done without interfering with the local developer's MVC view files.

### Locally declared controllers

A locally declared surface controller is one that is not shipped within an Umbraco package. It is created by the developer of the website they are creating. If you are planning on shipping a surface controller in an Umbraco package, then you will need to create a plugin based surface controller (see the next heading).

To create a locally declared surface controller:

* Create a controller that inherits from `Umbraco.Cms.Web.Website.Controllers.SurfaceController`
* The controller must be a public class.
* The controller must call the base constructor of `SurfaceController`
* The controller's name must be suffixed with the term `Controller`
* The controller must be inside a namespace

For example:

```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Infrastructure.Persistence;
using Umbraco.Cms.Web.Website.Controllers;

namespace RoutingDocs.Controllers
{
    public class MyController : SurfaceController
    {
        public MyController(
            IUmbracoContextAccessor umbracoContextAccessor,
            IUmbracoDatabaseFactory databaseFactory,
            ServiceContext services,
            AppCaches appCaches,
            IProfilingLogger profilingLogger,
            IPublishedUrlProvider publishedUrlProvider)
            : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
        {
        }

        public IActionResult Index()
        {
            return Content("Hello world");
        }
    }
}
```

#### Routing for locally declared controllers

All locally declared controllers gets routed to:

    /umbraco/surface/{controllername}/{action}/{id}

They do not get routed via an MVC area, so any views must exist in the following folders:

* `/Views/{controllername}/`
* `/Views/Shared/`
* `/Views/`

:::tip
If you get a 404 error when trying to access your surface controller, you may have forgotten to add a namespace to it!
:::

## Plugin based controllers

If you are shipping a surface controller in a package, then you should definitely be creating a plugin based surface controller. The only difference between creating a plugin based controller and locally declared controller, is that you need to add an attribute to your class, which defines the MVC area you'd like your controller to be routed through. Here's an example:

```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Infrastructure.Persistence;
using Umbraco.Cms.Web.Common.Attributes;
using Umbraco.Cms.Web.Website.Controllers;

namespace SurfaceControllerPackage
{
    [PluginController("SurfaceControllerPackage")]
    public class MyController : SurfaceController
    {
        public MyController(
            IUmbracoContextAccessor umbracoContextAccessor,
            IUmbracoDatabaseFactory databaseFactory,
            ServiceContext services,
            AppCaches appCaches,
            IProfilingLogger profilingLogger,
            IPublishedUrlProvider publishedUrlProvider)
            : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
        {
        }

        public IActionResult Index()
        {
            return Content("Hello world");
        }
    }
}
```

In the above, the surface controller will belong to the MVC area called 'SurfaceControllerPackage'. Perhaps it is obvious, but if you are creating a package that contains many surface controllers, then you should most definitely ensure that all of your controllers are routed through the same MVC area.

#### Routing for plugin based controllers

All plugin based controllers get routed to:

    /umbraco/{areaname}/{controllername}/{action}/{id}

Since they get routed via an MVC area, your views should be placed in the following folder:

* `~/App_Plugins/{areaname}/Views/{controllername}/`
* `~/App_Plugins/{areaname}/Views/Shared/`

Since you're only able to place static filese within your package's `App_Plugin` folder, it's highly recommend to ensure that the area you use is the same as your package name, since that allows your views to be found.

The controller itself should not be placed in the App_Plugins folder, the App_Plugins folder is for static files only, compiled files like the controller will be included in the dlls used by the nuget package. 

#### Protecting surface controller routes

If you only want a surface controller action to be available when it's used within an Umbraco form and not from the auto-routed URL, you can add the `[ValidateUmbracoFormRouteString]` attribute to the action method. This can be especially useful for plugin based controllers, as this makes sure the actions can only be activated from a form whenever it's used within the website.

```csharp
namespace RoutingDocs.Controllers
{
    public class MyController : SurfaceController
    {
        public MyController(
            IUmbracoContextAccessor umbracoContextAccessor,
            IUmbracoDatabaseFactory databaseFactory,
            ServiceContext services,
            AppCaches appCaches,
            IProfilingLogger profilingLogger,
            IPublishedUrlProvider publishedUrlProvider)
            : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
        {
        }

        [HttpPost]
        [ValidateUmbracoFormRouteString]
        public IActionResult HandleSubmit()
        {
            return RedirectToCurrentUmbracoPage();
        }
    }
}
```

Whenever you render an Umbraco form within your view using `Html.BeginUmbracoForm<MyController>(...)`, the forms action will be the URL of the current page (not the auto-routed URL of the surface controller). Umbraco will therefore add a hidden `ufprt` field to the form with an encrypted value containing the controller, action and optional area (known as the 'Umbraco form route string'). On form submission, this value is decrypted and Umbraco will activate the specified action of the surface controller.

```html
@using (Html.BeginUmbracoForm<MyController>("HandleSubmit"))
{
    <input type="submit" />
}
```

Note this doesn't protect against Cross-Site Request Forgery (CSRF) attacks, there is a `__RequestVerificationToken` you can use to protect you from this.

### Surface Controller Actions

You can read more about the surface controller [action result helpers](surface-controllers-actions-v9.md).
