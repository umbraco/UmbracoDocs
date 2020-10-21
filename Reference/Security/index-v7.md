---
versionFrom: 7.0.0
meta.Title: "Security in Umbraco"
meta.Description: "This section includes information on Umbraco security, its various security options and configuring how authentication & authorization works in Umbraco"
---

# Security

_This section includes information on Umbraco security, its various security options and configuring how authentication & authorization works in Umbraco_

## Umbraco Security overview

We have a dedicated security page on our main site which provides most of the details you may need to know about security within the Umbraco CMS including how to report a vulnerability: [https://umbraco.com/products/umbraco-cms/security/](https://umbraco.com/products/umbraco-cms/security/)

## SSL/HTTPS

We highly encourage the use of HTTPS on Umbraco websites especially in production environments. By using HTTPS you greatly improve the security of your website.

Don't forget to [configure your Umbraco when using HTTPS](use-https.md).

## Backoffice users

Authentication for backoffice users in Umbraco uses [ASP.NET Identity](https://www.asp.net/identity) which is a flexible and extendable framework for authentication.

Out of the box Umbraco ships with a custom ASP.NET Identity implementation which uses Umbraco's database data. Normally this is fine for most Umbraco developers, but in some cases the authentication process needs to be customized.

The Umbraco ASP.NET Identity implementation can be extended by using the [Umbraco Identity Extensions](https://github.com/umbraco/UmbracoIdentityExtensions) package. This package installs csharp files with some code snippets on how to customize the ASP.NET Identity implementation. Customization can include extending Umbraco's `UserManager` as well as implementing [External login providers (OAuth)](external-login-providers.md).

### [External login providers](external-login-providers.md)

The Umbraco backoffice supports external login providers (OAuth) for performing authentication of your users. This could be any OpenIDConnect provider such as Azure Active Directory, Identity Server, Google or Facebook.

### [BackOfficeUserManager](backoffice-user-manager-v7.3.0.md) and Events

The [`BackOfficeUserManager`](backoffice-user-manager-v7.3.0.md) is the ASP.NET Identity [UserManager](https://docs.microsoft.com/en-us/previous-versions/aspnet/dn613290(v=vs.108)) implementation in Umbraco. It exposes APIs for working with Umbraco User's via the ASP.NET Identity including password handling.

### Custom password check

In most cases [External login providers (OAuth)](external-login-providers.md) will meet the needs of most users when needing to authenticate with external resources but in some cases you may need to only change how the username and password credentials are checked.

This is typically a legacy approach to validating credentials with external resources but it is possible.

You are able to check the username and password against your own credentials store by implementing a [`IBackOfficeUserPasswordChecker`](custom-password-checker-v7.3.0.md).

#### Authenticating with Active Directory credentials

If you are using a network-based Azure Directory (not Azure Active Directory), we have set up a guide on how to [connect the backoffice to Active Directory](Authenticate-With-AD-vpre8.md). It can be done using the  `ActiveDirectoryBackOfficeUserPasswordChecker`.

### Sensitive data on members

Marking fields as [sensitive](sensitive-data.md) will hide the data in those fields for backoffice users that have no business viewing personal data of members.

### [Setup Umbraco for a FIPS Compliant Server](Setup-Umbraco-for-a-Fips-Server/index.md)

How to configure Umbraco to run on a FIPS compliant server.

### [Security settings](Security-settings/index.md)

Some security settings that can be used in Umbraco.
