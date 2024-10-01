---
description: A guide to implementing APIs in Umbraco projects
---

# Umbraco API Controllers

This article describes how to work with API controllers in Umbraco projects. It focuses on creating REST services using ASP.NET Core-based API controllers.

{% hint style="warning" %}
In Umbraco 13 and below, the recommended approach was to base API controllers on the `UmbracoApiController` class. However, `UmbracoApiController` is obsolete in Umbraco 14 and will be removed in Umbraco 15.

Read the article [Porting old Umbraco APIs](porting-old-umbraco-apis.md) for more details.
{% endhint %}

## API Overview

To better understand the basics of APIs, you can see the [Microsoft ASP.NET Core API documentation](https://learn.microsoft.com/en-us/aspnet/core/web-api/). The documentation provides a solid foundation for API concepts in .NET environments..

## Public APIs in Umbraco

Public APIs in Umbraco are similar to standard ASP.NET Core APIs. Below is an example of how to create an API in Umbraco:

{% code title="ProductsController.cs" overflow="wrap" lineNumbers="true" %}

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

## Adding Member Protection to Public APIs

You can secure your public APIs using front-end membership protection with the `[UmbracoMemberAuthorize]` attribute. This attribute allows you to restrict access based on member types, groups, or specific member IDs.

The available parameters are:

- `AllowType`: A comma-delimited list of allowed member types.
- `AllowGroup`: A comma-delimited list of allowed member groups.
- `AllowMembers`: A comma-delimited list of allowed member IDs.

To allow all members, apply the `[UmbracoMemberAuthorize]` attribute without parameters.

You can apply these attributes either at the **controller** level or at the **action** level.

{% hint style="info" %}
Read more about members and member login in the [Member Registration and Login](../../../tutorials/members-registration-and-login.md) article.
{% endhint %}

## Examples of Member Protection

The `[UmbracoMemberAuthorize]` attribute offers flexible options for securing your public APIs in Umbraco.  The following examples show different ways to apply member protection, such as how to restrict access by member type, group, or specific IDs.

### Example 1: Allow All Logged-In Members

In this example, any logged in member can access all actions in the `ProductsController` controller:

{% code title="ProductsController.cs" overflow="wrap" lineNumbers="true" %}

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

### Example 2: Restrict Access by Member Type

This example allows only logged-in members of type "Retailers" to access the `GetAll` action:

{% code title="ProductsController.cs" overflow="wrap" lineNumbers="true" %}

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

### Example 3: Restrict Access by Member Group

In this example, only members belonging to the "VIP" group can access any actions on the controller:

{% code title="ProductsController.cs" overflow="wrap" lineNumbers="true" %}

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

### Example 4: Restrict Access by Member IDs

This example allows only members with IDs `1, 10, and 20` to access the `GetAll` action:

{% code title="ProductsController.cs" overflow="wrap" lineNumbers="true" %}

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

Umbraco's Backoffice API is also known as the Management API. When you create API controllers for Umbraco's backoffice, you are writing Management API controllers.

For a detailed guide on how to create APIs for the Backoffice, see the [Creating a Backoffice API article](../../../tutorials/creating-a-backoffice-api/README.md) article.
