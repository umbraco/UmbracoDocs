---
versionFrom: 8.0.0
meta.Title: "Security in Umbraco"
meta.Description: "This section includes information on Umbraco security, its various security options and configuring how authentication & authorization works in Umbraco"
---

# Security

In this article you will find everything you need regarding security within Umbraco.

## [The Umbraco Trust Center](https://umbraco.com/about-us/trust-center/)

On our main website we have a dedicated security section which provides all the details you need to know about security within the Umbraco CMS. This includes how to report a vulnerability.

## [SSL/HTTPS](use-https.md)

We highly encourage the use of HTTPS on Umbraco websites especially in production environments. By using HTTPS you greatly improve the security of your website.

In the "Use HTTPS" article you can learn more about how to use HTTPS and how to set it up.

## [Security settings](Security-settings)

Learn which security settings that can be configured in Umbraco.

## [Security Hardening](Security-hardening)

Learm about how to can harden the security on your Umbraco website to secure it even further.

## [Security on Umbraco Cloud](../../Umbraco-Cloud/Frequently-Asked-Questions/#security-and-encryption)

When your project is hosted on Umbraco Cloud, you might be interested in more details about the security of the hosting. This information can be found in the Umbraco Cloud section of the documentation.

## Backoffice users

Authentication for backoffice users in Umbraco uses [ASP.NET Identity](https://www.asp.net/identity) which is a very flexible and extendable framework for authentication.

Out of the box Umbraco ships with a custom ASP.NET Identity implementation which uses Umbraco's database data. Normally this is fine for most Umbraco developers, but in some cases the authentication process needs to be customized.

ASP.NET Identity can be extended and it is also possible to override/replace any part of the process of authentication.

### Custom OAuth providers

The Umbraco backoffice supports custom OAuth providers for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook.

To install and configure a custom OAuth provider, use the [Identity Extensions package](https://github.com/umbraco/UmbracoIdentityExtensions).

The installation of these packages will install snippets of code with "readme" files on how to get up and running. Depending on the provider you've configured and its caption/color, the end result will look similar to this:

![OAuth login screen](images/google-oauth-v8.png)

#### Authenticating with Active Directory credentials

We have setup a guide on how to [connect the backoffice to Active Directory](authenticate-with-AD.md). It should be pretty straight forward with the `ActiveDirectoryBackOfficeUserPasswordChecker`.

#### Auto-linking accounts for custom OAuth providers

Traditionally a backoffice user will need to exist first and then that user can link their user account to an OAuth account in the backoffice. In many cases however, the identity server you choose will be the source of truth for all of your users.

In this case you would want to be able to create user accounts in your identity server and then have that user given access to the backoffice without having to create the user in the backoffice first. This is done via auto-linking.

Read more about [auto linking](auto-linking.md)

### Custom password check

You are able [check the username and password against your own credentials store](custom-password-checker.md) by implementing a new  `IBackOfficeUserPasswordChecker`.

### Sensitive data on members

Marking fields as **sensitive** will hide the data in those fields for backoffice users that do not have permission to view personal data of members.

Learn more about this in the [Sensitive Data](sensitive-data.md) article.

## [Setup Umbraco for a FIPS Compliant Server](Setup-Umbraco-for-a-Fips-Server/index.md)

How to configure Umbraco to run on a FIPS compliant server.

## [Reset admin password](reset-admin-password.md)

Use this guide to [reset the password of the "admin" user](reset-admin-password.md).

If you need to reset accounts of every other user while you still have administrative action, check this "[reset normal user password](password-reset.md)" article.

## Other articles related to security

* [Routing requirements for backoffice authentication](../Routing/Authorized/)
* [Health Checks](../../Extending/Health-Check/)
* [Consent Service](../Management/Services/ConsentService/)