---
description: >-
  The BackOfficeUserManager is the ASP.NET Core Identity UserManager
  implementation in Umbraco. It exposes APIs for working with Umbraco User's via
  the ASP.NET Core Identity including password handling.
---

# BackOfficeUserManager and Events

The `BackOfficeUserManager` is the ASP.NET Core Identity [UserManager](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.identity.usermanager-1) implementation in Umbraco. It exposes APIs for working with Umbraco Users via the ASP.NET Core Identity including password handling.

## Extending

The BackOfficeUserManager can be replaced during startup in order to use your own implementation.\
This may be required if you want to extend the functionality of the BackOfficeUserManager for things like supporting two-factor authentication(2FA).

### Example

You can replace the BackOfficeUserManager in the startup class by using the `SetBackOfficeUserManager` extension on the `IUmbracoBuilder`.

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .SetBackOfficeUserManager<CustomBackOfficeUserManager>()
    .Build();
```

You can then implement your custom `BackOfficeUserManager`, like this.\
Note the constructor minimum needs to inject what is required for the base `BackOfficeUserManager` class:

```csharp
 public class CustomBackOfficeUserManager : BackOfficeUserManager
{
    public CustomBackOfficeUserManager(
        IIpResolver ipResolver,
        IUserStore<BackOfficeIdentityUser> store,
        IOptions<BackOfficeIdentityOptions> optionsAccessor,
        IPasswordHasher<BackOfficeIdentityUser> passwordHasher,
        IEnumerable<IUserValidator<BackOfficeIdentityUser>> userValidators,
        IEnumerable<IPasswordValidator<BackOfficeIdentityUser>> passwordValidators,
        BackOfficeErrorDescriber errors,
        IServiceProvider services,
        IHttpContextAccessor httpContextAccessor,
        ILogger<CustomBackOfficeUserManager> logger,
        IOptions<UserPasswordConfigurationSettings> passwordConfiguration,
        IEventAggregator eventAggregator,
        IBackOfficeUserPasswordChecker backOfficeUserPasswordChecker)
        : base(
            ipResolver,
            store,
            optionsAccessor,
            passwordHasher,
            userValidators,
            passwordValidators,
            errors,
            services,
            httpContextAccessor,
            logger,
            passwordConfiguration,
            eventAggregator,
            backOfficeUserPasswordChecker)
    {
    }

    //Override whatever you need, e.g. SupportsUserTwoFactor.
    public override bool SupportsUserTwoFactor => false;
}
```

## Notifications

There are [many notifications](https://apidocs.umbraco.com/v16/csharp/api/Umbraco.Cms.Web.Common.Security.BackOfficeUserManager.html) you can handle on the `BackOfficeUserManager`.\
Internally these are mainly used for auditing but there are some that allow you to customize some workflows:

* `SendEmailNotification`
  * This is a generic notification but it has a property `EmailType` that specify the email type. This type can be `UserInvite`.\
    In that case, it allows you to take control over how a user in the backoffice is invited.\
    This might be handy if you are using an [External Login Provider](external-login-providers.md) that has the `DenyLocalLogin` option assigned\
    and you still want to have the user invite functionality available.\
    In this setup, all of your users are controlled by your external login provider so you would need to handle the user invite flow yourself by using this event and inviting the user via your external provider.\
    If you are using this event to replace the default functionality you will need to tell Umbraco that you've handled the invite by calling the`SendEmailNotification.HandleEmail()` method.)
* `UserLogoutSuccessNotification`
  * This is specifically used if you have an [External Login Provider](external-login-providers.md) in use\
    and you want to log out of that external provider when the user is logged out of the backoffice (that is log out of everywhere).\
    The notification has a property `SignOutRedirectUrl`. If this property is assigned then Umbraco will redirect to that URL upon successful\
    backoffice sign out in order to sign the user out of the external login provider.
