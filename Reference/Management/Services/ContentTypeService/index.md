---
versionFrom: 8.0.0
---

# ContentTypeService

The content type service acts as a "gateway" to Umbraco data for operations which are related to both content types and media types.

[Browse the API documentation for IContentTypeService](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IContentTypeService.html).

 * **Namespace:** `Umbraco.Core.Services`
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```C#
using Umbraco.Core;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
```

## Getting the service

### Services property
If you wish to use use the content type service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the content type service through a local `Services` property:

```C#
IContentTypeService contentTypeService = Services.ContentTypeService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IContentTypeService` interface in your constructor:

```csharp
public class MyClass
{

    private IContentTypeService _contentTypeService;
    
    public MyClass(IContentTypeService contentTypeService)
    {
        _contentTypeService = contentTypeService;
    }

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IContentTypeService contentTypeService = Umbraco.Core.Composing.Current.Services.ContentTypeService;
```

## Samples

* [**Retrieving content types**](Retrieving-content-types.md)<br />See examples on how to retrieve content types via the service - either individually or as a collection.

* [**Retrieving content type containers**](Retrieving-content-type-containers.md)<br />See examples on how to retrieve content type containers (folders) via the service - either individually or as a collection.
