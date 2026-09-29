---
description: Information on the security settings section
---

# Security Settings

The options in the security section allows you to configure all things security, whether to keep users logged in, password rules and more.

A full configuration with all default values can be seen here:

```json
"Umbraco": {
  "CMS": {
    "Security": {
      "KeepUserLoggedIn": false,
      "HideDisabledUsersInBackOffice": false,
      "AllowPasswordReset": true,
      "AuthCookieName": "UMB_UCONTEXT",
      "AuthCookieDomain": "",
      "AuthCookieSameSite": "Strict",
      "UsernameIsEmail": true,
      "MemberRequireUniqueEmail": true,
      "AllowedUserNameCharacters": "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._@+\\",
      "BackOfficeHost": "http://your-domain.com",
      "UserPassword": {
        "RequiredLength": 10,
        "RequireNonLetterOrDigit": false,
        "RequireDigit": false,
        "RequireLowercase": false,
        "RequireUppercase": false,
        "HashAlgorithmType": "PBKDF2.ASPNETCORE.V3",
        "MaxFailedAccessAttemptsBeforeLockout": 5
      },
      "MemberPassword": {
        "RequiredLength": 10,
        "RequireNonLetterOrDigit": false,
        "RequireDigit": false,
        "RequireLowercase": false,
        "RequireUppercase": false,
        "HashAlgorithmType": "PBKDF2.ASPNETCORE.V3",
        "MaxFailedAccessAttemptsBeforeLockout": 5
      },
      "UserDefaultLockoutTimeInMinutes": 43200,
      "MemberDefaultLockoutTimeInMinutes": 43200,
      "AllowConcurrentLogins": false,
      "UserAllowConcurrentLogins": null,
      "MemberAllowConcurrentLogins": null,
      "UserDefaultFailedLoginDurationInMilliseconds": 1000,
      "UserMinimumFailedLoginDurationInMilliseconds": 250,
      "PasswordResetEmailExpiry": "01:00:00",
      "UserInviteEmailExpiry": "3.00:00:00"
    }
  }
}
```

## Root level settings

At the root level of security you can configure the following

### Keep user logged in

When set to false a user will be logged out after a specific amount of time has passed with no activity. You can specify this time span in the [global settings](globalsettings.md) with the `TimeOut` key.

### Hide disabled users in backoffice

When this is set to "true" it's not possible to see disabled users. This means it's not possible to re-enable their access to the backoffice again. It also means you can't create an identical username if the user was disabled by a mistake.

### Allow password reset

This feature allows users to reset their passwords if they have forgotten them. By default, this is enabled. It can be disabled at both the UI and API level by setting this value to "false".

### Auth cookie name

The name of the authentication cookie that Umbraco sets in the browser when a backoffice user logs in. The default is `UMB_UCONTEXT`.

The authentication cookie holds the backoffice session. The browser sends it with every request the backoffice makes to the server.

Set this to a unique value per site when you run more than one Umbraco site on the same hostname. This includes sites running on `localhost` during local development. See [Run more than one site on the same hostname](#run-more-than-one-site-on-the-same-hostname) for an example.

### Auth cookie domain

The authentication cookie which is set in the browser when a backoffice user logs in is automatically set to the current domain.

### Auth cookie SameSite

Key: `AuthCookieSameSite`
Type: `string` (default: `"Strict"`)

Sets the `SameSite` attribute of the authentication cookie. Valid values are "Strict" (default), "Lax", "None", and "Unspecified".

Keep the default in production. The `SameSite` attribute stops cross-site requests from carrying the authentication cookie. The Management API has no antiforgery tokens, so the attribute is its protection against cross-site request forgery.

Only set the value to "None" when the backoffice runs on a different origin than the Umbraco server. For example, when you develop against a local dev server configured as the [BackOffice Host](#backoffice-host). Browsers accept a `SameSite=None` cookie only with the `Secure` attribute, which requires HTTPS. If a proxy terminates HTTPS in front of Umbraco, also set `UseHttps` to `true` in the [global settings](globalsettings.md).

Umbraco logs a warning at startup when the value is "None" outside the `Development` environment. Umbraco does not replace an unrecognized value with the default. It reports a configuration error instead.

### Username is email

This setting specifies whether the username and email address are separate fields in the backoffice editor. When set to "false", you can specify an email address and username, only the username can be used to log on. When set to "true" (the default value) the username is hidden and always the same as the email address.

### Member require unique email

By default Umbraco will not allow creation of more than one member account with the same email address. If you wish to allow this, set this value to `false`.

### Allowed user name characters

Defines the allowed characters for a username.

### BackOffice Host

Use this setting to override the Backoffice host URL. This is useful when the Backoffice client runs from a different origin than the Umbraco server. For example, in proxied, cloud-hosted setups, or when developing locally using Vite or another dev server.

### User default lockout time

Use this setting to configure how long time a User is locked out of the Umbraco backoffice when a lockout occurs. The setting accepts an integer which defines the lockout in minutes.

The default lockout time for users is 30 days (43200 minutes).

### Member default lockout time

Use this setting to configure how long time a Member is locked out of the Umbraco website when a lockout occurs. The setting accepts an integer which defines the lockout in minutes.

The default lockout time for users is 30 days (43200 minutes).

### Allow concurrent logins

Key: `AllowConcurrentLogins`
Type: `bool` (default: `false`)

When set to `false`, each account is limited to one active session at a time. A new login invalidates any existing session for the same account. This applies to both backoffice users and members unless overridden by the settings below.

### User allow concurrent logins

Key: `UserAllowConcurrentLogins`
Type: `bool?` (default: `null`)

Controls concurrent login behavior for backoffice users only. When `null`, the value falls back to `AllowConcurrentLogins`. Set to `true` or `false` to override the global setting for backoffice users.

### Member allow concurrent logins

Key: `MemberAllowConcurrentLogins`
Type: `bool?` (default: `null`)

Controls concurrent login behavior for members only. When `null`, the value falls back to `AllowConcurrentLogins`. Set to `true` or `false` to override the global setting for members.

{% hint style="info" %}
`UserAllowConcurrentLogins` and `MemberAllowConcurrentLogins` are available from Umbraco 17.3.
{% endhint %}

#### Configuration examples

Allow concurrent logins for members but not backoffice users:

```json
"Security": {
  "AllowConcurrentLogins": false,
  "MemberAllowConcurrentLogins": true
}
```

Disable concurrent logins for backoffice users while keeping them enabled globally:

```json
"Security": {
  "AllowConcurrentLogins": true,
  "UserAllowConcurrentLogins": false
}
```

### User login duration

Umbraco provides protection from user enumeration attacks looking to identify valid backoffice login accounts. It does this by attempting to equalize the time taken for successful and failed logins.

The `UserDefaultFailedLoginDurationInMilliseconds` can be used to provide a more realistic expected time for a successful login if the default isn't appropriate. This will be used before actual successful logins are detected. `UserMinimumFailedLoginDurationInMilliseconds` provides a minimum duration for a failed login.

### Password reset email expiry

Defines the expiry for the password reset email. When the email is sent, an `Expiry` header will be added that uses the value configured here. The default value is 1 hour.

### User invite email expiry

Defines the expiry for the user invite email. When the email is sent, an `Expiry` header will be added that uses the value configured here. The default value is 3 days.

## User password settings

This section lets you define the password rules for users.

### Required length

Specifies the minimum length a user password is allowed to be.

### Require non letter or digit

Requires a users password to contain at least one character which is not a letter or a digit if enabled.

### Require digit

Requires a users password to contain at least one digit if enabled.

### Require lowercase

Requires a users password to contain at least one lowercase letter if enabled.

### Require uppercase

Requires a users password to contain at least one uppercase letter if enabled.

### Max failed access attempts before lockout

Specifies the max amount of failed password attempts is allowed before the user is locked out of the site.

### Hash algorithm type

Allows you to specify what hashing algorithm should be used to store the users password.

Options are:

* `"PBKDF2.ASPNETCORE.V3"`
* `"PBKDF2.ASPNETCORE.V2"`
* `"HMACSHA256"`
* `"HMACSHA1"`

## Member password settings

This section allows you to define the password rules for members. This section is identical to the one for users.

## Run more than one site on the same hostname

Browsers scope cookies to the hostname and ignore the port number. Two sites running on `https://localhost:44301` and `https://localhost:44302` share the same cookies. With the default settings, both sites use the `UMB_UCONTEXT` authentication cookie. Signing in to one site then signs you out of the other.

Configure a unique [auth cookie name](#auth-cookie-name) for each site to stay signed in to both sites at the same time:

{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "Security": {
      "AuthCookieName": "UMB_UCONTEXT_SITEA"
    }
  }
}
```
{% endcode %}

The value must be valid in a cookie name, so avoid spaces and the characters `=`, `;`, and `,`.

As an alternative to configuring cookie names, give each site its own hostname. For example, map `sitea.localtest.me` and `siteb.localtest.me` to your local sites.

{% hint style="info" %}
Umbraco 17 and 18 also stored the backoffice tokens in cookies, configured in a `BackOfficeTokenCookie` section. Umbraco 19 authenticates the backoffice with the authentication cookie alone, and removes the token cookies along with that section.

Umbraco ignores the section and logs a warning at startup while it is present. Replace `BackOfficeTokenCookie:SiteName` with a unique `AuthCookieName`, and `BackOfficeTokenCookie:SameSite` with `AuthCookieSameSite`.
{% endhint %}
