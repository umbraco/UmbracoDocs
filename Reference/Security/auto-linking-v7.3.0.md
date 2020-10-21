---
versionFrom: 7.3.0
keywords: oauth, security
---

# Linking External Login Provider accounts

Traditionally when using [External login providers (OAuth)](external-login-providers.md), a backoffice user will need to exist first and then that user can link their user account to an external login provider in the backoffice.

In many cases however, the external login provider you install will be the source of truth for all of your users and you may want to provide a Single Sign On (SSO) approach to the backoffice. This is called Auto Linking.

:::note
Until v8.9.0 the auto-linking logic will __not__ execute if the local user already exists. This means if you need to auto-link an existing account you will need to do a lot of manual work within your external login provider callbacks to manually link the user.
:::

## Configure External Login provider

To enable auto linking there is an extension method on `Microsoft.Owin.Security.AuthenticationOptions` called `SetExternalSignInAutoLinkOptions` which you can pass in an instance of: `Umbraco.Web.Security.Identity.ExternalSignInAutoLinkOptions`

### Basic example

If you have installed the [Identity Extensions package](https://github.com/umbraco/UmbracoIdentityExtensions) and are using the Google provider, it will create a `UmbracoADAuthExtensions.cs` file which configures the Google options (`GoogleOAuth2AuthenticationOptions`). You can extend these options like:

```cs
googleOptions.SetExternalSignInAutoLinkOptions(
  new ExternalSignInAutoLinkOptions(autoLinkExternalAccount: true));
```

### Complete Example

This example shows the additional options available for linking accounts:

```C#
var autoLinkOptions = new ExternalSignInAutoLinkOptions(
    // must be true for auto-linking to be enabled
    autoLinkExternalAccount:true,

    // Optionally specify default user type/group, else
    // assign in the OnAutoLinking callback
    // (default is editor)
    defaultUserType: "editor",

    // Optionally specify the default culture to create
    // the user as. If null it will use the default
    // culture defined in the web.config, or it can
    // be dynamically assigned in the OnAutoLinking
    // callback.
    defaultCulture: "en-US");

// an optional callback you can specify to give you more
// control over how the backoffice user is created (auto-linked)
autoLinkOptions.OnAutoLinking = (BackOfficeIdentityUser user, ExternalLoginInfo info) =>
{
    // this callback will execute when the user is being
    // auto-linked but before it is created so you
    // can modify the user before it's persisted
};

googleOptions.SetExternalSignInAutoLinkOptions(autoLinkOptions);
```

:::note
For some providers, it doesn't make sense to use auto-linking. This is especially true for public providers such as Google or Facebook. In those cases, it would mean that anyone who has a Google or Facebook account can log into your site. For public providers such as this, if auto-linking was needed you would need to limit the access by domain or other information provided in the Claims using the options/callbacks specified in those provider's authentication options.
:::

## Local logins

If you have configured auto-linking, then any auto-linked user will have an empty password assigned and they will not be able to log in locally (via username and password). In order to log in locally they will have to assign a password to their account in the backoffice.
