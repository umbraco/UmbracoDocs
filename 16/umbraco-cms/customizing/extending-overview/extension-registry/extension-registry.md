---
description: >-
  Bringing new UI or additional features to the Backoffice is done by
  registering an Extension via an Extension Manifest.
---

# Register an Extension

Whether you're looking to make a single correction or a package, it is done via a file on the server that we call Umbraco Package JSON. This will be your starting point.

## Umbraco-package.json

In this file, you declare a name for the Package and declare one or more [`extension manifests`](extension-manifest.md).

```json
{
    "name": "My Customizations",
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

When writing the Umbraco Package Manifest, you can use the JSON Schema located in the root of your Umbraco project. The file is called `umbraco-package-schema.json`

```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My Customizations",
    "extensions": [
        ...
    ]
}
```

## Declare Extensions in JavaScript/TypeScript

Are you looking for as much help as you can get, or to make a bigger project? Then it's recommended to spend the time setting up a TypeScript Project for your Customizations. [Read more about Development Setups here](../../development-flow/).

TypeScript gives IntelliSense for everything, acting as documentation.

The following example demonstrates how you can configure your `umbraco-package.json` file to point to a single JavaScript/TypeScript file that declares all your Manifests.

There are two approaches for declaring Manifests in JavaScript/TypeScript. Read more about each option:

### [The Bundle approach](../extension-types/bundle.md)

The Bundle is an Extension that declares one or more Extension Manifests.

### [The Entry Point approach](../extension-types/backoffice-entry-point.md)

The Entry Point is an Extension that executes a method on startup. This can be used for different tasks, such as performing initial configuration and registering other Extension Manifests.

### Registration via any JavaScript code

Once you have running code, you can declare an Extension Manifest at any given point.

It's not a recommended approach, but for some cases, you may like to register and unregister Extensions on the fly. The following example shows how to register an extension manifest via JavaScript/TypeScript code:

```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest = {
    type: '...',
    ...
};

umbExtensionsRegistry.register(extension);
```
