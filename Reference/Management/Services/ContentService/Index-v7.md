---
keywords: services content service
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# ContentService

The ContentService acts as a "gateway" to Umbraco data for operations which are related to Content.

[Browse the v7 API documentation for ContentService](https://our.umbraco.com/apidocs/v7/csharp/api/Umbraco.Core.Services.ContentService.html).

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

If you wish to use use the content service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the content service through a local `Services` property:

```csharp
IContentService contentService = Services.ContentService;
```

In Razor views, you can access the content service through the `ApplicationContext` property:

```csharp
IContentService contentService = ApplicationContext.Services.ContentService;
```

If neither a `Services` property or a `ApplicationContext` property is available, you can also reference the `ApplicationContext` class directly and using the static `Current` property:

```csharp
IContentService contentService = ApplicationContext.Current.Services.ContentService;
```
