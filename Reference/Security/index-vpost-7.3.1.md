---
versionFrom: 7.3.1
---

# Introduction of Custom OAuth providers

Starting with Umbraco 7.3.1 Umbraco uses [ASP.Net Identity](https://www.asp.net/identity) for authentication of backoffice users. Asp.net identity is a very flexible and extensible framework for authentication.

Out of the box Umbraco ships with a ASP.Net Identity implementation which uses Umbraco's database data. Normally this is fine for most Umbraco developers
but in some cases the authentication process needs to be customized.

For more information on connecting other oauth providers look at the [Identity Extensions](https://github.com/umbraco/UmbracoIdentityExtensions) package.
