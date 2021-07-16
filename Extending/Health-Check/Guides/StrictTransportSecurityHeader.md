---
versionFrom: 9.0.0
state: complete
updated-links: true
verified-against: alpha-3
---

# Health check: Cookie hijacking and protocol downgrade attacks Protection (Strict-Transport-Security Header (HSTS))

_Checks if your site, when running with HTTPS, contains the Strict-Transport-Security Header (HSTS)._

## How to fix this health check

This health check can be fixed by adding a header before the response is started.

Preferable you use a security library like [NWebSec](https://docs.nwebsec.com/).

### Adding Click-Jacking Protection using NWebSec

If you take a NuGet dependency on [NWebsec.AspNetCore.Middleware/](https://www.nuget.org/packages/NWebsec.AspNetCore.Middleware/), you can use third extension methods on `IApplicationBuilder`.

```cs
public class Startup
{
    public void Configure(IApplicationBuilder app)
    {
        app.UseHsts(options => options.MaxAge(days: 30));

        ...
    }
}
```

### Adding Click-Jacking Protection using manual middleware

If you don't like to have a dependency on third party libraries. You can add the following custom middleware to the request pipeline.

```cs
public class Startup
{
    public void Configure(IApplicationBuilder app)
    {
        app.Use(async (context, next) =>
        {
            context.Response.Headers.Add("Strict-Transport-Security", "max-age=2592000");
            await next();
        });

       ...
    }
}
```
