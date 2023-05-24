---
description: >-
  Detailed instructions on how to install and configure Deploy into your Umbraco
  Vendr implementation.
---

# Installation

The Vendr Deploy package can be installed directly into your project's code base using our NuGet packages.

## NuGet Package Installation

To install the Vendr Deploy package via NuGet run the following command directly in the NuGet Manager Console window using Visual Studio:

```bash
PM> Install-Package Vendr.Deploy
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager.

![Installing Vendr Deploy via the NuGet Package Manager](../media/deploy/nuget\_package.png)

### Upgrading

Vendr Deploy does not consist of any UI files or database changes. It is generally ok to install the upgrade on top of a previous install.
