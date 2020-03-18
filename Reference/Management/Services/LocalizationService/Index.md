---
versionFrom: 8.0.0
---

# LocalizationService

The LocalizationService acts as a "gateway" to Umbraco data for operations which are related to Dictionary items and Languages.

[Browse the API documentation for ILocalizationService](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.ILocalizationService.html).

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

### Services property
If you wish to use use the localization service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the localization service through a local `Services` property:

```csharp
ILocalizationService localizationService = Services.LocalizationService;
```

### Dependency Injection
In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the ILocalizationService interface in your constructor:

```c#
public class MyClass
{

    private ILocalizationService _localizationService;
    
    public MyClass(ILocalizationService localizationService)
    {
        _localizationService = localizationService;
    }

}
```

### Static accessor
If neither a Services property or Dependency Injection is available, you can also reference the static Current class directly:

```c#
ILocalizationService localizationService = Umbraco.Core.Composing.Current.Services.LocalizationService;
```

## Samples

* [**Retrieving languages**](Retrieving-languages.md)<br />See examples on how to retrieve languages via the localization service - either individually or as a collection.
