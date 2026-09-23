---
description: >-
  Learn how to use Microsoft Entra ID (Azure Active Directory) credentials to
  login to Umbraco as a member.
---

# Add Microsoft Entra ID Authentication (Members)

This tutorial takes you through configuring Microsoft Entra ID (formerly Azure Active Directory) for member login on your Umbraco CMS website.

The tutorial uses the ASP.NET Core Microsoft Account authentication handler. This handler signs in against the Microsoft identity platform. It isn't configured for Azure AD B2C tenants, which use their own sign-in endpoints and user flows.

## Prerequisites

* An Umbraco project with a [setup for Member Login](../../develop-with-umbraco/tutorials/members-registration-and-login.md).
* Visual Studio, or another Integrated Development Environment (IDE).
* Access to an Entra ID (Azure AD) tenant with permission to register an application

## Step 1: Register the app in Entra ID

Register your site as an application in your Entra ID tenant. Follow [Microsoft's quickstart for registering an application](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app), then [add a client secret](https://learn.microsoft.com/en-us/entra/identity-platform/how-to-add-credentials).

When you register the app, use these settings:

* **Redirect URI**: select the **Web** platform and enter `https://{your-site}/umbraco-entraid-members-signin`. Use your local HTTPS address while developing. The path must match `CallbackPath` in Step 3 exactly.
* **Supported account types**: choose based on who should sign in. Step 3 needs an extra setting if you choose a single-tenant option.

Before moving on, make sure you have:

* The **Application (client) ID**.
* The client secret **Value**. Microsoft only shows it once.
* The **Directory (tenant) ID**, if you registered a single-tenant app.

## Step 2: Install the NuGet package

You need to install the `Microsoft.AspNetCore.Authentication.MicrosoftAccount` NuGet package. There are two approaches to installing the packages:

1. Use your favorite IDE and open up the **NuGet Package Manager** to search and install the package.
2. Use the command line to install the package:

```bash
dotnet add package Microsoft.AspNetCore.Authentication.MicrosoftAccount
```

## Step 3: Add sign-in

This step wires up the sign-in functionality only.

1. Create `MemberAuthenticationExtensions.cs`.

{% code title="MemberAuthenticationExtensions.cs" lineNumbers="true" %}

```csharp
namespace MyApp;

public static class MemberAuthenticationExtensions
{
    public static IUmbracoBuilder ConfigureAuthenticationMembers(this IUmbracoBuilder builder)
    {
        builder.AddMemberExternalLogins(logins =>
        {
            logins.AddMemberLogin(
                membersAuthenticationBuilder =>
                {
                    membersAuthenticationBuilder.AddMicrosoftAccount(
                        membersAuthenticationBuilder.SchemeForMembers("EntraId"),
                        options =>
                        {
                            options.CallbackPath = "/umbraco-entraid-members-signin";
                            options.ClientId = "YOURCLIENTID";
                            options.ClientSecret = "YOURCLIENTSECRET";
                            options.SaveTokens = true;
                        });
                });
        });
        return builder;
    }
}
```

{% endcode %}

{% hint style="warning" %}
Replace `YOURCLIENTID` and `YOURCLIENTSECRET` with the values from the Step 1.
Don't commit the client secret to source control. Read it from configuration instead, for example user secrets during development.
{% endhint %}

2. If you registered a single-tenant app in Step 1, add the tenant-specific endpoints inside `options`:

```csharp
options.AuthorizationEndpoint = "https://login.microsoftonline.com/YOURTENANTID/oauth2/v2.0/authorize";
options.TokenEndpoint = "https://login.microsoftonline.com/YOURTENANTID/oauth2/v2.0/token";
```

Replace `YOURTENANTID` with the Directory (tenant) ID. Without these, the handler uses the `/common` endpoints, which single-tenant apps reject. For more information, see [Microsoft's identity platform documentation](https://learn.microsoft.com/en-us/entra/identity-platform/howto-modify-supported-accounts).

3. Register the extension in `Program.cs`:

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

4. Build the project.
5. Run the site.

![Entra ID Login Screen](../../.gitbook/assets/AD_Login_Members.png)

If your member login view is based on the **Login** partial view snippet, a **Sign in with Microsoft** button appears under **Or using external providers**. Selecting it redirects to Microsoft and back to your site.

At this point, the login form shows this message after you return:

`The requested provider (UmbracoMembers.EntraId) has not been linked to an account, the provider must be linked before it can be used.`

This is expected. The sign-in succeeded, but no Member is linked to the Microsoft account yet. Step 4 fixes this.

{% hint style="info" %}
If Microsoft shows an error instead of redirecting back, check the error code:

* `AADSTS50011`: the redirect URI doesn't match. Compare the URI from Step 1 with `CallbackPath`, including the scheme and port.
* `AADSTS50194`: the app is single-tenant, but the `/common` endpoints are used. Add the endpoints from step 2.
{% endhint %}

## Step 4: Add auto-linking

Whether you need this step depends on how the site should work:

* **Microsoft sign-in is how people become members.** There's no separate registration step. Auto-linking is required. Without it, a Microsoft sign-in never results in a signed-in Member.
* **Members register locally and Microsoft sign-in is an extra option.** Auto-linking can stay off. Members link their account manually instead, from wherever your site lets a member manage their profile. If you don't have one, Umbraco's **Edit Profile** partial view snippet is a starting point.

With auto-linking on, a first-time sign-in with Microsoft creates a new Member automatically, using the settings below.

1. Create `EntraIdMembersExternalLoginProviderOptions.cs`:

{% code title="EntraIdMembersExternalLoginProviderOptions.cs" lineNumbers="true" %}

```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.Common.Security;

namespace MyApp;

public class EntraIdMembersExternalLoginProviderOptions : IConfigureNamedOptions<MemberExternalLoginProviderOptions>
{
    public const string SchemeName = "EntraId";

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
        options.AutoLinkOptions = new MemberExternalSignInAutoLinkOptions(
            autoLinkExternalAccount: true,
            defaultCulture: null,
            defaultIsApproved: true,
            defaultMemberTypeAlias: Constants.Security.DefaultMemberTypeAlias
        )
        {
            // Runs before the Member is created or linked.
            OnAutoLinking = (autoLinkUser, loginInfo) => { },
            // Return false to block the sign-in.
            OnExternalLogin = (user, loginInfo) => { return true; }
        };
    }
}
```

{% endcode %}

The settings mean:

* `defaultMemberTypeAlias`: the Member Type for new Members. `Constants.Security.DefaultMemberTypeAlias` is `Member`.
* `defaultIsApproved: true`: new Members are approved and can sign in immediately.

2. Register it and swap the hardcoded scheme string for the class's constant, in `MemberAuthenticationExtensions.cs` from Step 3:

{% code title="MemberAuthenticationExtensions.cs" lineNumbers="true" %}

```csharp
namespace MyApp;

public static class MemberAuthenticationExtensions
{
    public static IUmbracoBuilder ConfigureAuthenticationMembers(this IUmbracoBuilder builder)
    {
        builder.Services.ConfigureOptions<EntraIdMembersExternalLoginProviderOptions>();
        builder.AddMemberExternalLogins(logins =>
        {
            logins.AddMemberLogin(
                membersAuthenticationBuilder =>
                {
                    membersAuthenticationBuilder.AddMicrosoftAccount(
                        membersAuthenticationBuilder.SchemeForMembers(EntraIdMembersExternalLoginProviderOptions.SchemeName),
                        options =>
                        {
                            options.CallbackPath = "/umbraco-entraid-members-signin";
                            options.ClientId = "YOURCLIENTID";
                            options.ClientSecret = "YOURCLIENTSECRET";
                            options.SaveTokens = true;
                        });
                });
        });
        return builder;
    }
}
```

{% endcode %}

If you added the single-tenant endpoints in Step 3, keep them in `options`.

3. Rebuild and sign in again.

On the first sign-in, Umbraco creates a new Member or links an existing Member with the same email. Later sign-ins use that link.

{% hint style="info" %}
Are you building a package for Umbraco?

Then you will not have access to the `Program.cs` file. Instead you need to create a composer in order to register your extension method.

Learn more about this in the [Dependency Injection](../../develop-with-umbraco/application-code/backend-and-custom-logic/using-ioc.md) article.
{% endhint %}
