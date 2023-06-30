# Umbraco Security Settings

## Password settings

The settings for Umbraco passwords are configurable in appsettings. There are two different configuration objects - One for Umbraco Members and one for Users.

For more information see the [Security Settings documentation](../configuration/securitysettings.md#user-password-settings).

## Password reset settings

Umbraco backend users can [reset their own password](password-reset.md), or if they try too much, have a locked out account.

To deactivate the User password reset look at the [Umbraco Settings Security](../configuration/securitysettings.md#allow-password-reset) section.

To configure password reset verify the [Backoffice Login Password Reset](../../fundamentals/backoffice/login.md#password-reset) section.

## Other security settings

* [The Umbraco timeout in minutes](../configuration/globalsettings.md#timeout)
* [disableAlternativeTemplates](../configuration/webroutingsettings.md#disable-alternative-templates) If set to false this can be used to try to render pages in a way that they are not supposed to
* [disableFindContentByIdPath](../configuration/webroutingsettings.md#disable-find-content-by-id-path) If set to false this can be used to do an enumeration of the nodes in your website and find hidden pages.
* Umbraco Forms: [AntiForgeryToken](https://docs.umbraco.com/umbraco-forms/developer/configuration#enableantiforgerytoken) and DisableFormCaching
