---


meta.Title: Umbraco WebApi Authorization
description: How to secure your Umbraco Api controllers
---

# Umbraco Api - Authorization

_This section will describe how to secure your Umbraco Api controllers based on a users membership_

## Authorizing for the backoffice

### Inheriting from UmbracoAuthorizedApiController

Probably the easiest way to ensure your controller is secured for only backoffice users is to inherit from `Umbraco.Cms.Web.BackOffice.Controllers.UmbracoAuthorizedApiController`. This is essentially the same as applying `[Authorize(Policy = AuthorizationPolicies.BackOfficeAccess)]` to your controller (see below).

The `UmbracoAuthorizedApiController` is automatically routed. Check out the [routing documentation](../authorized.md) for more information on this topic.

### Using the Authorize attribute

To secure your controller based on backoffice membership use the attribute: `Microsoft.AspNetCore.Authorization.Authorize`, with the policy parameter set to `AuthorizationPolicies.BackOfficeAccess`, like so: `[Authorize(Policy = AuthorizationPolicies.BackOfficeAccess)]`.

This attribute will ensure that a valid backoffice user is logged in, however it's very important to note that this only works if the controller is routed to `/umbraco/backoffice/*`.

**Examples:**

This will only allow a logged in backoffice user to access the GetAllProducts action:

```csharp
public class ProductsController : UmbracoApiController
{
    [Authorize(Policy = AuthorizationPolicies.BackOfficeAccess)]
    [Route("umbraco/backoffice/product/{id?}")]
    public string GetProduct(int? id)
    {
        if (id is not null)
        {
            return $"Monitor model {id}";
        }
        return "Base model Monitor";
    }
}
```

## Using MemberAuthorizeAttribute

To secure your controller based on front-end membership use the attribute: `Umbraco.Cms.Web.Common.Filters.UmbracoMemberAuthorize`.

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

You can apply these attributes at the controller level or at the action level.

**Examples:**

This will only allow logged in members of type "Retailers" to access the GetAllProducts action:

```csharp
public class ProductsController : UmbracoApiController
{
    [UmbracoMemberAuthorize("Retailers", "", "")]
    public IEnumerable<string> GetAllProducts()
    {
        return new[] {"Table", "Chair", "Desk", "Computer"};
    }
}
```

This will only allow member's belonging to the group VIP to access any actions on the controller:

```
[UmbracoMemberAuthorize("", "VIP", "")]
public class ProductsController : UmbracoApiController
{
    public IEnumerable<string> GetAllProducts()
    {
        return new[] {"Table", "Chair", "Desk", "Computer"};
    }
}
```

This will only allow member's with Ids 1, 10 and 20 to access any actions on the controller:

```csharp
[UmbracoMemberAuthorize("", "", "1,10,20")]
public class ProductsController : UmbracoApiController
{
    public IEnumerable<string> GetAllProducts()
    {
        return new[] {"Table", "Chair", "Desk", "Computer"};
    }
}
```
