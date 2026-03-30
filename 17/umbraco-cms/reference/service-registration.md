---
description: >-
  Learn how to configure Umbraco to run only the services required on each
  specific server in your setup.
---

# Service Registration

Umbraco can be configured to run with different combinations of the backoffice, website, and Content Delivery API. This allows you to tailor each server in your infrastructure to its specific role, reducing attack surface and unnecessary processing.

## Supported Configurations

By default, Umbraco registers all services: the backoffice, website rendering, and Content Delivery API. However, you can choose to run only the services you need.

The following configurations are supported:

<table data-full-width="false"><thead><tr><th width="139.5625">Configuration</th><th width="115.69140625" data-type="checkbox">AddCore()</th><th width="155.87109375" data-type="checkbox">AddBackOffice()</th><th width="138.25390625" data-type="checkbox">AddWebsite()</th><th width="164.05859375" data-type="checkbox">AddDeliveryApi()</th></tr></thead><tbody><tr><td>Full (default)</td><td>false</td><td>true</td><td>true</td><td>true</td></tr><tr><td>Website + Delivery API</td><td>true</td><td>false</td><td>true</td><td>true</td></tr><tr><td>Website Only</td><td>true</td><td>false</td><td>true</td><td>false</td></tr><tr><td><p>Delivery API</p><p>Only</p></td><td>true</td><td>false</td><td>false</td><td>true</td></tr></tbody></table>

The key distinction is between `AddBackOffice()` and `AddCore()`:

* **`AddBackOffice()`** registers everything needed for the Umbraco backoffice, including the Management API, backoffice identity, and all supporting services.
* **`AddCore()`** registers only the foundational Umbraco services — configuration, core services, web components, caching, and background jobs — without any backoffice-specific services.

`AddBackOffice()` calls `AddCore()` internally, so there is no need to call both.

{% hint style="info" %}
`AddCore()` is idempotent. If both `AddBackOffice()` and `AddCore()` are called, the core services are only registered once.
{% endhint %}

### Configuration use cases

* **Full (default)**: Traditional Umbraco with all features enabled.
* **Website + Delivery API**: Front-end servers serving both rendered pages and headless content.
* **Website Only**: Front-end servers serving only rendered pages.
* **Delivery API Only**: Pure headless API servers.

## Full Umbraco (default)

The following is the standard configuration that includes the backoffice, website rendering, and Content Delivery API.

When you install a new Umbraco project, this is what you will see in the `Program.cs` file:

{% code title="Program.cs" %}
```csharp
WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

WebApplication app = builder.Build();

await app.BootUmbracoAsync();

app.UseUmbraco()
    .WithMiddleware(u =>
    {
        u.UseBackOffice();
        u.UseWebsite();
    })
    .WithEndpoints(u =>
    {
        u.UseBackOfficeEndpoints();
        u.UseWebsiteEndpoints();
    });

await app.RunAsync();
```
{% endcode %}

## Website + Delivery API (no backoffice)

The following configuration is useful for front-end servers in a load-balanced setup where a single backoffice instance is running.

The server can render pages and serve headless content, but the backoffice is not available.

{% code title="Program.cs" %}
```csharp
WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.CreateUmbracoBuilder()
    .AddCore()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

WebApplication app = builder.Build();

await app.BootUmbracoAsync();

app.UseUmbraco()
    .WithMiddleware(u =>
    {
        u.UseWebsite();
    })
    .WithEndpoints(u =>
    {
        u.UseWebsiteEndpoints();
        u.UseDeliveryApiEndpoints();
    });

await app.RunAsync();
```
{% endcode %}

## Website only

The following configuration is used for front-end servers that only serve rendered pages. Neither the backoffice nor the Content Delivery API is available.

{% code title="Program.cs" %}
```csharp
WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.CreateUmbracoBuilder()
    .AddCore()
    .AddWebsite()
    .AddComposers()
    .Build();

WebApplication app = builder.Build();

await app.BootUmbracoAsync();

app.UseUmbraco()
    .WithMiddleware(u =>
    {
        u.UseWebsite();
    })
    .WithEndpoints(u =>
    {
        u.UseWebsiteEndpoints();
    });

await app.RunAsync();
```
{% endcode %}

## Delivery API only

The following configuration is used for pure headless API servers. Only the Content Delivery API is available — no website rendering and no backoffice.

{% code title="Program.cs" %}
```csharp
WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.CreateUmbracoBuilder()
    .AddCore()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

WebApplication app = builder.Build();

await app.BootUmbracoAsync();

app.UseUmbraco()
    .WithMiddleware(u =>
    {
    })
    .WithEndpoints(u =>
    {
        u.UseDeliveryApiEndpoints();
    });

await app.RunAsync();
```
{% endcode %}

## Key differences between configurations

### Middleware

* **`UseBackOffice()`** — Registers middleware for the backoffice, including authentication and authorization. Only needed when using `AddBackOffice()`.
* **`UseWebsite()`** — Registers middleware for website rendering. Needed when using `AddWebsite()`.

### Endpoints

* **`UseBackOfficeEndpoints()`** — Maps the Management API controllers and backoffice routes. Only needed when using `AddBackOffice()`.
* **`UseWebsiteEndpoints()`** — Maps website rendering endpoints. Needed when using `AddWebsite()`.
* **`UseDeliveryApiEndpoints()`** — Maps the Content Delivery API controllers. Use this when running the Delivery API without the backoffice.

{% hint style="info" %}
`UseDeliveryApiEndpoints()` is only needed when running the Delivery API **without** the backoffice. When the full backoffice is enabled, `UseBackOfficeEndpoints()` handles mapping all API controllers, including the Delivery API.
{% endhint %}

## Considerations for Composers

When building packages or custom code using [Composers](../implementation/composing.md), be aware that some services are only available when the backoffice is enabled. If your Composer depends on backoffice-specific services, it will not work on servers configured with `AddCore()`.

You can check whether the backoffice is enabled by looking for the `IBackOfficeEnabledMarker` in the service collection:

{% code title="MyComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        if (builder.Services.Any(s => s.ServiceType == typeof(IBackOfficeEnabledMarker)))
        {
            // Register services that depend on the backoffice
        }
    }
}
```
{% endcode %}
