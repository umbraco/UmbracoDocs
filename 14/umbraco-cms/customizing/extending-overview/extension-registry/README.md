# Extension Registry

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

Most of BackOffice is based on Extensions making it crucial to understand how to register your own extensions. This introduction will give you an outline of the abilities of the extension registry.

## [Extension Registration](extension-registry.md) <a href="#registration" id="registration"></a>

The extension registry is a global registry that can be accessed and changed at anytime while Backoffice is running.

## [Extension Manifest](extension-manifest.md)

Each Extension Manifest has to declare its type, this is used to determine where it hooks into the system. It also looks at what data is required to declare within it.

## [Extension Types](../extension-types/)

### [Extension Conditions](../extension-types/condition.md) <a href="#conditions" id="conditions"></a>

Most extension types support conditions. Defining conditions enables you to control when and where the extension is available.

### [Kinds](../extension-types/kind.md) <a href="#kinds" id="kinds"></a>

The kinds feature enables you to base your extension registration on a preset. A kind provides the base manifest that you like to extend.

```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';
```

### [Entry Point](../extension-types/backoffice-entry-point.md) <a href="#entry-point" id="entry-point"></a>

The Entry Point manifest type is used to register an entry point for the backoffice. An entry point is a single JavaScript file that is loaded when the backoffice is initialized. This file can be used to do anything, this enables more complex logic to take place on startup.

### [Bundle](../extension-types/bundle.md) <a href="#package-manifest" id="package-manifest"></a>

The `bundle` extension type enables you to gather many extension manifests into one.
