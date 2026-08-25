---
description: >-
  Detailed instructions on how to install and configure Deploy into your Umbraco
  Commerce implementation.
---

# Installation

The Umbraco Commerce Deploy package can be installed directly into your project's code base using our NuGet packages.

## NuGet Package Installation

To install the Umbraco Commerce Deploy package via NuGet run the following command directly in the NuGet Manager Console window using Visual Studio:

```bash
PM> Install-Package Umbraco.Commerce.Deploy
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager.

![Installing Umbraco Commerce Deploy via the NuGet Package Manager](../media/deploy/nuget\_package.png)

### Upgrading

Umbraco Commerce Deploy does not consist of any UI files or database changes. It is generally ok to install the upgrade on top of a previous install.
