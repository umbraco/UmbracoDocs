# Linking External Login Provider accounts

Traditionally when using [External login providers (OAuth)](external-login-providers.md), a backoffice user or website member will need to exist first and then that user can link their user account to an external login provider in the backoffice or edit profile page.

In many cases, however, the external login provider you install will be the source of truth for all of your users.

In this case, you will want to provide a Single Sign On (SSO) approach to logging in. This would enable the creating of user accounts on the external login provider and then automatically give them access to Umbraco. This is called auto-Linking.

## Configure External Login provider

To enable auto linking you have to implement a custom named configuration of `BackOfficeExternalLoginProviderOptions` or `MemberExternalLoginProviderOptions` for users or members, respectively.

### Example for users

_This example shows connection to an Open ID Connect Service such as_ [_IdentityServer4_](https://github.com/IdentityServer/IdentityServer4) _or_ [_OpenIDDict_](https://github.com/openiddict/openiddict-core)

You can first create a `OpenIdConnectBackOfficeExternalLoginProviderOptions.cs` file which configures the options like

```Csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.BackOffice.Security;

namespace Umbraco9
{
    public class OpenIdConnectBackOfficeExternalLoginProviderOptions : IConfigureNamedOptions<BackOfficeExternalLoginProviderOptions>
    {
        public const string SchemeName = "OpenIdConnect";
        public void Configure(string name, BackOfficeExternalLoginProviderOptions options)
        {
            if (name != "Umbraco." + SchemeName)
            {
                return;
            }

            Configure(options);
        }

        public void Configure(BackOfficeExternalLoginProviderOptions options)
        {
            options.ButtonStyle = "btn-danger";
            options.Icon = "fa fa-cloud";
            options.AutoLinkOptions = new ExternalSignInAutoLinkOptions(
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
            )
            {
                // Optional callback
                OnAutoLinking = (autoLinkUser, loginInfo) =>
                {
                    // You can customize the user before it's linked.
                    // i.e. Modify the user's groups based on the Claims returned
                    // in the externalLogin info
                },
                OnExternalLogin = (user, loginInfo) =>
                {
                    // You can customize the user before it's saved whenever they have
                    // logged in with the external provider.
                    // i.e. Sync the user's name based on the Claims returned
                    // in the externalLogin info

                    return true; //returns a boolean indicating if sign in should continue or not.
                }
            };

            // Optionally you can disable the ability for users
            // to login with a username/password. If this is set
            // to true, it will disable username/password login
            // even if there are other external login providers installed.
            options.DenyLocalLogin = false;

            // Optionally choose to automatically redirect to the
            // external login provider so the user doesn't have
            // to click the login button. This is
            options.AutoRedirectLoginToExternalProvider = false;
        }
    }
}
```

Additionally, there are more advanced properties for `BackOfficeExternalLoginProviderOptions`:

* `BackOfficeExternalLoginProviderOptions.CustomBackOfficeView`
  * Allows for specifying a custom angular HTML view that will render in place of the default external login button. The purpose of this is in case you want to completely change the UI but also in these circumstances:
    * You want to display something different where external login providers are listed: in the login screen vs the backoffice panel vs on the logged-out screen. This same view will render in all of these cases but you can use the current route parameters to customize what is shown.
    * You want to change how the button interacts with the external login provider. For example, instead of having the site redirect on button-click, you want to open a popup window to load the external login provider.
  * The path is a virtual path, for example: `"~/App_Plugins/MyPlugin/BackOffice/my-external-login.html"`
  * When specifying this view it is 100% up to your angular view and affiliated angular controller to perform all required logic.

To register this configuration class, you can call the following from your `startup.cs`:

```Csharp
services.ConfigureOptions<OpenIdConnectBackOfficeExternalLoginProviderOptions>();
```

We recommend to create an extension method on the `IUmbracoBuilder`, to add the Open Id Connect Authentication, like this This extension can also handle the configuration of `OpenIdConnectBackOfficeExternalLoginProviderOptions`:

```Csharp
public static IUmbracoBuilder AddOpenIdConnectAuthentication(this IUmbracoBuilder builder)
{
    // Register OpenIdConnectBackOfficeExternalLoginProviderOptions here rather than require it in startup
    builder.Services.ConfigureOptions<OpenIdConnectBackOfficeExternalLoginProviderOptions>();

    builder.AddBackOfficeExternalLogins(logins =>
    {
        logins.AddBackOfficeLogin(
            backOfficeAuthenticationBuilder =>
            {
                backOfficeAuthenticationBuilder.AddOpenIdConnect(
                    // The scheme must be set with this method to work for the back office
                    backOfficeAuthenticationBuilder.SchemeForBackOffice(OpenIdConnectBackOfficeExternalLoginProviderOptions.SchemeName),
                    options =>
                    {
                        // use cookies
                        options.SignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
                        // pass configured options along
                        options.Authority = "https://localhost:5000";
                        options.ClientId = "YOURCLIENTID";
                        options.ClientSecret = "YOURCLIENTSECRET";
                        // Use the authorization code flow
                        options.ResponseType = OpenIdConnectResponseType.Code;
                        options.AuthenticationMethod = OpenIdConnectRedirectBehavior.RedirectGet;
                        // map claims
                        options.TokenValidationParameters.NameClaimType = "name";
                        options.TokenValidationParameters.RoleClaimType = "role";


                        options.RequireHttpsMetadata = true;
                        options.GetClaimsFromUserInfoEndpoint = true;
                        options.SaveTokens = true;
                        // add scopes
                        options.Scope.Add("openid");
                        options.Scope.Add("email");
                        options.Scope.Add("roles");
                        options.UsePkce = true;
                    });
            });
    });
    return builder;
}
```

Finally this extension can also be called from the `Startup.cs` like the example below:

```Csharp
services.AddUmbraco(_env, _config)
   .AddBackOffice()
   .AddWebsite()
   .AddComposers()
   .AddOpenIdConnectAuthentication()
   .Build();
```

{% hint style="info" %}
For some providers, it doesn't make sense to use auto-linking. This is especially true for public providers such as Google or Facebook. In those cases, it would mean that anyone who has a Google or Facebook account can log into your site. For public providers such as this, if auto-linking was needed you would need to limit the access by domain or other information provided in the Claims using the options/callbacks specified in those provider's authentication options.
{% endhint %}

### Example for members

The way to implement auto linking for members is fairly similar to how it is for users. The main difference is the UI, where Umbraco do not have a fixed login page for members. Instead, Umbraco ships with some Partial Macro Snippets for `Login` and `EditProfile` that contains handling of Login and manual linking of the configured external member providers.

When auto-linking is enabled, only the `Login` snippet is relevant as users do not have to register before.

The following example will show how to use Google and external login provider. You can first create a `GoogleMemberExternalLoginProviderOptions.cs` file which configures the options like

```Csharp
using System;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.BackOffice.Security;

namespace Umbraco9
{
    public class GoogleMemberExternalLoginProviderOptions : IConfigureNamedOptions<MemberExternalLoginProviderOptions>
    {
        public const string SchemeName = "Google";

        public void Configure(string name, MemberExternalLoginProviderOptions options)
        {
            if (name != Constants.Security.MemberExternalAuthenticationTypePrefix + SchemeName)
            {
                return;
            }

            Configure(options);
        }

        public void Configure(MemberExternalLoginProviderOptions options) =>
            options.AutoLinkOptions = new MemberExternalSignInAutoLinkOptions(
                // Must be true for auto-linking to be enabled
                autoLinkExternalAccount: true,

                // Optionally specify the default culture to create
                // the user as. If null it will use the default
                // culture defined in the web.config, or it can
                // be dynamically assigned in the OnAutoLinking
                // callback.
                defaultCulture: null,

                // Optionally specify the default "IsApprove" status. Must be true for auto-linking.
                defaultIsApproved:true,

                // Optionally specify the member type alias. Default is "Member"
                defaultMemberTypeAlias:"Member",

                // Optionally specify the member groups names to add the auto-linking user to.
                defaultMemberGroups: Array.Empty<string>()
            )
            {
                // Optional callback
                OnAutoLinking = (autoLinkUser, loginInfo) =>
                {
                    // You can customize the member before it's linked.
                    // i.e. Modify the member's groups based on the Claims returned
                    // in the externalLogin info
                },
                OnExternalLogin = (user, loginInfo) =>
                {
                    // You can customize the member before it's saved whenever they have
                    // logged in with the external provider.
                    // i.e. Sync the member's name based on the Claims returned
                    // in the externalLogin info

                    return true; //returns a boolean indicating if sign in should continue or not.
                }
            };
    }
}
```

To register this configuration class, you can call the following from your `startup.cs`:

```Csharp
services.ConfigureOptions<GoogleMemberExternalLoginProviderOptions>();
```

Like for users, we recommend creating an extension method on the `IUmbracoBuilder`, to add the Google Authentication, like this. This extension can also handle the configuration of `GoogleMemberExternalLoginProviderOptions`:

```Csharp
public static IUmbracoBuilder AddMemberGoogleAuthentication(this IUmbracoBuilder builder)
{
    // Register GoogleMemberExternalLoginProviderOptions here rather than require it in startup
    builder.Services.ConfigureOptions<GoogleMemberExternalLoginProviderOptions>();

    builder.AddMemberExternalLogins(logins =>
    {
        logins.AddMemberLogin(
            memberAuthenticationBuilder =>
            {
                memberAuthenticationBuilder.AddGoogle(
                    // The scheme must be set with this method to work for the Umbraco members
                    memberAuthenticationBuilder.SchemeForMembers(GoogleMemberExternalLoginProviderOptions.SchemeName),
                    options =>
                    {
                        options.ClientId = "YOURCLIENTID";
                        options.ClientSecret = "YOURCLIENTSECRET";
                    });
            });
    });
    return builder;
}
```

Finally this extension can also be called from the `Startup.cs` like the example below:

```Csharp
services.AddUmbraco(_env, _config)
   .AddBackOffice()
   .AddWebsite()
   .AddComposers()
   .AddMemberGoogleAuthentication()
   .Build();
```

{% hint style="info" %}
Auto-linking only makes sense if you have a public member registration anyway or the external provider does not have public account creation.
{% endhint %}

## Local logins

If you have configured auto-linking, then any auto-linked user or member will have an empty password assigned and they will not be able to log in locally (via username and password). In order to log in locally, they will have to assign a password to their account in the backoffice or the edit profile page.

For users only, if the `DenyLocalLogin` option is enabled, then all password changing functionality in the backoffice is also disabled and local login is not possible.

## Transfering Claims from External identities

In some cases you may want to flow a Claim returned in your external login provider to the Umbraco backoffice identity's Claims (the authentication cookie). This can be done during the `OnAutoLinking` and `OnExternalLogin`.

Reason for this could be to store the external login provider user ID into the backoffice identity cookie. That way it can be retrieved on each request in order to look up some data in another system that needs the current user id from the external login provider.

{% hint style="warning" %}
Do not flow large amounts of data into the backoffice identity because this information is stored into the backoffice authentication cookie and cookie limits will apply. Data like JWT tokens need to be [persisted](auto-linking.md#storing-external-login-provider-data) somewhere to be looked up and not stored within the backoffice identity itself.
{% endhint %}

### Example

_This is a very simplistic example for brevity, no null checks, etc..._

```Csharp
OnAutoLinking = (user, loginInfo) => {
    // You can customize the user before it's linked.
    // i.e. Modify the user's groups based on the Claims returned
    // in the externalLogin info
    var extClaim = externalLogin
        .Principal
        .FindFirst("MyClaim");
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
    var extClaim = externalLogin
        .Principal
        .FindFirst("MyClaim");
    user.Claims.Add(new IdentityUserClaim<string>
    {
        ClaimType = extClaim.Type,
        ClaimValue = extClaim.Value,
        UserId = user.Id
    });
    return true;
}
```

## Storing external login provider data

In some cases, you may need to persist data from your external login provider like Access Tokens, etc. You can persist this data to the affiliated user's external login data via the `IExternalLoginWithKeyService`. The `void Save(Guid userOrMemberKey,IEnumerable<IExternalLoginToken> tokens)` overload takes a new model of type `IEnumerable<IExternalLogin>`. `IExternalLogin` contains a property called `UserData`. This is a blob text column so can store any arbitrary data for the external login provider.

{% hint style="info" %}
Be aware that the local Umbraco user must already exist and be linked to the external login provider before data can be stored here. In cases where auto-linking occurs and the backoffice user isn't yet created, you will most likely need to store this data in memory. First, during auto-linking and then persist this data to the service once the user is linked and created.
{% endhint %}
