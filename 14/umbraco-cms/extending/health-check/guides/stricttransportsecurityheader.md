---
description: "Learn about the health checks that check for cookie hijacking and protocol downgrade attacks protection."
---

# Strict-Transport-Security Header

Checks if your site, when running with HTTPS, contains the Strict-Transport-Security Header (HSTS).

## How to fix this health check

This health check can be fixed by adding the `Strict-Transport-Security` header to responses. The header tells browsers that future requests should be made over HTTPS only.

{% hint style="warning" %}
Enabling HSTS on a domain will cause browsers to only use HTTPS (not HTTP) to communicate with your site. Only enable HSTS on domains that can, and should, use HTTPS exclusively.
{% endhint %}

### Using the UseHsts extension method

ASP.NET Core implements HSTS with the `UseHsts` extension method.

You can add `UseHsts` after the `env.IsDevelopment()` check-in `Program.cs`.

```csharp
if (builder.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
else
{
    app.UseHsts();
}
    //...
}
```
Add this to Program.cs to be able to set a timespan for HSTS, preferbly six months.

```csharp
builder.Services.AddHsts(options =>
{
    options.MaxAge = TimeSpan.FromDays(180);
    options.IncludeSubDomains = true; 
    options.Preload = true; 
});

```

This example only enables HSTS if the app is not running in development mode. `UseHsts` isn't recommended in development because the HSTS settings are highly cacheable by browsers.

Full details of `UseHsts`, and additional configuration, can be found in the [ASP.NET Core documentation](https://learn.microsoft.com/en-us/aspnet/core/security/enforcing-ssl?view=aspnetcore-5.0\&tabs=visual-studio#http-strict-transport-security-protocol-hsts-1).
