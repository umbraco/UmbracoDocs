---
versionFrom: 6.0.0
---

# DataTypeService

The DataTypeService acts as a "gateway" to Umbraco data for operations which are related to DataTypes and DataTypeDefinitions.

[Browse the API documentation for DataTypeService](https://our.umbraco.com/apidocs/v7/csharp/api/Umbraco.Core.Services.DataTypeService.html).

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

If you wish to use use the data type service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the data type service through a local `Services` property:

```c#
IDataTypeService dataTypeService = Services.DataTypeService;
```
In Razor views, you can access the data type service through the `ApplicationContext` property:
```c#
IDataTypeService dataTypeService = ApplicationContext.Services.DataTypeService;
```
If neither a `Services` property or a `ApplicationContext` property is available, you can also reference the `ApplicationContext` class directly and using the static `Current` property:
```c#
IDataTypeService dataTypeService = ApplicationContext.Current.Services.DataTypeService;
```
