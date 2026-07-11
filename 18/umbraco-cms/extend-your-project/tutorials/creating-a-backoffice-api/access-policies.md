---
description: How to apply access policies for Management APIs
---

# Access policies

A Management API is by default available to any authorized Umbraco backoffice user.

To further restrict access we can apply access policies using the `[Authorize]` attribute.

## Built-in access policies

Umbraco maintains a set of built-in access policies we can leverage in our own APIs. The policy names are defined in `Umbraco.Cms.Web.Common.Authorization.AuthorizationPolicies`.

For example, the following makes the API accessible only to users with Content section access:

{% code title="MyItemApiController.cs" %}
```csharp
using Umbraco.Cms.Web.Common.Authorization;
...

[Authorize(AuthorizationPolicies.SectionAccessContent)]
public class MyItemApiController : ManagementApiControllerBase
```
{% endcode %}

## Custom access policies

We can also define our own access policies. Custom access policies are a great way of keeping access control in sync across multiple endpoints, as projects evolve over time.

A custom access policy is defined by means of composition.

The following access policy definition requires the user to be a member of both the Umbraco Administrators group and a custom defined group:

{% code title="SampleCustomPolicyComposer.cs" %}
```csharp
public class SampleCustomPolicyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.AddAuthorization(options =>
            options.AddPolicy(SiteConstants.CustomPolicyName, policy =>
            {
                policy.AuthenticationSchemes.Add(OpenIddictValidationAspNetCoreDefaults.AuthenticationScheme);
                policy.RequireRole(SiteConstants.CustomGroupAlias);
                policy.RequireRole(Constants.Security.AdminGroupAlias);
            })
        );
}
```
{% endcode %}

{% code title="SiteConstants.cs" %}
```csharp
public static class SiteConstants
{
    public const string CustomPolicyName = "Site.CustomPolicy";

    public const string CustomGroupAlias = "customGroup";
}
```
{% endcode %}

With the policy defined, we can apply it to the API controller:

{% code title="MyItemApiController.cs" %}
```csharp
[Authorize(SiteConstants.CustomPolicyName)]
public class MyItemApiController : ManagementApiControllerBase
```
{% endcode %}

## Restricting access to a backoffice section

The `RequireRole` approach shown above checks which user groups the current user belongs to. The approach does not check which backoffice sections the user can access.

The built-in `SectionAccess` policies cover only Umbraco's own sections, such as Content and Media. There is no built-in policy for a custom section alias. To authorize against your own section, read the sections granted to the current user and compare them to the section you want to protect.

{% hint style="info" %}
In Umbraco 18, the backoffice identity no longer carries the user's start nodes or allowed sections as claims. As a result, you cannot determine section access by inspecting the claims on the current user. Read the values from the user instead, as shown below. For background, see the [Umbraco 18 announcement](https://github.com/umbraco/Announcements/issues/18).
{% endhint %}

### Checking section access in a controller

You can check section access directly in a controller. Inject `IBackOfficeSecurityAccessor` to reach the current user. The `AllowedSections` property lists the section aliases the user can access.

{% code title="MyItemApiController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Management.Controllers;
using Umbraco.Cms.Api.Management.Routing;
using Umbraco.Cms.Core.Models.Membership;
using Umbraco.Cms.Core.Security;

namespace UmbracoDocs.Samples;

[VersionedApiBackOfficeRoute("my/item")]
[ApiExplorerSettings(GroupName = "My item API")]
public class MyItemApiController : ManagementApiControllerBase
{
    private readonly IBackOfficeSecurityAccessor _backOfficeSecurityAccessor;

    public MyItemApiController(IBackOfficeSecurityAccessor backOfficeSecurityAccessor)
        => _backOfficeSecurityAccessor = backOfficeSecurityAccessor;

    [HttpGet("mine")]
    public IActionResult GetMine()
    {
        IUser? user = _backOfficeSecurityAccessor.BackOfficeSecurity?.CurrentUser;
        if (user is null)
        {
            return Unauthorized();
        }

        return user.AllowedSections.Contains(SiteConstants.CustomSectionAlias)
            ? Ok()
            : Forbid();
    }
}
```
{% endcode %}

Add the section alias to your constants:

{% code title="SiteConstants.cs" %}
```csharp
public static class SiteConstants
{
    // Existing constants...

    public const string CustomSectionAlias = "mySection";
}
```
{% endcode %}

### Reusing the check across controllers

The in-controller check suits a single endpoint. When multiple controllers share the same rule, move the check into a policy. You then apply the policy with `[Authorize]` rather than repeating the code.

A section check needs to load the current user, so it depends on Umbraco services. Registering a policy happens at startup, where injecting services is awkward. ASP.NET Core avoids the problem by splitting authorization into two parts:

* A **requirement** carries only data - the section to check. You construct it at startup, and it needs no services.
* A **handler** performs the check. Umbraco resolves the handler from the container for each request, so you can inject services into it.

The section lookup belongs in the handler, not in the startup registration.

#### Defining the authorization requirement

The requirement holds the section aliases to check. Access to any one of them satisfies the requirement.

{% code title="SectionAccessRequirement.cs" %}
```csharp
using Microsoft.AspNetCore.Authorization;

namespace UmbracoDocs.Samples;

public sealed class SectionAccessRequirement : IAuthorizationRequirement
{
    public SectionAccessRequirement(params string[] sectionAliases)
        => SectionAliases = sectionAliases;

    public string[] SectionAliases { get; }
}
```
{% endcode %}

#### Handling the requirement

The handler injects `IAuthorizationHelper` to turn the request's principal into an `IUser`. It then reads `AllowedSections` from that user and compares the values to the requirement.

The handler derives from `MustSatisfyRequirementAuthorizationHandler`, so it always calls `Succeed` or `Fail`. An unauthorized caller then receives a `403 Forbidden` response. This mirrors the approach Umbraco uses for its own built-in section policies.

{% code title="SectionAccessHandler.cs" %}
```csharp
using Microsoft.AspNetCore.Authorization;
using Umbraco.Cms.Api.Management.Security.Authorization;
using Umbraco.Cms.Core.Models.Membership;
using Umbraco.Cms.Core.Security.Authorization;
using Umbraco.Extensions;

namespace UmbracoDocs.Samples;

public sealed class SectionAccessHandler
    : MustSatisfyRequirementAuthorizationHandler<SectionAccessRequirement>
{
    private readonly IAuthorizationHelper _authorizationHelper;

    public SectionAccessHandler(IAuthorizationHelper authorizationHelper)
        => _authorizationHelper = authorizationHelper;

    protected override Task<bool> IsAuthorized(
        AuthorizationHandlerContext context,
        SectionAccessRequirement requirement)
    {
        var allowed = _authorizationHelper.TryGetUmbracoUser(context.User, out IUser? user)
                      && user.AllowedSections.ContainsAny(requirement.SectionAliases);

        return Task.FromResult(allowed);
    }
}
```
{% endcode %}

#### Registering the policy

A composer registers the handler in the container and defines the policy. The policy registration adds the authentication scheme and the requirement. The registration does not perform the section lookup, so it needs no services.

{% code title="SectionAccessPolicyComposer.cs" %}
```csharp
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.DependencyInjection;
using OpenIddict.Validation.AspNetCore;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace UmbracoDocs.Samples;

public class SectionAccessPolicyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Register the handler. Umbraco resolves it per request, where service injection works.
        builder.Services.AddSingleton<IAuthorizationHandler, SectionAccessHandler>();

        // Register the policy. The section lookup lives in the handler, not here.
        builder.Services.AddAuthorization(options =>
            options.AddPolicy(SiteConstants.CustomSectionPolicyName, policy =>
            {
                policy.AuthenticationSchemes.Add(
                    OpenIddictValidationAspNetCoreDefaults.AuthenticationScheme);
                policy.Requirements.Add(
                    new SectionAccessRequirement(SiteConstants.CustomSectionAlias));
            }));
    }
}
```
{% endcode %}

Add a policy name to your constants:

{% code title="SiteConstants.cs" %}
```csharp
public static class SiteConstants
{
    // Existing constants...

    public const string CustomSectionPolicyName = "Site.CustomSectionAccess";
}
```
{% endcode %}

#### Applying the policy

Apply the policy to the API controller in the same way as any other policy:

{% code title="MyItemApiController.cs" %}
```csharp
[Authorize(SiteConstants.CustomSectionPolicyName)]
public class MyItemApiController : ManagementApiControllerBase
```
{% endcode %}

## Accessing user data previously held in claims

The Umbraco 18 change removed three values from the backoffice identity: the allowed sections, the content start nodes, and the media start nodes. Each value is available from the `IUser` that you resolve from the current request.

| Value removed from the identity | How to read it from `IUser` |
| --- | --- |
| Allowed sections | `AllowedSections` |
| Content start nodes | `CalculateContentStartNodeIds(entityService, appCaches)` |
| Media start nodes | `CalculateMediaStartNodeIds(entityService, appCaches)` |

The start node methods are extension methods in the `Umbraco.Cms.Core.Models` namespace. They take an `IEntityService` and an `AppCaches`, which you inject into your controller.

{% code title="MyItemApiController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Management.Controllers;
using Umbraco.Cms.Api.Management.Routing;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Models.Membership;
using Umbraco.Cms.Core.Security;
using Umbraco.Cms.Core.Services;

namespace UmbracoDocs.Samples;

[VersionedApiBackOfficeRoute("my/item")]
[ApiExplorerSettings(GroupName = "My item API")]
public class MyItemApiController : ManagementApiControllerBase
{
    private readonly IBackOfficeSecurityAccessor _backOfficeSecurityAccessor;
    private readonly IEntityService _entityService;
    private readonly AppCaches _appCaches;

    public MyItemApiController(
        IBackOfficeSecurityAccessor backOfficeSecurityAccessor,
        IEntityService entityService,
        AppCaches appCaches)
    {
        _backOfficeSecurityAccessor = backOfficeSecurityAccessor;
        _entityService = entityService;
        _appCaches = appCaches;
    }

    [HttpGet("profile")]
    public IActionResult GetProfile()
    {
        IUser? user = _backOfficeSecurityAccessor.BackOfficeSecurity?.CurrentUser;
        if (user is null)
        {
            return Unauthorized();
        }

        IEnumerable<string> allowedSections = user.AllowedSections;
        int[] contentStartNodeIds = user.CalculateContentStartNodeIds(_entityService, _appCaches) ?? [];
        int[] mediaStartNodeIds = user.CalculateMediaStartNodeIds(_entityService, _appCaches) ?? [];

        return Ok(new
        {
            allowedSections,
            contentStartNodeIds,
            mediaStartNodeIds,
        });
    }
}
```
{% endcode %}
