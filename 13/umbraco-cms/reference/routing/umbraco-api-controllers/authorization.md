---
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

This attribute will ensure that a valid backoffice user is logged in. It is important to know that this only works if the controller is routed to `/umbraco/backoffice/*`.

**Example:**

{% hint style="warning" %}
The examples below uses UmbracoApiController which is removed in Umbraco 14. The replacement for this is UmbracoManagementApiControllerBase.
{% endhint %}

This will only allow a logged in backoffice user to access the `GetProduct`action:

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

The `AuthorizationPolicies` has a [series of other options](https://apidocs.umbraco.com/v13/csharp/api/Umbraco.Cms.Web.Common.Authorization.AuthorizationPolicies.html) you can set. An example is `UserBelongsToUserGroupInRequest`. By using this policy, you can check if the current incoming request of the user is in a specific backoffice User Group.

**Example:**

This will only allow a logged-in backoffice user that has access to the SensitiveData User Group to access the `GetProduct` action:

```csharp
public class ProductsController : UmbracoApiController
{
    [Authorize(Policy = AuthorizationPolicies.UserBelongsToUserGroupInRequest, Roles = Security.SensitiveDataGroupAlias)]
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

## Adding custom policies

You can add custom policies so you can set up your own requirements. You can do this by adding a new Policy to your builder:

**Example:**

```csharp
builder.Services.AddAuthorization(options =>
    options.AddPolicy(MyConstants.CustomPolicyName, policy => // Always good to use constants
    {
        policy.AuthenticationSchemes.Add(Constants.Security.BackOfficeAuthenticationType); // Default backoffice authentication scheme
        policy.RequireRole(Constants.Security.SensitiveDataGroupAlias); // Add the Sensitive Group as a requirement

        // Add more requirements as needed
    })
);
```

After configuring, you can now use the `Authorize` attribute with the name of your policy:

```csharp
[Authorize(Policy = MyConstants.CustomPolicyName)]
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

This will only allow logged in members of type "Retailers" to access the `GetAllProducts`action:

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
