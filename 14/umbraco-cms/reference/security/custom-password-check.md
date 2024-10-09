---
description: You can specify your own logic to validate a username and password against a custom data store. Learn more about it in this section.
---


# Replacing the basic username/password check

Having the ability to replace the logic to validate a username and password against a custom data store is important to some developers. Normally in ASP.Net Core Identity this would require you to override the `UmbracoBackOfficeUserManager.CheckPasswordAsync` implementation and then replace the `UmbracoBackOfficeUserManager` with your own class during startup. Since this is a common task we've made this process a lot easier with an interface called `IBackOfficeUserPasswordChecker`.

Here are the steps to specify your own logic for validating a username and password for the backoffice:

1.  Create an implementation of `Umbraco.Cms.Core.Security.IBackOfficeUserPasswordChecker`

    * There is one method in this interface: `Task<BackOfficeUserPasswordCheckerResult> CheckPasswordAsync(BackOfficeIdentityUser user, string password);`
    * The result of this method can be 3 things:
      * ValidCredentials = The credentials entered are valid and the authorization should proceed
      * InvalidCredentials = The credentials entered are not valid and the authorization process should return an error
      * FallbackToDefaultChecker = This is an optional result which can be used to fallback to Umbraco's default authorization process if the credentials could not be verified by your own custom implementation

    For example, to always allow login when the user enters the password `test` you could do:

    ```csharp
    using System.Threading.Tasks;
    using Umbraco.Core.Models.Identity;
    using Umbraco.Core.Security;

    namespace MyNamespace;
    
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
    ```
2.  Register the `MyPasswordChecker` in your `Program.cs` file:

    ```csharp
    builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

    builder.Services.AddUnique<IBackOfficeUserPasswordChecker, MyPasswordChecker>();
    ```

{% hint style="info" %}
If the username entered in the login screen does not exist in Umbraco, then `MyPasswordChecker()` does not run. Instead, Umbraco will immediately fall back to its internal checks, which is the default Umbraco behavior.
{% endhint %}
