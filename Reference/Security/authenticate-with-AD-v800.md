---
versionFrom: 8.0.0
versionTo: 8.0.3
---

:::note
The example works only in v8.0.x
:::

# Authenticating on the Umbraco backoffice with Active Directory credentials

Umbraco 8.0.0 incorporated the previous [Umbraco Identity Extensibility](https://github.com/umbraco/UmbracoIdentityExtensions) package in to the core.

You'll need to create a new file to override the existing owin configuration (e.g. `~/App_Start/MyOwinStartup.cs`) like so:

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

