# TagService

Tag service to query for tags in the tags db table.

[Browse the API documentation for ITagService interface](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.ITagService.html).

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

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `ITagService` interface in your constructor:

```csharp
public class MyClass
{
    private ITagService _tagService;

	public MyClass(ITagService tagService)
	{
		_tagService = tagService;
	}
}
```

In Razor views, you can access the member service through the `@inject` directive:

```csharp
@inject ITagService TagService
```