---
meta.Title: Maintaining Umbraco Packages
description: >-
  Once you've created and published your package, here is what's involved in
  it's ongoing maintenance
---

# Maintaining packages

Once you've created and published your package, what's involved in its ongoing maintenance?

## Updating with new Umbraco major versions

Umbraco will regular release update to the CMS as patch or minor versions. These are verified to be backwards compatible. As such there's no expectation that a package may break when a new version of this type comes out.

When a new major version of Umbraco is released, there will be breaking changes. You should test your package on this latest version to confirm it still works. Unless there's been a significant change to the CMS, many packages will continue to work with the new major version without any update. However you may be using a service or API that has undergone a breaking change.

If this happens, the changes will be documented and you should be able to update your code, recompile and test. After that you can release a new major version of your own package.

Even if there are no breaking changes that affect you, it's worth also looking for any code you using that is marked as obsolete. Umbraco will obsolete public methods or constructors that are expected to be removed in a future major version.

### Referencing Umbraco dependencies

When creating a package with Umbraco you will be taking a dependency on at least one Umbraco package. You will do this in the `.csproj` file for your package:

```xml
<PackageReference Include="Umbraco.Cms.Web.BackOffice" Version="10.0.0" />
```

As indicated, this states the package is compatible with Umbraco 10 and any future version. This would allow the developer to install the package into an Umbraco 12 or 13 solution for example.

If you want to maintain tighter control over this, you can specify an upper bound, like this:

```xml
<PackageReference Include="Umbraco.Cms.Web.BackOffice" Version="[10.0.0, 13)" />
```

This states that the package is compatible with Umbraco 10, 11 and 12, but not 13. Thus it prevents anyone installing your package into an Umbraco solution that you haven't verified compatibility with.  Once you have, you can increase the bound or otherwise update the dependent Umbraco version as appropriate.

## Manage feature requests and issues

If you want to encourage feedback, feature requests, and issue reports then you should make available an issue tracker.

This can be [provided as information about your package](https://docs.umbraco.com/umbraco-dxp/marketplace/listing-your-package) and will be linked from your package's page on the Umbraco Marketplace. Specifically you should populate the `IssueTrackerUrl` field.

## Package no longer required?

After some time it could be that your package should no longer be used. Perhaps it is now too old, or it has been superseded by another one that you recommend instead.

You can indicate this by [deprecating your package on NuGet](https://learn.microsoft.com/en-us/nuget/nuget-org/deprecate-packages).
