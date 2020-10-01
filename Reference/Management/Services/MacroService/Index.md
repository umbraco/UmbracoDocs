---
versionFrom: 8.0.0
---

# IMacroService

Defines the MacroService, which is an easy access to operations involving `IMacro`.

[Browse the API documentation for IMacroService interface](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IMacroService.html).

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

If you wish to use use the macro service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the macro service through a local `Services` property:

```csharp
IMacroService macroService = Services.MacroService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IMacroService` interface in your constructor:

```csharp
public class MyClass
{

    private IMacroService _macroService;

	public MyClass(IMacroService macroService)
	{
		_macroService = macroService;
	}

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IMacroService macroService = Umbraco.Core.Composing.Current.Services.MacroService;
```
