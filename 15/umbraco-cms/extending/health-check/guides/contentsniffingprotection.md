---
description: Protect your Umbraco site from MIME sniffing vulnerabilities using security headers like X-Content-Type-Options.
---

# Health check: Content/MIME Sniffing Protection

_Checks that your site contains a header used to protect against Multipurpose Internet Mail Extensions (MIME) sniffing vulnerabilities._

## How to fix this health check

This health check can be fixed by adding a header before the response is started.

Preferable you use a security library like [NWebSec](https://docs.nwebsec.com/).

### Adding Content/MIME Sniffing Protection using NWebSec

If you take a NuGet dependency on [NWebsec.AspNetCore.Middleware/](https://www.nuget.org/packages/NWebsec.AspNetCore.Middleware/), you can use third extension methods on `WebApplication`.

```csharp
...
WebApplication app = builder.Build();

app.UseXContentTypeOptions();
...
```

### Adding Content/MIME Sniffing Protection using manual middleware

If you do not like to have a dependency on third party libraries, you can add the following custom middleware to the request pipeline.

First create the middleware class:

```csharp
namespace MySite.Middleware;

public class NoSniffMiddleware : IMiddleware
{
    public async Task InvokeAsync(HttpContext context, RequestDelegate next)
    {
        context.Response.Headers.Append("X-Content-Type-Options", "nosniff");
        await next(context);
    }
}
```

Next register it in `Program.cs`

```csharp
using MySite.Middleware;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<NoSniffMiddleware>();

builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

WebApplication app = builder.Build();

app.UseMiddleware<NoSniffMiddleware>();

await app.BootUmbracoAsync();
...
```
