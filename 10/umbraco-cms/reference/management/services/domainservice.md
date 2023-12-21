# DomainService

The DomainService acts as a "gateway" to Umbraco data for operations which are related to domains.

[Browse the API documentation for IDomainService](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IDomainService.html).

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

If you wish to use the domain service in a class, you need to specify the `IDomainService` interface in your constructor:

```csharp
public class MyClass
{
    private IDomainService _domainService;
    
    public MyClass(IDomainService domainService)
    {
        _domainService = domainService;
    }
}
```

In Razor views, you can access the domain service through the `@inject` directive:

```csharp
@inject IDomainService DomainService
```
