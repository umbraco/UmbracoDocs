# FileService

The FileService acts as a "gateway" to Umbraco data for operations which are related to Scripts, Stylesheets and Templates.

[Browse the API documentation for IFileService](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IFileService.html).

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

If you wish to use the file service in a class, you need to specify the `IFileService` interface in your constructor:

```csharp
public class MyClass
{
    private IFileService _fileService;
    
    public MyClass(IFileService fileService)
    {
        _fileService = fileService;
    }
}
```

In Razor views, you can access the file service through the `@inject` directive:

```csharp
@inject IFileService FileService
```
