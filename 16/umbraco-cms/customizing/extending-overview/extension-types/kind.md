---
description: Create reusable, standardized configurations for extensions, helping to streamline development, ensure consistency, and reduce duplication.
---

# Kind

A Kind is a preset configuration that extensions inherit for consistency. It reduces redundancy by defining default properties. This simplifies maintenance for extensions sharing similar functionality.

Every Kind links to a specific extension type. Extensions of that type referencing a Kind automatically inherit its settings. This ensures uniformity across different extensions.

## Benefits of Using a Kind

- **Reduces redundancy** – Defines common settings once for reuse across extensions.
- **Ensures consistency** – Extensions using the same Kind follow a standardized structure.
- **Simplifies definitions** – Extensions inherit predefined properties to reduce manual configuration.

## Kind Registration

Register a Kind using the standard extension method. The key properties defining a Kind registration are:

- `type`: Always set this to `kind`.
- `alias`: A unique identifier for the Kind.
- `matchType`: Specifies the applicable extension type.
- `matchKind`: Defines the Kind alias referenced by extensions.
- `manifest`: Contains preset values for inheritance.

### Example: Registering a Button Kind for Header Apps

This example registers a Button Kind for [**Header Apps**](../extension-types/header-apps.md). It provides a preset button configuration for other extensions to reuse.

Properties:

- `type` is 'kind', registering it as a Kind extension.
- `matchType` is 'headerApp', targeting Header App extensions.
- `matchKind` is 'button', serving as the Kind's alias. 
- The `manifest` holds default properties, like `elementName`, for inheritance.

```typescript
import type { UmbExtensionManifestKind } from "@umbraco-cms/backoffice/extension-registry";

export const customHeaderAppButton: UmbExtensionManifestKind = {
	type: 'kind',
	alias: 'Umb.Kind.MyButtonKind', 
	matchType: 'headerApp', 
	matchKind: 'button', 
	manifest: {
		// Add default properties for the 'button' Kind
    	elementName: 'umb-header-app-button',
	},
};
```

## Using the Kind in Other Extensions

Use a Kind by setting the `type` and `kind` properties. The extension then automatically inherits the Kind's properties.

### Example: Header App Extension Using the Button Kind

```typescript
const manifest = {
	type: 'headerApp', // Extension type
	kind: 'button', // References the 'button' Kind
	name: 'My Header App Example',
	alias: 'My.HeaderApp.Example',
	meta: {
		label: 'My Example',
		icon: 'icon-home',
		href: '/some/path/to/open/when/clicked',
  },
};
```

Here, the extension uses `kind: 'button'` to inherit `elementName`. It also adds custom metadata to further customize behavior or appearance.

## Custom Kind Example

The code below demonstrates how to create a custom kind and then use it to create a header button app.

{% code title="kinds/manifests.ts" %}
```typescript
import type { UmbExtensionManifestKind } from "@umbraco-cms/backoffice/extension-registry";

export const customHeaderAppButton: UmbExtensionManifestKind = {
  type: 'kind',
  alias: 'Umb.Kind.MyButtonKind', 
  matchType: 'headerApp', 
  matchKind: 'customHeaderAppButton', 
  manifest: {
    elementName: 'umb-header-app-button',
  },
};
```
{% endcode %}

This code registers the Button Kind. Other Header App extensions using `type: 'headerApp'` and `kind: 'customHeaderAppButton'` will inherit the preset `elementName: 'umb-header-app-button'`.

Another Header App extension can be created without defining `elementName`. It automatically inherits this property from the Kind.

{% code title="header-button/manifests.ts" %}
```typescript
const manifest = {
	type: 'headerApp', 
	kind: 'customHeaderAppButton', 
	name: 'My Header App Example',
	alias: 'My.HeaderApp.Example',
	meta: {
		label: 'My Example',
		icon: 'icon-home',
		href: '/some/path/to/open/when/clicked',
	},
};
```
{% endcode %}

Referencing the Kind ensures consistency by inheriting shared properties. This also simplifies updating configurations across multiple extensions.
