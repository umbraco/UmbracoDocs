---
description: >-
  Umbraco supports external login providers (OAuth) for performing
  authentication of your users and members.
---

# External login providers

Both the Umbraco backoffice users and website members support external login providers (OAuth) for performing authentication. This could be any OpenIDConnect provider such as Entra ID/Azure Active Directory, Identity Server, Google, or Facebook.

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

{% hint style="info" %}
In some cases, when using Azure AD for login, you may encounter the following error: `OpenIdConnectProtocol requires the jwt token to have an 'iss' claim`.

Install a newer version of `Microsoft.IdentityModel.Protocols.OpenIdConnect` to solve this problem.
{% endhint %}

## Try it out

{% content-ref url="../../tutorials/add-microsoft-entra-id-authentication.md" %}
[add-microsoft-entra-id-authentication.md](../../tutorials/add-microsoft-entra-id-authentication.md)
{% endcontent-ref %}

{% content-ref url="../../tutorials/add-google-authentication.md" %}
[add-google-authentication.md](../../tutorials/add-google-authentication.md)
{% endcontent-ref %}

<details>

<summary>Umbraco OpenIdConnect Example [Community-made]</summary>

This community-created package with a complete Umbraco solution incl. an SQLite database demonstrates how OpenID Connect can be used: [Umbraco OpenIdConnect Example](https://github.com/jbreuer/Umbraco-OpenIdConnect-Example).

It is great for testing and for trying out the implementation before building it into your project.

**This project is not managed or maintained by Umbraco HQ.**

</details>

<details>

<summary>Umbraco Entra ID (Azure AD) Example [Community-made]</summary>

This community-created package will allow you to automatically create Umbraco user accounts for users in your directory. This will then associate the Umbraco users with groups based on their AD group: [Umbraco.Community.AzureSSO](https://github.com/Gibe/Umbraco.Community.AzureSSO).

**This project is not managed or maintained by Umbraco HQ.**

</details>

## Extend core functionality

When you are implementing your own custom authentication on Users and/or Members on your Umbraco CMS website, you are effectively extending existing features.

The process requires adding a couple of new classes (`.cs` files) to your Umbraco project:

* **Custom-named configuration** to add additional configuration for handling different options related to the authentication. [See a generic example of the configuration class to learn more.](external-login-providers.md#custom-named-configuration)
* A **composer and named** to extend on the default authentication implementation in Umbraco CMS for either Users or Members. [See a generic example to learn more.](external-login-providers.md#generic-backoffice-login-provider-composer)

You can setup similar behavior using a [static extension class](external-login-providers.md#static-extension-class) and add them straight into the `Program.cs` file. But you will lose access to dependency injection this way, thus our helper class.

{% hint style="info" %}
It is also possible to register the configuration class directly into the extension class. See examples of how this is done in the [generic examples for the static extension class](external-login-providers.md#static-extension-class).
{% endhint %}

## Auto-linking

Traditionally, a backoffice User or frontend Member will need to exist in Umbraco first. Once they exist there, they can link their user account to an external login provider.

In many cases, however, the external login provider you install will be the source of truth for all of your users and members.

In this case, you will want to provide a Single Sign On (SSO) approach to logging in. This would enable the creation of user accounts on the external login provider and then automatically give them access to Umbraco. This is called **auto-linking**.

### Local logins

When auto-linking is configured, then any auto-linked user or member will have an empty password assigned. This means that they will not be able to log in locally (via username and password). In order to log in locally, they will have to assign a password to their account in the backoffice or the edit profile page.

For users specifically, if the `DenyLocalLogin` option is enabled, all password-changing functionality in the backoffice is disabled, and local login is not possible.

### Transferring Claims from External identities

In some cases, you may want to flow a Claim returned in your external login provider to the Umbraco backoffice identity's Claims. This could be the authentication cookie. Flowing Claims between the two can be done during the `OnAutoLinking` and `OnExternalLogin`.

The reason for wanted to flow a Claim could be to store the external login provider user ID into the backoffice identity cookie. It can then be retrieved on each request to look up data in another system needing the current user ID from the external login provider.

{% hint style="warning" %}
Do not flow large amounts of data into the backoffice identity. This information is stored in the backoffice authentication cookie and cookie limits will apply. Data like Json Web Tokens (JWT) needs to be [persisted](external-login-providers.md#storing-external-login-provider-data) somewhere to be looked up and not stored within the backoffice identity itself.
{% endhint %}

#### Example

This is a simplistic example of brevity including no null checks, etc.

```csharp
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

### Storing external login provider data

In some cases, you may need to persist data from your external login provider like Access Tokens, etc.

You can persist this data to the affiliated user's external login data via the `IExternalLoginWithKeyService`. The `void Save(Guid userOrMemberKey,IEnumerable<IExternalLoginToken> tokens)` overload takes a new model of type `IEnumerable<IExternalLogin>`.

`IExternalLogin` contains a property called `UserData`. This is a blob text column which can store any arbitrary data for the external login provider.

{% hint style="info" %}
Be aware that the local Umbraco user must already exist and be linked to the external login provider before data can be stored here. In cases where auto-linking occurs and the user isn't yet created, you need to store the data in memory first during auto-linking. Then you can persist the data to the service once the user is linked and created.
{% endhint %}

### Auto-linking on backoffice authentication

For some providers, it does not make sense to use auto-linking. This is especially true for public providers such as Google or Facebook.

In those cases, it would mean that anyone who has a Google or Facebook account can log into your site.

If auto-linking for public providers such as these was needed you would need to limit the access. This can be done by domain or other information provided in the claims using the options/callbacks specified in those provider's authentication options.

#### Is your project hosted on Umbraco Cloud?

Umbraco Cloud uses Umbraco ID for all authentication, including access to the Umbraco Backoffice.

If you are working with External Login Providers on a project hosted on Umbraco Cloud, extra configuration is required.

To disable the automatic redirect to Umbraco ID, follow these steps:

1. Open the `umbraco-cloud.json` file in your favorite code editor.
2. Locate the `Identity` section.
3. Add a new key: `AutoRedirectLogin`.
4. Set the value to `false`.

{% code title="umbraco-cloud.json" %}

```json
"Identity": {
    "ClientId": "0297c0f6-83ad-4481-9ae2-07a3f5475333",
    "ClientSecret": "Q5~T526ixOHlj47lg7Mu7_.zN1fK.7ua.9",
    "EnvironmentId": "3105e6eb-4a1e-42dd-91e9-ffdbe3dd30a8",
    "LocalLoginRedirectUri": "https://redirect.identity.umbraco.com",
    "AutoRedirectLogin": false
  }
```

{% endcode %}

### Auto-linking on Member authentication

Auto-linking on Member authentication only makes sense if you have a public member registration already or the provider does not have public account creation.

## Generic examples

The following section presents a series of generic examples.

{% hint style="warning" %}
"_Provider_" is a placeholder used to replace the names of actual external login providers. When you implement your own custom authentication, you will need to use the correct method names for the chosen provider. Otherwise, the examples will not work as intended.
{% endhint %}

### Custom-named configuration

The configuration file is used to configure a handful of different options for the authentication setup. A generic example of such file is shown below.

{% tabs %}
{% tab title="User Authentication" %}
{% code title="GenericBackOfficeExternalLoginProviderOptions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Api.Management.Security;
using Umbraco.Cms.Core;

namespace MyUmbracoProject.CustomAuthentication;

public class GenericBackOfficeExternalLoginProviderOptions : IConfigureNamedOptions<BackOfficeExternalLoginProviderOptions>
{
    public const string SchemeName = "Generic";
    public void Configure(string name, BackOfficeExternalLoginProviderOptions options)
    {
        if (name != Constants.Security.BackOfficeExternalAuthenticationTypePrefix + SchemeName)
        {
            return;
        }

        Configure(options);
    }

    public void Configure(BackOfficeExternalLoginProviderOptions options)
    {
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
                // in the external login info.
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

namespace MyUmbracoProject.CustomAuthentication;

public class ProviderMembersExternalLoginProviderOptions : IConfigureNamedOptions<MemberExternalLoginProviderOptions>
{
    public const string SchemeName = "OpenIdConnect";
    public void Configure(string? name, MemberExternalLoginProviderOptions options)
    {
        if (name != Constants.Security.MemberExternalAuthenticationTypePrefix + SchemeName)
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
            defaultMemberTypeAlias: Constants.Security.DefaultMemberTypeAlias
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
```
{% endcode %}
{% endtab %}
{% endtabs %}

Next, you need to register the button in the BackOffice. This is done by adding a manifest file to the `App_Plugins/ExternalLoginProviders` folder.

{% code title="umbraco-package.json" lineNumbers="true" %}
```json
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "My Auth Package",
  "allowPublicAccess": true,
  "extensions": [
    {
      "type": "authProvider",
      "alias": "My.AuthProvider.Generic",
      "name": "My Auth Provider",
      "forProviderName": "Umbraco.Generic",
      "meta": {
        "label": "Generic",
        "defaultView": {
          "icon": "icon-cloud"
        },
        "behavior": {
          "autoRedirect": false
        },
        "linking": {
          "allowManualLinking": true
        }
      }
    }
  ]
}
```
{% endcode %}

You have a few options to configure the button:

* `element` - Define your own custom element for the button. This is useful if you want to display something other than a button, For example: a link or an image. For more information, see the [Customizing the BackOffice Login Button](external-login-providers.md#customizing-the-backoffice-login-button) section.
* `forProviderName` - The name of the provider you are configuring. This should match the `SchemeName` in the `GenericBackOfficeExternalLoginProviderOptions` class with "Umbraco." prepended.
* `meta.label` - The label to display on the button. The user will see this text. For example: "Sign in with Generic".
* `meta.defaultView.icon` - The icon to display on the button. You can use any of the icons from the Umbraco Icon Picker. If you want to use a custom icon, you need to first register it to the [`icons` extension point](../../customizing/extending-overview/extension-types/icons.md).
* `meta.defaultView.color` - (Default: "default") The color style of the button. You can use any color style from the [Umbraco UI Library](https://uui.umbraco.com/?path=/story/uui-button--looks-and-colors).
  * Default (blue)
  * Positive (green)
  * Warning (yellow)
  * Danger (red)
* `meta.defaultView.look` - (Default: "secondary") The look of the button. You can use any of the looks from the [Umbraco UI Library](https://uui.umbraco.com/?path=/story/uui-button--looks-and-colors). eg. Primary (solid background colour, white text), Secondary (grey background, coloured text), Outline (white background with sold grey border, coloured text), Placeholder (white with dotted grey border, coloured text)  
* `meta.behavior.autoRedirect` - Automatically redirects the user to the external login provider, skipping the Umbraco login page, unless the user has specifically logged out or timed out.
* `meta.behavior.popupTarget` - (Default: "umbracoAuthPopup") The target for the popup window. This is the name of the window that will be opened when the user clicks the button. If you want to open the login page in a new tab, you can set this to "\_blank".
* `meta.behavior.popupFeatures` - (Default: "width=600,height=600,menubar=no,location=no,resizable=yes,scrollbars=yes,status=no,toolbar=no") The features of the popup window. This is a string of comma-separated key-value pairs. For example: "width=600,height=600". You can read more on the [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/API/Window/open#features).
* `meta.linking.allowManualLinking` - Allows the user to link or unlink their account from the BackOffice. You need to allow manual linking on the `ExternalSignInAutoLinkOptions` as well.

The button will now be displayed on the login page in the Umbraco Backoffice.

<figure><img src="images/login-external.jpg" alt=""><figcaption><p>The login page with a Generic button shown</p></figcaption></figure>

### Generic backoffice login provider composer

A composer and `genericAuthenticationOptions` configuration class to setup the authentication options for the generic authentication provider using dependency injection. Replace `genericAuthenticationOptions` with the Options method from the provider you are using.

{% code title="GenericBackOfficeExternalLoginComposer.cs" lineNumbers="true" %}
```csharp
// this example uses a non existing generic OathProvider NuGet package
// but any package that uses the Microsoft.AspNetCore.Authentication.OAuth.OathOptions will work
using AspNet.Security.OAuth.Generic;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Api.Management.Security;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Web.Common.Helpers;

namespace MyUmbracoProject.CustomAuthentication;

public class GenericBackOfficeExternalLoginComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // register the generic loginProvider options (auto linking, manual linking, ...)
        builder.Services.ConfigureOptions<GenericBackOfficeExternalLoginProviderOptions>();
        // register the generic authtication options (secret, callback, errorhandling, ...)
        builder.Services.ConfigureOptions<ConfigureGenericAuthenticationOptions>();

        builder.AddBackOfficeExternalLogins(logins =>
        {
            logins.AddBackOfficeLogin(
                backOfficeAuthenticationBuilder =>
                {
                    // this Add... method will be part of the OathProvider nuget package you install
                    backOfficeAuthenticationBuilder.AddGenericProvider(
                    // replace AddGenericProvider with the Add method of the provider you are using
                        BackOfficeAuthenticationBuilder.SchemeForBackOffice(GenericBackOfficeExternalLoginProviderOptions
                            .SchemeName)!,
                        options =>
                        {
                            // need to give an empty action here for the options pattern configuration to work 🤷
                            // if you do not wish to use the umbraco default error handling and hardcode all your values instead of injecting them,
                            // you can set the configuration right here instead.
                        });
                });
        });
    }
}

// the ...AuthenticationOptions method will be part of the OathProvider nuget package you install
// check the Add... method invoked on the backOfficeAuthenticationBuilder to figure out the correct type
public class ConfigureGenericAuthenticationOptions : IConfigureNamedOptions<GenericAuthenticationOptions>
{
    private readonly OAuthOptionsHelper _helper;

    public ConfigureGenericAuthenticationOptions(OAuthOptionsHelper helper)
    {
        _helper = helper;
    }

    public void Configure(GenericAuthenticationOptions options)
    {
        // since we have access to dependency injection, these values can be read from the app settings using the IOptions pattern
        options.CallbackPath = "/umbraco-signing-generic"; // can be anything as middleware will add this to the route table
        options.ClientId = "your client id for the login provider";
        options.ClientSecret = "your client secret for the login provider";
        options.Scope.Add("user:email"); // email is needed for auto linking purposes

        // This will redirect error responses from the login provider towards the default umbraco oath login error page
        // which will try to display the error state in a meaningful way.
        // You can implement your own error handling by handling options.Events.OnAccessDenied & options.Events.OnRemoteFailure
        _helper.SetDefaultErrorEventHandling(options, GenericBackOfficeExternalLoginProviderOptions.SchemeName);
    }

    public void Configure(string? name, GenericAuthenticationOptions options)
    {
        // only configure the options if it is for the backend
        if (name == BackOfficeAuthenticationBuilder.SchemeForBackOffice(GenericBackOfficeExternalLoginProviderOptions
                .SchemeName))
        {
            Configure(options);
        }
    }
}

```
{% endcode %}

### Static extension class

The extension class is required to extend on the default authentication implementation in Umbraco CMS. A generic example of such extension class can be seen below.

{% tabs %}
{% tab title="User Authentication" %}
{% code title="GenericBackofficeAuthenticationExtensions.cs" lineNumbers="true" %}
```csharp
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;
using Umbraco.Cms.Web.BackOffice.Security;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;

namespace MyUmbracoProject.CustomAuthentication;

public static class GenericBackofficeAuthenticationExtensions
{
    public static IUmbracoBuilder AddGenericBackofficeAuthentication(this IUmbracoBuilder builder)
    {
        // Register ProviderBackOfficeExternalLoginProviderOptions here rather than require it in startup
        builder.Services.ConfigureOptions<GenericBackOfficeExternalLoginProviderOptions>();

        builder.AddBackOfficeExternalLogins(logins =>
        {
            logins.AddBackOfficeLogin(
                backOfficeAuthenticationBuilder =>
                {
                    // The scheme must be set with this method to work for the back office
                    // Replace GenericOfficeExternalLoginProviderOptions with the Options method from the provider you are using
                    var schemeName =
                        backOfficeAuthenticationBuilder.SchemeForBackOffice(GenericOfficeExternalLoginProviderOptions
                            .SchemeName);

                    ArgumentNullException.ThrowIfNull(schemeName);

                    // Replace AddGenericProvider with the Add method from the provider you are using

                    backOfficeAuthenticationBuilder.AddGenericProvider(
                        schemeName,
                        options =>
                        {
                            // Callback path: Represents the URL to which the browser should be redirected to.
                            // The default value is '/signin-provider'.
                            // The value here should match what you have configured in you external login provider.
                            // The value needs to be unique.
                            options.CallbackPath = "/umbraco-provider-signin";
                            options.ClientId = "YOURCLIENTID"; // Replace with your client id generated while creating OAuth client ID
                            options.ClientSecret = "YOURCLIENTSECRET"; // Replace with your client secret generated while creating OAuth client ID

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
```
{% endcode %}
{% endtab %}

{% tab title="Member Authentication" %}
{% code title="ProviderMembersAuthenticationExtensions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace MyUmbracoProject.CustomAuthentication;

public static class ProviderMemberAuthenticationExtensions
{
    public static IUmbracoBuilder AddProviderMemberAuthentication(this IUmbracoBuilder builder)
    {
        // [OPTIONAL]
        // Register ProviderMembersExternalLoginProviderOptions here rather than require it in startup
        builder.Services.ConfigureOptions<ProviderMembersExternalLoginProviderOptions>();

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
                            // Callback path: Represents the URL to which the browser should be redirected to.
                            // The default value is `/signin-oidc`.
                            // The value here should match what you have configured in your external login provider.
                            // The value needs to be unique.
                            options.CallbackPath = "/umbraco-provider-signin";

                            options.ClientId = "YOURCLIENTID";
                            options.ClientSecret = "YOURCLIENTSECRET";

                                // Example: Save login tokens
                            options.SaveTokens = true;

                        });
                });
        });
        return builder;
    }
}
```
{% endcode %}
{% endtab %}
{% endtabs %}

For a more in-depth article on how to set up OAuth providers in .NET refer to the [Microsoft Documentation](https://learn.microsoft.com/en-us/aspnet/core/security/authentication/social/?view=aspnetcore-8.0\&tabs=visual-studio).

### Customizing the BackOffice Login Button

If you want to customize the login button, you can do so by adding a custom element to the manifest file. This is useful if you want to display something other than a button. For example, a link or an image.

The path to the custom view is a virtual path, like this example: `"~/App_Plugins/MyPlugin/BackOffice/my-external-login.js"`.

When a custom view is specified, it is 100% up to this module to perform all the required logic.

The module should define a Custom Element and export it as default. Optionally, the Custom Element can declare a number of properties to be passed to it. These properties are:

* `manifest`: The manifest object for the provider that you registered in the `umbraco-package.json` file.
* `onSubmit`: A function that is called when the form is submitted. This function will handle the form submission and redirect the user to the external login provider.
* `userLoginState`: The current view state of the user. This can be one of the following values:
  * `loggingIn`: The user is on the login screen.
  * `loggedOut`: The user clicked the logout button and is on the logged-out screen.
  * `timedOut`: The user's session has timed out and they are on the timed-out screen.

**TypeScript**

If you use TypeScript, you can use this interface to define the properties:

{% code title="login-types.ts" %}
```typescript
type UserViewState = 'loggingIn' | 'loggedOut' | 'timedOut';

interface IExternalLoginCustomViewElement {
  displayName?: string;
  providerName?: string;
  externalLoginUrl?: string;
  userViewState?: UserViewState;
};
```
{% endcode %}

#### Examples

The Custom Element can be implemented in a number of ways with many different libraries or frameworks. The following examples show how to make a button appear and redirect to the external login provider. You will learn how to use the `externalLoginUrl` property to redirect to the external login provider. The login form should look like this when you open Umbraco:

![Login form with custom external login button](images/external-login-provider-javascript.jpg)

When you click the button, the form will submit a POST request to the `externalLoginUrl` property. The external login provider will then redirect back to the Umbraco site with the user logged in.

{% hint style="info" %}
You have access to the [Umbraco UI Library](../../customizing/ui-documentation.md) in the custom element. You can use the UUI components directly in your template.
{% endhint %}

{% code title="App_Plugins/ExternalLoginProviders/umbraco-package.json" lineNumbers="true" %}
```json
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "My Auth Package",
  "allowPublicAccess": true,
  "extensions": [
    {
      "type": "authProvider",
      "alias": "My.AuthProvider.Generic",
      "name": "My Auth Provider",
      "forProviderName": "Umbraco.Generic",
      "element": "/App_Plugins/ExternalLoginProviders/my-external-login.js", // This line has been added
      "meta": {
        "label": "Generic",
        "defaultView": {
          "icon": "icon-cloud"
        },
        "behavior": {
          "autoRedirect": false
        },
        "linking": {
          "allowManualLinking": true
        }
      }
    }
  ]
}
```
{% endcode %}

{% tabs %}
{% tab title="Vanilla (JavaScript)" %}
We have to define a template first and then the custom element itself. The template is a small HTML form with a button. The custom element will then render the template and attach an event listener for clicks on the button in the `constructor` method.

{% code title="~/App_Plugins/ExternalLoginProviders/my-external-login.js" lineNumbers="true" %}
```javascript
const template = document.createElement('template');
template.innerHTML = `
  <style>
    :host {
      display: block;
      width: 100%;
    }
    #button {
      width: 100%;
    }
  </style>
  <h3>Our Company</h3>
  <p>If you have signed up with Our Company, you can sign in to Umbraco by clicking the button below.</p>
  <uui-button type="button" id="button" look="primary">
    <uui-icon name="icon-cloud"></uui-icon>
    Sign in with Our Company
  </uui-button>
`;

/**
 * This is an example how to set up a custom element as a Web Component.
 */
export default class MyCustomView extends HTMLElement {
  manifest = {};
  onSubmit = () => {};
  userLoginState = '';

  constructor() {
    super();
    this.attachShadow({ mode: 'open' });
    this.shadowRoot.appendChild(template.content.cloneNode(true));

    this.shadowRoot.getElementById('button').addEventListener('click', () => {
      this.onSubmit(this.manifest.forProviderName);
    });
  }
}

customElements.define('my-custom-view', MyCustomView);
```
{% endcode %}
{% endtab %}

{% tab title="Lit (JavaScript)" %}
It is also possible to use a library like [Lit](https://lit.dev/) to render the custom element. The following example shows how to use Lit to render the custom element. The custom element will render a form with a button. The button will submit the form to the `externalLoginUrl` property. We do not have to perform any logic in the `constructor` method because Lit will automatically update any event listeners. Styling is also handled by Lit in the `static styles` property.

We are using Lit version 3 in this example imported directly from a JavaScript delivery network to keep the example slim. You can also use a bundler like [Vite](https://vitejs.dev) to bundle the Lit library with your custom element.

{% hint style="info" %}
To learn more about how to set up a project with Vite, see the [Creating your first extension](../../tutorials/creating-your-first-extension.md) tutorial.
{% endhint %}

{% code title="~/App_Plugins/ExternalLoginProviders/my-external-login.js" lineNumbers="true" %}
```javascript
import { LitElement, css, html } from 'https://cdn.jsdelivr.net/gh/lit/dist@3/core/lit-core.min.js';

/**
 * This is an example how to set up a LitElement component.
 */
export default class MyLitView extends LitElement {
  static get properties() {
    return {
      manifest: { type: Object },
      onSubmit: { type: Function },
      userLoginState: { type: String, state: true }
    };
  }

  get displayName() {
    return this.manifest.meta?.label ?? this.manifest.forProviderName;
  }

  render() {
    return html`
        <h3>Our Company</h3>
        <p>If you have an account with Our Company, you can sign in to Umbraco by clicking the button below.</p>
        <p>The user is currently: ${this.userLoginState}</p>
        <uui-button type="button" id="button" look="primary" label="${this.displayName}" @click=${() => this.onSubmit(this.manifest.forProviderName)}>
          <uui-icon name="icon-cloud"></uui-icon>
          ${this.displayName}
        </uui-button>
    `;
  }

  static styles = css`
    :host {
      display: block;
      width: 100%;
    }
    #button {
      width: 100%;
    }
  `;
}

customElements.define('my-lit-view', MyLitView);
```
{% endcode %}
{% endtab %}
{% endtabs %}
