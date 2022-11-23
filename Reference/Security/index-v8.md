---
versionFrom: 8.0.0
meta.Title: "Security in Umbraco"
description: "This section includes information on Umbraco security, its various security options and configuring how authentication & authorization works in Umbraco"
---

# Security

In this article, you will find everything you need regarding security within Umbraco.

## [The Umbraco Trust Center](https://umbraco.com/about-us/trust-center/)

On our main website, we have a dedicated security section which provides all the details you need to know about security within the Umbraco CMS. This includes how to report a vulnerability.

## [SSL/HTTPS](SSL-HTTPS/index-v8.md)

We highly encourage the use of HTTPS on Umbraco websites, especially in production environments. By using HTTPS you greatly improve the security of your website.

In the "Use HTTPS" article you can learn more about how to use HTTPS and how to set it up.

## [Security Settings](Security-settings/index-v8.md)

Learn which password settings that can be configured in Umbraco.

## [Security Hardening](Security-hardening/index-v8.md)

Learn about how to can harden the security on your Umbraco website to secure it even further.

## [Security on Umbraco Cloud](../../Umbraco-Cloud/Frequently-Asked-Questions/#security-and-encryption)

When your project is hosted on Umbraco Cloud, you might be interested in more details about the security of the hosting. This information can be found in the Umbraco Cloud section of the documentation.

## [Backoffice users](https://www.asp.net/identity)

Authentication for backoffice users in Umbraco uses [ASP.NET Identity](https://www.asp.net/identity) which is a flexible and extendable framework for authentication.

Out of the box Umbraco ships with a custom ASP.NET Identity implementation which uses Umbraco's database data. Normally this is fine for most Umbraco developers, but in some cases the authentication process needs to be customized.

The Umbraco ASP.NET Identity implementation can be extended by using the [Umbraco Identity Extensions](https://github.com/umbraco/UmbracoIdentityExtensions) package. This package installs csharp files with some code snippets on how to customize the ASP.NET Identity implementation. Customization can include extending Umbraco's `UserManager` as well as implementing [External login providers (OAuth)](external-login-providers/index-v7.md).

### [External login providers](external-login-providers/index-v7.md)

The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook.

### [BackOfficeUserManager and Events](BackOfficeUserManager-and-Notifications/index-v8.9.md)

The [`BackOfficeUserManager`](BackOfficeUserManager-and-Notifications/index-v8.9.md) is the ASP.NET Identity [UserManager](https://docs.microsoft.com/en-us/previous-versions/aspnet/dn613290(v=vs.108)) implementation in Umbraco. It exposes APIs for working with Umbraco Users via the ASP.NET Identity including password handling.

### [Custom password check](Custom-password-check/index-v8.1.1.md)

In most cases [External login providers (OAuth)](external-login-providers) will meet the needs of most users when needing to authenticate with external resources but in some cases you may need to only change how the username and password credentials are checked.

This is typically a legacy approach to validating credentials with external resources but it is possible.

You are able to check the username and password against your own credentials store by implementing a [`IBackOfficeUserPasswordChecker`](Custom-password-check/index-v8.1.1.md).

#### [Authenticating with Active Directory credentials](Authenticate-with-Active-Directory/index-v8.md)

If you are using a network based Azure Directory (not Azure Active Directory), we have set up a guide on how to [connect the backoffice to Active Directory](Authenticate-with-Active-Directory/index.md). It can be done using the  `ActiveDirectoryBackOfficeUserPasswordChecker`.

## [Sensitive data on members](Sensitive-data-on-members/index.md)

Marking fields as **sensitive** will hide the data in those fields for backoffice users that do not have permission to view personal data of members.

Learn more about this in the [Sensitive Data](Sensitive-data-on-members/index.md) article.

## [Setup Umbraco for a FIPS Compliant Server](Setup-Umbraco-for-a-Fips-Server/index-v8.md)

How to configure Umbraco to run on a FIPS compliant server.

## [Reset admin password](Reset-admin-password/index-v8.md)

Use this guide to [reset the password of the "admin" user](Reset-admin-password/index-v8.md).

If you need to reset accounts of every other user while you still have administrative action, check this "[reset normal user password](password-reset.md)" article.

## Other articles related to security

* [Routing requirements for backoffice authentication](../Routing/Authorized-v8)
* [Health Checks](../../Extending/Health-Check/index-v8.md)
* [Consent Service](../Management/Services/ConsentService/index-v8.md)
