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

To configure the provider create a new static extension class and configure a custom-named option as `ProviderBackOfficeExternalLoginProviderOptions` described in detail in the [auto-linking](auto-linking.md) section. The code example below shows how the configuration for Google Authentication can be done.

```csharp
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;
using Umbraco.Cms.Web.BackOffice.Security;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;

namespace Umbraco.Cms.Web.UI.NetCore.Configuration
{
    public static class ProviderBackofficeAuthenticationExtensions
    {
        public static IUmbracoBuilder AddProviderBackofficeAuthentication(this IUmbracoBuilder builder)
        {
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
                            });
                    });
            });
            return builder;
        }
    }
}
```

Another similar example of the configuration for authentication for **Members** may look like this:

```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace Umbraco.Cms.Web.UI.NetCore.Configuration
{
    public static class ProviderMemberAuthenticationExtensions
    {
        public static IUmbracoBuilder AddProviderMemberAuthentication(this IUmbracoBuilder builder)
        {
            builder.AddMemberExternalLogins(logins =>
            {
                logins.AddMemberLogin(
                    memberAuthenticationBuilder =>
                    {
                        memberAuthenticationBuilder.AddProvider(
                            // The scheme must be set with this method to work for the back office
                            memberAuthenticationBuilder.SchemeForMembers(ProviderMemberExternalLoginProviderOptions.SchemeName),
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

Finally, update `ConfigureServices` in your `Startup.cs` class to register your configuration with Umbraco. An example may look like this:

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

Depending on the provider you've configured and its caption/color, the end result will look similar to this for users:

![OAuth Login Screen](images/google-oauth-v8.png)

Because Umbraco does not control the UI of members, this can be set up to look exactly like you would like. Umbraco ships with a Partial Macro snippet for `Login` that will show all configured external login providers.

## Auto-linking accounts for custom OAuth providers

Traditionally, a backoffice User or frontend Member will need to exist in Umbraco first. Once they exist there, they can link their user account to an external login provider. In many cases, however, the external login provider you install will be the source of truth for all of your Users and Members.

In this case, you will want to be able to create user accounts in your external login provider and automatically them access to the backoffice. This is done via auto-linking.

This could also be the case for members if your website allows the public creation of members. In this case, the creation process can be simplified by allowing auto-linking to the external account. This could be when using something like Facebook, Twitter, or Google.

Read more about this in the [Linking External Login Provider accounts](auto-linking.md) article.
