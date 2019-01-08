---
product: "UmbracoCms"
complexity: "Intermediate"
audience: "Developers"
meta.Title: "Controllers in Umbraco"
meta.Description: "An Umbraco API Controller is an ASP.NET WebApi controller that is used for creating REST services."
---
# Controllers in Umbraco

_There are a few types of controllers in Umbraco that perform different tasks_

## Render MVC Controllers

These are the controllers that get executed when rendering content during an Umbraco route.

These controllers are of type `Umbraco.Web.MVC.RenderMvcController`.

See [Controller & Action Selection for details on using these controllers](../Default-Routing/Controller-Selection/)

## Surface Controllers

A SurfaceController is an MVC controller that interacts with the front-end rendering of an UmbracoPage. They can be used for rendering MVC Child Actions and for handling form data submissions.
SurfaceControllers are auto-routed meaning that you don't have to add/create your own routes for these controllers to work.

All implementations of SurfaceControllers inherit from the base class `Umbraco.Web.Mvc.SurfaceController`.

See [Reference documentation on SurfaceControllers for full details](../../Reference/Routing/surface-controllers.md)

## Umbraco Api Controllers

An Umbraco API Controller is an ASP.NET WebApi controller that is used for creating REST services. These controllers are auto-routed meaning that you don't have to add/create your own routes for these controllers to work.

All implementations of Umbraco Api Controllers inherit from the base class `Umbraco.Web.WebApi.UmbracoApiController`.

See [Reference documentation on Umbraco Api Controllers for full details](../../Reference/Routing/WebApi/index.md)

## Umbraco Authorized Controllers and Attributes

An Umbraco Authorized controller is used when the controller requires member or user authentication (authN) and/or authorization (authZ). If either the authN or authZ fail the controller will return a "401 - unauthorized response."  

### Backoffice Authorization

The Umbraco Authorized controllers and attributes for backoffice users are:

#### MVC

Any MVC Controller or Action that is attributed with `Umbraco.Web.Mvc.UmbracoAuthorizeAttribute` will authenticate the request for a backoffice user. A base class implementation that already exists with this attribute is: `Umbraco.Web.Mvc.UmbracoAuthorizedController`. These MVC controllers are not auto-routed.  See [Routing requirements for backoffice authentication](../../Reference/Routing/Authorized/index.md) for more details on routing requirements.

#### WebApi

Any WebApi Controller or Action that is attributed with `Umbraco.Web.WebApi.UmbracoAuthorizeAttribute` will authenticate the request for a backoffice user.

A base class implementation that already exists with this attribute is: `Umbraco.Web.WebApi.UmbracoAuthorizedApiController`. Since this controller inherits from `Umbraco.Web.WebApi.UmbracoApiController` it is auto-routed. This controller is also attributed with `Umbraco.Web.WebApi.IsBackOfficeAttribute` to ensure that it is routed correctly to be authenticated for the backoffice.

Another common base class implementation for the backoffice is `Umbraco.Web.Editors.UmbracoAuthorizedJsonController` which inherits from `Umbraco.Web.WebApi.UmbracoAuthorizedApiController` but has some special filters applied to it to automatically handle anti-forgery tokens for use with AngularJS in the backoffice.

### Members & Front-end Authorization

Authorizing a controller for a front-end member is achieved with attributes:

* `Umbraco.Web.Mvc.MemberAuthorizeAttribute` - for MVC controllers
* `Umbraco.Web.WebApi.MemberAuthorizeAttribute` - for WebApi controllers

You can attribute your controller or action with this attribute which will ensure that a member must be logged in to access the resource. An example:

```csharp
[MemberAuthorize]
public class AccountController : SurfaceController
{
    [HttpPost]
    public ActionResult UpdateAccountInfo(AccountInfo accountInfo)
    {
        // TODO: Update the account info for the current member
    }
}
```

There are a few properties that exist for the attribute to give you more control over the authorization process for which members can access the resource:

* `AllowType` - Comma delimited list of allowed member types
* `AllowGroup` - Comma delimited list of allowed member groups

### Routing

For details on the routes and route requirements regarding authentication see [Routing for authentication](../../Reference/Routing/Authorized/index.md)
