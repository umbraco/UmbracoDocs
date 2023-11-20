# Versions and updates

Umbraco Heartcore is a software as a service (SaaS) offering, that eliminates upgrade concerns. All maintenance related to the CMS, its features, and APIs is handled by Umbraco HQ.

Umbraco HQ will regularly be adding new features to the CMS and new capabilities to the REST APIs. Each time new endpoints are added to the REST API the `api-version` will be updated to reflect the changes. API releases and versioning is handled following the [ASP.NET API versioning guidelines](https://github.com/microsoft/aspnet-api-versioning).

We follow semver in terms of versioning, which means you can be sure that existing APIs will continue to work as expected without breaking. If a breaking change is required then the major version will be incremented, but the previous major version will continue to work.

{% hint style="info" %}
For API calls, it's advisable **to employ the `api-version` header to indicate the API version you intend to use**. If no version is specified the latest vesrion of the API will be used.

Learn more about which versions of the API is available as well as what version each endpoint uses in the[ Umbraco Heartcore API Documentation.](api-documentation/)
{% endhint %}

When using our [Client Libraries](client-libraries/), the `api-version` is handled as part of the library and generally not something you need to worry about.

Be aware that the client library releases will have certain features available. The Forms API is unavailable in the initial release (1.0) of the .NET Core client library, for instance. This was made available in the 1.1 version of the client library.