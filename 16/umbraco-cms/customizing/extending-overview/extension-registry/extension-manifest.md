---
description: Learn about the different methods for declaring an Extension Manifest.
---

# Extension Manifest

The Extension Manifest is the first step for any extension. It is the declaration of what you want to register.

In this section, you will find all the Extension Types provided by the Backoffice. [See all Extension Types here.](../extension-types/)

## Extension Manifest Format

An Extension Manifest can be written as a JavaScript or JSON Object.

The abilities of the extensions rely on the specific extension type. The Type sets the scene for what the extension can do and what it needs to be utilized. Some extension types can be made purely via the manifest. Other types require files, like a JavaScript file containing a Web Component.

```typescript
{
    type: '...',
    alias: 'my.customization',
    name: 'My customization'
    ...
};
```

The required fields of any Extension Manifest are:

* `type` — The type defines the purpose of the extension. It is used to determine where the extension will be used.
* `alias` — This is a unique identifier for this manifest. Prefix it with something that makes your extension unique. Example: `mfc.Dashboard.Overview` .
* `name` — This is a representational name of this manifest; It does not need to be unique, but this can be beneficial when debugging extensions. Example: `My Fictive Company Overview Dashboar` .

### Additional Manifest features

Most extension types support the use of the following generic features for their Manifest:

* `weight` - Define a weight to determine the importance or visual order of this extension. A higher weight gives a more prominent position.
* `overwrites` - Define one or more Extension Aliases that this extension should replace. Notice it only omits the listed Extensions when this is rendered in the same spot. [Read more in Replace, Exclude or Unregister](replace-exclude-or-unregister.md).
* `conditions` - Define one or more conditions that must be permitted for the extension to become available. [Extension Conditions](../extension-conditions.md).
* `kind` - Define a kind-alias of which this manifest should be based upon. Kind acts like a preset for your manifest. [Extension Kinds](../extension-kind.md).

Many of the Extension Types require additional information declared as part of a `meta` field.

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

