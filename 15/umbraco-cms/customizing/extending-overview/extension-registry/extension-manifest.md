---
description:
---

# Extension Manifest

Each Extension Manifest has to declare its type, this is used to determine where it hooks into the system. It also looks at what data is required to declare within it.

The abilities of the extensions rely on the specific extension type. The Type sets the scene for what the extension can do and what it needs to be utilized. Some extension types rely on a reference to other extensions.

The following overview lists all the available extension types:

{% content-ref url="../extension-types/" %}
[extension-types](../extension-types/)
{% endcontent-ref %}


## Extension Manifest Format

A Extension Manifest can be written either as JavaScript Object or a JSON Object.

There is a few general properties, the required set of properties consists of the `type`, `alias` and `name`.

```typescript
const manifest = {
    type: '...',
    alias: 'my.customization',
    name: 'My customization'
    ...
};
```

The `type` defined what it is declaring
The `alias` is a unique identifier for this manifest. It must be globally unique, so make sure to prefix with something that makes your extension unique.
The `name` is a representational name of this manifest, this does not need to be unique but such can be beneficial when debugging extensions.

## Declare Extension Manifest

Extension Manifest and can be declared in multiple ways. One of these is to declare it as part of the [Umbraco Package Manifest](../../package-manifest.md).

You can declare new Extension Manifests in JavaScript at any given point.

```typescript
import { umbExtensionsRegistry } from "@umbraco-cms/backoffice/extension-registry"

const manifest = {
    type: '...',
    ...
};

umbExtensionsRegistry.register(extension);
```

Backoffice also comes with two Extension types which can be used to register more extensions.

### Using `bundle` to declare other Extension Manifest

The bundle extension type can be used for declaring multiple Extension Manifests with JavaScript in a single file.

The bundle declares a single JavaScript file that will be loaded at startup. All the Extension Manifests exported from this Module will be registered in the Extension Registry.

Read more about the `bundle` extension type in the [Bundle](../extension-types/bundle.md) article.

### Using `backofficeEntryPoint` as your foundation

The `backofficeEntryPoint` extension type is special, it can be used to run any JavaScript code at startup.\
This can be used as an entry point for a package.\
The entry point declares a single JavaScript file that will be loaded and run when the Backoffice starts.

The `entryPbackofficeEntryPointoint` extension is also the way to go if you want to load in external libraries such as jQuery, Angular, React, etc. You can use the `backofficeEntryPoint` to load in the external libraries to be shared by all your extensions. Loading **global CSS files** can also be used in the `backofficeEntryPoint` extension.

Read more about the `backofficeEntryPoint` extension type in the [Entry Point](../extension-types/entry-point.md) article.
