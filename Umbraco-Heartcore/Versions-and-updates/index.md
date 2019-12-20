---
versionFrom: 8.0.0
---

# Versions and updates

Umbraco Heartcore is a headless SaaS (software as a service) product, which means that one of the benefits is that you do not have to worry about upgrades. These will all be handled by Umbraco HQ. 

Umbraco HQ will regularly be adding new features and endpoints to the REST APIs, as well as maintaining the existing structure and endpoints. Each time this is done, a new version of the API will be released. API releases and versioning is handled following the [ASP.NET API versioning guidelines](https://github.com/microsoft/aspnet-api-versioning).

:::note
It is important that you **use the `API-version` header to specify which version of the API you will be using** when making calls to the API. If no version is specified the latest vesrion of the API will be used, which could potentially break your client if it is setup for a lower version.

Learn more about which versions of the API is available as well as what version each endpoint uses in the [Umbraco Heartcore API Documentation](https://our.umbraco.com/documentation/Umbraco-Heartcore/API-Documentation/).
:::

The client libraries will be updated according to the changes in the REST APIs.