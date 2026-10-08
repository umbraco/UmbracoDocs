---
description: Learn how to protect your Umbraco site from clickjacking attacks using X-Frame-Options and security headers.
---

# Health check: Click-Jacking Protection

_Checks if your site is allowed to be IFRAMEd by another site and thus would be susceptible to click-jacking._

## How to fix this health check

This health check can be fixed by adding a header before the response is started.

Preferable you use a security library like [NWebSec](https://docs.nwebsec.com/).

### Adding Click-Jacking Protection using NWebSec

If you take a NuGet dependency on [NWebsec.AspNetCore.Middleware/](https://www.nuget.org/packages/NWebsec.AspNetCore.Middleware/), you can use third extension methods on `IApplicationBuilder`.

```csharp
...
WebApplication app = builder.Build();
app.UseXfo(options => options.SameOrigin());
```

### Adding Click-Jacking Protection using manual middleware

Avoid third-party library dependency by using custom middleware added to the request pipeline.

The strongly typed `XFrameOptions` property can be used to set the header:

```csharp
app.Use(async (context, next) => 
{ 
    context.Response.Headers.XFrameOptions = "SAMEORIGIN"; 
    await next(); 
});
```

Alternatively, the header can be set using the string indexer:

```csharp
app.Use(async (context, next) =>
{
    context.Response.Headers["X-Frame-Options"] = "SAMEORIGIN";
    await next();
});
```
