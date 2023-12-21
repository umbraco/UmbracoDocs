# TextService

The TextService is the entry point to localize any key in the text storage source for a given culture.

[Browse the API documentation for ILocalizedTextService interface](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.ILocalizedTextService.html).

 * **Namespace:** `Umbraco.Cms.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

 All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Cms.Core.Services;
```

## Getting the service

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

In Razor views, you can access the member service through the `@inject` directive:

```csharp
@inject ILocalizedTextService LocalizedTextService
```
