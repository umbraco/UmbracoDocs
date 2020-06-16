---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# ApplicationTreeService

**Applies to Umbraco 7.x and newer**

The ApplicationTreeService is used to control/query the storage for tree registrations in the ~/Config/trees.config file.

[Browse the API documentation for IApplicationTreeService](https://our.umbraco.com/apidocs/v7/csharp/api/Umbraco.Core.Services.IApplicationTreeService.html).

 * **Namespace:** `Umbraco.Core.Services`
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

    using Umbraco.Core;
    using Umbraco.Core.Models;
    using Umbraco.Core.Services;

## Getting the service
The ApplicationTreeService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the ApplicationTreeService is available through a local `Services` property.

    Services.ApplicationTreeService

Getting the service through the `ApplicationContext`:

    ApplicationContext.Current.Services.ApplicationTreeService
