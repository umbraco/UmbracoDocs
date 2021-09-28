---
versionFrom: 8.0.0
---

# TagService

Tag service to query for tags in the tags db table.

[Browse the API documentation for ITagService interface](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.ITagService.html).

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

If you wish to use use the tag service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the tag service through a local `Services` property:

```csharp
ITagService tagService = Services.TagService;
```

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

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
ITagService tagService = Umbraco.Core.Composing.Current.Services.TagService;
```
