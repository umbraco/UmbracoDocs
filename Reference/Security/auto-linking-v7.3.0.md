---
versionFrom: 7.3.0
keywords: oauth, security
---

# Auto Linking accounts

Traditionally when using [External login providers (OAuth)](external-login-providers.md), a backoffice user will need to exist first and then that user can link their user account to an external login provider in the backoffice.

In many cases however, the external login provider you install will be the source of truth for all of your users and you may want to provide a Single Sign On (SSO) approach to the back office. This is called Auto Linking.

## Configure External Login provider

To enable auto linking there is an extension method on `Microsoft.Owin.Security.AuthenticationOptions` called `SetExternalSignInAutoLinkOptions` which you can pass in an instance of: `Umbraco.Web.Security.Identity.ExternalSignInAutoLinkOptions`

_Example:_

If you have installed the [Identity Extensions package](https://github.com/umbraco/UmbracoIdentityExtensions) and are using the Google provider, it will create a file: `UmbracoADAuthExtensions.cs` which configures the Google options (`GoogleOAuth2AuthenticationOptions`). You can extend these options like:

```cs
googleOptions.SetExternalSignInAutoLinkOptions(
  new ExternalSignInAutoLinkOptions(autoLinkExternalAccount: true));
```

:::note
For some providers it doesn't make sense to use auto-linking especially public providers such as Google or Facebook because in those cases it would mean that anyone can log into your site that has a Google or Facebook account. For public providers such as this, if auto-linking was needed you would need to limit the access by domain or other information provided in the Claims using the options/callbacks specified in those provider's authentication options.
:::

## Local logins

If you have configured auto-linking, then any auto-linked user will have an empty password assigned and they will not be able to login locally (via username and password). In order to login locally they will have to assign a password to their account in the back office.


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

googleOptions.SetExternalSignInAutoLinkOptions(autoLinkOptions);
```
