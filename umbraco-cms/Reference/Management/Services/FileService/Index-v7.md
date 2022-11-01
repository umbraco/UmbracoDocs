---
versionFrom: 6.0.0
---

# FileService

:::note
Applies to Umbraco 6.0.0+
:::

The FileService acts as a "gateway" to Umbraco data for operations which are related to Scripts, Stylesheets and Templates.

[Browse the API documentation for FileService](https://our.umbraco.com/apidocs/v7/csharp/api/Umbraco.Core.Services.FileService.html).

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
The FileService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the FileService is available through a local `Services` property.

```csharp
Services.FileService
```

Getting the service through the `ApplicationContext`:

```csharp
ApplicationContext.Current.Services.FileService
```
