---
versionFrom: 6.2.0
---

# MemberTypeService

:::note
Applies to Umbraco 6.2 and 7.1 and newer
:::

The MemberTypeService acts as a "gateway" to Umbraco data for operations which are related to MemberTypes.

[Browse the API documentation for MemberTypeService](https://our.umbraco.com/apidocs/v7/csharp/api/Umbraco.Core.Services.MemberTypeService.html).

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
The MemberTypeService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the MemberTypeService is available through a local `Services` property.

```csharp
Services.MemberTypeService
```

Getting the service through the `ApplicationContext`:

```csharp
ApplicationContext.Current.Services.MemberTypeService
```
