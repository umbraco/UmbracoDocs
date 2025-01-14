# Upgrade Umbraco Engage

This article shows how to upgrade Umbraco Engage to the latest version.

When upgrading Umbraco Engage, you can consult the [version specific upgrade](version-specific-upgrade-notes.md) notes to learn about potential breaking changes and common pitfalls.

{% hint style="warning" %}
Before you upgrade, it is recommended that your site and database be backed up.
{% endhint %}

## Get the latest version of Umbraco Engage

To upgrade to the latest version of Umbraco Engage you can use:

* NuGet
* Visual Studio

### NuGet

1. Install the latest version using the `dotnet add package Umbraco.Engage` command.
    * You can also specify version: `dotnet add package Umbraco.Engage --version <VERSION>`.
2. Run `dotnet restore` to install the package.

### Visual Studio

1. Go to `Tools` -> `NuGet Package Manager` -> `Manage NuGet Packages for Solution...` in Visual Studio.
2. Select **Umbraco.Engage**.
3. Select the latest version from the Version drop-down and click **Install**.

When the task completes, open the **.csproj** file to make sure the package reference is updated:

```xml
<ItemGroup>
  <PackageReference Include="Umbraco.Engage" Version="xx.x.x" />
</ItemGroup>
```

If you are using one or more of the below sub-packages, they also need to be upgraded as well:

| Sub-package | Description |
| -- | -- |
| Umbraco.Engage.Core | Core Engage functionality that doesn't require any infrastructure-specific dependencies. |
| Umbraco.Engage.Infrastructure | Infrastructure-specific project containing implementations of core Engage functionality. |
| Umbraco.Engage.Web | The core Engage logic that requires a web context. |
| Umbraco.Engage.Data | |
| Umbraco.Engage.Common | |
| Umbraco.Engage.Forms | A package that extends Umbraco Engage with Umbraco Forms. |
| Umbraco.Engage.Headless | A package that adds headless functionality to Umbraco Engage. |
| Umbraco.Engage.Commerce | A package that extends Umbraco Engage with Umbraco Commerce. |
