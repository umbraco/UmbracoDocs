# EntityService

The EntityService acts as a "gateway" to Umbraco data for operations which are related to entities.

[Browse the API documentation for IEntityService interface](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IEntityService.html).

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

If you wish to use the entity service in a class, you need to specify the `IEntityService` interface in your constructor:

```csharp
public class MyClass
{
	private IEntityService _entityService;

	public MyClass(IEntityService entityService)
	{
		_entityService = entityService;
	}
}
```

In Razor views, you can access the entity service through the `@inject` directive:

```csharp
@inject IEntityService EntityService
```
