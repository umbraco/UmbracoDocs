---
versionFrom: 8.5.0
---

# Install the full version of the Models Builder

In this article you will find instructions on how to install the full version of the Models Builder to your Umbraco project.

The full version can be installed with the following NuGet packages.

## Umbraco.ModelsBuilder

:::note
Version 8.x of the `Umbraco.ModelsBuilder` package is for Umbraco 8.  Version 3.x is for Umbraco 7.
:::

[Umbraco.ModelsBuilder](https://www.nuget.org/packages/Umbraco.ModelsBuilder/) - this is the core package for the full version of Models Builder and will disable the Umbraco version of Models Builder, and will remove the Umbraco version of the "Models Builder" dashboard UI from the "Settings" section.

```xml
Install-Package Umbraco.ModelsBuilder
```

## Umbraco.ModelsBuilder.Ui

[Umbraco.ModelsBuilder.Ui](https://www.nuget.org/packages/Umbraco.ModelsBuilder.Ui/)

This package is optional and will add the "Models Builder" dashboard UI for the full version into the "Settings" section of the Umbraco backoffice.

If you only install this, then `Umbraco.ModelsBuilder` will automatically get installed as a dependency.

```xml
Install-Package Umbraco.ModelsBuilder.Ui
```
