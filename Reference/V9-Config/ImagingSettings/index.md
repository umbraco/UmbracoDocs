---
versionFrom: 9.0.0
meta.Title: "Umbraco Imaging Settings"
meta.Description: "Information on the imaging settings section"
state: complete
verified-against: rc-3
update-links: true
---


# Imaging settings

The imaging settings section lets you configure the cache and resize settings for processed images on your project (using [ImageSharp.Web](https://docs.sixlabors.com/articles/imagesharp.web/) as default implementation). If you need to configure allowed image file types or auto fill image properties, you want to use [content settings](../ContentSettings/index-v9.md) instead.

All these settings contain default values, so nothing needs to be explicitly configured. A complete settings section for imaging can be seen here with all the default values:

```json
"Umbraco": {
  "CMS": {
    "Imaging": {
      "Cache": {
        "BrowserMaxAge": "7.00:00:00",
        "CacheMaxAge": "365.00:00:00",
        "CachedNameLength": 8,
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

### Browser max age

Specifies how long a requested processed image may be stored in the browser cache by using this value in the `Cache-Control` response header. The default is 7 days (formatted as a timespan).

### Cache max age

Specifies how long a processed image may be used from the server cache before it needs to be re-processed again. The default is one year (365 days, formatted as a timespan).

### Cache name length

Whenever an image is cached it will use a generated name (based on the SHA256 file hash by default), this setting allows you to change how long that name will be, by default 8 characters. It's worth mentioning here that cached images will be in a series of subfolders based on their name, for instance: a file with the name `abc1` will be put in `/a/b/c/1`. This is done to mitigate the potential performance hit of having a very large amount of files in the same folder, so a longer cache name length will result in a deeper folder structure.

### Cache folder

Allows you to specify the location of the cached images folder. By default, the cached images are stored in `~/umbraco/Data/TEMP/MediaCache`. The tilde (`~`) resolves to the content root of your project/application.

## Resize

Contains configuration for image resizing.

### Max width/max height

Specifies the maximum width and height an image can be resized to. If the requested width and height are _both_ above the configured maximums, no resizing will be performed. This adds very basic security to prevent resizing to very big dimensions and using a lot of server CPU/memory to do so.
