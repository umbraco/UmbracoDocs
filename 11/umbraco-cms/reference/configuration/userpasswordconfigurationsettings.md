---
description: This article covers information about the User Password configuration setting.
---

# User Password Configuration Settings

This section lets you define the password rules for users.

```json
"Umbraco": {
    "CMS": {
        "UserPassword": {
            "RequiredLength": 10,
            "RequireNonLetterOrDigit": false,
            "RequireDigit": false,
            "RequireLowercase": false,
            "RequireUppercase": false,
            "HashAlgorithmType": "PBKDF2.ASPNETCORE.V3",
            "MaxFailedAccessAttemptsBeforeLockout": 5
        }
    }
}
```

## Required length

Specifies the minimum length a user password is allowed to be.

## Require non letter or digit

Requires a users password to contain at least one character which is not a letter or a digit if enabled.

## Require digit

Requires a users password to contain at least one digit if enabled.

## Require lowercase

Requires a users password to contain at least on lowercase letter if enabled.

## Max failed access attempts before lockout

Specifies the max amount of failed password attempts is allowed before the user is locked out of the site.

## Hash algorithm type

Allows you to specify what hashing algorithm should be used to store the users password.

Options are:

* `"PBKDF2.ASPNETCORE.V3"`
* `"PBKDF2.ASPNETCORE.V2"`
* `"HMACSHA256"`
* `"HMACSHA1"`
