---
description: >-
  In this section, you will learn how to add a Content Security Policy (CSP)
  nonce to scripts & styles injected by Engage.
---

# Content Security Policy nonce configuration

Engage automatically injects different scripts and styles into the returned HTML when requesting content. It also adds the option to set a nonce for the duration of a request to be picked up and added to said scripts and styles. This can be used when a CSP requires a nonce for scripts.&#x20;

{% hint style="info" %}
This feature has been added in version 13.3.0+ of Engage.
{% endhint %}

## How to set a nonce

Because a nonce should only be used once, it must be set in a location that gives control for individual requests. This could be in a Render Controller Action or a Service with lifetime Scoped or Transient. The following steps use a Render Controller to set a nonce.

1. Get an instance of `IContentInjectionSecurityService` from the `Umbraco.Engage.Infrastructure.Common.Security` namespace into your controller using dependency injection.&#x20;
2. Call the `.SetNonceForCurrentRequest("Your-Nonce-Here")` method before rendering content.
3. Proceed as you to return content.

```csharp
public class HomeController : RenderController
{
    private readonly IContentInjectionSecurityService _contentInjectionSecurityService;

    public HomeController(
        ILogger<RenderController> logger,
        ICompositeViewEngine compositeViewEngine,
        IUmbracoContextAccessor umbracoContextAccessor,
        IContentInjectionSecurityService contentInjectionSecurityService) : base(logger, compositeViewEngine, umbracoContextAccessor)
    {
        _contentInjectionSecurityService = contentInjectionSecurityService;
    }
    
    public IActionResult Home()
    {
        _contentInjectionSecurityService.SetNonceForCurrentRequest("Your-Nonce-Here");
        return base.Index();
    }
}
```

## Usage

When a nonce is present for the current request, it will be added to the following locations:

* The bot detection (ping) script within the Head tag.
* The client-side analytics initializer script within the Body tag.
* The cockpit scripts (only if the cockpit partial is added).
* Any applied Personalization that makes use of CSS or Javascript.

{% hint style="warning" %}
Engage does not modify the existing CSP and doesn't set a nonce to scripts and styles added without Engage.
{% endhint %}

