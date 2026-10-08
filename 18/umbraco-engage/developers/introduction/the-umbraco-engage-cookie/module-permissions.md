---
description: >-
  It is possible to disable the individual modules of Umbraco Engage (Analytics,
  A/B testing, Personalization) through code based on any criteria you want.
---

# Module Permissions

You could choose to give visitors control over these settings through a cookie bar on your site.

To do this you have to create an implementation of the `Umbraco.Engage.Infrastructure.Permissions.ModulePermissions.IModulePermissions` interface and override our default implementation.

This interface defines 3 methods that you will have to implement:

{% code overflow="wrap" %}
```csharp
/// <summary>
/// Indicates if A/B testing is allowed for the given request context.
/// If false, the visitor will not be assigned to any A/B tests and will not
/// see any active A/B test content.
/// </summary>
/// <param name="context">Context of the request</param>
/// <returns>True if A/B testing is allowed, otherwise false.</returns>
bool AbTestingIsAllowed(HttpContext context);

/// <summary>
/// Indicates if Analytics is allowed for the given request context.
/// If false, the visitor will be treated as the built-in Anonymous visitor
/// and all their activity will be assigned to the Anonymous visitor rather than the specific visitor.
/// No A/B testing or Personalization will be allowed either if this is false regardless of their
/// respective IsAllowed() outcomes.
/// In addition, no cookie will be sent to the visitor when this is set to false.
/// </summary>
/// <param name="context">Context of the request</param>
/// <returns>True if Analytics is allowed, otherwise false.</returns>
bool AnalyticsIsAllowed(HttpContext context);

/// <summary>
/// Indicates if Personalization testing is allowed for the given request context.
/// If false, the visitor will not see any personalized content.
/// </summary>
/// <param name="context">Context of the request</param>
/// <returns>True if Personalization is allowed, otherwise false.</returns>
bool PersonalizationIsAllowed(HttpContext context);
```
{% endcode %}

Using these methods you can control per visitor whether or not the modules are active. Your implementation will need to be registered with Umbraco using the `AddUnique()` method, overriding the default implementation which enables all modules all the time. Make sure your composer runs after the Umbraco Engage composer by using the `[ComposeAfter]` attribute.

It could look something like this:

{% code overflow="wrap" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Engage.Common.Composing;
using Umbraco.Engage.Infrastructure.Permissions.ModulePermissions;

namespace YourNamespace
{
    [ComposeAfter(typeof(UmbracoEngageApplicationComposer))]
    public class YourComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.Services.AddUnique<IModulePermissions, YourCustomModulePermissions>();
        }
    }
}
```
{% endcode %}

## Member tracking when analytics is denied

When `AnalyticsIsAllowed` returns false, Engage treats the visitor as the built-in Anonymous visitor. Engage still records the pageview. Only the visitor attribution changes.

By default, a pageview from a logged-in member still carries that member's key when analytics is denied. The row is written either way. Denying analytics changes the visitor, not the member key.

Engage provides an opt-in setting to change this behaviour. When you enable it, Engage attaches the member key only to requests where analytics is allowed.

### RequireAnalyticsPermissionForMemberTracking

The `RequireAnalyticsPermissionForMemberTracking` setting lives under `Engage:Analytics:DataCollection` and defaults to `false`. The setting and the rule for using it are documented on the configuration interface:

{% code overflow="wrap" %}
```csharp
/// <summary>
/// When enabled, an Umbraco member key is attached to a pageview only for requests where
/// <c>IModulePermissions.AnalyticsIsAllowed</c> returns true. Requests without analytics
/// permission are still tracked, but as an anonymous visitor with no member key.
/// </summary>
/// <remarks>
/// Analytics consent must be decided from the request itself, for example a cookie banner,
/// and never from who is logged in. On a regular page request the analytics permission is
/// evaluated before authentication, while the visitor is still anonymous, so an
/// <c>IModulePermissions</c> implementation whose answer depends on the authenticated member
/// is an unsupported way to implement the interface. Headless collection requests do not
/// take that path and are evaluated against the tracking context their endpoint constructs.
/// Replacing the built-in raw pageview extractor bypasses this setting.
/// </remarks>
bool RequireAnalyticsPermissionForMemberTracking => false;
```
{% endcode %}

To enable the setting, add it to your `appsettings.json`:

{% code title="appsettings.json" %}
```json
{
  "Engage": {
    "Analytics": {
      "DataCollection": {
        "RequireAnalyticsPermissionForMemberTracking": true
      }
    }
  }
}
```
{% endcode %}

### Clearing member keys from existing pageviews

The setting applies going forward. It stops new pageviews from carrying a member key when analytics is denied. It does not change rows that Engage recorded before you enabled the setting.

To remove member keys from pageviews already collected, run the following script against your database during a maintenance window.

{% code title="ClearMemberKeys.sql" %}
```sql
-- Clears the Umbraco member key from pageviews already collected.
-- Back up your database first. This change cannot be undone.
-- Scope the WHERE clause yourself before running (see the notes below).
UPDATE umbracoEngageAnalyticsPageview
SET umbracoMemberKey = NULL
WHERE umbracoMemberKey IS NOT NULL;
```
{% endcode %}

{% hint style="warning" %}
Review these points before you run the script:

* The script clears **every** stored member key. Engage does not store the per-request analytics outcome on the pageview, so the data cannot tell a member who consented from one who declined.
* To clear only the members who declined, scope the `WHERE` clause yourself. Filter by member key, or by a date range from before your consent solution went live.
* The member key is the only source of member identity on a pageview. Clearing it also removes those members from the **Profiles** view in the backoffice.
* This change cannot be undone. Make sure you have a backup.
{% endhint %}

## Tracking a visitor's Initial Pageview

{% hint style="warning" %}
By changing the default module permissions to false a visitor will not be tracked until they give their consent to the Analytics module. In that case, the module permission `AnalyticsIsAllowed` will be set to `true`.

If the module permission is set to true it is required to reload the current page as soon as the visitor has given consent. This needs to happen to track the current page visit the visitor has given consent on.

If no reload is performed the visitor's referrer and/or campaign information will not be tracked.

Calling the `window.location.reload();` method is the preferred option, as this will preserve any referrers & query strings supplied in the current request.

This results in Umbraco Engage processing the current page visit & visitor correctly.

An example implementation [using Cookiebot can be found in the security and privacy section](../../../security-and-privacy/gdpr/how-to-become-gdpr-compliant-using-cookiebot.md).
{% endhint %}
