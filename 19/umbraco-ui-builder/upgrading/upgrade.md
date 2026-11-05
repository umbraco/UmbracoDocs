---
description: Learn how to manually upgrade Umbraco UI Builder to the latest version.
---

# Upgrading Umbraco UI Builder

This article explains how to manually upgrade Umbraco UI Builder to the latest version. Before upgrading Umbraco UI Builder, see the [Version Specific Upgrade Notes](version-specific.md) for potential breaking changes and common pitfalls.

{% hint style="warning" %}
Before upgrading, take a complete backup of your site and database.
{% endhint %}

## Get the latest version of Umbraco UI Builder

To get the latest version of Umbraco UI Builder, you can upgrade using either of the two options:

- [NuGet](#nuget)
- [Visual Studio](#visual-studio)

### NuGet

- To install the latest version via NuGet:

```sh
dotnet add package Umbraco.UIBuilder
```

- To specify a package version:

```sh
dotnet add package Umbraco.UIBuilder --version <VERSION>
```

- After adding the package reference, restore dependencies:

```sh
dotnet restore
```

### Visual Studio

1. Open Visual Studio.
2. Navigate to `Tools` -> `NuGet Package Manager` -> `Manage NuGet Packages for Solution...`.
3. Select **Umbraco.UIBuilder**.
4. Choose the latest version from the drop-down and click **Install**.
5. After installation, verify the update in your **.csproj** file:

```xml
<ItemGroup>
  <PackageReference Include="Umbraco.UIBuilder" Version="xx.x.x" />
</ItemGroup>
```

## Upgrade Sub-Packages

If you are using any of the following sub-packages, upgrade them as well:

| Sub-package | Description |
| -- | -- |
| Umbraco.UIBuilder.Core | Core functionality without infrastructure dependencies |
| Umbraco.UIBuilder.Infrastructure | Infrastructure-specific implementations |
| Umbraco.UIBuilder.Web | Core logic requiring a web context |
| Umbraco.UIBuilder.Web.StaticAssets |Static assets for the presentation layer |
| Umbraco.UIBuilder.Startup | Registers UI Builder with Umbraco |
| Umbraco.UIBuilder | The main UI Builder package |
