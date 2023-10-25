---
description: "Information on the imaging settings section"
---


# Imaging settings

The imaging settings section lets you configure the cache and resize settings for processed images on your project (using [ImageSharp.Web](https://docs.sixlabors.com/articles/imagesharp.web/) as default implementation). If you need to configure allowed image file types or auto fill image properties, you want to use [content settings](contentsettings.md) instead.

All these settings contain default values, so nothing needs to be explicitly configured. A complete settings section for imaging can be seen here with all the default values:

```json
"Umbraco": {
  "CMS": {
    "Imaging": {
      "Cache": {
        "BrowserMaxAge": "7.00:00:00",
        "CacheMaxAge": "365.00:00:00",
        "CacheFolderDepth": 8,
        "CacheHashLength": 12,
        "CacheFolder": "~/umbraco/Data/TEMP/MediaCache"
      },
      "Resize": {
        "MaxWidth": 5000,
        "MaxHeight": 5000
      }
    }
  }
}
```

## Cache

Contains configuration for browser and server caching. 
When changing these cache headers, it is recommended to clear your media cache. This is due to the data being stored in the cache and not updated when the configuration is changed.

### Browser max age

Specifies how long a requested processed image may be stored in the browser cache by using this value in the `Cache-Control` response header. The default is 7 days (formatted as a timespan).

### Cache max age

Specifies how long a processed image may be used from the server cache before it needs to be re-processed again. The default is one year (365 days, formatted as a timespan).

### Cache folder depth

Gets or sets the depth of the nested cache folders structure to store the images. Defaults to 8.

### Cache hash length
Gets or sets the length of the filename to use (minus the extension) when storing images in the image cache. Defaults to 12 characters.

### Cache folder

Allows you to specify the location of the cached images folder. By default, the cached images are stored in `~/umbraco/Data/TEMP/MediaCache`. The tilde (`~`) resolves to the content root of your project/application.

## Resize

Contains configuration for image resizing.

### Max width/max height

Specifies the maximum width and height an image can be resized to. If the requested width and height are _both_ above the configured maximums, no resizing will be performed. This adds basic security to prevent resizing to big dimensions and using a lot of server CPU/memory to do so.

The maximum width and height settings are enforced by setting the `ImageSharpMiddlewareOptions.OnParseCommandsAsync` option of ImageSharp to an Umbraco-specific function. If you want to add your own logic without overwriting this behaviour, use the following code:

```csharp
public class ConfigureImageSharpMiddlewareOptionsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.Configure<ImageSharpMiddlewareOptions>(options =>
        {
            // Capture existing task to not overwrite it
            var onParseCommandsAsync = options.OnParseCommandsAsync;
            options.OnParseCommandsAsync = async context =>
            {
                // Custom logic before

                await onParseCommandsAsync(context);

                // Custom logic after
            };
        });
}
```
