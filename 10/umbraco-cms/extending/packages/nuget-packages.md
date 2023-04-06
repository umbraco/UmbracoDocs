---
description: "Umbraco packages use the familiar NuGet format and method of distribution."
---

# NuGet Packages

All Umbraco packages for Umbraco 10+ are distributed as NuGet packages.

A NuGet package is a standard way of delivering compiled code and configuration to a .NET project. NuGet packages contain dlls and other files required for the solution. For more information on NuGet packages see Microsoft's [An introduction to NuGet](https://docs.microsoft.com/en-us/nuget/what-is-nuget) documentation.

NuGet packages can be installed via the command line using a command like the following:

```none
dotnet add package MyPackage --version 1.2.0
```

Alternatively, they can be installed through the [Package Manager Console](https://docs.microsoft.com/en-us/nuget/consume-packages/install-use-packages-powershell) within Visual Studio using a command similar to the one below:

```none
PM> Install-Package MyPackage -version 1.2.0
```