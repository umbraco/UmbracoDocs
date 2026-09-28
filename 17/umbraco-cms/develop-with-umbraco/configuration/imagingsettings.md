---
description: Information on the imaging settings section
---

# Imaging settings

The imaging settings section lets you configure the cache, resize, and memory settings for processed images on your project (using [ImageSharp.Web](https://docs.sixlabors.com/articles/imagesharp.web/) as default implementation). If you need to configure allowed image file types or auto fill image properties, you want to use [content settings](contentsettings.md) instead.

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
      },
      "Memory": {
        "Enabled": false,
        "MaximumPoolSizeMegabytes": 0,
        "MaximumConcurrentProcessing": 0,
        "MaximumDecodedImageMegabytes": 0
      },
      "HMACSecretKey": ""
    }
  }
}
```

## Cache

Contains configuration for browser and server caching.\
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

## Memory

Contains configuration for the memory used while processing images.

Image processing decodes the full-resolution source image into memory before resizing it. A page of distinct thumbnails decodes every source at the same time. Peak memory use is therefore the number of concurrent requests multiplied by the size of a decoded source. On a host with a hard memory limit, that peak can exhaust the limit and the process is killed. Containers and small App Service plans are typical examples.

When enabled, Umbraco applies three bounds to the image processing library:

* A cap on the memory pool the library keeps between requests.
* A limit on how many images are processed at the same time.
* A ceiling on the size of a single decoded image.

Each bound is derived from the memory available to the process. The derived bounds apply only when less than 4 GB is available. On a host with more memory, the image processing library keeps its own defaults. A bound you set explicitly applies on any host, whatever the available memory.

The feature is disabled by default. Enable it on hosts with a memory limit:

{% code caption="appsettings.json" %}

```json
"Umbraco": {
  "CMS": {
    "Imaging": {
      "Memory": {
        "Enabled": true
      }
    }
  }
}
```

{% endcode %}

### Enabled

Turns memory management on or off. Defaults to `false`, which leaves the memory behavior of the image processing library untouched.

### Maximum pool size megabytes

Caps the memory pool the image processing library retains between requests. Defaults to `0`, which derives a value between 16 MB and 64 MB from the available memory.

### Maximum concurrent processing

Limits how many images are processed at the same time. Defaults to `0`, which derives a value from the available memory, capped at the processor count.

Requests beyond the limit wait for a place. A request that waits for 30 seconds without getting one is turned away. The response is `503 Service Unavailable` with a `Retry-After` header, and a warning is logged. Cached images are served without waiting.

### Maximum decoded image megabytes

Caps the size of the largest buffer allocated while decoding a single image. Defaults to `0`, which derives a value between 256 MB and 1024 MB from the available memory.

A request for an image that needs more than the ceiling fails, and Umbraco logs a warning that names the setting. Either raise the value or reduce the size of the source image. The ceiling applies to the source decode and is unrelated to the `Resize` settings, which limit the output dimensions.

### How available memory is determined

Umbraco reads the memory available to the process from the .NET garbage collector (GC), which respects a container memory limit. On hosts where the process shares a machine with other applications, the reported value can be larger than your share. Set the `DOTNET_GCHeapHardLimit` environment variable to the memory you want image processing to respect. The value is written in hexadecimal bytes. For example, `0x70000000` limits the process to 1792 MB.

The same environment variable lets you test the bounds on a development machine with plenty of memory.

### Monitoring

Each bound reports itself when the site starts. The log entries are written at the `Information` level and name the resolved values:

```
Capped the image processing memory pool at 56 MB, with 1792 MB available to the process.
Capped a single decoded image at 448 MB, with 1792 MB available to the process.
Bounded concurrent image processing to 2, with 1792 MB and 2 processors available to the process.
```

When the feature is disabled on a host where the bounds would engage, a single entry names the setting to turn on:

```
Imaging memory management is disabled, so the imaging library's own memory behavior stands. 1792 MB is available to the process, below the 4096 MB at which it would bound the memory the library uses. Set Umbraco:CMS:Imaging:Memory:Enabled to true to enable it.
```

When the bounds engage, memory use stays flat under load. Memory pressure is therefore no longer a sign that the site needs more capacity. Watch for `503` responses on image requests and the "Turned away an image processing request" warning instead. Both mean that demand for image processing exceeds what the host can serve. A larger host, or a Content Delivery Network (CDN) in front of the site, is the remedy.

## Hash-based Message Authentication Code (HMAC) secret key

Specifies the key used to secure image requests by generating an HMAC. This ensures that only valid requests can access or manipulate images.

To enable it, you need to set a secure random key. This key should be kept secret and not shared publicly. The key can be set through the `IOptions` pattern, or you can insert a base64 encoded key in the `appsettings.json` file. The key should ideally be 64 bytes long.

The key must be the same across all environments (development, staging, production) to ensure that image requests work for content published across environments.

### New installs

For new Umbraco installations, a unique key will be automatically created and applied to the configuration.

### Upgraded projects

For projects created on Umbraco 17.2 or earlier, a unique key was not automatically created and applied.

If the `HMACSecretKey` is not set, image requests are not secured, and any person can request images with any parameters. This may expose your server to abuse, such as excessive resizing requests or unauthorized access to images.

It is recommended to add this key.

A health check is available under _Settings > Health Checks_ that verifies the existence of the configured key and warns if it is absent.

To render media from a backoffice extension without building signed URLs by hand, see [Working with Media](../../extend-your-project/backoffice-extensions/foundation/working-with-media.md).

### Key length

The `HMACSecretKey` should be a secure, random key. For most use cases, a 64-byte (512-bit) key is recommended. If you are using `HMACSHA384` or `HMACSHA512`, you may want to use a longer key (for example: 128 bytes).

### Example configuration

**appsettings.json**

```json
"Umbraco": {
  "CMS": {
    "Imaging": {
      "HMACSecretKey": "some-base64-encoded-key"
    }
  }
}
```

**Using the `IOptions` pattern**

To generate the `HMACSecretKey` programmatically instead of hardcoding it in configuration files, use the `IOptions` pattern. The following example demonstrates how to generate a secure random key at runtime:

```csharp
using System.Security.Cryptography;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Configuration.Models;

public class HMACSecretKeyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.Configure<ImagingSettings>(options =>
        {
            if (options.HMACSecretKey.Length == 0)
            {
                byte[] secret = new byte[64]; // Change to 128 when using HMACSHA384 or HMACSHA512
                RandomNumberGenerator.Create().GetBytes(secret);
                options.HMACSecretKey = secret;

                var logger = builder.BuilderLoggerFactory.CreateLogger<HMACSecretKeyComposer>();
                logger.LogInformation("Imaging settings is now using HMACSecretKey: {HMACSecretKey}", Convert.ToBase64String(secret));
            }
        });
}
```

{% hint style="warning" %}
The `HMACSecretKey` must be kept secret and never exposed publicly. If the key is exposed, malicious users may generate valid HMACs and exploit server resources.
{% endhint %}

### Testing the Configuration

To verify that your `HMACSecretKey` is working correctly:

1. Set the `HMACSecretKey` key in the `appsettings.json` file or via the `IOptions` pattern.
2. Make a request to an image URL with valid parameters and ensure it works as expected.
3. Modify the URL parameters or remove the HMAC signature and confirm that the request is rejected.
