---
description: >-
  Learn how to use Azure Active Directory credentials to login to the Umbraco
  backoffice
---

# Authenticating the Umbraco backoffice with Azure Active Directory credentials

This article describes how to configure Azure Active Directory (Azure AD) with Umbraco Users and Members.

{% hint style="warning" %}
Azure AD conflicts with Umbraco ID which is the main authentication method used on all Umbraco Cloud projects.

Due to this, we **highly recommend not using Azure AD for backoffice authentication on your Umbraco Cloud projects**.

It is still possible to use other [External Login Providers](external-login-providers.md) like Google Auth and OpenIdConnect, with Umbraco Cloud.
{% endhint %}

## Configuring Azure AD

Before your applications can interact with Azure AD B2C, they must be registered with a tenant that you manage. For more information, see [Microsoft's Tutorial: Create an Azure Active Directory B2C tenant](https://learn.microsoft.com/en-us/azure/active-directory-b2c/tutorial-create-tenant).

## Installing the NuGet Package

You need to install the `Microsoft.AspNetCore.Authentication.MicrosoftAccount` NuGet package. There are two approaches to installing the packages:

1. Use your favorite Integrated Development Environment (IDE) and open up the **NuGet Package Manager** to search and install the packages.
2. Use the command line to install the package.

## Azure AD Authentication for Users

* Create a class called `BackofficeAuthenticationExtensions.cs` to configure the external login.

{% code title="BackofficeAuthenticationExtensions.cs" lineNumbers="true" %}
```csharp
using Microsoft.AspNetCore.Authentication.MicrosoftAccount;
using Microsoft.Extensions.DependencyInjection;

namespace MyApp
{
    public static class BackofficeAuthenticationExtensions
    {
        public static IUmbracoBuilder ConfigureAuthentication(this IUmbracoBuilder builder)
        {
            builder.AddBackOfficeExternalLogins(logins =>
            {
                const string schema = MicrosoftAccountDefaults.AuthenticationScheme;
                
                logins.AddBackOfficeLogin(
                    backOfficeAuthenticationBuilder =>
                    {
                        backOfficeAuthenticationBuilder.AddMicrosoftAccount(
                            // the scheme must be set with this method to work for the back office
                            backOfficeAuthenticationBuilder.SchemeForBackOffice(schema) ?? string.Empty,
                            options =>
                            {
                                //By default this is '/signin-microsoft' but it needs to be changed to this
                                options.CallbackPath = "/umbraco-signin-microsoft/";
                                //Obtained from the AZURE AD B2C WEB APP
                                options.ClientId = "{your_client_id}";
                                //Obtained from the AZURE AD B2C WEB APP
                                options.ClientSecret = "{your_client_secret}";
                                //options.TokenEndpoint = $"https://login.microsoftonline.com/{tenantId}/oauth2/v2.0/token";
                                //options.AuthorizationEndpoint = $"https://login.microsoftonline.com/{tenantId}/oauth2/v2.0/authorize";                                    
                            });
                    });
            });
            return builder;
        }
    }
}
```
{% endcode %}

{% hint style="info" %}
Ensure to replace `{your_client_id}` and `{your_client_secret}` in the code with the values from the Azure AD tenant. If Azure AD is configured to use accounts in the organizational directory only (single tenant), you also have to specify the Token and AuthorizationEndpoint.
{% endhint %}

* Update `ConfigureServices` method in the `Startup.cs` file:

{% code title="Startup.cs" lineNumbers="true" %}
```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddComposers()
        // Add ConfigureAuthentication
        .ConfigureAuthentication()
        .Build();
}
```
{% endcode %}

* Build and run the website. You can now log in with your Azure AD credentials.

![AD Login Screen](../../../../10/umbraco-cms/reference/security/images/AD\_Login.png)

{% hint style="info" %}
In some cases where Azure B2C does not provide an email for the user, it can be necessary to add additional code.

Add the following snippet within the `AddMicrosoftAccount` options between lines 29 and 30 in the code sample in step one:

```csharp
 // Example of how to get a different field from the user profile
options.UserInformationEndpoint = "https://graph.microsoft.com/v1.0/me?$select=otherMails,displayName,givenName,surname,id";
options.ClaimActions.MapCustomJson(ClaimTypes.Email, x =>
{
    return x.GetProperty("otherMails").EnumerateArray().First().ToString();
});
```

This extra code will read the user email from the Microsoft Graph API.
{% endhint %}

## Azure AD Authentication for Members

* Create a Member login functionality, see the [Member registration and login](../../tutorials/members-registration-and-login.md#member-registration-and-login) article.
* Create a class called `MemberAuthenticationExtensions.cs` to configure the external login.

{% code title="MemberAuthenticationExtensions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.DependencyInjection;

namespace MyApp
{
    public static class MemberAuthenticationExtensions
    {
        public static IUmbracoBuilder ConfigureAuthenticationMembers(this IUmbracoBuilder builder)
        {
            builder.Services.ConfigureOptions<AzureB2CMembersExternalLoginProviderOptions>();
            builder.AddMemberExternalLogins(logins =>
            {
                logins.AddMemberLogin(
                    membersAuthenticationBuilder =>
                    {
                        membersAuthenticationBuilder.AddMicrosoftAccount(
                            // The scheme must be set with this method to work for members
                            membersAuthenticationBuilder.SchemeForMembers(AzureB2CMembersExternalLoginProviderOptions.SchemeName),
                            options =>
                            {
                                //Callbackpath - Important! The CallbackPath represents the URL to which the browser should be redirected to and the default value is
                                // /signin-oidc This should be unique!.
                                options.CallbackPath = "/umbraco-b2c-members-signin";
                                //Obtained from the AZURE AD B2C WEB APP
                                options.ClientId = "YOURCLIENTID";
                                //Obtained from the AZURE AD B2C WEB APP
                                options.ClientSecret = "YOURCLIENTSECRET"; 
                                options.SaveTokens = true;
                            });
                    });
            });
            return builder;
        }
    }
}
```
{% endcode %}

{% hint style="info" %}
Ensure to replace `YOURCLIENTID` and `YOURCLIENTSECRET` in the code with the values from the Azure AD tenant.
{% endhint %}

* To enable a member to link their account to an external login provider such as Azure AD in the Umbraco Backoffice, you have to implement a custom-named configuration `MemberExternalLoginProviderOptions` for Members. Add the following code in the `AzureB2CMembersExternalLoginProviderOptions.cs` file:

{% code title="AzureB2CMembersExternalLoginProviderOptions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.Common.Security;

namespace MyApp
{
    public class AzureB2CMembersExternalLoginProviderOptions : IConfigureNamedOptions<MemberExternalLoginProviderOptions>
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

            options.AutoLinkOptions = new MemberExternalSignInAutoLinkOptions(
                // must be true for auto-linking to be enabled
                autoLinkExternalAccount: true,

                // Optionally specify the default culture to create
                // the user as. If null it will use the default
                // culture defined in the appSettings.json, or it can
                // be dynamically assigned in the OnAutoLinking
                // callback.

                defaultCulture: null,
                
                // Optionally specify the default "IsApprove" status. Must be true for auto-linking.
                defaultIsApproved: true,

                // Optionally specify the member type alias. Default is "Member"
                defaultMemberTypeAlias: "Member"

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

                    return true; //returns a boolean indicating if sign-in should continue or not.
                }
            };
        }
    }
}
```
{% endcode %}

* Next, update `ConfigureServices` method in the `Startup.cs` file:

{% code title="Startup.cs" lineNumbers="true" %}
```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddComposers()
        // Add ConfigureAuthentication
        .ConfigureAuthentication()
        //Add Members ConfigureAuthentication
        .ConfigureAuthenticationMembers()
        .Build();
}
```
{% endcode %}

* Build and run the website. Your members can now log in with their Azure AD credentials.

![AD Login Screen](../../../../10/umbraco-cms/reference/security/images/AD\_Login\_Members.png)
