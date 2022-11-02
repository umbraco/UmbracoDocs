---
versionFrom: 8.0.0
---

# TextService

The TextService is the entry point to localize any key in the text storage source for a given culture.

[Browse the API documentation for ILocalizedTextService interface](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.ILocalizedTextService.html).

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

If you wish to use the text service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the text service through a local `Services` property:

```csharp
ILocalizedTextService localizedTextService = Services.TextService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `ILocalizedTextService` interface in your constructor:

```csharp
public class MyClass
{

    private ILocalizedTextService _textService;

	public MyClass(ILocalizedTextService textService)
	{
		_textService = textService;
	}

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
ILocalizedTextService textService = Umbraco.Core.Composing.Current.Services.TextService;
```
