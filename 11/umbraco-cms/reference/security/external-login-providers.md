---
description: >-
  Umbraco supports supports external login providers (OAuth) for performing
  authentication of your users and members.
---

# External login providers

Both the Umbraco backoffice users and website members support external login providers (OAuth) for performing authentication. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google, or Facebook.

{% hint style="info" %}
Unlike previous major releases of Umbraco the use of the Identity Extensions package is no longer required.
{% endhint %}

Install an appropriate Nuget package for the provider you wish to use. Some popular ones found in Nuget include:

* [Google](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.Google)
* [Facebook](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.Facebook)
* [Microsoft](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.MicrosoftAccount/)
* [Twitter](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.Twitter/3.0.0)
* [Open ID Connect](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.OpenIdConnect)
* [Others](https://docs.microsoft.com/en-us/aspnet/core/security/authentication/social/other-logins?view=aspnetcore-5.0)

## Try it out

{% content-ref url="../../tutorials/add-azure-active-directory-authentication.md" %}
[configuration](../../tutorials/add-azure-active-directory-authentication.md)
{% endcontent-ref %}

{% content-ref url="../../tutorials/add-google-authentication.md" %}
[configuration](../../tutorials/add-google-authentication.md)
{% endcontent-ref %}

<details>

<summary>Umbraco OpenIdConnect Example [Community-made]</summary>

This community-created package with a complete Umbraco solution incl. an SQLite database demonstrates how OpenID Connect can be used: [Umbraco OpenIdConnect Example](https://github.com/jbreuer/Umbraco-OpenIdConnect-Example).

It is great for testing and for trying out the implementation before building it into your own project.

**This project is not managed or maintained by Umbraco HQ.**

</details>

## Extend core functionality

When you are implementing your own custom authentication on Users and/or Members on your Umbraco CMS website, you are effectively extending existing features.

The process requires adding a couple of new classes (`.cs` files) to your Umbraco project:

* **Custom-named configuration** to add additional configuration for handling different options related to the authentication.
* A **static extention class** to extend on the default authentication implementation in Umbraco CMS for either Users or Members.

## Generic examples

The following section presents a series of generic examples.

"*Provider*" is used to replace place of the names of actual external login providers. When you implement your own custom authentication, you will need to use the correct method names for the chosen provider.

### Custom-named configuration

The configuration file is used to configure a handful of different options for the authentication setup. A generic example of such file is shown below.

{% tabs %}
{% tab title="User Authentication" %}

{% code title="ProviderBackOfficeExternalLoginProviderOptions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.BackOffice.Security;

namespace MyUmbracoProject.CustomAuthentication
{
    public class ProviderBackOfficeExternalLoginProviderOptions : IConfigureNamedOptions<BackOfficeExternalLoginProviderOptions>
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
            // Customize the login button
            options.ButtonStyle = "btn-danger";
            options.Icon = "fa fa-cloud";

            // The following options are relevant if you
            // want to configure auto-linking on the authentication.
            options.AutoLinkOptions = new ExternalSignInAutoLinkOptions(

                // Set to true to enable auto-linking
                autoLinkExternalAccount: true,

                // [OPTIONAL]
                // Default: "Editor"
                // Specify User Group.
                defaultUserGroups: new[] { Constants.Security.EditorGroupAlias },

                // [OPTIONAL]
                // Default: The culture specified in appsettings.json.
                // Specify the default culture to create the User as.
                // It can be dynamically assigned in the OnAutoLinking callback.
                defaultCulture: null,

                // [OPTIONAL]
                // Disable the ability to link/unlink manually from within
                // the Umbraco backoffice.
                // Set this to false if you don't want the user to unlink 
                // from this external provider.
                allowManualLinking: false
            )
            {
                // [OPTIONAL] Callback
                OnAutoLinking = (autoLinkUser, loginInfo) =>
                {
                    // Customize the user before it's linked.
                    // Modify the User's groups based on the Claims returned
                    // in the external ogin info.
                },

                // [OPTIONAL] Callback
                OnExternalLogin = (user, loginInfo) =>
                {
                    // Customize the User before it is saved whenever they have
                    // logged in with the external provider.
                    // Sync the Users name based on the Claims returned
                    // in the external login info

                    // Returns a boolean indicating if sign-in should continue or not.
                    return true;
                }
            };

            // [OPTIONAL]
            // Disable the ability for users to login with a username/password.
            // If set to true, it will disable username/password login
            // even if there are other external login providers installed.
            options.DenyLocalLogin = false;

            // [OPTIONAL]
            // Choose to automatically redirect to the external login provider
            // effectively removing the login button.
            options.AutoRedirectLoginToExternalProvider = false;
        }
    }
}
```
{% endcode %}

{% endtab %}

{% tab title="Member Authentication" %}

{% code title="ProviderMembersExternalLoginProviderOptions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.Common.Security;

namespace MyUmbracoProject.CustomAuthentication
{
    public class ProviderMembersExternalLoginProviderOptions : IConfigureNamedOptions<MemberExternalLoginProviderOptions>
    {
        public const string SchemeName = "OpenIdConnect";
        public void Configure(string name, MemberExternalLoginProviderOptions options)
        {
            if (name != "Umbraco." + SchemeName)
            {
                return;
            }

            Configure(options);
        }

        public void Configure(MemberExternalLoginProviderOptions options)
        {
            // The following options are relevant if you
            // want to configure auto-linking on the authentication.
            options.AutoLinkOptions = new MemberExternalSignInAutoLinkOptions(

                // Set to true to enable auto-linking
                autoLinkExternalAccount: true,

                // [OPTIONAL]
                // Default: The culture specified in appsettings.json.
                // Specify the default culture to create the Member as.
                // It can be dynamically assigned in the OnAutoLinking callback.
                defaultCulture: null,
                
                // [OPTIONAL]
                // Specify the default "IsApproved" status.
                // Must be true for auto-linking.
                defaultIsApproved: true,

                // [OPTIONAL]
                // Default: "Member"
                // Specify the Member Type alias.
                defaultMemberTypeAlias: "Member"
            )
            {
                // [OPTIONAL] Callback
                OnAutoLinking = (autoLinkUser, loginInfo) =>
                {
                    // Customize the Member before it's linked.
                    // Modify the Members groups based on the Claims returned
                    // in the external ogin info.
                },
                OnExternalLogin = (user, loginInfo) =>
                {
                    // Customize the Member before it is saved whenever they have
                    // logged in with the external provider.
                    // Sync the Members name based on the Claims returned
                    // in the external login info

                    // Returns a boolean indicating if sign-in should continue or not.
                    return true;
                }
            };
        }
    }
}
```
{% endcode %}

{% endtab %}
{% endtabs %}

#### Advanced properties

Additionally, more advanced custom properties can be added to the `BackOfficeExternalLoginProviderOptions`.

<details>

<summary>`BackOfficeExternalLoginProviderOptions.CustomBackOfficeView`</summary>

The `CustomBackofficeView` allows for specifying a custom Angular HTML view that will render in place of the default external login button. Use this in case you want to change the UI or one of the following:

* You want to display something different where external login providers are listed: in the login screen vs the backoffice panel vs on the logged-out screen. This same view will render in all of these cases but you can use the current route parameters to customize what is shown.
* You want to change how the button interacts with the external login provider. For example, instead of having the site redirect on button-click, you want to open a popup window to load the external login provider.

The path to the custom view is a virtual path, like this example: `"~/App_Plugins/MyPlugin/BackOffice/my-external-login.html"`.

When a custom view is specified it is 100% up to this view and affiliated Angular controllers to perform all required logic.

</details>

### Static extension class

The extension class is required to extend on the default authentication implementation in Umbraco CMS. A generic example of such extension class can be seen below.

{% tabs %}
{% tab title="User Authentication" %}

{% code title="ProviderBackofficeAuthenticationExtensions.cs" lineNumbers="true" %}
```csharp
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;
using Umbraco.Cms.Web.BackOffice.Security;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;

namespace MyUmbracoProject.CustomAuthentication
{
    public static class ProviderBackofficeAuthenticationExtensions
    {

        public static IUmbracoBuilder AddProviderBackofficeAuthentication(this IUmbracoBuilder builder)
        {
            // [OPTIONAL]
            // Register ProviderBackOfficeExternalLoginProviderOptions here rather than require it in startup
            builder.Services.ConfigureOptions<ProviderBackOfficeExternalLoginProviderOptions>();

            builder.AddBackOfficeExternalLogins(logins =>
            {
                logins.AddBackOfficeLogin(
                    backOfficeAuthenticationBuilder =>
                    {
                        backOfficeAuthenticationBuilder.AddProvider(
                            // The scheme must be set with this method to work for the back office
                            backOfficeAuthenticationBuilder.SchemeForBackOffice(ProviderBackOfficeExternalLoginProviderOptions.SchemeName),
                            options =>
                            {
                                //  By default this is '/signin-provider' but it needs to be changed to this
                                options.CallbackPath = "/umbraco-provider-signin";

                                options.ClientId = "YOURCLIENTID";
                                options.ClientSecret = "YOURCLIENTSECRET";
                                
                                // Example: Map Claims
                                // Relevant when using auto-linking.
                                options.GetClaimsFromUserInfoEndpoint = true;
                                options.TokenValidationParameters.NameClaimType = "name";

                                // Example: Add scopes
                                options.Scope.Add("email");
                            });
                    });
            });
            return builder;
        }
    }
}
```
{% endcode %}

{% endtab %}

{% tab title="Member Authentication" %}

{% code title="ProviderMembersAuthenticationExtensions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace MyUmbracoProject.CustomAuthentication
{
    public static class ProviderMemberAuthenticationExtensions
    {
        public static IUmbracoBuilder AddProviderMemberAuthentication(this IUmbracoBuilder builder)
        {
            // [OPTIONAL]
            // Register ProviderMembersExternalLoginProviderOptions here rather than require it in startup
            builder.Services.ConfigureOptions<GoogleMemberExternalLoginProviderOptions>();

            builder.AddMemberExternalLogins(logins =>
            {
                logins.AddMemberLogin(
                    memberAuthenticationBuilder =>
                    {
                        memberAuthenticationBuilder.AddProvider(
                            // The scheme must be set with this method to work for the back office
                            memberAuthenticationBuilder.SchemeForMembers(ProviderMembersExternalLoginProviderOptions.SchemeName),
                            options =>
                            {
                                options.ClientId = "YOURCLIENTID";
                                options.ClientSecret = "YOURCLIENTSECRET";

                            });
                    });
            });
            return builder;
        }
    }
}
```
{% endcode %}

{% endtab %}
{% endtabs %}

Finally, update `ConfigureServices` method in your `Startup.cs` class to register your configuration with Umbraco. An example may look like this:

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddComposers()

        // Register your configuration methods here

        .Build();
}
```

For a more in-depth article on how to set up OAuth providers in .NET refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/aspnet/core/security/authentication/social/?view=aspnetcore-5.0\&tabs=visual-studio).

Depending on the provider you've configured the end result for User authentication will look similar to this:

![OAuth Login Screen](images/google-oauth-v8.png)

Since Umbraco does not control the UI for a Members setup, this can be set up to look exactly how you would like. Umbraco ships with a Partial Macro snippet for `Login` that will show any configured external login providers.

## Auto-linking accounts for custom OAuth providers

Traditionally, a backoffice User or frontend Member will need to exist in Umbraco first. Once they exist there, they can link their user account to an external login provider.

In many cases, however, the external login provider you install will be the source of truth for all of your users and members.

In this case, you will want to provide a Single Sign On (SSO) approach to logging in. This would enable the creating of user accounts on the external login provider and then automatically give them access to Umbraco. This is called **auto-Linking**.

This could also be the case for members if your website allows the public creation of members. In this case, the creation process can be simplified by allowing auto-linking to the external account. This could be when using something like Facebook, Twitter, or Google.

Read more about this in the [Linking External Login Provider accounts](auto-linking.md) article.
