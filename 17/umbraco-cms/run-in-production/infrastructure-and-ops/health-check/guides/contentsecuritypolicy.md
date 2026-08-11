---
description: Implement a Content Security Policy (CSP) to protect your Umbraco site from XSS and data injection.
---

# Content Security Policy (CSP)

_This check verifies if your site has a Content Security Policy (CSP) header to defend against Cross-Site Scripting (XSS) and data injection attacks._

## How to fix this health check

This health check can be fixed by adding a Content Security Policy (CSP) header before the response is started.

You can add the header using custom middleware or a third-party library like [NWebsec](https://docs.nwebsec.com/).

## CSP nonces

The Umbraco backoffice uses inline scripts such as import maps that a strict CSP would block. A CSP nonce is a cryptographically random, single-use token generated per request. Adding a `nonce-<value>` source to your `script-src` directive allows those specific scripts to execute. All other inline scripts remain blocked.

Umbraco generates a per-request nonce through the `ICspNonceService` and applies it to backoffice script tags automatically. You need to include the same nonce in your CSP header so the browser permits those scripts.

### Adding a CSP using custom middleware

Resolve `ICspNonceService` from the request services to include the nonce in your header:

```csharp
using Umbraco.Cms.Core.Security;

app.Use(async (context, next) =>
{
    ICspNonceService cspNonceService = context.RequestServices
        .GetRequiredService<ICspNonceService>();
    var nonce = cspNonceService.GetNonce();

    context.Response.Headers.Append("Content-Security-Policy",
        $"default-src 'self'; " +
        $"script-src 'self' 'nonce-{nonce}'; " +
        $"style-src 'self' 'unsafe-inline'; " +
        $"img-src 'self' blob: data: https://news-dashboard.umbraco.com; " +
        $"connect-src 'self'; " +
        $"font-src 'self'; " +
        $"frame-src 'self' https://marketplace.umbraco.com");

    await next();
});

app.UseUmbraco()...
```

### Adding a CSP using NWebsec

If you use the [NWebsec.AspNetCore.Middleware](https://www.nuget.org/packages/NWebsec.AspNetCore.Middleware/) NuGet package, configure CSP with the `UseCsp` extension method. Then call `UseUmbracoCspNonceInjection()` to inject the Umbraco nonce into the header that NWebsec produces.

{% hint style="warning" %}
Place `UseUmbracoCspNonceInjection()` **after** `UseCsp()` to ensure the nonce is injected into the existing header.
{% endhint %}

```csharp
app.UseCsp(options => options
    .DefaultSources(s => s
        .Self())
    .ImageSources(s => s
        .Self()
        .CustomSources(
            "data:",
            "blob:",
            "https://news-dashboard.umbraco.com"))
    .ScriptSources(s => s
        .Self())
    .StyleSources(s => s
        .Self()
        .UnsafeInline())
    .FontSources(s => s
        .Self())
    .ConnectSources(s => s
        .Self())
    .FrameSources(s => s
        .Self()
        .CustomSources(
            "data:",
            "https://marketplace.umbraco.com")));

// Inject Umbraco's nonce into the CSP header produced by NWebsec.
app.UseUmbracoCspNonceInjection();

app.UseUmbraco()...
```

The `UseUmbracoCspNonceInjection()` middleware finds the `script-src` directive in the CSP header and appends the nonce value. It works with both `Content-Security-Policy` and `Content-Security-Policy-Report-Only` headers.
