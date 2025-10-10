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
      },
      "HMACSecretKey": ""
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

## HMAC secret key

Specifies the key used to secure image requests by generating a hash-based message authentication code (HMAC). This ensures that only valid requests can access or manipulate images.

To enable it, you need to set a secure random key. This key should be kept secret and not shared publicly. The key can be set through the `IOptions` pattern, or you can insert a base64 encoded key in the `appsettings.json` file. The key should ideally be 64 bytes long.

The key must be the same across all environments (development, staging, production) to ensure that image requests work for content published across environments.

### Default Behavior

If the `HMACSecretKey` is not set, image requests are not secured, and any person can request images with any parameters. This may expose your server to abuse, such as excessive resizing requests or unauthorized access to images.

### Key Length

The `HMACSecretKey` should be a secure, random key. For most use cases, a 64-byte (512-bit) key is recommended. If you are using `HMACSHA384` or `HMACSHA512`, you may want to use a longer key (for example: 128 bytes).

### Example Configuration

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
