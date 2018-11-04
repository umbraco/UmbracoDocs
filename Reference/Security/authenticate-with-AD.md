---
versionFrom: 7.5.0
---

# Authenticating on the Umbraco backoffice with Active Directory credentials

Umbraco 7.5.0 introduced a built-in `IBackOfficeUserPasswordChecker` for Active Directory: `Umbraco.Core.Security.ActiveDirectoryBackOfficeUserPasswordChecker`.

Remember to add the namespace `Umbraco.Core.Models.Identity` to resolve the `BackOfficeIdentityUser`.

To configure Umbraco to use `ActiveDirectoryBackOfficeUserPasswordChecker`, first install the [Umbraco Identity Extensibility](https://github.com/umbraco/UmbracoIdentityExtensions) package:

    Install-Package UmbracoCms.IdentityExtensions

Then modify `~/App_Start/UmbracoStandardOwinStartup.cs` to override `UmbracoStandardOwinStartup.Configuration` like so:

```C#
    public override void Configuration(IAppBuilder app)
    {
        // ensure the default options are configured
        base.Configuration(app);
        // active directory authentication

        var applicationContext = ApplicationContext.Current;
        app.ConfigureUserManagerForUmbracoBackOffice<BackOfficeUserManager, BackOfficeIdentityUser>(
            applicationContext,
            (options, context) =>
            {
                var membershipProvider = Umbraco.Core.Security.MembershipProviderExtensions.GetUsersMembershipProvider().AsUmbracoMembershipProvider();
        var settingContent = Umbraco.Core.Configuration.UmbracoConfig.For.UmbracoSettings().Content;
                var userManager = BackOfficeUserManager.Create(
                    options,
                    applicationContext.Services.UserService,
                    applicationContext.Services.EntityService,
                    applicationContext.Services.ExternalLoginService,
                    membershipProvider,
            settingContent
                );
                userManager.BackOfficeUserPasswordChecker = new ActiveDirectoryBackOfficeUserPasswordChecker();
                return userManager;
            });
    }
```

The `ActiveDirectoryBackOfficeUserPasswordChecker` will look in appSettings for the name of your domain. Add this setting to Web.config:

```xml
    <appSettings>
        <add key="ActiveDirectoryDomain" value="mydomain.local" />
    </appSettings>
```

Finally, to use your `UmbracoStandardOwinStartup` class during startup, add this setting to Web.config:

```xml
    <appSettings>
        <add key="owin:appStartup" value="UmbracoStandardOwinStartup" />
    </appSettings>
```

If the active directory setup uses usernames instead of emails for authentication this will need configuring against the Umbraco user. This can be done in Umbraco back office under a specific user in user management by setting the name and Username to be the active directory username. Making Username visible for editing requires `usernameIsEmail` in umbracoSettings.config to be set to false:

    <usernameIsEmail>false</usernameIsEmail>

:::note
if the username entered in the login screen does not already exist in Umbraco then `ActiveDirectoryBackOfficeUserPasswordChecker()` does not run.  Umbraco will fall back to the default authentication.
:::