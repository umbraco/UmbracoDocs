---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Authenticating on the Umbraco backoffice with Active Directory credentials

## Installing the package

Before you begin, you need to install the `Microsoft.AspNetCore.Authentication.MicrosoftAccount` NuGet package. There are two approaches to installing the packages:

1. Use your favorite IDE and open up the NuGet Package Manager to search and install the packages
1. Use the command line to install the package

## Configure
Next step is to create an extension method to configure the external login. Create a class called BackofficeAuthenticationExtensions.

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
                                //  by default this is '/signin-microsoft' but it needs to be changed to this
                                options.CallbackPath = "/umbraco/";
                                options.ClientId = "{your_client_id}";
                                options.ClientSecret = "{your_client_secret}}";
                            });
                    });
            });
            return builder;
        }
    }
}
```

Last step is to update the `Startup.cs` class. Update the `ConfigureServices` method like so: 

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