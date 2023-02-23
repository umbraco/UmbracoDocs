---
description: This article covers how to use the Member Password Configuration setting.
---

# Member Password Configuration Settings

This section allows you to define the password rules for members.

```json
"Umbraco": {
    "CMS": {
        "MemberPasswordConfigurationSettings": {
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

Specifies the minimum length a member password is allowed to be.

## Require non letter or digit

Requires a members password to contain at least one character which is not a letter or a digit if enabled.

## Require digit

Requires a members password to contain at least one digit if enabled.

## Require lowercase

Requires a member password to contain at least on lowercase letter if enabled.

## Max failed access attempts before lockout

Specifies the max amount of failed password attempts is allowed before the member is locked out of the site.

## Hash algorithm type

Allows you to specify what hashing algorithm should be used to store the members password.

Options are:

* `"PBKDF2.ASPNETCORE.V3"`
* `"PBKDF2.ASPNETCORE.V2"`
* `"HMACSHA256"`
* `"HMACSHA1"`
