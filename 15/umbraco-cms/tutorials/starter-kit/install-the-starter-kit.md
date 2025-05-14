# Install the Starter Kit

Installing the Starter Kit provides a pre-built set of templates, content types, and demo content to explore or kickstart your Umbraco project.

## Outcome

You’ll have the Umbraco Starter Kit installed in your local project, ready to explore in the backoffice. This setup adds example content and templates, perfect for learning or quick prototyping.

## Steps

You can install the Starter Kit in two ways, depending on your preference:

* [Option 1: Install via .NET CLI](#option-1-install-via-net-cli)
* [Option 2: Install via Visual Studio](#option-2-install-via-visual-studio)

### Option 1: Install via .NET CLI

To install the Starter Kit via the .Net CLI, follow these steps:

1. Open a terminal in your Umbraco project folder.
2. Run the following command to add the Starter Kit package:

```bash
dotnet add package Umbraco.TheStarterKit
```

3. Build the project:

```bash
dotnet build
```

4. Run the project:

```bash
dotnet run
```

5. Go to `https://localhost:xxxx/` to view the Starter Kit content.

### Option 2: Install via Visual Studio

To install the starter Kit via Visual Studio, follow these steps:

1. Open your Umbraco project in Visual Studio.
2. Go to **Tools** -> **NuGet Package Manager** -> **Manage NuGet Packages for Solution...**.
3. Browse for **Umbraco.TheStarterKit**.
4. Select the appropriate version from the Version drop-down depending on the Umbraco version you are using.
5. Click **Install**.
6. Open the **.csproj** file to make sure the package reference is added:

```xml
<ItemGroup>
<PackageReference Include="Umbraco.TheStarterKit" Version="xx.x.x" />
</ItemGroup>
```

## Summary

You now have a fully functional Umbraco site with demo content, templates, and structure to explore. Use this setup as the foundation for the upcoming lessons in this Starter Kit tutorial.

[Back to Lessons](./)
