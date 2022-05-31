---
versionFrom: 9.0.0
---

# DataTypeService

The DataTypeService acts as a "gateway" to Umbraco data for operations which are related to DataTypes and DataTypeDefinitions.

[Browse the API documentation for IDataTypeService](https://apidocs.umbraco.com/v9/csharp/api/Umbraco.Cms.Core.Services.IDataTypeService.html).

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

If you wish to use the data type service in a class, you need to specify the `IDataTypeService` interface in your constructor:

```c#
public class MyClass
{
    private IDataTypeService _dataTypeService;
    
    public MyClass(IDataTypeService dataTypeService)
    {
        _dataTypeService = dataTypeService;
    }
}
```

In Razor views, you can access the data type service through the `@inject` directive:

```csharp
@inject IDataTypeService DataTypeService
```