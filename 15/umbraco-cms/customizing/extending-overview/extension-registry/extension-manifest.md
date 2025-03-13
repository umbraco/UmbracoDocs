---
description: Learn about the different methods for declaring an Extension Manifest.
---

# Extension Manifest

The Extension Manifest is the first step for any extension. It is the declaration of what you want to register.

In this section you will find all the Extension Types provided by the Backoffice. [See all Extension Types here.](../extension-types/)

### Extension Manifest Format

An Extension Manifest can be written as a JavaScript or JSON Object.

There are a few general properties, the required set of properties consists of the `type`, `alias`, and `name`.

```typescript
const manifest = {
    type: '...',
    alias: 'my.customization',
    name: 'My customization'
    ...
};
```

The `type` defines what it is declaring. The `alias` is a unique identifier for this manifest. It must be globally unique, so make sure to prefix it with something that makes your extension unique. The `name` is a representational name of this manifest, this does not need to be unique but such can be beneficial when debugging extensions.

### Manifest Data

Each Extension Manifest has to declare its type. This is used to determine where it hooks into the system. It also determines what data is required of this manifest.

The abilities of the extensions rely on the specific extension type. The Type sets the scene for what the extension can do and what it needs to be utilized. Some extension types can be made purely via the manifest. Other requires files, like a JavaScript file containing a Web Component.

The required fields of any extension manifest are:

* `type` - The type defines the type and purpose of the extension. It is used to determine where the extension will be used and defines the data needed for this manifest.
* `alias`- The alias is used to identify the extension. This has to be unique for each extension.
* `name` - The name of the extension. This is used to identify the extension in the UI.

Additionally, many extensions support the use of the following fields:

* `weight` - Define a weight, to determine the importance or visual order of this extension. The higher the weight, the higher in the list it will appear.
* `overwrites` - Define one or more Extension Aliases that this extension should replace. Notice it only omits the listed Extensions when this is rendered in the same spot. [Read more in Replace, Exclude or Unregister](replace-exclude-or-unregister.md).
* `conditions` - Define one or more conditions that must be permitted for the extension to become available. [Extension Conditions](../extension-conditions/extension-conditions.md).
* `kind` - Define a kind-alias of which this manifest should be based upon. Kinds acts like a preset for your manifest. [Extension Kinds](../extension-kind.md).

Many of the Extension Types require additional information declared as part of a `meta` field.

### Registration

An Extension Manifest can be registered in multiple ways.

The primary registration should take part of the Umbraco Package Manifest.

You can choose to declare all Extensions in the Package Manifest, or use one of three Extension Types to registere more extensions.

This enables you to locate your Manifests in files together with the implementation code and the ability to declare Extension Manifests in TypeScript.

A typical structure would be to declare one or more `Bundle` extensions in the Package Manifest. Each of the Bundles points to a `manifests.js` file which declares the Extensions of interest.

#### The `bundle` extension type

The Bundle extension type is used to declare multiple Extension Manifests from a single JavaScript file.

The Bundle is loaded at startup. All the Extension Manifests exported of the JavaScript file will be registered.

Read more about the `bundle` extension type in the [Bundle](../../../extending/extending-overview/extension-registry/bundle.md)[ ](../extension-types/bundle.md)article.

#### The `backofficeEntryPoint` extension type

Run any JavaScript code when Backoffice startups, after the user is logged in. This can be used as an entry point for a package, registering more extensions or configuring your package.

There are many use cases. To name a few, it could be to load external libraries shared by all your extensions or load **global CSS files** for the whole application.

The entry point declares a single JavaScript file that will be loaded and run when the Backoffice starts.

Read more about the `backofficeEntryPoint` extension type in the [Entry Point](extension-manifest.md#the-backofficeentrypoint-extension-type) article.

#### The `appEntryPoint` extension type

Similar as `appEntryPoint` this runs as startup, the difference is that this runs before the user is logged in. Use this to initiate things before the user is logged in or to provide things for the Login screen.

## Type intellisense

It is recommend to make use of the Type intellisense that we provide.

When writing your Manifest in TypeScript you should use the Type `UmbExtensionManifest`, see the [TypeScript setup](../../development-flow/typescript-setup.md) article to make sure you have Types correctly configured.

<pre class="language-typescript"><code class="lang-typescript">export const manifests: Array&#x3C;UmbExtensionManifest> = [
<strong>    {
</strong>        type: '...',
        alias: 'my.customization',
        name: 'My customization'
        ...
    },
    ...
];
</code></pre>

When writing the Umbraco Package Manifest you can use the JSON Schema located in the root of your Umbraco project called `umbraco-package-schema.json`

```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "Fast Track Customizations",
    "extensions": [
        {
            "type": "...",
            "alias": "my.customization",
            "name": "My customization"
            ...
        },
        ...
    ]
}
```

### Registration via any JavaScript code

Alternatively, an Extension Manifest can be declared in JavaScript at any given point.

The following example shows how to register an extension manifest via JavaScript code:

```typescript
import { umbExtensionsRegistry } from "@umbraco-cms/backoffice/extension-registry"

const manifest = {
    type: '...',
    ...
};

umbExtensionsRegistry.register(extension);
```
