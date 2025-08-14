---
description: "Information on the runtime settings section"
---

# Runtime settings

In the Runtime settings you can configure:

- Size limits for requests and query strings. Neither of these settings needs to be configured. If nothing is configured, requests and query strings can be any size.
- The runtime mode of Umbraco.
- The lifetime of temporary file uploads. This is primarily used when uploading images and other media in the backoffice.

An example of a configuration could look something like:

```json
"Umbraco": {
  "CMS": {
    "Runtime": {
      "MaxRequestLength": 2048,
      "Mode": "BackofficeDevelopment",
      "TemporaryFileLifeTime": "1.00:00:00"
    }
  }
}
```

- `MaxRequestLength` is specified in kilobytes. Setting this limits the request size, including the size of uploaded files. This only has an effect on the server when hosting with Kestrel. But it is also used by the Backoffice to advise the users. See the [Maximum Upload Size Settings
](./maximumuploadsizesettings.md) article for more information.
- `Mode` can have three values: `BackofficeDevelopment` (default), `Development`, and `Production`. For more information, see the [Runtime modes](../../fundamentals/setup/server-setup/runtime-modes.md) article.
- `TemporaryFileLifeTime` is specified as a timespan. The default value is one day - `1.00:00:00`.
