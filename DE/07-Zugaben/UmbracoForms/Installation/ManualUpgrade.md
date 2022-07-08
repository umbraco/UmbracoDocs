---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Manual upgrade of Umbraco Forms

This article will show how to manually upgrade Umbraco Forms to run the latest version with Umbraco 9.

## Get the latest version of Umbraco Forms

To get the latest version of Umbraco Forms you will need to upgrade using NuGet.

NuGet installs the latest version of the package when you use the `dotnet add package` command unless you specify a package version:

`dotnet add package Umbraco.Forms --version <VERSION>`

After you have added a package reference to your project by executing the `dotnet add package Umbraco.Forms` command in the directory that contains your project file, run `dotnet restore` to install the package.

You can also update forms through the `NuGet Package Manager` in Visual studio:

![NuGet Package Manager](images/Manage_packages.png)

When the command completes, open the **.csproj** file to make sure the package reference was updated:

```xml
<ItemGroup>
  <PackageReference Include="Umbraco.Forms" Version="9.0.1" />
</ItemGroup>
```
