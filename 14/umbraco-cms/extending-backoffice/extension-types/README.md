---
description: >-
  The declaration of an extension is done by an Extension Manifest, either
  registered via an Umbraco-Package Manifest or directly to the Extension
  Registry in JavaScript.
---

# Extension Types

### Extension Manifest Type

Each Extension Manifest has to declare its type, this is used to determine where it hooks into the system. It also looks at what data is required to declare within it.

The pages of this article describe all the extension types that Backoffice supports. Here is a list of the most common types:

{% content-ref url="dashboards.md" %}
[dashboards.md](dashboards.md)
{% endcontent-ref %}

{% content-ref url="property-editors/" %}
[property-editors](property-editors/)
{% endcontent-ref %}

{% content-ref url="sections-and-trees/" %}
[sections-and-trees](sections-and-trees/)
{% endcontent-ref %}

## Declare Extension Manifest

Extension Manifest and can be declared in multiple ways. One of these is to declare it as part of the [Umbraco Package Manifest](../package-manifest.md).

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

Read more about the `bundle` extension type in the [Bundle](../extension-registry/bundle.md)article.

### Using `backofficeEntryPoint` as your foundation

The `backofficeEntryPoint` extension type is special, it can be used to run any JavaScript code at startup.\
This can be used as an entry point for a package.\
The entry point declares a single JavaScript file that will be loaded and run when the Backoffice starts.

The `entryPbackofficeEntryPointoint` extension is also the way to go if you want to load in external libraries such as jQuery, Angular, React, etc. You can use the `backofficeEntryPoint` to load in the external libraries to be shared by all your extensions. Loading **global CSS files** can also be used in the `backofficeEntryPoint` extension.

Read more about the `backofficeEntryPoint` extension type in the [Entry Point](../extension-registry/entry-point.md) article.
