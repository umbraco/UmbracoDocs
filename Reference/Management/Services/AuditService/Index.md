---
versionFrom: 8.0.0
---

# AuditService

The AuditService acts as a "gateway" to Umbraco data for operations which are related to the audit trail.

[Browse the API documentation for IAuditService interface](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IAuditService.html).

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

If you wish to use use the audit service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the audit service through a local `Services` property:

```csharp
IAuditService auditService = Services.AuditService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IAuditService` interface in your constructor:

```csharp
public class MyClass
{

    private IAuditService _auditService;
    
    public MyClass(IAuditService auditService)
    {
        _auditService = auditService;
    }

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IAuditService auditService = Umbraco.Core.Composing.Current.Services.AuditService;
```
