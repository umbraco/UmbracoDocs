---

keywords: services content service
versionFrom: 8.0.0
---

# ContentService

The ContentService acts as a "gateway" to Umbraco data for operations which are related to Content.

[Browse the v8 API documentation for ContentService](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IContentService.html).

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
If you wish to use the content service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the content service through a local `Services` property:

```csharp
IContentService contentService = Services.ContentService;
```

The `Services` property is also available in the Razor veiw inheriting from `UmbracoViewPage`.

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IContentService` interface in your constructor:

```csharp
public class MyClass
{

    private readonly IContentService _contentService;
    
    public MyClass(IContentService contentService)
    {
        _contentService = contentService;
    }

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IContentService contentService = Umbraco.Core.Composing.Current.Services.ContentService;
```
