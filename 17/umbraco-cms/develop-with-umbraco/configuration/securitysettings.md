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
      "UserInviteEmailExpiry": "3.00:00:00",
      "BackOfficeTokenCookie": {
        "SameSite": "Strict",
        "SiteName": ""
      }
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

The authentication cookie which is set in the browser when a backoffice user logs in, and defaults to `UMB_UCONTEXT`.

Set this to a unique value per site when you run more than one Umbraco site on the same hostname. This includes sites running on `localhost` during local development. See [Site name](#site-name) for the full set of settings needed.

### Auth cookie domain

The authentication cookie which is set in the browser when a backoffice user logs in is automatically set to the current domain.

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

## Backoffice token cookie settings

User authentication tokens are redacted from the server's authentication responses and put into secure cookies instead. This section lets you change the default settings for the generated token cookies.

It is not recommended to change the `SameSite` setting, as it may result in lesser security for the backoffice users. The `SiteName` setting only changes the names of the cookies and does not weaken their security.

### Same site

Sets the `SameSite` configuration for the token cookies. Valid values are "Unspecified", "None", "Lax", and "Strict" (default).

### Site name

The `SiteName` configuration appends a suffix to the names of the backoffice token cookies, so that each site can have its own cookies.

Use this when you run more than one Umbraco site on the same hostname. Browser cookies are scoped to the hostname and ignore the port number, so two sites running on `https://localhost:44301` and `https://localhost:44302` share the same cookies. Signing in to one site then signs you out of the other. Unique cookie names allow for signing in to more than one backoffice simultaneously.

The value is appended to the cookie names exactly as written, so include any separator you want yourself. It must be valid in a cookie name, so avoid spaces and the characters `=`, `;`, and `,`.

| `SiteName`     | Resulting cookie names                                                                    |
| -------------- | ----------------------------------------------------------------------------------------- |
| `""` (default) | `__Host-umbAccessToken`, `__Host-umbRefreshToken`, `__Host-umbPkceCode`                   |
| `"-siteA"`     | `__Host-umbAccessToken-siteA`, `__Host-umbRefreshToken-siteA`, `__Host-umbPkceCode-siteA` |

Sites running over plain HTTP do not get the `__Host-` prefix on the cookie names.

#### Configuration example

`SiteName` only covers the token cookies. The backoffice authentication cookie is shared between the sites as well, so also configure a unique [auth cookie name](#auth-cookie-name) for each site. Without it, a site signs you out again the next time it needs to re-authenticate the user. This happens after the session expires, or when signing in with an external login provider.

Configure both settings, using values that are unique to each site:

```json
"Umbraco": {
  "CMS": {
    "Security": {
      "AuthCookieName": "UMB_UCONTEXT_SITEA",
      "BackOfficeTokenCookie": {
        "SiteName": "-siteA"
      }
    }
  }
}
```

As an alternative to configuring cookie names, give each site its own hostname. For example, map `sitea.localtest.me` and `siteb.localtest.me` to your local sites.

{% hint style="info" %}
This setting is not related to the `SiteName` setting in the [hosting settings](hostingsettings.md). That setting names the site in the hosting environment and has no effect on cookies.
{% endhint %}
