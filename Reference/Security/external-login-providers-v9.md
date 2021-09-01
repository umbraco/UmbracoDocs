---
versionFrom: 9.0.0
meta.Title: "External login providers"
meta.Description: "The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook."
---

# External login providers

The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users.
This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook.

Depending on the provider you've configured and its caption/color, the end result will look similar to this:

![OAuth login screen](images/google-oauth-v8.png)

To enable external login providers, you typically needs to install the provided nuget package. E.g. `Microsoft.Identity.Web` for Azure AD or `Microsoft.AspNetCore.Authentication.Google` for Google.

You can enable the external login providers using the `AddBackOfficeExternalLogins` extension method on `IUmbracoBuilder` in the `startup.cs`.
and configure a custom named options like `GoogleBackOfficeExternalLoginProviderOptions` described in details in the [auto linking](auto-linking-v9.md) section.;

### Example

```cs
    public class Startup
    {
        ...

        /// <summary>
        /// Configures the services
        /// </summary>
        /// <remarks>
        /// This method gets called by the runtime. Use this method to add services to the container.
        /// For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        /// </remarks>
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddUmbraco(_env, _config)
                .AddBackOffice()
                .AddWebsite()
                .AddComposers()
                .AddBackOfficeExternalLogins(logins =>
                {
                    logins.AddBackOfficeLogin(
                        backOfficeAuthenticationBuilder =>
                        {
                            backOfficeAuthenticationBuilder.AddGoogle(
                                // The scheme must be set with this method to work for the back office
                                backOfficeAuthenticationBuilder.SchemeForBackOffice(GoogleBackOfficeExternalLoginProviderOptions.SchemaName),
                                options =>
                                {
                                    //  By default this is '/signin-google' but it needs to be changed to this
                                    options.CallbackPath = "/umbraco-google-signin";
                                    options.ClientId = "YOURCLIENTID";
                                    options.ClientSecret = "YOURCLIENTSECRET";
                                });
                        });
                })
                .Build();

            services.ConfigureOptions<GoogleBackOfficeExternalLoginProviderOptions>();
        }

        ...
    }
```


## Auto-linking accounts for custom OAuth providers

Traditionally a backoffice user will need to exist first and then that user can link their user account to an external login provider in the backoffice. In many cases however, the external login provider you install will be the source of truth for all of your users.

In this case, you would want to be able to create user accounts in your external login provider and then have that user given access to the backoffice without having to create the user in the backoffice first. This is done via auto-linking.

Read more about [auto linking](auto-linking-v9.md).
