---
description: >-
  Bringing new UI or additional features to the Backoffice is done by
  registering an Extension via an Extension Manifest.
---

# Register extensions
Whether you're looking to make extensions in the context of an Umbraco project or a package, you always need a specific JSON file for this, the umbraco-package.json file. This is the starting point of any extension.

## Umbraco-package.json
To get extensions registered in Umbraco, you need to have an `umbraco-package.json` file. This file needs to be located in `wwwroot/App_Plugins/#YOUR_EXTENSION_NAME#`. Umbraco scans for these files on boot and reads the [`extension manifests`](extension-manifest.md) that are present in the file to register the extensions.

{% hint style="info" %}
Even though the file is called umbraco-package.json and even though it will be displayed in the 'installed packages' overview in the backoffice, it does not mean that extensions can only work in the context of a package.
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

When writing the Umbraco Package Manifest, you can use the JSON Schema located in the root of your Umbraco project. The file is called `umbraco-package-schema.json`

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

There are two additional properties that are not required, but can be useful:

* `id` - a unique identifier of the package. If you are creating a NuGet package, use that as the id.
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

## Advanced registration
### The bundle approach
Instead of registering each manifest in the `umbraco-package.json` you can have multiple manifests and build them into a bundle. You then register this bundle in a single `bundle` extension. In larger projects with a lot of extensions, this allows you to keep your umbraco-package.json file leaner. Read more in the [bundle approach](../extension-types/bundle.md).

### The entry point approach
The Entry Point is an Extension that executes a method on startup. This can be used for different tasks, such as performing initial configuration and registering other Extension Manifests. Read more in [the entry point approach](../extension-types/backoffice-entry-point.md).

### Registration with JavaScript on the fly
In some cases, extensions are not static and cannot be registered in the umbraco-package.json or in a bundle. For instance, your manifest gets defined based on information from the server. Or you can even generate the manifests server side based on data in the database. In that case, you need to register extensions on the fly. 

The following example shows how to register an extension manifest via JavaScript/TypeScript code:

```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest = {
    type: '...',
    ...
};

umbExtensionsRegistry.register(extension);
```

When and where to execute this code is up to you and depending on your situation. But in a lot of cases, it makes sense to execute this on boot, using the [the entry point approach](../extension-types/backoffice-entry-point.md).
