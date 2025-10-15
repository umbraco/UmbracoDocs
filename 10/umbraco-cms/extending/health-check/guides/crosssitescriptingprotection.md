---


---

# Health check: Cross-site scripting Protection (X-XSS-Protection header)

_This header enables the Cross-site scripting (XSS) filter in your browser. It checks for the presence of the X-XSS-Protection-header._

## How to fix this health check

This health check can be fixed by adding a header before the response is started.

Preferable you use a security library like [NWebSec](https://docs.nwebsec.com/).

### Adding Cross-site scripting Protection using NWebSec

If you take a NuGet dependency on [NWebsec.AspNetCore.Middleware/](https://www.nuget.org/packages/NWebsec.AspNetCore.Middleware/), you can use third extension methods on `IApplicationBuilder`.

```csharp
public class Startup
{
    public void Configure(IApplicationBuilder app)
    {
        app.UseXXssProtection(options => options.EnabledWithBlockMode());

        ...
    }
}
```

### Adding Cross-site scripting Protection using manual middleware

If you don't like to have a dependency on third party libraries. You can add the following custom middleware to the request pipeline.

```csharp
public class Startup
{
    public void Configure(IApplicationBuilder app)
    {
        app.Use(async (context, next) =>
        {
            context.Response.Headers.Add("X-Xss-Protection", "1; mode=block");
            await next();
        });

       ...
    }
}
```
