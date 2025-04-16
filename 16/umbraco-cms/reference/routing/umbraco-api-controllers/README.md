---
description: A guide to implementing APIs in Umbraco projects
---

# Umbraco API Controllers

This article describes how to work with API Controllers in Umbraco to create REST services.

{% hint style="warning" %}
`UmbracoApiController` has been removed from Umbraco CMS as of version 15.

Read the article [Porting old Umbraco APIs](porting-old-umbraco-apis.md) for more details.
{% endhint %}

## What is an API?

The Microsoft ASP.NET Core API documentation is a great place to familiarize yourself with API concepts. It can be found on the [official ASP.NET Core site](https://dotnet.microsoft.com/en-us/apps/aspnet/apis).

## Public APIs in Umbraco

A public API in Umbraco is created as any other ASP.NET Core API:

{% code title="ProductsController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;

namespace UmbracoDocs.Samples;

[ApiController]
[Route("/api/shop/products")]
public class ProductsController : Controller
{
    [HttpGet]
    public IActionResult GetAll() => Ok(new[] { "Table", "Chair", "Desk", "Computer" });
}
```
{% endcode %}

## Adding member protection to public APIs

To protect your APIs based on front-end membership, you can annotate your API controllers with the `[UmbracoMemberAuthorize]` attribute.

There are 3 parameters that can be supplied to control how the authorization works:

```csharp
// Comma delimited list of allowed member types
string AllowType

// Comma delimited list of allowed member groups
string AllowGroup

// Comma delimited list of allowed member Ids
string AllowMembers
```

To allow all members, use the attribute without supplying any parameters.

You can apply these attributes either at controller level or at action level.

{% hint style="info" %}
Read more about members and member login in the [Member Registration and Login](../../../tutorials/members-registration-and-login.md) article.
{% endhint %}

### Examples

This will allow any logged in member to access all actions in the `ProductsController` controller:

{% code title="ProductsController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Web.Common.Filters;

namespace UmbracoDocs.Samples;

[ApiController]
[Route("/api/shop/products")]
[UmbracoMemberAuthorize]
public class ProductsController : Controller
{
    [HttpGet]
    public IActionResult GetAll() => Ok(new[] { "Table", "Chair", "Desk", "Computer" });
}
```
{% endcode %}

This will only allow logged in members of type "Retailers" to access the `GetAll` action:

{% code title="ProductsController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Web.Common.Filters;

namespace UmbracoDocs.Samples;

[ApiController]
[Route("/api/shop/products")]
public class ProductsController : Controller
{
    [HttpGet]
    [UmbracoMemberAuthorize("Retailers", "", "")]
    public IActionResult GetAll() => Ok(new[] { "Table", "Chair", "Desk", "Computer" });
}
```
{% endcode %}

This will only allow members belonging to the "VIP" group to access any actions on the controller:

{% code title="ProductsController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Web.Common.Filters;

namespace UmbracoDocs.Samples;

[ApiController]
[Route("/api/shop/products")]
[UmbracoMemberAuthorize("", "VIP", "")]
public class ProductsController : Controller
{
    [HttpGet]
    public IActionResult GetAll() => Ok(new[] { "Table", "Chair", "Desk", "Computer" });
}
```
{% endcode %}

This will only allow the members with ids 1, 10 and 20 to access the `GetAll` action:

{% code title="ProductsController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Web.Common.Filters;

namespace UmbracoDocs.Samples;

[ApiController]
[Route("/api/shop/products")]
public class ProductsController : Controller
{
    [HttpGet]
    [UmbracoMemberAuthorize("", "", "1,10,20")]
    public IActionResult GetAll() => Ok(new[] { "Table", "Chair", "Desk", "Computer" });
}
```
{% endcode %}

## Backoffice API Controllers

Read the [Creating a Backoffice API article](../../../tutorials/creating-a-backoffice-api/README.md) for a comprehensive guide to writing APIs for the Management API.

{% hint style="info" %}
The Umbraco Backoffice API is also known as the Management API. Thus, a Backoffice API Controller is often referred to as a Management API Controller.
{% endhint %}
