# ContentTypeService

The content type service acts as a "gateway" to Umbraco data for operations which are related to both content types and media types.

[Browse the API documentation for IContentTypeService](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IContentTypeService.html).

* **Namespace:** `Umbraco.Cms.Core.Services`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Cms.Core.Services;
```

For Razor views:

```csharp
@using Umbraco.Cms.Core.Services
```

## Getting the service

### Dependency Injection

If you wish to use the content type service in a class, you need to specify the `IContentTypeService` interface in your constructor:

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

In Razor views, you can access the content type service through the `@inject` directive:

```csharp
@inject IContentTypeService ContentTypeService
```

## Samples

* [**Retrieving content types**](retrieving-content-types.md)\
  See examples on how to retrieve content types via the service - either individually or as a collection.
* [**Retrieving content type containers**](retrieving-content-type-containers.md)\
  See examples on how to retrieve content type containers (folders) via the service - either individually or as a collection.
