---
versionFrom: 7.3.0
---

# Replacing the basic username/password check

Having the ability to simply replace the logic to validate a username and password against a custom data store is important to some developers. Normally in ASP.Net Identity this
would require you to override the `UmbracoBackOfficeUserManager.CheckPasswordAsync` implementation and then replace the `UmbracoBackOfficeUserManager` with your own class during startup.
Since this is a common task we've made this process a lot easier with an interface called `IBackOfficeUserPasswordChecker`.

Here are the steps to specify your own logic for validating a username and password for the backoffice:

1. Install the [UmbracoIdentityExtensions package](https://github.com/umbraco/UmbracoIdentityExtensions)

1. Create an implementation of `Umbraco.Core.Security.IBackOfficeUserPasswordChecker`

    * There is one method in this interface: `Task<BackOfficeUserPasswordCheckerResult> CheckPasswordAsync(BackOfficeIdentityUser user, string password);`
    * The result of this method can be 3 things:
        * ValidCredentials = The credentials entered are valid and the authorization should proceed
        * InvalidCredentials = The credentials entered are not valid and the authorization process should return an error
        * FallbackToDefaultChecker = This is an optional result which can be used to fallback to Umbraco's default authorization process if the credentials could not be verified by your own custom implementation

For example, to always allow login when the user enters the password `test` you could do:

```C#
    using System.Threading.Tasks;
    using Umbraco.Core.Models.Identity;
    using Umbraco.Core.Security;

    namespace MyNamespace
    {
        public class MyPasswordChecker : IBackOfficeUserPasswordChecker
        {
            public Task<BackOfficeUserPasswordCheckerResult> CheckPasswordAsync(BackOfficeIdentityUser user, string password)
            {
                var result = (password == "test")
                    ? Task.FromResult(BackOfficeUserPasswordCheckerResult.ValidCredentials)
                    : Task.FromResult(BackOfficeUserPasswordCheckerResult.InvalidCredentials);

                return result;
            }
        }
    }
```

1. Modify the `~/App_Start/UmbracoCustomOwinStartup.cs` class

    * Replace the `app.ConfigureUserManagerForUmbracoBackOffice` call with a custom overload to specify your custom `IBackOfficeUserPasswordChecker`  

```C#
            var applicationContext = ApplicationContext.Current;
            app.ConfigureUserManagerForUmbracoBackOffice<BackOfficeUserManager, BackOfficeIdentityUser>(
                applicationContext,
                (options, context) =>
                {
                    var membershipProvider = Umbraco.Core.Security.MembershipProviderExtensions.GetUsersMembershipProvider().AsUmbracoMembershipProvider();
            var settingContent = Umbraco.Core.Configuration.UmbracoConfig.For.UmbracoSettings().Content;
                    var userManager = BackOfficeUserManager.Create(options,
                        applicationContext.Services.UserService,
                        applicationContext.Services.EntityService,
                        applicationContext.Services.ExternalLoginService,
                        membershipProvider,
            settingContent);

                    // Set your own custom IBackOfficeUserPasswordChecker
                    userManager.BackOfficeUserPasswordChecker = new MyPasswordChecker();
                    return userManager;
                });
```

1. Make sure to switch the `owin:appStartup` appSetting in your `web.config` file to use `UmbracoCustomOwinStartup`: `<add key="owin:appStartup" value="UmbracoCustomOwinStartup"/>`

:::note
if the username entered in the login screen does not exist in Umbraco then `MyPasswordChecker()` does not run, instead Umbraco will immediately fall back to its internal checks (default Umbraco behavior).
:::
