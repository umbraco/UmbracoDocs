---
versionFrom: 7.3.0
meta.Title: "External login providers"
meta.Description: "The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook."
---

# External login providers

The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook.

To install and configure an external login provider, use the [Identity Extensions package](https://github.com/umbraco/UmbracoIdentityExtensions).

The installation of these packages will install snippets of code with "readme" files on how to get up and running. Depending on the provider you've configured and its caption/color, the end result will look similar to this:

![OAuth Login Screen](images/google-oauth-v8.png)

## Auto-linking accounts for custom OAuth providers

Traditionally a backoffice user will need to exist first and then that user can link their user account to an external login provider in the backoffice. In many cases however, the external login provider you install will be the source of truth for all of your users.

In this case, you would want to be able to create user accounts in your external login provider and then have that user given access to the backoffice without having to create the user in the backoffice first. This is done via auto-linking.

Read more about [auto linking](../auto-linking/index.md).

## How to disable automatic redirection to the umbraco identity login screen in Umbraco Cloud projects

Since Umbraco Cloud uses Umbraco Identity by default and has automatic redirection to the login screen, you cannot use external login.
You can disable it using the configuration below:

```xml
<add key="Umbraco.Cloud.Identity.AutoRedirectLogin" value="false" />
```

**Note:** Make sure that your ClientId, ClientSecret, EnvironmentId and LocalLoginRedirectUri are in place in Identity section, otherwise you may break Umbraco Identity authorization.