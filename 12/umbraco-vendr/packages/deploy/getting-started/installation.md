---
title: Installation
description: Installing Vendr Deploy, an add-on package for Vendr, the eCommerce solution for Umbraco v8+
---

Vendr Deploy can be installed directly into your projects code base using our NuGet packages. 

## NuGet Package Installation

To install the Vendr Deploy package via NuGet you can run the following command directly in the NuGet Manager Console window:

```bash
PM> Install-Package Vendr.Deploy
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager GUI.

![Installing Vendr Deploy via the NuGet Package Manager GUI](/media/screenshots/deploy/nuget_package.png)

## Upgrading

Vendr Deploy doesn't consist of any UI files, or database changes so it is generally ok to install the upgrade over the top of a previous install.