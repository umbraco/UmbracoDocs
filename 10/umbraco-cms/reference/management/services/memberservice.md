# MemberService

The MemberService acts as a "gateway" to Umbraco data for operations which are related to Members.

[Browse the API documentation for IMemberService interface](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IMemberService.html).

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

If you wish to use the member service in a class, you need to specify the `IMemberService` interface in your constructor:

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

In Razor views, you can access the member service through the `@inject` directive:

```csharp
@inject IMemberService MemberService
```
