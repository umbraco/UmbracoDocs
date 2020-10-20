---
versionFrom: 8.9.0
keywords: oauth, security
---

# Auto Linking accounts

Traditionally when using [External login providers (OAuth)](external-login-providers.md), a backoffice user will need to exist first and then that user can link their user account to an external login provider in the backoffice.

In many cases however, the external login provider you install will be the source of truth for all of your users and you may want to provide a Single Sign On (SSO) approach to the back office. This is called Auto Linking.

## Configure External Login provider

To enable auto linking there is an extension method on `Microsoft.Owin.Security.AuthenticationOptions` called `SetBackOfficeExternalLoginProviderOptions` which you can pass in an instance of: [`BackOfficeExternalLoginProviderOptions`](https://github.com/umbraco/Umbraco-CMS/blob/v8/contrib/src/Umbraco.Web/Security/BackOfficeExternalLoginProviderOptions.cs)

### Example

If you have installed the [Identity Extensions package](https://github.com/umbraco/UmbracoIdentityExtensions) and are using the Azure Active Directory provider, it will create a file: `UmbracoADAuthExtensions.cs` which configures the AAD options (`OpenIdConnectAuthenticationOptions`). You can extend these options like:

```cs
adOptions.SetBackOfficeExternalLoginProviderOptions(
    new BackOfficeExternalLoginProviderOptions
    {
        AutoLinkOptions = new ExternalSignInAutoLinkOptions(
            // must be true for auto-linking to be enabled
            autoLinkExternalAccount: true,

            // Optionally specify default user group, else
            // assign in the OnAutoLinking callback
            defaultUserGroups: new[] { Constants.Security.EditorGroupAlias },

            // Optionally specify the default culture to create
            // the user as. If null it will use the default
            // culture defined in the web.config, or it can
            // be dyanmically assigned in the OnAutoLinking
            // callback.
            defaultCulture: null)
        {
            // Optionally you can disable the ability to link/unlink
            // manually from within the back office. Set this to false
            // if you don't want the user to unlink from this external
            // provider.
            AllowManualLinking = false,

            // Optional callback
            OnAutoLinking = (user, externalLogin) =>
            {
                // You can customize the user before it's created.
                // i.e. Modify the user's groups based on the Claims returned
                // in the externalLogin info
            },

            // Optional callback
            OnExternalLogin = (user, externalLogin) =>
            {
                // You can customize the user before it's saved whenever they have
                // logged in with the external provider.
                // i.e. Sync the user's name based on the Claims returned
                // in the externalLogin info
            }
        },

        // Optionally you can disable the ability for users
        // to login with a username/password. If this is set
        // to true, it will disable username/password login
        // even if there are other external login providers installed.
        DenyLocalLogin = true,

        // Optionally choose to automatically redirect to the
        // external login provider so the user doesn't have
        // to click the login button. This is
        AutoRedirectLoginToExternalProvider = true
    });
```

There are additional more advanced properties for `BackOfficeExternalLoginProviderOptions`:

* `BackOfficeExternalLoginProviderOptions.CustomBackOfficeView`
  * Allows for specifying a custom angular html view that will render in place of the default external login button. The purpose of this is in case you want to completely change the UI but also in these circumstance:
    * You want to display something different where external login providers are lsited: in the login screen vs the back office panel vs on the logged out screen. This same view will render in all of these cases but you can use the current route parameters to customize what is shown.
    * You want to change how the button interacts with the external login provider. For example, instead of having the site redirect on button click you want to open a popup window to load the exernal login provider.
  * The path is a virtual path, for example: `"~/App_Plugins/MyPlugin/BackOffice/my-external-login.html"`
  * When specifying this view it is 100% up to your angular view and affiliated angular controller to perform all required logic. To get started, the easiest way is to copy what the [default angular view does](https://github.com/umbraco/Umbraco-CMS/blob/v8/contrib/src/Umbraco.Web.UI.Client/src/views/components/application/umb-login.html#L126-L140) and then implement your angular controller to do with the [default controller does](https://github.com/umbraco/Umbraco-CMS/blob/v8/contrib/src/Umbraco.Web.UI.Client/src/common/directives/components/application/umblogin.directive.js#L48).
* `BackOfficeExternalLoginProviderOptions.OnChallenge`
  * A callback that is executed when Umbraco returns the ChallengeResult to perform the redirect.
  * This is mostly a legacy callback since any logic during the redirect should be done within the OpenIdConnect options.

:::note
For some providers it doesn't make sense to use auto-linking especially public providers such as Google or Facebook because in those cases it would mean that anyone can log into your site that has a Google or Facebook account. For public providers such as this, if auto-linking was needed you would need to limit the access by domain or other information provided in the Claims using the options/callbacks specified in those provider's authentication options.
:::

## Local logins

If you have configured auto-linking, then any auto-linked user will have an empty password assigned and they will not be able to login locally (via username and password). In order to login locally they will have to assign a password to their account in the back office.

If the `DenyLocalLogin` option is enabled, then all password changing functionality in the back office is also disabled and local login is not possible.
