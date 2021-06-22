---
versionFrom: 9.0.0
meta.Title: "Umbraco Imaging Settings"
meta.Description: "Information on the imaging settings section"
state: complete
verified-against: beta-3
update-links: true
---


# Imaging settings

Imaging settings lets you configure the caching settings, and resize settings for images on your project. If you need to configure allowed image file types, or auto fill image properties, you want to use [content settings](../ContentSettings/index-v9.md) instead.

All these settings contains default values, so nothing needs to be configured. A complete settings section for imaging can be seen here with all the default values:

```json
"Umbraco": {
  "CMS": {
    "Imaging": {
      "Cache": {
        "BrowserMaxAge": "7.00:00:00",
        "CacheMaxAge": "365.00:00:00",
        "CachedNameLength": 8,
        "CacheFolder": "..\\umbraco\\mediacache"
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

Contains configuration for caching.

### Browser max age

Specifies how long an image may be stored in the browser cache before it gets renewed, formatted as a timespan. The default is seven days.

### Cache max age

This setting allows you to specify how long an image may be stored in the local cache before it gets renewed. Defaults to one year (365 days).

### Cache name length

Whenever an image is cached it will be remamed with a randomly generated name, this setting allows you to change how long that name will be, by default 8 characters. It's worth mentioning here that cached images will be but in a series of sub folders based on their name, for instance a file with the name `abc1` will be put in `mediacahce/a/b/c/1`. This is done to mitigate the potential performance hit of having a very large amount of files in the same folder, so a longer cache name length will result in a deeper folder structure.

### Cache folder

Allows you to specify the location of the media cache foler. It's important to note here that the relative path is based off the `wwwroot` folder, this is why the default relative path starts with `..\`. So by default the path backs out of the `wwwroot` folder and stores the media cache in `\umbraco\mediacache`.

## Resize

Contains configuration for image resizing.

### Max width

Specifies the maximum width an image can be resized to.

### Max height

Specifies the maximum height an image can be resized to.
