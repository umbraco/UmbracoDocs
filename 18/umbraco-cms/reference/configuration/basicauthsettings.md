---
description: >-
  Configuration reference for the Umbraco basic authentication settings
  section in appsettings.json.
---

# Basic Authentication Settings

This article is a reference for the `Umbraco:CMS:BasicAuth` configuration section. For an overview of the feature, including the login flow, frontend-only deployments, and view customization, see the [Basic Authentication](../security/basic-authentication.md) article.

A basic authentication section with all default values:

{% code title="appsettings.json" %}
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
      },
      "LoginViewPath": "/umbraco/BasicAuthLogin/Login.cshtml",
      "TwoFactorViewPath": "/umbraco/BasicAuthLogin/TwoFactor.cshtml"
    }
  }
}
```
{% endcode %}

## AllowedIPs

A comma-separated list of IP addresses to limit where requests can come from.

## Enabled

Enables or disables basic authentication. The default value is `false`.

## RedirectToLoginPage

When set to `true`, users are redirected to a standalone server-rendered login page at `/umbraco/basic-auth/login` instead of seeing the browser's native authentication popup. The default value is `false`.

This setting is required for [External login providers](../security/external-login-providers.md) and [Two-factor Authentication](../security/two-factor-authentication.md) to work with basic authentication.

{% hint style="info" %}
When two-factor authentication is required for a user, the login flow redirects to the 2FA page automatically. This happens even when `RedirectToLoginPage` is set to `false`, because the browser's native popup cannot complete a 2FA flow.
{% endhint %}

## SharedSecret

A shared secret sent via an HTTP header to bypass basic authentication. This is useful for server-to-server communication.

### HeaderName

The header name used to compare the shared secret. The default value is `X-Authentication-Shared-Secret`.

### Value

The value of the shared secret. Must be a non-empty string to be enabled. The default value is `null`.

## LoginViewPath

Path to a custom Razor view for the login page. When omitted, the built-in login view is used. See [Customizing the login views](../security/basic-authentication.md#customizing-the-login-views) for details.

## TwoFactorViewPath

Path to a custom Razor view for the two-factor authentication (2FA) page. When omitted, the built-in 2FA view is used. See [Customizing the login views](../security/basic-authentication.md#customizing-the-login-views) for details.
