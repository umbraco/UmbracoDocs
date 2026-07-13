# Response Caching

Response caching reduces the number of requests a client or proxy makes to a web server. See the Microsoft documentation for details of [Response caching in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/response?view=aspnetcore-6.0) and how to implement the [Response Caching Middleware](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/middleware?view=aspnetcore-6.0).

## Modify the `Cache-Control` header for Static Files

Example class to allow the modification of the `Cache-Control` header for static assets by file extension, but excluding Umbraco BackOffice assets.

```csharp
using System.IO;
using System;
using System.Collections.Generic;

using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using Microsoft.AspNetCore.Http.Headers;
using Microsoft.Net.Http.Headers;

using Umbraco.Cms.Core.Configuration.Models;
using IHostingEnvironment = Umbraco.Cms.Core.Hosting.IHostingEnvironment;

namespace Umbraco.Docs.Samples.Web.Tutorials;

public class ConfigureStaticFileOptions : IConfigureOptions<StaticFileOptions>
{
    // These are the extensions of the file types we want to cache (add and remove as you see fit)
    private static readonly HashSet<string> _cachedFileExtensions = new(StringComparer.OrdinalIgnoreCase)
    {
        ".ico",
        ".css",
        ".js",
        ".svg",
        ".woff2",
        ".jpg"
    };

    private readonly string _backOfficePath;

    public ConfigureStaticFileOptions(IOptions<GlobalSettings> globalSettings, IHostingEnvironment hostingEnvironment)
        => _backOfficePath = globalSettings.Value.GetBackOfficePath(hostingEnvironment);

    public void Configure(StaticFileOptions options)
        => options.OnPrepareResponse = ctx =>
        {
            // Exclude Umbraco backoffice assets
            if (ctx.Context.Request.Path.StartsWithSegments(_backOfficePath))
            {
                return;
            }

            // Set headers for specific file extensions
            var fileExtension = Path.GetExtension(ctx.File.Name);
            if (_cachedFileExtensions.Contains(fileExtension))
            {
                ResponseHeaders headers = ctx.Context.Response.GetTypedHeaders();

                // Update or set Cache-Control header
                CacheControlHeaderValue cacheControl = headers.CacheControl ?? new CacheControlHeaderValue();
                cacheControl.Public = true;
                cacheControl.MaxAge = TimeSpan.FromDays(365);
                headers.CacheControl = cacheControl;
            }
        };
}
```

Register the service in `Program.cs`

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

builder.Services.AddTransient<IConfigureOptions<StaticFileOptions>, ConfigureStaticFileOptions>();
```

## Modify the `Cache-Control` header for ImageSharp.Web

For setting `Cache-Control` max-age header for images processed by the ImageSharp middleware, you can set the `Umbraco:CMS:Imaging:Cache:BrowserMaxAge` setting.

See the [Images Settings](configuration/imagingsettings.md) article for more information.

## Add the `Cache-Control` header for rendering using the [ResponseCache attribute](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/response?view=aspnetcore-6.0#responsecache-attribute)

For example using a custom [Default Controller](../implementation/default-routing/controller-selection.md#change-the-default-controllers) you can add the ResponseCache attribute to the `Index` method

```csharp
public class DefaultController : RenderController
{
    public DefaultController(ILogger<RenderController> logger, ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor) : base(logger, compositeViewEngine, umbracoContextAccessor)
    {
    }

    [ResponseCache(NoStore = true, Location = ResponseCacheLocation.None)]
    public override IActionResult Index()
    {
        return CurrentTemplate(new ContentModel(CurrentPage));
    }
}
```
