# MemberGroupService

The MemberGroupService acts as a "gateway" to Umbraco data for operations which are related to Member groups, which are also known as Member Roles.

[Browse the API documentation for IMemberGroupService](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IMemberGroupService.html).

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

If you wish to use the member group service in a class, you need to specify the `IMemberGroupService` interface in your constructor:

```csharp
public class MyClass
{
    private IMemberGroupService _memberGroupService;
    
    public MyClass(IMemberGroupService memberGroupService)
    {
        _memberGroupService = memberGroupService;
    }
}
```

In Razor views, you can access the member group service through the `@inject` directive:

```csharp
@inject IMemberGroupService MemberGroupService
```
