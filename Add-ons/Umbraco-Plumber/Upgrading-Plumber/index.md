---
meta.Title: "Umbraco Plumber Upgrades"
meta.Description: "Information about upgrading with Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Upgrading Umbraco Plumber

This article shows how to manually upgrade Umbraco Plumber to run the latest version. Umbraco Plumber displays a prompt in the **Workflow** section when a new version is available.

## Get the latest version of Umbraco Plumber

To get the latest version of Umbraco Plumber, you can upgrade using:

- [NuGet](#nuget)
- [Visual Studio](#visual-studio)

### NuGet

- NuGet installs the latest version of the package when you use the `dotnet add package Plumber.Workflow` command unless you specify a package version:

  `dotnet add package Plumber.Workflow --version <VERSION>`

- After you have added a package reference to your project by executing the `dotnet add package Plumber.Workflow` command in the directory that contains your project file, run `dotnet restore` to install the package.

### Visual Studio

- Go to `Tools` -> `NuGet Package Manager` -> `Manage NuGet Packages for Solution...` in Visual Studio, to upgrade Umbraco Plumber:
- Select **Plumber.Workflow**.
- Select the latest version from the **Version** drop-down and click **Install**.

  ![NuGet Package Manager](images/Manage_packages_v10.png)

- When the command completes, open the **<project-name>.csproj** file to make sure the package reference is updated:

  ```xml
  <ItemGroup>
    <PackageReference Include="Plumber.Workflow" Version="10.x.x" />
  </ItemGroup>
  ```
