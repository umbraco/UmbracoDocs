---
description: >-
  Protect the front-end of your Umbraco website with basic authentication
  using backoffice user credentials.
---

# Basic Authentication

Basic authentication protects the front-end of your Umbraco website using backoffice user credentials. When enabled, visitors must authenticate before accessing any page.

The feature supports username and password login, two-factor authentication, and external login providers (Google, Microsoft, and others). Authentication uses a standalone server-rendered login page that works independently of the backoffice.

## Enabling basic authentication

Enable basic authentication in `appsettings.json`:

{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "BasicAuth": {
      "Enabled": true,
      "RedirectToLoginPage": true
    }
  }
}
```
{% endcode %}

With `RedirectToLoginPage` set to `true`, visitors are redirected to a login page at `/umbraco/basic-auth/login`. With it set to `false`, the browser shows its native authentication pop-up.

Set `RedirectToLoginPage` to `true` when using external login providers or two-factor authentication. The browser's native pop-up cannot complete these flows.

For the full list of configuration options, see the [Basic Authentication Settings](../configuration/basicauthsettings.md) article.

## Login flow

When `RedirectToLoginPage` is set to `true`, the login flow works as follows:

1. A visitor requests a protected page.
2. The middleware redirects to `/umbraco/basic-auth/login?returnPath=...`.
3. The visitor enters their backoffice credentials.
4. If two-factor authentication is required, the visitor is redirected to `/umbraco/basic-auth/2fa`.
5. On successful authentication, the visitor is redirected back to the original page.

External login providers appear as buttons on the login page when configured. See the [External login providers](external-login-providers.md) article for setup instructions.

{% hint style="info" %}
When two-factor authentication is required for a user, the login flow redirects to the 2FA page automatically. This happens even when `RedirectToLoginPage` is set to `false`, because the browser's native pop-up cannot complete a 2FA flow.
{% endhint %}

## Frontend-only deployments

Basic authentication works in frontend-only deployments where the backoffice is not available. To enable this, register `AddBackOfficeSignIn()` in your `Program.cs`:

{% code title="Program.cs" %}
```csharp
builder.CreateUmbracoBuilder()
    .AddCore()
    .AddBackOfficeSignIn()
    .AddWebsite()
    .AddComposers()
    .Build();
```
{% endcode %}

`AddBackOfficeSignIn()` registers backoffice identity and cookie authentication without the full backoffice. This enables the standalone login page with support for two-factor authentication and external login providers.

For details on the available configurations, see the [Service Registration](../service-registration.md) article.

{% hint style="info" %}
When using the full backoffice setup with `AddBackOffice()`, backoffice sign-in is included automatically. You do not need to add `AddBackOfficeSignIn()` separately.
{% endhint %}

## Customizing the login views

The built-in login and 2FA pages use minimal styling and work without customization. To match your site's design, you can provide custom Razor views.

Set the view paths in `appsettings.json`:

{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "BasicAuth": {
      "Enabled": true,
      "RedirectToLoginPage": true,
      "LoginViewPath": "~/Views/BasicAuth/Login.cshtml",
      "TwoFactorViewPath": "~/Views/BasicAuth/TwoFactor.cshtml"
    }
  }
}
```
{% endcode %}

The login view receives a `BasicAuthLoginModel` with the following properties:

- `ReturnPath` — the URL to redirect to after login.
- `ErrorMessage` — an error message to display (null when no error).
- `ExternalLoginProviders` — a list of configured external login providers to render as buttons.

The 2FA view receives a `BasicAuthTwoFactorModel` with the following properties:

- `ReturnPath` — the URL to redirect to after verification.
- `ErrorMessage` — an error message to display (null when no error).
- `TwoFactorProviders` — a list of available 2FA providers.

{% hint style="info" %}
Use the built-in views at `/umbraco/BasicAuthLogin/Login.cshtml` and `/umbraco/BasicAuthLogin/TwoFactor.cshtml` as a reference when creating custom views.
{% endhint %}
