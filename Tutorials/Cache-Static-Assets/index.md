---
versionFrom: 9.3.0
---

# Cache static assets

Example to cache static assets by file extension, but excluding Umbraco BackOffice assets.

```csharp
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Microsoft.Net.Http.Headers;
using System;
using System.Collections.Generic;
using System.IO;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Configuration.Models;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Extensions;

namespace My.Site.Composers;

public class StaticFilesComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.AddTransient<IConfigureOptions<StaticFileOptions>, ConfigureStaticFileOptions>();

    private class ConfigureStaticFileOptions : IConfigureOptions<StaticFileOptions>
    {
        // These are the extensions of the file types we want to cache (add and remove as you see fit)
        private static readonly HashSet<string> _cachedFileExtensions = new(StringComparer.OrdinalIgnoreCase)
        {
            ".ico",
            ".css",
            ".js",
            ".svg",
            ".woff2"
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
}
```

## Cache images in ImageSharp

For setting `Cache-Control` max-age header for images processed by the ImageSharp middleware, you can set the `Umbraco:CMS:Imaging:Cache:BrowserMaxAge` setting.

See the [Images Settings](https://our.umbraco.com/Documentation/Reference/Configuration/ImagingSettings/) article for more information.
