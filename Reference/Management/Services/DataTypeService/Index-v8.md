---
versionFrom: 8.0.0
---

# DataTypeService

The DataTypeService acts as a "gateway" to Umbraco data for operations which are related to DataTypes and DataTypeDefinitions.

[Browse the API documentation for IDataTypeService](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IDataTypeService.html).

 * **Namespace:** `Umbraco.Core.Services`
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```c#
using Umbraco.Core;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
```

## Getting the service

### Services property
If you wish to use use the data type service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the data type service through a local `Services` property:

```c#
IDataTypeService dataTypeService = Services.DataTypeService;
```

### Dependency Injection
In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the IDataTypeService interface in your constructor:

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

### Static accessor
If neither a Services property or Dependency Injection is available, you can also reference the static Current class directly:

```c#
IDataTypeService dataTypeService = Umbraco.Core.Composing.Current.Services.DataTypeService;
```
