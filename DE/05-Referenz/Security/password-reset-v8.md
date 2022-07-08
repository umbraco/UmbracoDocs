---
versionFrom: 7.0.0
---

# Locking of Users and password reset

It's impossible to brute force the authentication on the login screen because after `maxInvalidPasswordAttempts` the account of the user will be locked, and until that account is unlocked in the Users section, no attempt will succeed.

## Password reset on login screen

When you submit the password reset form, an email is sent to the user with a link. This link contains a random token for this user that is valid for 24 hours.

The settings `allowPasswordReset` is documented in the [Umbraco Settings Security Section](../Config/umbracoSettings/index.md#security) and e-mail configuration settings in [Backoffice Login Password Reset Section](../../Getting-Started/Backoffice/Login/index.md#password-reset)

## Password reset of a non-existing user

If the user that is specified in the form does not exist, no e-mail will be sent and there will be no response in the form that this user does not exist. This is done to prevent leaking which users have an account.

## Password reset of a locked user

If a user is locked out, it is possible to do a password reset. After the e-mail with the password reset link is followed the user will still be locked out unless the user has specified the new password in which case the user will automatically be unlocked.

## Reset admin user password

If you lost the admin user password and you need to reset is, [check this article](reset-admin-password.md).
