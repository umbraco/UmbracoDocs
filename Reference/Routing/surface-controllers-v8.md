---
versionFrom: 7.0.0
meta.Title: "Surface Controllers"
meta.Description: "Information about Surface Controllers in Umbraco"
---

# Surface controllers

_A surface controller is an MVC controller that interacts with the front-end rendering of an Umbraco page. They can be used for rendering MVC child actions and for handling form data submissions. Surface controllers are auto-routed, meaning that you don't have to add/create your own routes for these controllers to work._

## What is a surface controller?

It is a regular ASP.NET MVC controller that:

* Is auto-routed, meaning you don't have to setup any custom routes to make it work
* Is used for interacting with the front-end of Umbraco (not the backoffice)

Since any surface controller inherits from the `Umbraco.Web.Mvc.SurfaceController` class, the controller instantly supports many of the helper methods and properties that are available on the base `SurfaceController` class including `UmbracoHelper` and `UmbracoContext`. Therefore, all surface controllers have native Umbraco support for:

* Interacting with Umbraco routes during HTTP POSTs (i.e. `return CurrentUmbracoPage();` )
* Rendering forms in Umbraco (i.e. `@using (Html.BeginUmbracoForm<MyController>(...)){}` )
* Rendering of ASP.NET MVC child actions

## Creating a surface controller

Surface controllers are plugins, meaning they are found when the Umbraco application boots. There are 2 types of surface controllers: **locally declared** & **plugin based**. The main difference between the two is that a plugin based controller gets routed via an MVC area, which is defined in the controller (see below). Because a plugin based controller is routed via an MVC area, it means that the views can be stored in a custom folder specific to the package it is being shipped in. This can be done without interfering with the local developer's MVC view files.

### Locally declared controllers

A locally declared surface controller is one that is not shipped within an Umbraco package. It is created by the developer of the website they are creating. If you are planning on shipping a surface controller in an Umbraco package, then you will need to create a plugin based surface controller (see the next heading).

To create a locally declared surface controller:

* Create a controller that inherits from `Umbraco.Web.Mvc.SurfaceController`
* The controller must be a public class.
* The controller's name must be suffixed with the term `Controller`
* The controller must be inside a namespace

For example:

```csharp
namespace TestWebsite.Core.Controllers
{
    public class MyController : Umbraco.Web.Mvc.SurfaceController
    {
        public ActionResult Index()
        {
            return Content("hello world");
        }
    }
}
```

#### Routing for locally declared controllers

All locally declared controllers get routed to:

    /umbraco/surface/{controllername}/{action}/{id}

They do not get routed via an MVC area, so any views must exist in the following folders:

* `~/Views/{controllername}/`
* `~/Views/Shared/`
* `~/Views/`

:::tip
If you get a 404 error when trying to access your surface controller, you may have forgotten to add a namespace to it!
:::

## Plugin based controllers

If you are shipping a surface controller in a package, then you should definitely be creating a plugin based surface controller. The only difference between creating a plugin based controller and locally declared controller, is that you need to add an attribute to your class, which defines the MVC area you'd like your controller to be routed through. Here's an example:

```csharp
namespace TestPackage.Core.Controllers
{
    [PluginController("SuperAwesomeAnalytics")]
    public class MyController : Umbraco.Web.Mvc.SurfaceController
    {
        public ActionResult Index()
        {
            return Content("hello world");
        }
    }
}
```

In the above, the surface controller will belong to the MVC area called 'SuperAwesomeAnalytics'. Perhaps it is obvious, but if you are creating a package that contains many surface controllers, then you should most definitely ensure that all of your controllers are routed through the same MVC area.

#### Routing for plugin based controllers

All plugin based controllers get routed to:

    /umbraco/{areaname}/{controllername}/{action}/{id}

Since they get routed via an MVC area, your views should be placed in the following folder:

* `~/App_Plugins/{areaname}/Views/{controllername}/`
* `~/App_Plugins/{areaname}/Views/Shared/`

The controller itself should not be placed in the App_Plugins folder, as files in this folder are not compiled by Umbraco. Either build your controller to a dll file and place it in bin, or put the .cs file in the App_Code folder.

#### Protecting surface controller routes

If you only want a surface controller action to be available when it's used within an Umbraco form and not from the auto-routed URL, you can add the `[ValidateUmbracoFormRouteString]` attribute to the action method. This can be especially useful for plugin based controllers, as this makes sure the actions can only be activated whenever it's used within the website.

```csharp
namespace TestWebsite.Core.Controllers
{
    public class MyController : Umbraco.Web.Mvc.SurfaceController
    {
        [HttpPost]
        [ValidateUmbracoFormRouteString]
        public ActionResult HandleSubmit()
        {
            return RedirectToCurrentUmbracoPage();
        }
    }
}
```

:::note
This attribute is only available since Umbraco 7.15.1 and 8.1.1.
:::

Whenever you render an Umbraco form within your view using `Html.BeginUmbracoForm<MyController>(...)`, the forms action will be the URL of the current page (not the auto-routed URL of the surface controller). Umbraco will therefore add a hidden `ufprt` field to the form with an encrypted value containing the controller, action and optional area (known as the 'Umbraco form route string'). On form submission, this value is decrypted and Umbraco will activate the specified action of the surface controller.

```html
@using (Html.BeginUmbracoForm<MyController>("HandleSubmit"))
{
    <input type="submit" />
}
```

This concept is similair to ASP.NET Web Form's view state, but only stores the route information, so the value is considerably smaller. Also note this doesn't protect against Cross-Site Request Forgery (CSRF) attacks: you can use ASP.NET MVC anti-forgery tokens to protect you from this.

:::note
Encryption/decryption is done using the machine key (configured in the `Web.config` file), so make sure this is unique for every website. The current Umbraco installer will thankfully allow you to automatically generate a unique machine key for you, so make sure to do so!
:::

### Surface Controller Actions

You can read more about the surface controller [action result helpers](surface-controllers-actions.md).
