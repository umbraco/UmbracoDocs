# Custom Extension types

The extension registry is an open system, which can hold any Extension Manifest Type. This article describes how you can declare your types. Types can be declared for re-useability/maintainability or to open up for other package extensions.

## Manifest Type Declaration

A Manifest Type is declared via a TypeScript Interface, like shown below:

```typescript
import type { ManifestBase } from '@umbraco-cms/backoffice/extension-api';

export interface ManifestPreviewAppProvider extends ManifestBase {
    type: 'myPrefixedExtensionType';
}

// Declare the Manifest Type in the global UmbExtensionManifestMap interface:
declare global {
    interface UmbExtensionManifestMap {
        MyPrefixedExtensionManifest: MyExtensionManifestType;
    }
}
```
