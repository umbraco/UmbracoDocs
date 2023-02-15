# AuditService

The AuditService acts as a "gateway" to Umbraco data for operations which are related to the audit trail.

[Browse the API documentation for IAuditService interface](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IAuditService.html).

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

If you wish to use the audit service in a class, you need to use Dependency Injection (DI). For instance if you have registered your own class in Umbraco's DI container, you can specify the `IAuditService` interface in your constructor:

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

In Razor views, you can access the audit service through the `@inject` directive:

```csharp
@inject IAuditService AuditService
```
