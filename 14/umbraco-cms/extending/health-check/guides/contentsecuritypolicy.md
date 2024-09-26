---
description: Implement a Content Security Policy (CSP) to protect your Umbraco site from XSS and data injection.
---

# Content Security Policy (CSP)

_This check verifies if your site has a Content Security Policy (CSP) header to defend against Cross-Site Scripting (XSS) and data injection attacks._

## How to fix this health check
This health check can be fixed by adding a header before the response is started.

Preferable you use a security library like [NWebSec](https://docs.nwebsec.com/).

### Adding a Content Security Policy (CSP) using NWebSec

If you take a NuGet dependency on [NWebsec.AspNetCore.Middleware/](https://www.nuget.org/packages/NWebsec.AspNetCore.Middleware/), you can use third extension methods on `IApplicationBuilder`.

```csharp
...
WebApplication app = builder.Build();
app.UseCsp(options => options
    .ImageSources(s => s
        .Self()
        .CustomSources(
            "our.umbraco.com data:",
            "dashboard.umbraco.com"))
    .DefaultSources(s => s
        .Self()
        .CustomSources(
            "our.umbraco.com",
            "marketplace.umbraco.com"))
    .ScriptSources(s => s
        .Self())
    .StyleSources(s => s
        .Self())
    .FontSources(s => s
        .Self())
    .ConnectSources(s => s
        .Self())
    .FrameSources(s => s
        .Self()));
```

### Adding a Content Security Policy (CSP) using manual middleware

Avoid third-party library dependencies by using custom middleware added to the request pipeline as shown below.

```csharp
app.Use(async (context, next) =>
{
    context.Response.Headers.Append("Content-Security-Policy", "img-src 'self' our.umbraco.com data: dashboard.umbraco.com; default-src 'self' our.umbraco.com marketplace.umbraco.com; script-src 'self'; style-src 'unsafe-inline' 'self'; font-src 'self'; connect-src 'self'; frame-src 'self'; ");
    await next();
});
```
