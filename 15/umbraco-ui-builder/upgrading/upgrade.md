# Upgrading Umbraco UI Builder

This article shows how to manually upgrade Umbraco UI Builder to run the latest version.
When upgrading Umbraco UI Builder, be sure to also consult the [version specific upgrade](version-specific.md) notes to learn about potential breaking changes and common pitfalls.

{% hint style="warning" %}
Before upgrading, it is always advisable to take a complete backup of your site and database.
{% endhint %}

## Get the latest version of Umbraco UI Builder

To upgrade to the latest version of Umbraco UI Builder you can use:

- NuGet
- Visual Studio

### NuGet

- NuGet installs the latest version of the package when you use the `dotnet add package Umbraco.UIBuilder` command unless you specify a package version: `dotnet add package Umbraco.UIBuilder --version <VERSION>`

- After you have added a package reference to your project by executing the `dotnet add package Umbraco.UIBuilder` command in the directory that contains your project file, run `dotnet restore` to install the package.


### Visual Studio

1. Go to `Tools` -> `NuGet Package Manager` -> `Manage NuGet Packages for Solution...` in Visual Studio, to upgrade Umbraco UI Builder:
2. Select **Umbraco.UIBuilder**.
3. Select the latest version from the Version drop-down and click Install.
4. When the command completes, open the **.csproj** file to make sure the package reference is updated:

```xml
<ItemGroup>
  <PackageReference Include="Umbraco.UIBuilder" Version="xx.x.x" />
</ItemGroup>
```

If you are using one or more of the below sub-packages, they also need to be upgraded as well:

| Sub-package | Description |
| -- | -- |
| Umbraco.UIBuilder.Core | Core UI Builder functionality that doesn't require any infrastructure-specific dependencies |
| Umbraco.UIBuilder.Infrastructure | Infrastructure-specific project containing implementations of core UI Builder functionality |
| Umbraco.UIBuilder.Web | The core UI Builder logic that requires a web context |
| Umbraco.UIBuilder.Web.StaticAssets | The static assets for the UI Builder presentation layer |
| Umbraco.UIBuilder.Startup | The main logic for registering UI Builder with Umbraco |
| Umbraco.UIBuilder | The main UI Builder package |