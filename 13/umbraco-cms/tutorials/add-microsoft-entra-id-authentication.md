---
description: >-
  Learn how to use Microsoft Entra ID (Azure Active Directory) credentials to login to Umbraco as a member.
---

# Add Microsoft Entra ID (Azure Active Directory) authentication (Members)

This tutorial takes you through configuring Microsoft Entra ID (Azure Active Directory/Azure AD) for the member login on your Umbraco CMS website.

{% hint style="warning" %}
Entra ID conflicts with Umbraco ID which is the main authentication method used on all Umbraco Cloud projects.

Due to this, we **highly recommend not using Azure AD for backoffice authentication on your Umbraco Cloud projects**.

It is still possible to use other [External Login Providers](../reference/security/external-login-providers.md) like Google Auth and OpenIdConnect, with Umbraco Cloud.
{% endhint %}

## Prerequisites

* A project with a setup for Members.
* Visual Studio, or another Integrated Development Environment (IDE).

## Step 1: Configure Entra ID

Before your applications can interact with Entra ID, they must be registered with a tenant that you manage. This can be either an Entra ID (Azure AD) tenant or an Entra ID B2C (Azure AD B2C) tenant. For more information on creating an Azure AD B2C tenant, see [Microsoft's Tutorial: Quickstart: Use your Azure subscription to create an external tenant](https://learn.microsoft.com/en-us/entra/external-id/customers/quickstart-tenant-setup).

Follow these steps to register your web application with your Entra tenant and configure it for member sign-in:

1. Follow the instructions in [Register an application in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app?tabs=client-secret) using the [Microsoft Entra admin center](https://entra.microsoft.com/).

2. On the **App Registrations** screen, copy the **Application (Client) ID** value. You will need this in your code later. 
3. Click **Add a certificate or secret**.

![Entra Example: App Registration Screen](<../../../13/umbraco-cms/tutorials/images/Entra-Example-App-Registration-ClientCredentials.png>)

4. Add a new client secret and copy the generated **Value**. You will use this in your code as well.


Back on the "Overview" screen, click on the "Add a Redirect URI" link.

6. Add full URLs for all of your applicable environments (local, dev, live, etc.) with the path `/umbraco-b2c-members-signin` appended. For example, `https://mysite.com/umbraco-b2c-members-signin`.

## Step 2: Install the NuGet package

You need to install the `Microsoft.AspNetCore.Authentication.MicrosoftAccount` NuGet package. There are two approaches to installing the packages:

1. Use your favorite Integrated Development Environment (IDE) and open up the **NuGet Package Manager** to search and install the packages.
2. Use the command line to install the package.

## Step 3: Implement the Entra ID Authentication

1. Create a new class for custom configuration options: `EntraIDB2CMembersExternalLoginProviderOptions.cs`.

{% code title="EntraIDB2CMembersExternalLoginProviderOptions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.Common.Security;

namespace MyApp;

public class EntraIDB2CMembersExternalLoginProviderOptions : IConfigureNamedOptions<MemberExternalLoginProviderOptions>
{
    public const string SchemeName = "ActiveDirectoryB2C";

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
            // [OPTIONAL] Callbacks
            OnAutoLinking = (autoLinkUser, loginInfo) =>
            {
                // You can customize the Member before it's linked.

				// Update the Member name based on the Microsoft Account name. (optional)
				autoLinkUser.Name = loginInfo.Principal.Identity?.Name;

				// You can modify the Member's groups based on the Claims returned in the external login info.
				
            },
            OnExternalLogin = (user, loginInfo) =>
            {
                // You can also update the Member before it is saved whenever they have
                // logged in with the external provider.
                // For example, re-sync the Member's name based on the Claims returned in the external login info

                // Return a boolean indicating if sign-in should continue or not.
                return true;
            }
        };
    }
}
```
{% endcode %}

{% hint style="info" %}

With **autolinking**, if a visitor uses **Sign in with Microsoft** and their email matches a member, that member is signed in. If no matching member exists, a new one is created. By default, it isn’t assigned to any groups.

{% endhint %}

2. Create a new static extension class called `MemberAuthenticationExtensions.cs`.

{% code title="MemberAuthenticationExtensions.cs" lineNumbers="true" %}
```csharp
namespace MyApp;

public static class MemberAuthenticationExtensions
{
    public static IUmbracoBuilder ConfigureAuthenticationMembers(this IUmbracoBuilder builder)
    {
        builder.Services.ConfigureOptions<EntraIDB2CMembersExternalLoginProviderOptions>();
        builder.AddMemberExternalLogins(logins =>
        {
            builder.Services.ConfigureOptions<EntraIDB2CMembersExternalLoginProviderOptions>();
            builder.AddMemberExternalLogins(logins =>
            {
                logins.AddMemberLogin(
                    membersAuthenticationBuilder =>
                    {
                        membersAuthenticationBuilder.AddMicrosoftAccount(

                            // The scheme must be set with this method to work for the external login.
                            membersAuthenticationBuilder.SchemeForMembers(EntraIDB2CMembersExternalLoginProviderOptions.SchemeName),
                            options =>
                            {
                                // Callbackpath: Represents the URL to which the browser should be redirected to.
                                // This needs to be unique.
                                // In order to have Umbraco members auto-linked, use "/umbraco-b2c-members-signin"                                
                                options.CallbackPath = "/umbraco-b2c-members-signin";

                                //Obtained from the ENTRA ID B2C WEB APP
                                options.ClientId = "YOURCLIENTID";
                                //Obtained from the ENTRA ID B2C WEB APP
                                options.ClientSecret = "YOURCLIENTSECRET";

                                // If you are using single-tenant app registration (e.g. for an intranet site), you must specify the Token Endpoint and Authorization Endpoint:
                                //options.TokenEndpoint = $"https://login.microsoftonline.com/{tenantId}/oauth2/v2.0/token";
                                //options.AuthorizationEndpoint = $"https://login.microsoftonline.com/{tenantId}/oauth2/v2.0/authorize";    

                                options.SaveTokens = true;
                            });
                    });
            });
        });
        return builder;
        });
    }
}
```
{% endcode %}

{% hint style="info" %}

Ensure to replace `YOURCLIENTID` and `YOURCLIENTSECRET` in the code with the values from the Entra ID tenant. If Entra ID is configured to use accounts in the organizational directory only (single tenant registration), you must specify the Token and Authorization endpoint. For more information on the differences between single and multi tenant registration, refer to [Microsoft's identity platform documentation](https://learn.microsoft.com/en-us/entra/identity-platform/howto-modify-supported-accounts).

{% endhint %}

{% hint style="info" %}

The Client Secret value will expire and must be regenerated in the Entra admin center. Use configurable secret storage to provide the value to your code, rather than hard-coding it. 

{% endhint %}

4. Add the Members authentication configuration in the `Program.cs` file:

{% code title="Program.cs" lineNumbers="true" %}

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    //Add Members ConfigureAuthentication
    .ConfigureAuthenticationMembers()
    .Build();
```

{% endcode %}

{% hint style="info" %}

Are you building a package for Umbraco?

Then you will not have access to the `Program.cs` file. Instead you need to create a composer in order to register your extension method.

Learn more about this in the [Dependency Injection](../reference/using-ioc.md) article.

{% endhint %}

5. Build the project.
6. Run the website.

![Entra ID Login Screen](<../../../10/umbraco-cms/reference/security/images/AD\_Login\_Members (1).png>)
