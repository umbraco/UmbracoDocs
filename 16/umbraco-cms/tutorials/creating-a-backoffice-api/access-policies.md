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
