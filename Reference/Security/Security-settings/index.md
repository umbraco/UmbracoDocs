---
versionFrom: 9.0.0
---

# Umbraco Security Settings

## Password settings

The settings for Umbraco passwords are configurable in appsettings. There are two different configuration objects - One for Umbraco Members and one for Users.

For more information see the [Security Settings documentation](../../V9-Config/SecuritySettings/#user-password-settings).

## Password reset settings

Umbraco backend users can [reset their own password](../password-reset.md), or if they try too much, have a locked out account.

To deactivate the User password reset look at the [Umbraco Settings Security](../../V9-Config/SecuritySettings/#allow-password-reset) section.

To configure password reset verify the [Backoffice Login Password Reset](../../../Fundamentals/Backoffice/Login/index.md#password-reset) section.

## Other security settings

- [The Umbraco timeout in minutes](../../V9-Config/GlobalSettings/#timeout)
- [disableAlternativeTemplates](../../V9-Config/WebRoutingSettings/#disable-alternative-templates) If set to false this can be used to try to render pages in a way that they are not supposed to
- [disableFindContentByIdPath](../../V9-Config/WebRoutingSettings/#disable-find-content-by-id-path) If set to false this can be used to do an enumeration of the nodes in your website and find hidden pages.
- Umbraco Forms: [AntiForgeryToken](../../../Add-ons/UmbracoForms/Developer/Configuration/index#enableantiforgerytoken) and DisableFormCaching
