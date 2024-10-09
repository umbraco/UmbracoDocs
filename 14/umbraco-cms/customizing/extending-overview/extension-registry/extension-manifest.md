---
description: Learn about the different methods for declaring an Extension Manifest.
---

# Extension Manifest

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The Extension Manifest is the point of entry for any extension. This is the declaration of what you want to register.

The content in this section describes all the extension types that the Backoffice supports. Here is a list of the most common types:

{% content-ref url="../../../tutorials/creating-a-custom-dashboard/" %}
[creating-a-custom-dashboard](../../../tutorials/creating-a-custom-dashboard/)
{% endcontent-ref %}

{% content-ref url="../../property-editors/composition/" %}
[composition](../../property-editors/composition/)
{% endcontent-ref %}

{% content-ref url="../../section-trees.md" %}
[section-trees.md](../../section-trees.md)
{% endcontent-ref %}

## Manifest Data

Each Extension Manifest has to declare its type. This is used to determine where it hooks into the system. It also determines what data is required of this manifest.

The abilities of the extensions rely on the specific extension type. The Type sets the scene for what the extension can do and what it needs to be utilized. Some extension types can be made purely via the manifest. Other requires files, like a JavaScript file containing a Web Component.

The required fields of any extension manifest are:

* `type` - The type defines the type and purpose of the extension. It is used to determine where the extension will be used and defines the data needed for this manifest.
* `alias`- The alias is used to identify the extension. This has to be unique for each extension.
* `name` - The name of the extension. This is used to identify the extension in the UI.

Additionally, many extensions supports the use of the following fields:

* `weight` - Define a weight, to determine the importance or visual order of this extension.
* `conditions` - Define one or more conditions which must be permitted for the extension to become available. [Extension Conditions](../extension-conditions/extension-conditions.md).
* `kind` - Define a kind-alias of which this manifest should be based upon. Kinds acts like a preset for your manifest. [Extension Kinds](../extension-kind/extension-kind.md).

Many of the Extension Types requires additional information declared as part of a `meta` field.

## Registration

An Extension Manifest can be declared in multiple ways.

The primary way is to declare it as part of the [Umbraco Package Manifest](../../umbraco-package.md).

Additionally, two Extension types can be used to register other extensions.

A typical use case is to declare one main Extension Manifest as part of the [Umbraco Package Manifest](../../umbraco-package.md). Such main Extension Manifest would be using one of the following types:

### The `bundle` extension type

The Bundle extension type can be used for declaring multiple Extension Manifests with JavaScript in a single file.

The Bundle declares a single JavaScript file that will be loaded at startup. All the Extension Manifests exported of this Module will be registered in the Extension Registry.

Read more about the `bundle` extension type in the [Bundle](../../../extending/extending-overview/extension-registry/bundle.md) article.

### The `backofficeEntryPoint` extension type

The `backofficeEntryPoint` extension type can run any JavaScript code at startup. This can be used as an entry point for a package.

The entry point declares a single JavaScript file that will be loaded and run when the Backoffice starts.

The `entryPbackofficeEntryPointoint` extension is also the way to go if you want to load in external libraries such as jQuery, Angular, or React. You can use the `backofficeEntryPoint` type to load in the external libraries to be shared by all your extensions. Loading **global CSS files** can also be used in the `backofficeEntryPoint` extension.

Read more about the `backofficeEntryPoint` extension type in the [Entry Point](../../../extending/extending-overview/extension-registry/entry-point.md) article.

## Registration via any JavaScript code

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
