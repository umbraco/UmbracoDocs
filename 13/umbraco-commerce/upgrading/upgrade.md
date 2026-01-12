# Upgrading Umbraco Commerce

This article shows how to manually upgrade Umbraco Commerce to run the latest version.\
When upgrading Umbraco Commerce, be sure to also consult the [version specific upgrade](version-specific-upgrades.md) notes to learn about potential breaking changes and common pitfalls.

{% hint style="warning" %}
Before upgrading, it is always advisable to take a complete backup of your site and database.
{% endhint %}

## Get the latest version of Umbraco Commerce

To get the latest version of Umbraco Commerce you can upgrade using:

* NuGet
* Visual Studio

### NuGet

* NuGet installs the latest version of the package when you use the `dotnet add package Umbraco.Commerce` command unless you specify a package version: `dotnet add package Umbraco.Commerce --version <VERSION>`
* After you have added a package reference to your project by executing the `dotnet add package Umbraco.Commerce` command in the directory that contains your project file, run `dotnet restore` to install the package.

### Visual Studio

1. Go to `Tools` -> `NuGet Package Manager` -> `Manage NuGet Packages for Solution...` in Visual Studio, to upgrade Umbraco Commerce:
2. Select **Umbraco.Commerce**.
3. Select the latest version from the Version drop-down and click Install.
4. When the command completes, open the **.csproj** file to make sure the package reference is updated:

```xml
<ItemGroup>
  <PackageReference Include="Umbraco.Commerce" Version="xx.x.x" />
</ItemGroup>
```

If you are using one or more of the below sub-packages, they also need to be upgraded as well:

<table><thead><tr><th width="282">Sub-package</th><th>Description</th></tr></thead><tbody><tr><td><strong>Umbraco.Commerce.Common</strong></td><td>A shared project of common, non-Commerce-specific patterns and helpers.</td></tr><tr><td><strong>Umbraco.Commerce.Core</strong></td><td>Core Commerce functionality that doesn't require any infrastructure-specific dependencies.</td></tr><tr><td><strong>Umbraco.Commerce.Infrastructure</strong></td><td>Infrastructure-specific project containing implementations of core Commerce functionality.</td></tr><tr><td><strong>Umbraco.Commerce.Persistence.SqlServer</strong></td><td>Persistence-specific project containing implementations of core Commerce persistence functionality for SQL Server.</td></tr><tr><td><strong>Umbraco.Commerce.Persistence.Sqllite</strong></td><td>Persistence-specific project containing implementations of core Commerce persistence functionality for SQLite.</td></tr><tr><td><strong>Umbraco.Commerce.Web</strong></td><td>Core Commerce functionality that requires a web context.</td></tr><tr><td><strong>Umbraco.Commerce.Cms</strong></td><td>Core Commerce functionality that requires an Umbraco dependency.</td></tr><tr><td><strong>Umbraco.Commerce.Cms.Web</strong></td><td>The Commerce functionality for the Umbraco presentation layer.</td></tr><tr><td><strong>Umbraco.Commerce.Cms.Web.UI</strong></td><td>The static Commerce assets for the Umbraco presentation layer.</td></tr><tr><td><strong>Umbraco.Commerce.Cms.Startup</strong></td><td>The Commerce functionality for registering Commerce with Umbraco.</td></tr><tr><td><strong>Umbraco.Commerce</strong></td><td>The main Commerce package entry point package.</td></tr></tbody></table>
