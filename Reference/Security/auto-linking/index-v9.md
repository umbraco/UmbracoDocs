---
versionFrom: 9.0.0
keywords: oauth, security
---

# Linking External Login Provider accounts

Traditionally when using [External login providers (OAuth)](../external-login-providers/index-v9.md), a backoffice user will need to exist first and then that user can link their user account to an external login provider in the backoffice.

In many cases, however, the external login provider you install will be the source of truth for all of your users and you may want to provide a single sign-on (SSO) approach to the backoffice. This is called Auto Linking.


## Configure External Login provider

To enable auto linking pass a `ExternalSignInAutoLinkOptions` object into the `autoLinkOptions` of `BackOfficeExternalLoginProviderOptions`. For example:

### Example

If you have followed the instructions to [Setup an External Login Provider](../external-login-providers/index-v9.md) update your IBuilder Extension to pass the `autoLinkOptions`

_This example shows connection to an Open ID Connect Service such as [IdentityServer4](https://github.com/IdentityServer/IdentityServer4) or [OpenIDDict](https://github.com/openiddict/openiddict-core)_

```cs
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Security;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Web.BackOffice.Security;
using Umbraco.Extensions;

public static class AuthenticationServerExtensions
{
    public static IUmbracoBuilder AddAuthenticationServer(this IUmbracoBuilder builder)
    {
        var authServerOptions = new AuthenticationServerOptions();
        builder.Config.GetSection(AuthenticationServerOptions.AuthenticationServer).Bind(authServerOptions);

        builder.AddBackOfficeExternalLogins(backOfficeLoginOptions =>
        {
            backOfficeLoginOptions.AddBackOfficeLogin(new BackOfficeExternalLoginProviderOptions(
                "btn-danger",
                "fa-cloud",
                autoLinkOptions: new ExternalSignInAutoLinkOptions(
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

                    defaultCulture: null,
                    // Optionally you can disable the ability to link/unlink
                    // manually from within the back office. Set this to false
                    // if you don't want the user to unlink from this external
                    // provider.
                    allowManualLinking: false
                ){
                    // Optional callback
                    OnAutoLinking = (autoLinkUser, loginInfo) => {
                        // You can customize the user before it's linked.
                        // i.e. Modify the user's groups based on the Claims returned
                        // in the externalLogin info
                    },
                    OnExternalLogin = (user, loginInfo) => {
                        // You can customize the user before it's saved whenever they have
                        // logged in with the external provider.
                        // i.e. Sync the user's name based on the Claims returned
                        // in the externalLogin info
                        return true;
                    }
                },
                // Optionally you can disable the ability for users
                // to login with a username/password. If this is set
                // to true, it will disable username/password login
                // even if there are other external login providers installed.
                denyLocalLogin: true,

                // Optionally choose to automatically redirect to the
                // external login provider so the user doesn't have
                // to click the login button. This is
                autoRedirectLoginToExternalProvider: true
            ), backOfficeAuthOptions =>
            {
                backOfficeAuthOptions.AddOpenIdConnect("Umbraco.oidc", "City Account", openIdOptions =>
                {
                    // use cookies
                    openIdOptions.SignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;

                    // pass configured options along
                    openIdOptions.Authority = authServerOptions.Authority;
                    openIdOptions.ClientId = authServerOptions.ClientId;
                    openIdOptions.ClientSecret = authServerOptions.ClientSecret;

                    // Use the authorization code flow
                    openIdOptions.ResponseType = OpenIdConnectResponseType.Code;
                    openIdOptions.AuthenticationMethod = OpenIdConnectRedirectBehavior.RedirectGet;

                    // map claims
                    openIdOptions.TokenValidationParameters.NameClaimType = "name";
                    openIdOptions.TokenValidationParameters.RoleClaimType = "role";
                    
                    openIdOptions.RequireHttpsMetadata = true;
                    openIdOptions.GetClaimsFromUserInfoEndpoint = true;
                    openIdOptions.SaveTokens = true;

                    // add scopes
                    openIdOptions.Scope.Add("openid");
                    openIdOptions.Scope.Add("email");
                    openIdOptions.Scope.Add("roles");

                    openIdOptions.UsePkce = true;
                });
            });
        });
        return builder;
    }
}
```

Additionally, there are more advanced properties for `BackOfficeExternalLoginProviderOptions`:

* `BackOfficeExternalLoginProviderOptions.CustomBackOfficeView`
  * Allows for specifying a custom angular HTML view that will render in place of the default external login button. The purpose of this is in case you want to completely change the UI but also in these circumstances:
    * You want to display something different where external login providers are listed: in the login screen vs the backoffice panel vs on the logged-out screen. This same view will render in all of these cases but you can use the current route parameters to customize what is shown.
    * You want to change how the button interacts with the external login provider. For example, instead of having the site redirect on button-click, you want to open a popup window to load the external login provider.
  * The path is a virtual path, for example: `"~/App_Plugins/MyPlugin/BackOffice/my-external-login.html"`
  * When specifying this view it is 100% up to your angular view and affiliated angular controller to perform all required logic. To get started, the easiest way is to copy what the [default angular view](https://github.com/umbraco/Umbraco-CMS/blob/v8/contrib/src/Umbraco.Web.UI.Client/src/views/components/application/umb-login.html#L126-L140) does and then implement your angular controller to do what the [default controller](https://github.com/umbraco/Umbraco-CMS/blob/v8/contrib/src/Umbraco.Web.UI.Client/src/common/directives/components/application/umblogin.directive.js#L48) does.

:::note
For some providers, it doesn't make sense to use auto-linking. This is especially true for public providers such as Google or Facebook. In those cases, it would mean that anyone who has a Google or Facebook account can log into your site. For public providers such as this, if auto-linking was needed you would need to limit the access by domain or other information provided in the Claims using the options/callbacks specified in those provider's authentication options.
:::

## Local logins

If you have configured auto-linking, then any auto-linked user will have an empty password assigned and they will not be able to log in locally (via username and password). In order to log in locally, they will have to assign a password to their account in the backoffice.

If the `DenyLocalLogin` option is enabled, then all password changing functionality in the backoffice is also disabled and local login is not possible.

## Transfering Claims from External identities

In some cases you may want to flow a Claim returned in your external login provider to the Umbraco backoffice identity's Claims (the authentication cookie). This can be done during the `OnAutoLinking` and `OnExternalLogin`.

Reason for this could be to store the external login provider user ID into the backoffice identity cookie. That way it can be retrieved on each request in order to look up some data in another system that needs the current user id from the external login provider.

:::warning
Do not flow large amounts of data into the backoffice identity because this information is stored into the backoffice authentication cookie and cookie limits will apply. Data like JWT tokens need to be [persisted](#storing-external-login-provider-data) somewhere to be looked up and not stored within the backoffice identity itself.
:::

### Example

_This is a very simplistic example for brevity, no null checks, etc..._

```cs
OnAutoLinking = (user, loginInfo) => {
    // You can customize the user before it's linked.
    // i.e. Modify the user's groups based on the Claims returned
    // in the externalLogin info
    var extClaim = loginInfo.Principal.FindFirst("MyClaim");
    user.Claims.Add(new IdentityUserClaim<string>
    {
        ClaimType = extClaim.Type,
        ClaimValue = extClaim.Value,
        UserId = user.Id
    });
},
OnExternalLogin = (user, loginInfo) => {
    // You can customize the user before it's saved whenever they have
    // logged in with the external provider.
    // i.e. Sync the user's name based on the Claims returned
    // in the externalLogin info
    var extClaim = loginInfo.Principal.FindFirst("MyClaim");
    user.Claims.Add(new IdentityUserClaim<string>
    {
        ClaimType = extClaim.Type,
        ClaimValue = extClaim.Value,
        UserId = user.Id
    });
    return true;
}
```

:::note
Be aware that the local Umbraco user must already exist and be linked to the external login provider before data can be stored here. In cases where auto-linking occurs and the backoffice user isn't yet created, you will most likely need to store this data in memory. First, during auto-linking and then persist this data to the service once the user is linked and created.
:::
