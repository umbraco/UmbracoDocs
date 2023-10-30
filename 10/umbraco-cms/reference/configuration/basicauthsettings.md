---


meta.Title: "Umbraco Basic Authentication Settings"
description: "Information on the basic authentication section"
---

# Basic Authentication Settings

Allows you to configure the basic authentication settings for Umbraco. A basic authentication section fully populated with default values can be seen here:

```json
"Umbraco": {
  "CMS": {
    "BasicAuth": {
      "AllowedIPs": [],
      "Enabled": false,
      "RedirectToLoginPage": false,
      "SharedSecret": {
        "HeaderName": "X-Authentication-Shared-Secret",
        "Value": null
      }
    }
  }
}
```
## AllowedIPs

This is a comma-separated list of IP addresses you want to limit where the requests can come from.

## Enabled

If the value is set to `true`, the basic authentication is enabled. By default, the value is set to false.

## RedirectToLoginPage

If the value is set to `true`, instead of showing the basic authentication popup in the browser, the user is redirected to the login page. This is required for external logins to work. By default, the value is set to false.

## SharedSecret

A shared secret can be sent using an HTTP header to bypass the basic authentication. This can be valuable for server-to-server communication.

### HeaderName

The header name used to compare the shared secret. By default, the value is set to `X-Authentication-Shared-Secret`.

### Value

The value of the shared secret. Must be a string longer than 0 characters to be enabled. The default value is `null`.
