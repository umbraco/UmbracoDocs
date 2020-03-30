---
versionFrom: 8.0.0
---

# MemberService

The MemberService acts as a "gateway" to Umbraco data for operations which are related to Members.

[Browse the API documentation for MemberService](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IMemberService.html).

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

If you wish to use use the member service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the member service through a local `Services` property:

```csharp
IMemberService memberService = Services.MemberService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IMemberService` interface in your constructor:

```csharp
public class MyClass
{

    private IMemberService _memberService;
    
    public MyClass(IMemberService memberService)
    {
        _memberService = memberService;
    }

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IMemberService memberService = Umbraco.Core.Composing.Current.Services.MemberService;
```

