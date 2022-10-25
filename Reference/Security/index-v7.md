---
versionFrom: 7.0.0
meta.Title: "Security in Umbraco"
meta.Description: "This section includes information on Umbraco security, its various security options and configuring how authentication & authorization works in Umbraco"
---

# Security

This section includes information on Umbraco security, its different security options and configuring how authentication & authorization works in Umbraco.

## [Umbraco Security overview](https://umbraco.com/products/umbraco-cms/security/)

We have a dedicated security page on our main site which provides most of the details you may need to know about security within the Umbraco CMS including how to report a vulnerability: [https://umbraco.com/products/umbraco-cms/security/](https://umbraco.com/products/umbraco-cms/security/)

## [SSL/HTTPS](SSL-HTTPS/index.md)

We highly encourage the use of HTTPS on Umbraco websites especially in production environments. By using HTTPS you greatly improve the security of your website.

Don't forget to [configure your Umbraco when using HTTPS](SSL-HTTPS/index.md).

## [Backoffice users](https://www.asp.net/identity)

Authentication for backoffice users in Umbraco uses [ASP.NET Identity](https://www.asp.net/identity) which is a flexible and extendable framework for authentication.

Out of the box Umbraco ships with a custom ASP.NET Identity implementation which uses Umbraco's database data. Normally this is fine for most Umbraco developers, but in some cases the authentication process needs to be customized.

The Umbraco ASP.NET Identity implementation can be extended by using the [Umbraco Identity Extensions](https://github.com/umbraco/UmbracoIdentityExtensions) package. This package installs csharp files with some code snippets on how to customize the ASP.NET Identity implementation. Customization can include extending Umbraco's `UserManager` as well as implementing [External login providers (OAuth)](external-login-providers).

### [External login providers](external-login-providers)

The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook.

### [BackOfficeUserManager and Events](BackOfficeUserManager-and-Notifications/index-v7.3.0.md)

The [`BackOfficeUserManager`](BackOfficeUserManager-and-Notifications/index-v7.3.0.md) is the ASP.NET Identity [UserManager](https://docs.microsoft.com/en-us/previous-versions/aspnet/dn613290(v=vs.108)) implementation in Umbraco. It exposes APIs for working with Umbraco User's via the ASP.NET Identity including password handling.

### [Custom password check](Custom-password-check/index-v7.3.0.md)

In most cases [External login providers (OAuth)](external-login-providers) will meet the needs of most users when needing to authenticate with external resources but in some cases you may need to only change how the username and password credentials are checked.

This is typically a legacy approach to validating credentials with external resources but it is possible.

You are able to check the username and password against your own credentials store by implementing a [`IBackOfficeUserPasswordChecker`](Custom-password-check/index-v7.3.0.md).

#### [Authenticating with Active Directory credentials](Authenticate-with-Active-Directory/index-vpre8.md)

If you are using a network-based Azure Directory (not Azure Active Directory), we have set up a guide on how to [connect the backoffice to Active Directory](Authenticate-with-Active-Directory/index-vpre8.md). It can be done using the  `ActiveDirectoryBackOfficeUserPasswordChecker`.

Umbraco version 7.5.0+ comes with a built-in `IBackOfficeUserPasswordChecker` for **Active Directory**: `Umbraco.Core.Security.ActiveDirectoryBackOfficeUserPasswordChecker`.

### [Sensitive data on members](Sensitive-data-on-members/index.md) (Available from Umbraco version 7.9.0)

Marking fields as [sensitive](Sensitive-data-on-members/index.md) will hide the data in those fields for backoffice users that have no business viewing personal data of members.

If you've upgraded from a version before 7.9.0, none of the backoffice users will have access to sensitive data by default.

### [Setup Umbraco for a FIPS Compliant Server](Setup-Umbraco-for-a-Fips-Server/index.md)

How to configure Umbraco to run on a FIPS compliant server.

### [Security settings](Security-settings/index.md)

Some security settings that can be used in Umbraco.

### Introduction of Custom OAuth providers (Available from Umbraco version 7.3.1)

Starting with Umbraco 7.3.1 Umbraco uses [ASP.Net Identity](https://www.asp.net/identity) for authentication of backoffice users. Asp.NET identity is a flexible and extensible framework for authentication.

Out of the box Umbraco ships with a ASP.Net Identity implementation which uses Umbraco's database data. Normally this is fine for most Umbraco developers
but in some cases the authentication process needs to be customized.

For more information on connecting other oauth providers look at the [Identity Extensions](https://github.com/umbraco/UmbracoIdentityExtensions) package.
