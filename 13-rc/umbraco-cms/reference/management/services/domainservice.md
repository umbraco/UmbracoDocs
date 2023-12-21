# DomainService

The domain service acts as a "gateway" to Umbraco data for operations which are related to domains.

* **Namespace:** `Umbraco.Cms.Core.Services`
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

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static Current class directly:

```csharp
IDomainService domainService = Umbraco.Core.Composing.Current.Services.DomainService;
```
