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

"Number of Active Installs" is used as the measure for "Most popular" packages shown on the Marketplace home page.

## How Number of Active Installs is Collected

Umbraco installations that have opted into sending telemetry data will send information periodically to a central collection service. This may include information about packages that are installed.

On a regular basis this information is aggregated and stored in the database that serves the Marketplace API and website.

## Package Identification

Packages are identified in the telemetry service based on one of the following:

- The package NuGet ID provided in a [package manifest file or manifest filter](https://docs.umbraco.com/umbraco-cms/extending/property-editors/package-manifest).
- The package name provided in a package manifest file or manifest filter.
- The name of the folder within `/App_Plugins/` that the package creates.

The most reliable way of matching up a package between the Marketplace and the telemetry data is if the package NuGet Id is provided. This can be included in your manifest file or filter if your package depends on Umbraco 12 or above.

{% hint style="info" %}
If you use a manifest filter and take a dependency on a lower version of Umbraco, the `PackageManifest.PackageId` isn't available. You can still have set it for Umbraco installations that run Umbraco 12 using reflection. An example of this technique can be found within the open-source [Umbraco AuthorizedServices package](https://github.com/umbraco/Umbraco.AuthorizedServices/blob/287f284662d16cd9ae7218bae6512c7d86b36563/src/Umbraco.AuthorizedServices/Manifests/AuthorizedServicesManifestFilter.cs#L30).
{% endhint %}

Even if the package Id is provided in your package manifest, only installations of Umbraco 12 and up will use it for telemetry reporting. Older versions will use the package name or folder.

If the package name or folder is used, this may not be the same as the NuGet package ID. If not, we need to ensure your package is stored along with the alternate name that is used in the CMS and telemetry data.

It's no longer possible to supply this via the `umbraco-marketplace.json` file. The field by which this was supplied has been deprecated in the schema and if provided will no be longer imported. This was due to the risks of two package developers providing the same alternate names.

Instead we maintain this list at HQ. You may own a package that appears to not rank as expected via the "most active installs" measure. If you suspect it's due to the telemetry data not being correctly allocated, let us know. We can make the necessary updates such that it's popularity is properly reflected. You can reach us at [packages@umbraco.com](mailto:packages@umbraco.com) and tell us the name used for your package in the package manifest or folder.

### What if I don't have a client-side component?

Some packages may not have either a `package.manifest.json` file nor create a folder in `/App_Plugins/`. This would normally be the case if the package is providing only server-side functionality, and is written purely in C#.

For these cases there's an option to add and register a manifest filter that ensures the name and Id is set.

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
                PackageId = "MyPackage",
                PackageName = "My Package",
            });
    }
}
```

The class needs to be registered as part of the application startup, via a composer or an extension method as shown here:

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
