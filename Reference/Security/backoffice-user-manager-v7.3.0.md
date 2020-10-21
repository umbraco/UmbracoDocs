---
versionFrom: 7.3.0
versionTo: 8.9.0
meta.Title: "BackOfficeUserManager and Events"
meta.Description: "The BackOfficeUserManager is the ASP.NET Identity UserManager implementation in Umbraco. It exposes APIs for working with Umbraco User's via the ASP.NET Identity including password handling."
---

# BackOfficeUserManager and Events

The `BackOfficeUserManager` is the ASP.NET Identity [UserManager](https://docs.microsoft.com/en-us/previous-versions/aspnet/dn613290(v=vs.108)) implementation in Umbraco. It exposes APIs for working with Umbraco User's via the ASP.NET Identity including password handling.

## Extending

The BackOfficeUserManager can be extended during OWIN startup in order to replace its implementation with your own. This may be required if you want to extend the functionality of the BackOfficeUserManager for things like supporting two-factor authentication (2FA).

:::note
A 2FA implementation example is part of the community package ["Umbraco 2FA"](https://our.umbraco.com/packages/backoffice-extensions/umbraco-2fa/) and the source code can be found [here](https://github.com/Offroadcode/Umbraco-2FA).

In this case, it is required to extend the BackOfficeUserManager in order to implement the ASP.NET Identity `SupportsUserTwoFactor` property and the underlying User Store implementations: `IUserTwoFactorStore`, `IUserPhoneNumberStore`.
:::

### Example

You can create a custom OWIN startup class (or if you install the [Identity Extensions package](https://github.com/umbraco/UmbracoIdentityExtensions) it will add a custom OWIN startup class for you to use) then you can override `ConfigureUmbracoUserManager` to create a custom implementation.

```cs
public class UmbracoCustomOwinStartup : UmbracoDefaultOwinStartup
{
    /// <summary>
    /// Configures the BackOfficeUserManager for Umbraco
    /// </summary>
    /// <param name="app"></param>
    protected override void ConfigureUmbracoUserManager(IAppBuilder app)
    {
        // There are several overloads of this method that allow
        // you to customize the BackOfficeUserManager or even custom
        // BackOfficeUserStore (This is the default).
        app.ConfigureUserManagerForUmbracoBackOffice(
            Services,
            Mapper,
            UmbracoSettings.Content,
            GlobalSettings,
            global::Umbraco.Core.Security.MembershipProviderExtensions.GetUsersMembershipProvider().AsUmbracoMembershipProvider());
    }
}
```

The overloads of `ConfigureUmbracoUserManager` [are listed here](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Web.Security.AppBuilderExtensions.html). One overload provides a callback in order for you to return a custom implementation of `BackOfficeUserManager`.

## Events

There are [several static events](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Web.Security.BackOfficeUserManager-1.html#events) you can subscribe to on the `BackOfficeUserManager`. Internally these are mostly used for auditing.
