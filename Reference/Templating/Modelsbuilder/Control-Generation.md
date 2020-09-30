---
versionFrom: 8.5.0
---

# Control Models Generation

Generation of models can be controlled through various C# attributes in the custom files.

These features are only available on the full version of the [Models Builder](https://github.com/zpqrtbnk/Zbu.ModelsBuilder).

## Installing the Full Version of Models Builder
The full version can be installed with the following nuget packages.  

### Umbraco.ModelsBuilder
Note - Version 8.x of the `Umbraco.ModelsBuilder` package is for Umbraco 8.  Version 3.x is for Umbraco 7.

[Umbraco.ModelsBuilder](https://www.nuget.org/packages/Umbraco.ModelsBuilder/) - this is the core package for the full version of Models Builder and will disable the Umbraco version of Models Builder, and will remove the Umbraco version of the "Models Builder" dashboard UI from the "Settings" section.
```
Install-Package Umbraco.ModelsBuilder
```

### Umbraco.ModelsBuilder.Ui
[Umbraco.ModelsBuilder.Ui](https://www.nuget.org/packages/Umbraco.ModelsBuilder.Ui/)
This package is optional and will add the "Models Builder" dashboard UI for the full version into the "Settings" section of the Umbraco back office.

NB - if you just install this, then `Umbraco.ModelsBuilder` will automatically get installed as a dependency.
```
Install-Package Umbraco.ModelsBuilder.Ui
```

