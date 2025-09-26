---
description: >-
  Bringing new UI or additional features to the Backoffice is done by
  registering an Extension via an Extension Manifest.
---


# Register Extensions
Making extensions to either an Umbraco project or a package requires an umbraco-package.json file. This JSON file is the starting point for any extension.

## Umbraco-package.json
To get extensions registered in Umbraco, you need to have an `umbraco-package.json` file. This file must be located in or in a subfolder of either the `App_Plugins` folder or the `wwwroot` folder. It's recommended to place the file in `App_Plugins/#YOUR_EXTENSION_NAME#/umbraco-package.json`, or in `wwwroot/App_Plugins/#YOUR_EXTENSION_NAME#/umbraco-package.json` for packages and Razor Class Libraries. Umbraco scans for these files on boot and reads the [`Extension Manifests`](extension-manifest.md) that are present in the file to register the extensions.

{% hint style="info" %}
Extensions can also work outside of the context of a package.
{% endhint %}

{% code title="umbraco-package.json" %}
```json
{
    "name": "My Customizations",
    "extensions": [
        {
            "type": "...",
            "alias": "my.customization.extension1",
            "name": "My customization extension 1"
            ...
        },
        ...
    ]
}
```
{% endcode %}


When writing the Umbraco Package Manifest, you can use the JSON schema located in the root of your Umbraco project. This file is called `umbraco-package-schema.json`.

{% code title="umbraco-package.json" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My Customizations",
    "extensions": [
        ...
    ]
}
```
{% endcode %}


There are two additional, optional properties that can be useful:

* `id` - a unique identifier of the package. If you are creating a NuGet package, use this value as the id.
* `version` - the version of the package that is displayed in the backoffice in the overview of installed packages. This is also used for package migrations.


This is an example of a full umbraco-package.json that registers two localization extensions:

```json
{
  "$schema": "../../umbraco-package-schema.json",
  "id": "MyCustomizations",
  "name": "My Customizations",
  "version": "16.0.0",
  "extensions": [
    {
      "type": "localization",
      "alias": "MyCustomizations.Localize.EnUS",
      "name": "English",
      "meta": {
        "culture": "en"
      },
      "js": "/App_Plugins/MyCustomizations/localization/en.js"
    },
    {
      "type": "localization",
      "alias": "MyCustomizations.Localize.NlNl",
      "name": "Danish",
      "meta": {
        "culture": "dk"
      },
      "js": "/App_Plugins/MyCustomizations/localization/dk.js"
    }
  ]
}
```


## Advanced Registration
### The Bundle Approach
Instead of registering each manifest in the `umbraco-package.json`, you can have multiple manifests and build them into a bundle. You then register this bundle in a single `bundle` extension. In larger projects with a lot of extensions, this allows you to keep your umbraco-package.json file leaner. Read more in the [bundle approach](../extension-types/bundle.md).

### The Entry Point Approach
The Entry Point is an extension that executes a method on startup. You can use this for different tasks, such as performing initial configuration and registering other Extension Manifests. Read more in [the entry point approach](../extension-types/backoffice-entry-point.md).

### Registration with JavaScript on the Fly
In some cases, extensions are not static and cannot be registered in the umbraco-package.json or in a bundle.  Here are some examples of these cases:

- your manifest might be defined based on information from the server
- you might generate the manifests server side based on data in the database. 

In cases such as these, you need to register extensions on the fly.


The following example shows how to register an Extension Manifest via JavaScript/TypeScript code:

```typescript

import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest = {
  type: '...',
  // ...
};

umbExtensionsRegistry.register(manifest);
```


When and where you execute this code depends on your situation. In many cases, it makes sense to execute this on boot, using the [entry point approach](../extension-types/backoffice-entry-point.md).
