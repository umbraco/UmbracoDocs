# DomainService

The domain service acts as a "gateway" to Umbraco data for operations which are related to domains.

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

### Services property

If you wish to use use the domain service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the domain service through a local `Services` property:

```csharp
IDomainService domainService = Services.DomainService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the IDomainService interface in your constructor:

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

In Razor views, you can access the Data Type service through the `@inject` directive:

```csharp
@inject IDomainService DomainService
```
