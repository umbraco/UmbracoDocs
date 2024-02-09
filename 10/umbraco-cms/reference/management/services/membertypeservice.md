# MemberTypeService

The MemberTypeService acts as a "gateway" to Umbraco data for operations which are related to MemberTypes.

[Browse the API documentation for IMemberTypeService interface](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IMemberTypeService.html).

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

If you wish to use the member type service in a class, you need to specify the `IMemberTypeService` interface in your constructor:

```csharp
public class MyClass
{
    private IMemberTypeService _memberTypeService;
    
    public MyClass(IMemberTypeService memberTypeService)
    {
        _memberTypeService = memberTypeService;
    }
}
```

In Razor views, you can access the member type service through the `@inject` directive:

```csharp
@inject IMemberTypeService MemberTypeService
```
