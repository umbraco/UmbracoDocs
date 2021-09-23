---
versionFrom: 9.0.0
keywords: oauth, security
meta.Title: "External login providers"
meta.Description: "The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook."
---

# External login providers

The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook.

Unlike previous major releases of Umbraco the use of Identity Extensions package is no longer required.

Install an appropriate nuget package for the provider you wish to use. Some popular ones found in Nuget include:
 * [Google](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.Google)
 * [Facebook](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.Facebook)
 * [Microsoft](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.MicrosoftAccount/)
 * [Twitter](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.Twitter/3.0.0)
 * [Open ID Connect](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.OpenIdConnect)
 * [Others](https://docs.microsoft.com/en-us/aspnet/core/security/authentication/social/other-logins?view=aspnetcore-5.0)

To configure the provider create a new static extension class for your provider and configure a custom named options like `GoogleBackOfficeExternalLoginProviderOptions` described in details in the [auto linking](../auto-linking/index-v9.md) section.
An example of configuration for Google Authentication may look like:

```Csharp
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;
using Umbraco.Cms.Web.BackOffice.Security;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;

namespace Umbraco.Cms.Web.UI.NetCore.Configuration
{
    public static class GoogleAuthenticationExtensions
    {
        public static IUmbracoBuilder AddGoogleAuthentication(this IUmbracoBuilder builder)
        {
            builder.AddBackOfficeExternalLogins(logins =>
            {
                logins.AddBackOfficeLogin(
                    backOfficeAuthenticationBuilder =>
                    {
                        backOfficeAuthenticationBuilder.AddGoogle(
                            // The scheme must be set with this method to work for the back office
                            backOfficeAuthenticationBuilder.SchemeForBackOffice(GoogleBackOfficeExternalLoginProviderOptions.SchemeName),
                            options =>
                            {
                                //  By default this is '/signin-google' but it needs to be changed to this
                                options.CallbackPath = "/umbraco-google-signin";
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

Finally, update `ConfigureServices` in your `Startup.cs` class to register your configuration with Umbraco. An example may look like:
```Csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddComposers()
        .AddGoogleAuthentication()
        .Build();
}
```

For a more in depth article on how to setup OAuth providers in .NET refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/aspnet/core/security/authentication/social/?view=aspnetcore-5.0&tabs=visual-studio).

Depending on the provider you've configured and its caption/color, the end result will look similar to this:

![OAuth Login Screen](images/google-oauth-v8.png)

## Auto-linking accounts for custom OAuth providers

Traditionally a backoffice user will need to exist first and then that user can link their user account to an external login provider in the backoffice. In many cases however, the external login provider you install will be the source of truth for all of your users.

In this case, you would want to be able to create user accounts in your external login provider and then have that user given access to the backoffice without having to create the user in the backoffice first. This is done via auto-linking.

Read more about [auto linking](../auto-linking/index-v9.md).
