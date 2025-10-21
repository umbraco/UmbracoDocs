---
description: >-
  An Umbraco API Controller is an ASP.NET WebApi controller that is used for
  creating REST services.
---

# Controllers

Umbraco contains different types of controllers to perform different tasks:

* [Render MVC Controllers](controllers.md#render-mvc-controllers)
* [Surface Controllers](controllers.md#surface-controllers)
* [Umbraco API Controllers](controllers.md#umbraco-api-controllers)
* [Umbraco Authorized Controllers and Attributes](controllers.md#umbraco-authorized-controllers-and-attributes)

## Render MVC Controllers

When you make a page request to the MVC application, a controller is responsible for returning the response to that request. The controller can perform one or more actions.

By default, all front-end requests to an Umbraco site are auto-routed via the _Index_ action of a core Controller: `Umbraco.Cms.Web.Common.Controllers.RenderController`.

For details on using Render MVC Controllers, see the [Controller & Action Selection](default-routing/controller-selection.md) article.

## Surface Controllers

A SurfaceController is an MVC controller that interacts with the front-end rendering of an UmbracoPage. They can be used for rendering view components and for handling Form data submissions. SurfaceControllers are auto-routed which means you don't have to add/create your own routes for these controllers to work.

All implementations of Surface Controllers inherit from the base class: `Umbraco.Cms.Web.Website.Controllers.SurfaceController`.

For details on using Surface Controllers, see the [Surface Controllers](../reference/routing/surface-controllers/) article.

## Umbraco API Controllers

An Umbraco API Controller is an ASP.NET WebAPI controller that is used for creating REST services. These controllers are auto-routed which means that you don't have to add/create your own routes for these controllers to work.

All implementations of Umbraco API Controllers inherit from the base class: `Umbraco.Cms.Web.Common.Controllers.UmbracoApiController`.

For details on using Umbraco API Controllers, see the [Umbraco API Controllers](../reference/routing/umbraco-api-controllers/) article.

## Umbraco Authorized Controllers and Attributes

An Umbraco Authorized Controller is used when the controller requires member or user authentication (authN) and/or authorization (authZ). If either the `authN` or `authZ` fail, the controller will return a `401 - unauthorized response`.

### Backoffice Authorization

The Umbraco Authorized controllers and attributes for Backoffice Users are:

* **MVC**\
  There is no specific controller available to inherit from. We recommend inheriting from the basic `Umbraco.Cms.Web.Common.Controllers.UmbracoController` and applying the following attributes to your method:
  * `[Authorize(Policy = AuthorizationPolicies.BackOfficeAccess)]`: Uses .NET authorization using the BackOfficeAccess policy. We recommend adding extra custom authorization policies for your endpoints.
  *   `[DisableBrowserCache]`: Tells the browser to not cache the result.

      Remember to [add a route](../reference/routing/authorized.md#defining-a-route) for your controller.

#### Example custom authorized backoffice MVC Controller

```csharp
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Web.Common.Authorization;
using Umbraco.Cms.Web.Common.Controllers;
using Umbraco.Cms.Web.Common.Filters;

namespace My.Custom.Controllers;

[Authorize(Policy = AuthorizationPolicies.BackOfficeAccess)]
[DisableBrowserCache]
public class ExampleController : UmbracoController
{
    public ActionResult Test()
    {
        TempData["Test"] = "Test";
        return View();
    }
}
```

* **WebAPI**

{% hint style="warning" %}
`UmbracoAuthorizedApiController` and `UmbracoAuthorizedJsonController` have been removed from Umbraco 14. Use`ManagementApiControllerBase` class instead.
{% endhint %}

```
A base class implementation for authorized auto-routed Umbraco API controllers is inherited from: `Umbraco.Cms.Web.BackOffice.Controllers.UmbracoAuthorizedApiController`. This controller inherits from `Umbraco.Cms.Web.Common.Controllers.UmbracoApiController` it is auto-routed. This controller is also attributed with `Umbraco.Cms.Web.Common.Attributes.IsBackOfficeAttribute` to ensure that it is routed correctly to be authenticated for the backoffice.

Another base class implementation for the backoffice is `Umbraco.Cms.Web.BackOffice.Controllers.UmbracoAuthorizedJsonController`. It inherits from `Umbraco.Cms.Web.BackOffice.Controllers.UmbracoAuthorizedApiController` but has some special filters applied to it to automatically handle anti-forgery tokens for use with AngularJS in the backoffice.
```

For more details on Routing requirements, see the [Routing requirements for backoffice authentication](../reference/routing/authorized.md) article.

### Members & Front-end Authorization

Authorizing a controller for a front-end member is achieved with attributes:

* `Umbraco.Cms.Web.Common.Filters.UmbracoMemberAuthorizeAttribute` - Ensures authorization is successful for a website user (member).
* `Umbraco.Cms.Web.Common.Filters.UmbracoMemberAuthorizeFilter` - Ensures authorization is successful for a front-end member

You can attribute your controller or action with this attribute which will ensure that a member must be logged in to access the resource. An example:

```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Infrastructure.Persistence;
using Umbraco.Cms.Web.Common.Filters;
using Umbraco.Cms.Web.Website.Controllers;

namespace UmbracoProject.Controller;

[UmbracoMemberAuthorize]
public class AccountController : SurfaceController
{
    public AccountController(
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
    public IActionResult UpdateAccountInfo(AccountInfo accountInfo)
    {
        // TODO: Update the account info for the current member
    }
}
```

The `UmbracoMemberAuthorizeAttribute()` and `UmbracoMemberAuthorizeFilter()` contain the following properties to provide control over the authorization process for which members can access the resource:

* `AllowType` - Comma delimited list of allowed member types.
* `AllowGroup` - Comma delimited list of allowed member groups.
* `AllowMembers` - Comma delimited list of allowed members.

For more details, see the [Using MemberAuthorizeAttribute](../reference/routing/umbraco-api-controllers/authorization.md) section in the Umbraco API - Authorization article.

### Routing

For Umbraco to authenticate a request for the backoffice, the routing needs to be specific. For details on the routes and route requirements, see the [Routing requirements for backoffice authentication](../reference/routing/authorized.md). To secure your Umbraco API controllers based on a users membership, see the [Umbraco API - Authorization](../reference/routing/umbraco-api-controllers/authorization.md) article.
