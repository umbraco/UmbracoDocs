---
versionFrom: 8.0.0
---

# MemberGroupService
The MemberGroupService acts as a "gateway" to Umbraco data for operations which are related to Member groups, which are also known as Member Roles.

[Browse the API documentation for IMemberGroupService](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IMemberGroupService.html).

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

If you wish to use use the member group service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the member group service through a local `Services` property:

```csharp
IMemberGroupService memberGroupService = Services.MemberGroupService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IMemberGroupService` interface in your constructor:

```csharp
public class MyClass
{

    private IMemberGroupService _memberGroupService;
    
    public MyClass(IMemberService memberGroupService)
    {
        _memberGroupService = memberGroupService;
    }

}
```
### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IMemberGroupService memberGroupService = Umbraco.Core.Composing.Current.Services.MemberGroupService;
```
