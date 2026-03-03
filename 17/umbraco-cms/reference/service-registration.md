# Service Registration

Umbraco can be configured to run with different combinations of the backoffice, website, and Content Delivery API. This allows you to tailor each server in your infrastructure to its specific role, reducing attack surface and unnecessary processing.

## Supported Configurations

By default, Umbraco registers all services: the backoffice, website rendering, and Content Delivery API. However, you can choose to run only the services you need.

The following configurations are supported:

| Configuration | Builder Methods | Use Case |
|---|---|---|
| Full (default) | `AddBackOffice()` + `AddWebsite()` + `AddDeliveryApi()` | Traditional Umbraco with all features enabled. |
| Website + Delivery API | `AddCore()` + `AddWebsite()` + `AddDeliveryApi()` | Front-end servers serving both rendered pages and headless content. |
| Website only | `AddCore()` + `AddWebsite()` | Front-end servers serving only rendered pages. |
| Delivery API only | `AddCore()` + `AddDeliveryApi()` | Pure headless API servers. |

The key distinction is between `AddBackOffice()` and `AddCore()`:

- **`AddBackOffice()`** registers everything needed for the Umbraco backoffice, including the Management API, backoffice identity, and all supporting services.
- **`AddCore()`** registers only the foundational Umbraco services — configuration, core services, web components, caching, and background jobs — without any backoffice-specific services.

`AddBackOffice()` calls `AddCore()` internally, so there is no need to call both.

{% hint style="info" %}
`AddCore()` is idempotent. If both `AddBackOffice()` and `AddCore()` are called, the core services are only registered once.
{% endhint %}

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

- **`UseBackOffice()`** — Registers middleware for the backoffice, including authentication and authorization. Only needed when using `AddBackOffice()`.
- **`UseWebsite()`** — Registers middleware for website rendering. Needed when using `AddWebsite()`.

### Endpoints

- **`UseBackOfficeEndpoints()`** — Maps the Management API controllers and backoffice routes. Only needed when using `AddBackOffice()`.
- **`UseWebsiteEndpoints()`** — Maps website rendering endpoints. Needed when using `AddWebsite()`.
- **`UseDeliveryApiEndpoints()`** — Maps the Content Delivery API controllers. Use this when running the Delivery API without the backoffice.

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
