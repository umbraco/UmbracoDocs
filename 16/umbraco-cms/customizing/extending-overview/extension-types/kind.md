---
description: Create reusable, standardized configurations for extensions, helping to streamline development, ensure consistency, and reduce duplication.
---

# Kind

A Kind is a preset configuration that extensions can inherit to ensure consistency and reduce redundancy. It defines a set of default properties or behaviors that extensions can adopt, making it easier to maintain and configure extensions that share similar functionality.

A Kind is always linked to a specific extension type. Extensions using the same type and referencing a Kind automatically inherit its settings, ensuring uniformity across different extensions.

## Benefits of Using a Kind

- Reduces redundancy – Common settings are defined once and reused across extensions.
- Ensures consistency – Extensions using the same Kind follow a standardized structure and behavior.
- Simplifies extension definitions – Extensions inherit predefined properties, reducing manual configuration.

## Kind Registration

To register a Kind, use the same method as other extensions. The key properties that define a Kind registration are:

- `type`: Always set to `kind`.
- `alias`: A unique identifier for the Kind.
- `matchType`: Specifies the extension type that the Kind applies to.
- `matchKind`: Defines the Kind alias, which extensions must reference.
- `manifest`: Contains the preset values that extensions will inherit.

### Example: Registering a Button Kind for Header Apps

The following example shows how to register a Button Kind for [**Header Apps**](../extension-types/header-apps.md). This kind provides a preset configuration for a button element that can be reused by other Header App extensions.

```typescript
const manifest: ManifestKind<UmbExtensionManifest> = {
	type: 'kind',
	alias: 'Umb.Kind.MyButtonKind', // Unique alias for the Kind
	matchType: 'headerApp', // Applies to Header App extensions
	matchKind: 'button', // Defines the Kind alias
	manifest: {
		// Add default properties for the 'button' Kind
    	elementName: 'umb-header-app-button',
	},
};
```

In this example:

- `type` is set to 'kind' to register it as a Kind extension.
- `matchType` is 'headerApp', specifying that this Kind is for Header App extensions.
- `matchKind` is 'button,' which is the alias of the Kind.
- The `manifest` contains default properties like elementName that extensions using this Kind will inherit.

## Using the Kind in Other Extensions

To use the Kind in other extensions, the extension must reference it by setting the `type` and `kind` properties. The extension will automatically inherit the Kind's properties.

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

extensionRegistry.register(manifest);
```

In this example, the Header App extension uses the `kind: 'button'`, meaning it inherits the `elementName` defined in the Button Kind. The extension can still add custom properties (like metadata in this case) to further customize the behavior or appearance.

## Kind Example

Here’s an example of how to register and use the Button Kind in a Header App extension:

{% code title="kinds/manifests.ts" %}

{% hint style="warning" %}
This example uses the dynamic extension registration approach. `umbExtensionsRegistry.register()` might be called from within an entrypoint lifecycle method like `onInit()`. For more information, see the [Backoffice Entry Point](./backoffice-entry-point.md) article.
{% endhint %}

```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';
import type { ManifestKind } from "@umbraco-cms/backoffice/extension-api";

const manifest: ManifestKind<UmbExtensionManifest> = {
  type: 'kind',
  alias: 'Umb.Kind.MyButtonKind',  // Alias for the Kind
  matchType: 'headerApp', // Extension type the Kind applies to
  matchKind: 'customHeaderAppButton',  // Defines the Kind alias
  manifest: {
    elementName: 'umb-header-app-button',
  },
};

umbExtensionsRegistry.register(manifest);
```
{% endcode %}

This code registers the Button Kind, so other Header App extensions using `type: 'headerApp'` and `kind: 'customHeaderAppButton'` will inherit the preset `elementName: 'umb-header-app-button'`.

Now another Header App extension can be created without defining `elementName`, as it will automatically inherit it from the Kind:

{% code title="kinds/manifests.ts" %}

{% hint style="warning" %}
This example uses the dynamic extension registration approach. `umbExtensionsRegistry.register()` might be called from within an entrypoint lifecycle method like `onInit()`. For more information, see the [Backoffice Entry Point](./backoffice-entry-point.md) article.
{% endhint %}

```typescript
import { umbExtensionsRegistry } from "@umbraco-cms/backoffice/extension-registry";

const manifest = {
	type: 'headerApp', // Extension type
	kind: 'customHeaderAppButton',  // References the matchKind property ('customHeaderAppButton')
	name: 'My Header App Example',
	alias: 'My.HeaderApp.Example',
	meta: {
		label: 'My Example',
		icon: 'icon-home',
		href: '/some/path/to/open/when/clicked',
	},
};

umbExtensionsRegistry.register(manifest);
```
{% endcode %}

By referencing the Kind, the extension inherits shared properties like `elementName`, ensuring consistency and reducing redundancy across extensions. This method also makes it easier to update configurations across multiple extensions.
