---
description: Installing Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Installation

Umbraco UI Builder is installed via the NuGet package manager by issuing the following command in your web project.

```bash
dotnet add package Umbraco.UIBuilder
```

If you wish to install Umbraco UI Builder into a class library without the UI elements, you can add a reference to the `Umbraco.UIBuilder.Startup` package instead.

```bash
dotnet add package Umbraco.UIBuilder.Startup
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager graphical user interface (GUI)  in Visual Studio.

## Installing a License

See the [Licensing page](licensing-model.md#installing-your-license) for details on how to install a license.
