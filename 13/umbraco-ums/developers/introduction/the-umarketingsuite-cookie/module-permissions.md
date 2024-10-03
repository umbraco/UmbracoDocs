---
description: >-
  It is possible to disable the individual modules of Umbraco uMS (Analytics,
  A/B testing, Personalization) through code based on any criteria you want.
---

# Module Permissions

You could choose to give visitors control over these settings through a cookie bar on your site.&#x20;

To do this you have to create an implementation of the `uMarketingSuite.Business.Permissions.ModulePermissions.IModulePermissions` interface and override our default implementation.

This interface defines 3 methods that you will have to implement:

{% code overflow="wrap" %}
```csharp
/// <summary>/// Indicates if A/B testing is allowed for the given request context./// If false, the visitor will not be assigned to any A/B tests and will not/// see any active A/B test content./// </summary>/// <param name="context">Context of the request</param>/// <returns>True if A/B testing is allowed, otherwise false.</returns>bool AbTestingIsAllowed(HttpContextBase context);/// <summary>/// Indicates if Analytics is allowed for the given request context./// If false, the visitor will be treated as the built-in Anonymous visitor/// and all their activity will be assigned to the Anonymous visitor rather than the specific visitor./// No A/B testing or Personalization will be allowed either if this is false regardless of their/// respective IsAllowed() outcomes./// In addition, no cookie will be sent to the visitor when this is set to false./// </summary>/// <param name="context">Context of the request</param>/// <returns>True if Analytics is allowed, otherwise false.</returns>bool AnalyticsIsAllowed(HttpContextBase context);/// <summary>/// Indicates if Personalization testing is allowed for the given request context./// If false, the visitor will not see any personalized content./// </summary>/// <param name="context">Context of the request</param>/// <returns>True if Personalization is allowed, otherwise false.</returns>bool PersonalizationIsAllowed(HttpContextBase context);
```
{% endcode %}

Using these methods you can control per visitor whether or not the modules are active. Your implementation will need to be registered with Umbraco using the `RegisterUnique()` method, overriding the default implementation which enables all modules all the time. Make sure your composer runs after the uMarketingSuite composer by using the `[ComposeAfter]` attribute.

For uMarketingSuite 2.x, the `AttributeBasedComposer` has been renamed to `UMarketingSuiteApplicationComposer`, with which it could look something like this:

{% code overflow="wrap" %}
```csharp
using uMarketingSuite.Business.Permissions.ModulePermissions;using uMarketingSuite.Common.Composing;using Umbraco.Core;using Umbraco.Core.Composing;namespace YourNamespace {    [ComposeAfter(typeof(UMarketingSuiteApplicationComposer))]    public class YourComposer : IComposer    {        public void Compose(Composition composition)        {            composition.RegisterUnique<IModulePermissions, YourCustomModulePermissions>();        }    }}
```
{% endcode %}

### Tracking a visitor's Initial Pageview

{% hint style="warning" %}
If you change the default module permissions to false and the visitor has not given any consent yet Umbraco uMS does not actively track that visitor until they have given their consent to the Analytics module (module permission `AnalyticsIsAllowed` set to **true**).

If the module permission is set to true it is required to reload the current page as soon as the visitor has given consent to track the current page visit the visitor has given consent on.

If no reload is performed the visitor's referrer and/or campaign information will not be tracked!

Calling the `window.location.reload();` method is the preferred option, as this will preserve any referrers & query strings supplied in the current request.&#x20;

This results in Umbraco uMS processing the current page visit & visitor correctly.

An [example](../../../security-and-privacy/gdpr/how-to-become-gdpr-compliant-using-cookiebot.md) implementation using Cookiebot can be found in the security and privacy section.
{% endhint %}

