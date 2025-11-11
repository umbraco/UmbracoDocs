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
      "UserDefaultFailedLoginDurationInMilliseconds": 1000,
      "UserMinimumFailedLoginDurationInMilliseconds": 250,
      "BackOfficeTokenCookie": {
        "Enabled": false,
        "SameSite": "Strict"
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

When set to `false`, any user account is prevented from having multiple simultaneous sessions. In this mode, only one session per user can be active at any given time. This enhances security and prevents concurrent logins with the same user credentials.

### User login duration

Umbraco provides protection from user enumeration attacks looking to identify valid backoffice login accounts. It does this by attempting to equalize the time taken for successful and failed logins.

The `UserDefaultFailedLoginDurationInMilliseconds` can be used to provide a more realistic expected time for a successful login if the default isn't appropriate. This will be used before actual successful logins are detected. `UserMinimumFailedLoginDurationInMilliseconds` provides a minimum duration for a failed login.

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

As an added security feature, user authentication tokens can be returned in secure cookies from the server's authentication requests. This section lets you change the default settings for the generated token cookies.

For backwards compatibility reasons, the feature is disabled by default.

We recommend you:

1. Enable this feature (see below).
2. Retain the default values for the rest of the configuration.

### Enabled

When set to `true`, user authentication tokens are redacted from the server authentication responses and put into secure cookies instead.

### Same site

Sets the `SameSite` configuration for the token cookies. Valid values are "Unspecified", "None", "Lax" and "Strict" (default).
