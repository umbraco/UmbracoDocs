---
versionFrom: 7.3.0
meta.Title: "External login providers"
meta.Description: "The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook."
---

# External login providers

The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook.

To install and configure an external login provider, use the [Identity Extensions package](https://github.com/umbraco/UmbracoIdentityExtensions).

The installation of these packages will install snippets of code with "readme" files on how to get up and running. Depending on the provider you've configured and its caption/color, the end result will look similar to this:

![OAuth login screen](images/google-oauth-v8.png)

## Auto-linking accounts for custom OAuth providers

Traditionally a backoffice user will need to exist first and then that user can link their user account to an external login provider in the backoffice. In many cases however, the external login provider you install will be the source of truth for all of your users.

In this case, you would want to be able to create user accounts in your external login provider and then have that user given access to the backoffice without having to create the user in the backoffice first. This is done via auto-linking.

Read more about [auto linking](auto-linking.md).
