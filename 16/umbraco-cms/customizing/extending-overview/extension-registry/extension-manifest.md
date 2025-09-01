---
description: Learn about the different methods for declaring an Extension Manifest.
---

# Extension Manifest
This page explains how to author Extension Manifests for Umbraco backoffice extensions.
It outlines the manifest structure, required fields, and optional features used across types.

## What is an Extension Manifest?
An Extension Manifest declares a single backoffice extension and its configuration.
Umbraco reads the manifest to register the extension in the Extension Registry.
The chosen extension type determines required fields and available capabilities.
Some extensions need extra assets, like a JavaScript file with a Web Component.

## Extension Manifest Format
An Extension Manifest has a strict format where some properties are required and some depend on the Extension Type. An Extension Manifest can be written as a JavaScript or JSON Object. We'll dive deeper into that when [registering an extension](extension-registry).

The abilities of the extensions rely on the specific extension type. The Type sets the scene for what the extension can do and what it needs to be utilized. Some extension types can be made purely via the manifest, like a section or menu item. Other types require files, like a JavaScript file containing a Web Component, like a custom property editor.

### Required Manifest properties
A minimal Extension Manifest looks like this (in JSON formatting):

```json
{
    "type": "...",
    "alias": "my.customization",
    "name": "My customization"
}
```

These fields are all required and have the following meaning:

* `type` — The type defines the purpose of the extension. Umbraco has many [extension types](../extension-types) available.
* `alias` — This is a unique identifier for this manifest. Prefix it with something that makes your extension unique. For example: _FictiveCompany.MyProject.Dashboard.Overview_.
* `name` — This is a representational name of this manifest; It does not need to be unique, but this can be beneficial when debugging extensions. This name also shows up in the Extensions Insights in the backoffice of Umbraco. For example: _My Fictive Company Overview Dashboard_.

### Additional Manifest properties
Most extension types support the use of the following generic features for their Manifest:

* `weight` - Define a weight to determine the importance or visual order of this extension. A higher weight gives a more prominent position. For instance, for a dashboard it determines it's order between other dashboards.
* `overwrites` - If replacing an existing extension, this define one or more Extension Aliases that this extension should replace. Read more in [Replace, Exclude or Unregister extensions](replace-exclude-or-unregister.md).
* `conditions` - Define one or more conditions that must pass for the extension to become available. For instance, don't show a section if you don't have the proper rights. Read more in [Extension Conditions](../extension-conditions.md). 
* `kind` - Some extension types can reference a predefined Kind. By specifying a Kind, the manifest inherits the Kind's properties. This allows for reuse of predefined settings. See [Extension Kind](../extension-kind.md).
* `meta` - Many Extension Types require additional information declared as part of a `meta` field. It depends on the extension what is required. For instance label and icon of a menu item.

For more information, see an overview of all possible [Extension Types](../extension-types/) and their requirements.


---- Below should be moved or removed, because it requires too much context for this file -----

## Type intellisense
It is recommended to make use of the Type IntelliSense that we provide.

When writing your Manifest in TypeScript, you should use the Type `UmbExtensionManifest`. See the article on [Development Setup](../../development-flow/) to ensure you have Types correctly configured.

{% code title="manifests.ts" %}
```typescript
export const manifests: Array<UmbExtensionManifest> = [
    {
        type: '...',
        alias: 'my.customization',
        name: 'My customization'
        ...
    }
]
```
{% endcode %}

When writing the Umbraco Package Manifest, you can use the JSON Schema located in the root of your Umbraco project called `umbraco-package-schema.json` .

```json
{
    "$schema": "../../umbraco-package-schema.json",
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

