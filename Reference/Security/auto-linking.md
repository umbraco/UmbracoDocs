---
versionFrom: 7.3.0
keywords: oauth, security
---

# Auto Linking accounts

:::note
This article contains information from the old issue tracker [U4-6753 - Identity support must have an option to enable auto-linked accounts](https://issues.umbraco.org/issue/U4-6753)
:::

For some providers it doesn't make sense to have to link external accounts after a local account has been created. These providers would be OAuth providers such as Active Directory providers where the admin knows that only their user's with auth against the end-point.

For public providers such as Google or Facebook, this doesn't make any sense, we cannot auto-link public providers.

The auto-linking should be enabled by a startup option and when activated, when a user that doesn't have a local account is auth-ed. On the reply we will create a local user with a generated password and create their account as per the specified options of the provider. With a generated password it means they cannot log in 'offline' but that is ok, if that functionality is required then the administrator can log in to the backoffice to reset their local password.

To do this there is an extension method on `Microsoft.Owin.Security.AuthenticationOptions` called `SetExternalSignInAutoLinkOptions` which you can pass in an instance of: `Umbraco.Web.Security.Identity.ExternalSignInAutoLinkOptions`

This is done during the configuration of the OAuth provider, the options class allows you to dynamically return data for each of it's methods if required, alternatively you can specify what the methods will return based on it's ctor arguments. Generally there would be very little to configure and if you wanted to auto-link/create local accounts based on your external OAuth provider you can just do (for example):

```C#
    googleOptions.SetExternalSignInAutoLinkOptions(
      new ExternalSignInAutoLinkOptions(autoLinkExternalAccount: true));
```

The custom options also have a field to display a custom angular view after the linking has taken place, this view can be used to gather further user information such as their name, a local login name or password, etc... This hasn't been implemented yet, will do soon.

## Example

Here's an example of specifying auto link options for your OAuth provider:

```C#
    // create the options, all parameters are optional but if you wish to enable
    // any auto-linking, the autoLinkExternalAccount parameter must be true
    var autoLinkOptions = new ExternalSignInAutoLinkOptions(
        autoLinkExternalAccount:true,
        defaultUserType: "editor",
        defaultCulture: "en-US");

    // an optional callback you can specify to give you more control over how the
    // backoffice user is created (auto-linked)
    autoLinkOptions.OnAutoLinking = (BackOfficeIdentityUser user, ExternalLoginInfo info) =>
    {
        // this callback will execute when the user is being auto-linked but before it is created
        // so you can modify the user before it's persisted
    };

    identityServerOptions.SetExternalSignInAutoLinkOptions(autoLinkOptions);
```