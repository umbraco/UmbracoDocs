---
versionFrom: 8.9.0
keywords: oauth, security
---

# Linking External Login Provider accounts

Traditionally when using [External login providers (OAuth)](external-login-providers.md), a backoffice user will need to exist first and then that user can link their user account to an external login provider in the backoffice.

In many cases, however, the external login provider you install will be the source of truth for all of your users and you may want to provide a single sign-on (SSO) approach to the backoffice. This is called Auto Linking.

:::note
From v8.9.0 the auto-linking logic will execute even if the local user already exists which means you can auto-link an already existing account.
:::


## Configure External Login provider

To enable auto linking there is an extension method on `Microsoft.Owin.Security.AuthenticationOptions` called `SetBackOfficeExternalLoginProviderOptions` which you can pass in an instance of: [`BackOfficeExternalLoginProviderOptions`](https://github.com/umbraco/Umbraco-CMS/blob/v8/contrib/src/Umbraco.Web/Security/BackOfficeExternalLoginProviderOptions.cs)

### Example

If you have installed the [Identity Extensions package](https://github.com/umbraco/UmbracoIdentityExtensions) and are using the Azure Active Directory provider, it will create a `UmbracoADAuthExtensions.cs` file which configures the AAD options (`OpenIdConnectAuthenticationOptions`). You can extend these options like:

```cs
adOptions.SetBackOfficeExternalLoginProviderOptions(
    new BackOfficeExternalLoginProviderOptions
    {
        AutoLinkOptions = new ExternalSignInAutoLinkOptions(
            // must be true for auto-linking to be enabled
            autoLinkExternalAccount: true,

            // Optionally specify default user group, else
            // assign in the OnAutoLinking callback
            // (default is editor)
            defaultUserGroups: new[] { Constants.Security.EditorGroupAlias },

            // Optionally specify the default culture to create
            // the user as. If null it will use the default
            // culture defined in the web.config, or it can
            // be dynamically assigned in the OnAutoLinking
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
                // You can customize the user before it's linked.
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

Additionally, there are more advanced properties for `BackOfficeExternalLoginProviderOptions`:

* `BackOfficeExternalLoginProviderOptions.CustomBackOfficeView`
  * Allows for specifying a custom angular HTML view that will render in place of the default external login button. The purpose of this is in case you want to completely change the UI but also in these circumstances:
    * You want to display something different where external login providers are listed: in the login screen vs the backoffice panel vs on the logged-out screen. This same view will render in all of these cases but you can use the current route parameters to customize what is shown.
    * You want to change how the button interacts with the external login provider. For example, instead of having the site redirect on button-click, you want to open a popup window to load the external login provider.
  * The path is a virtual path, for example: `"~/App_Plugins/MyPlugin/BackOffice/my-external-login.html"`
  * When specifying this view it is 100% up to your angular view and affiliated angular controller to perform all required logic. To get started, the easiest way is to copy what the [default angular view](https://github.com/umbraco/Umbraco-CMS/blob/v8/contrib/src/Umbraco.Web.UI.Client/src/views/components/application/umb-login.html#L126-L140) does and then implement your angular controller to do what the [default controller](https://github.com/umbraco/Umbraco-CMS/blob/v8/contrib/src/Umbraco.Web.UI.Client/src/common/directives/components/application/umblogin.directive.js#L48) does.
* `BackOfficeExternalLoginProviderOptions.OnChallenge`
  * A callback that is executed when Umbraco returns the ChallengeResult to perform the redirect.
  * This is mostly a legacy callback since any logic during the redirect should be done within the OpenIdConnect options.

:::note
For some providers, it doesn't make sense to use auto-linking. This is especially true for public providers such as Google or Facebook. In those cases, it would mean that anyone who has a Google or Facebook account can log into your site. For public providers such as this, if auto-linking was needed you would need to limit the access by domain or other information provided in the Claims using the options/callbacks specified in those provider's authentication options.
:::

## Local logins

If you have configured auto-linking, then any auto-linked user will have an empty password assigned and they will not be able to log in locally (via username and password). In order to log in locally, they will have to assign a password to their account in the backoffice.

If the `DenyLocalLogin` option is enabled, then all password changing functionality in the backoffice is also disabled and local login is not possible.

## Transfering Claims from External identities

:::note
This was not easily possible before v8.9.0
:::

In some cases you may want to flow a Claim returned in your external login provider to the Umbraco backoffice identity's Claims (the authentication cookie). This can be done during the `OnAutoLinking` and `OnExternalLogin`.

Reason for this could be to store the external login provider user ID into the backoffice identity cookie. That way it can be retrieved on each request in order to look up some data in another system that needs the current user id from the external login provider.

:::warning
Do not flow large amounts of data into the backoffice identity because this information is stored into the backoffice authentication cookie and cookie limits will apply. Data like JWT tokens need to be [persisted](#storing-external-login-provider-data) somewhere to be looked up and not stored within the backoffice identity itself.
:::

### Example

_This is a very simplistic example for brevity, no null checks, etc..._

```cs
adOptions.SetBackOfficeExternalLoginProviderOptions(
    new BackOfficeExternalLoginProviderOptions
    {
        AutoLinkOptions = new ExternalSignInAutoLinkOptions(
            autoLinkExternalAccount: true)
        {
            OnAutoLinking = (user, loginInfo) =>
            {
                // flow the MyClaim claim to the umbraco
                // back office identity cookie authentication
                var extClaim = loginInfo
                    .ExternalIdentity
                    .FindFirst("MyClaim");
                user.Claims.Add(new IdentityUserClaim<int>
                {
                    ClaimType = extClaim.Type,
                    ClaimValue = extClaim.Value,
                    UserId = user.Id
                });
            },
            OnExternalLogin = (user, loginInfo) =>
            {
                // flow the MyClaim claim to the umbraco
                // back office identity cookie authentication
                var extClaim = loginInfo
                    .ExternalIdentity
                    .FindFirst("MyClaim");
                user.Claims.Add(new IdentityUserClaim<int>
                {
                    ClaimType = extClaim.Type,
                    ClaimValue = extClaim.Value,
                    UserId = user.Id
                });
            }
        }
    });
```

## Storing external login provider data

In some cases, you may need to persist data from your external login provider like Access Tokens, etc. You can persist this data to the affiliated user's external login data via the `IExternalLoginService`.

The `void Save(IIdentityUserLoginExtended login)` overload takes a new model of type `IIdentityUserLoginExtended` that contains property called `UserData`. This is a blob text column so can store any arbitrary data for the external login provider.

:::note
Be aware that the local Umbraco user must already exist and be linked to the external login provider before data can be stored here. In cases where auto-linking occurs and the backoffice user isn't yet created, you will most likely need to store this data in memory. First, during auto-linking and then persist this data to the service once the user is linked and created.
:::
