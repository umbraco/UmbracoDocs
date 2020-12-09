---
versionFrom: 8.1.0
---

# Authenticating on the Umbraco backoffice with Active Directory credentials

You'll need to create a new file to override the existing owin configuration. Create a directory in your root folder called "App_Start" (if it doesn't already exist) and then create a startup configuration file (e.g. `~/App_Start/MyOwinStartup.cs`) like so:

```C#
using Microsoft.Owin;
using MyApp;
using Owin;
using Umbraco.Core.Models.Identity;
using Umbraco.Core.Security;
using Umbraco.Web;
using Umbraco.Web.Security;

[assembly: OwinStartup("MyOwinStartup", typeof(MyOwinStartup))]
namespace MyApp
{
    public class MyOwinStartup : UmbracoDefaultOwinStartup
    {
        public override void Configuration(IAppBuilder app)
        {
            //ensure the default options are configured
            base.Configuration(app);

            // active directory authentication
            ConfigureBackofficeActiveDirectoryPasswords(app);
        }

        private void ConfigureBackofficeActiveDirectoryPasswords(IAppBuilder app)
        {
            app.ConfigureUserManagerForUmbracoBackOffice<BackOfficeUserManager, BackOfficeIdentityUser>(
                RuntimeState,
                GlobalSettings,
                (options, context) =>
                {
                    var membershipProvider = MembershipProviderExtensions.GetUsersMembershipProvider().AsUmbracoMembershipProvider();
                    var userManager = BackOfficeUserManager.Create(
                        options,
                        Services.UserService,
                        Services.MemberTypeService,
                        Services.EntityService,
                        Services.ExternalLoginService,
                        membershipProvider,
                        Mapper,
                        UmbracoSettings.Content,
                        GlobalSettings
                    );
                    userManager.BackOfficeUserPasswordChecker = new ActiveDirectoryBackOfficeUserPasswordChecker();
                    return userManager;
                });
        }
    }

}
```

The `ActiveDirectoryBackOfficeUserPasswordChecker` will look in appSettings for the name of your domain. Add this setting to Web.config:

```xml
<appSettings>
    <add key="ActiveDirectoryDomain" value="mydomain.local" />
</appSettings>
```
:::tip
One way to find your Active Directory Domain if you are logged into your domain is to open a command prompt and run `set logon` and use the value returned as the `LOGONSERVER` (not including any slashes).
:::

Finally, to use your `UmbracoStandardOwinStartup` class during startup, update this setting to Web.config:

```xml
<appSettings>
    <add key="owin:appStartup" value="MyOwinStartup" />
</appSettings>
```

If the active directory setup uses usernames instead of emails for authentication this will need configuring against the Umbraco user. This can be done in Umbraco backoffice under a specific user in user management by setting the name and Username to be the active directory username. Making Username visible for editing requires `usernameIsEmail` in umbracoSettings.config to be set to false:

```xml
<usernameIsEmail>false</usernameIsEmail>
```

:::note
if the username entered in the login screen does not already exist in Umbraco then `ActiveDirectoryBackOfficeUserPasswordChecker()` does not run.  Umbraco will fall back to the default authentication.
:::
