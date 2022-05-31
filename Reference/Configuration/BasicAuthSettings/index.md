---
versionFrom: 9.0.0
meta.Title: "Umbraco Basic Authentication Settings"
meta.Description: "Information on the basic authentication section"
---

# Basic Authentication Settings

Allows you to configure the basic authentication settings for Umbraco. A basic authentication section fully populated with default values can be seen here:

```json
"Umbraco": {
  "CMS": {
    "BasicAuth": {
      "Enabled": false,
      "AllowedIPs": []
    }
  }
}
```

## Enabled

If the value is set to true, the basic authentication is enabled. By default, the value is set to false.

## AllowedIPs

This is a comma-separated list of IP addresses you want to limit where the requests can come from.
