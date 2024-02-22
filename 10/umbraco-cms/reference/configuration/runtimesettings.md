---


meta.Title: Umbraco Runtime Settings
description: Information on the runtime settings section
---

# Runtime settings

Runtime settings allows you to configure the `MaxRequestLength` and `MaxQueryStringLength` for your application. Neither of these settings needs to be configured. If nothing is configured reqests and query string can be any size.

An example of a configuration could look something like:

```json
"Umbraco": {
  "CMS": {
    "Runtime": {
      "MaxQueryStringLength": 90,
      "MaxRequestLength": 2048,
      "Mode": "BackofficeDevelopment"
    }
  }
}
```

`MaxRequestLength` is specified in kilobytes, limiting requests, and therefore uploaded files, to 2 megabytes. Additionally, it sets a maximum query string length of 90 characters.

`Mode` can have three values: `BackofficeDevelopment` (default), `Development`, and `Production`.

For more information, see the [Runtime modes](../../fundamentals/setup/server-setup/runtime-modes.md) article.
