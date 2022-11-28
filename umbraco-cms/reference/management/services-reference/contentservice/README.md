# ContentService

The ContentService acts as a "gateway" to Umbraco data for operations which are related to Content.

[Browse the v9 API documentation for ContentService](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IContentService.html).

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

If you wish to use the content service in a class, you need to use Dependency Injection (DI) in your constructor:

```csharp
public class MyClass
{
    private IContentService _contentService;
    
    public MyClass(IContentService contentService)
    {
        _contentService = contentService;
    }
}
```

In Razor views, you can access the content service through the `@inject` directive:

```csharp
@inject IContentService ContentService
```
