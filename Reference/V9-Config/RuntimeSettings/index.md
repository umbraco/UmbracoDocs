---
versionFrom: 9.0.0
meta.Title: "Umbraco Runtime Settings"
meta.Description: "Information on the runtime settings section"
state: complete
verified-against: beta-3
update-links: true
---

# Runtime settings

Runtime settings allows you to configure the `MaxRequestLength` and `MaxQueryStringLength` for your application. Neither of these settings needs to be configured. If nothing is configured reqests and query string can be any size.

An example of a configuration could look something like: 

```json
"Umbraco": {
  "CMS": {
    "Runtime": {
      "MaxQueryStringLength": 90,
      "MaxRequestLength": 2048
    }
  }
}
```

`MaxRequsetLength` is specified in kilobytes, so this configuration would limit requests, and therefore uploaded files, to 2 megabytes, and a maximum query string length of 90 characters.