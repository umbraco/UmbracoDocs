---
versionFrom: 6.0.0
---

# LocalizationService

:::note
Applies to Umbraco 6.0.0+
:::

The LocalizationService acts as a "gateway" to Umbraco data for operations which are related to Dictionary items and Languages.

[Browse the API documentation for LocalizationService](https://our.umbraco.com/apidocs/v7/csharp/api/Umbraco.Core.Services.LocalizationService.html).

 * **Namespace:** `Umbraco.Core.Services`
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Core;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
```

## Getting the service

If you wish to use use the localization service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the localization service through a local `Services` property:

```csharp
ILocalizationService localizationService = Services.LocalizationService;
```

In Razor views, you can access the localization service through the `ApplicationContext` property:

```csharp
ILocalizationService localizationService = ApplicationContext.Services.LocalizationService;
```

If neither a `Services` property or a `ApplicationContext` property is available, you can also reference the `ApplicationContext` class directly and using the static `Current` property:

```csharp
ApplicationContext.Current.Services.LocalizationService
```

## Samples

* [**Retrieving languages**](Retrieving-languages-v7.md)<br />See examples on how to retrieve languages via the localization service - either individually or as a collection.
