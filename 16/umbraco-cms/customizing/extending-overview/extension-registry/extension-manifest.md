---
description: Learn about the different methods for declaring an Extension Manifest.
---

# Extension Manifest
This page explains what an Extension Manifest for a Umbraco backoffice extension is. It outlines the manifest structure, required fields, and optional features used across types.

## What is an Extension Manifest?
This page explains what an Extension Manifest for Umbraco backoffice extensions is. It outlines the manifest structure, required fields, and optional features used across types.
Umbraco reads the extension manifest to register the extension in the Extension Registry.
Each extension is of a certain type and this determines the required fields of the manifest and its available capabilities.
An Extension Manifest declares a single backoffice extension along with its configuration.

## Extension Manifest Format
Some extensions need extra assets, such as a JavaScript file with a Web Component.

The abilities of the extensions rely on the specific extension type. The type sets the scene for what the extension can do and what it needs to be utilized. Some extension types can be made purely via the manifest, like a section or menu item. Other types require files, like a JavaScript file containing a Web Component, like a custom property editor.
An Extension Manifest has a strict format where some properties are required and some depend on the Extension Type. An Extension Manifest can be written as a JavaScript or JSON object. You can learn more about this when [registering an extension](extension-registry).
### Required Manifest properties
A minimal Extension Manifest looks like this:

```json
{
    "type": "...",
    "alias": "my.customization",
    "name": "My customization"
}
```

These fields are all required and have the following meaning:

* `type` — The type defines the purpose of the extension. Umbraco has many [extension types](../extension-types) available.
* `alias` — Unique identifier for this manifest. Prefix it with something that makes your extension unique. For example: _FictiveCompany.MyProject.Dashboard.Overview_.
* `name` — This is a representational name of this manifest; It does not need to be unique, but this can be beneficial when debugging extensions. This name also shows up in the Extensions Insights in the backoffice of Umbraco. For example: _My Fictive Company Overview Dashboard_.

### Additional Manifest properties
Most extension types support the use of the following generic features for their Manifest:

* `weight` - Define a weight to determine the importance or visual order of this extension. A higher weight gives a more prominent position. For instance, for a dashboard it determines it's order between other dashboards.
* `overwrites` - If replacing an existing extension, this define one or more Extension Aliases that this extension should replace. Read more in [Replace, Exclude or Unregister extensions](replace-exclude-or-unregister.md).
* `conditions` - Define one or more conditions that must pass for the extension to become available. For instance, don't show a section if you don't have the proper rights. Read more in [Extension Conditions](../extension-conditions.md). 
* `kind` - Some extension types can reference a predefined Kind. By specifying a Kind, the manifest inherits the Kind's properties. This allows for reuse of predefined settings. See [Extension Kind](../extension-kind.md).
* `meta` - Many Extension Types require additional information declared as part of a `meta` field. It depends on the extension what is required. For instance label and icon of a menu item.

For more information, see an overview of all possible [Extension Types](../extension-types/) and their requirements.