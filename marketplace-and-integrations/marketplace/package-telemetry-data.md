---
description: >-
  How package telemetry data collected from Umbraco installations is used to order packages
---

# Package Telemetry Data

Umbraco installations that have opted into providing basic or detailed telemetry data will indicate which packages are installed. We use that information to order packages by "Most Active Installs".

## Package Popularity

We have two measures that we can use to rank packages by popularity:

- **Total Number of NuGet Downloads** (obtained from nuget.org)
- **Number of Active Installs** (obtained from CMS package telemetry over the past 14 days)

Both of these are available for website users to select when filtering the list of packages they are reviewing.

Currently "Total Number of NuGet Downloads" is used as the measure for "Most popular" packages shown on the Marketplace home page.

We plan to switch this in the near future to use the measure of "Number of Active Installs".

## How Number of Active Installs is Collected

Umbraco installations that have opted into sending telemetry data will send information periodically to a central collection service. This may include information about packages that are installed.

On a nightly basis this information is aggregated and stored in the database that serves the Marketplace API and website.

## Package Identification

Packages are identified in the telemetry service based on one of the following:

- The package name provided in a `package.manifest` file.
- The name of the folder within `/App_Plugins/` that the package creates.

This may not be the same as the NuGet package Id.

If not, please ensure to supply the name that will be found by the package telemetry in your `umbraco-marketplace.json` file, under the `AlternatePackageNames` key. For more details see the page on [listing your package](listing-your-package.md).

For example, a package may be registered at NuGet with an Id of `Umbraco.Community.MyPackage` and create a folder at `/App_Plugins/MyPackage`. The following should be added to the `umbraco-marketplace.json` file to ensure it's telemetry data is correctly allocated:

```json
    {
      "$schema": "https://marketplace.umbraco.com/umbraco-marketplace-schema.json",
      "AlternatePackageNames": [ "MyPackage" ],
    }
```

### What if I don't have a client-side component?

Some packages may not have either of the two identifying methods available. This would normally be the case if the package is providing only server-side functionality, and is written purely in C#.

For these cases there's an option to add and register a class that ensures the name is set.

An example is shown here:

```csharp
using System.Collections.Generic;
using Umbraco.Cms.Core.Manifest;

namespace Umbraco.Community.MyPackage
{
    internal sealed class PackageManifestFilter : IManifestFilter
    {
        public void Filter(List<PackageManifest> manifests) =>
            manifests.Add(new PackageManifest
            {
                PackageName = "MyPackage",
            });
    }
}
```

The class needs to be registered as part of application startup, via an extension method (as shown here), or a composer:

```csharp
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace Umbraco.Community.MyPackage
{
    public static class UmbracoBuilderExtensions
    {
        public static IUmbracoBuilder AddMyPackage(this IUmbracoBuilder builder)
        {
            builder.ManifestFilters().Append<PackageManifestFilter>();
            return builder;
        }
    }
}
```



