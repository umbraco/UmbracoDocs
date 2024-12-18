---
description: A kind extension provides the preset for other extensions to use
---

# Kind

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

## Kind

A kind is matched with a specific type. When another extension uses that type and kind it will inherit the preset manifest of the kind extension.

The registration of Kinds is done in the same manner as the registration of other extensions. But the format of it is different. Let's take a look at an example of how to implement the `Kind registration` for a [**Header App**](../extension-types/header-apps.md) **Button Kind**.

## Understanding the Kind Extension

The root properties of this object define the `Kind registration`. Then the manifest property holds the preset for the extension using this kind to be based upon. This object can hold the property values that make sense for the Kind.

```ts
...

const manifest: UmbExtensionManifestKind = {
	type: 'kind',
	alias: 'Umb.Kind.MyButtonKind',
	matchType: 'headerApp',
	matchKind: 'button',
	manifest: {
		...
	},
};

...
```

For the kind to be used, it needs to match up with the registration of the extension using it. This happens when the extension uses a type, which matches the value of `matchType` of the Kind. As well the extension has to utilize that kind, by setting the value of `kind` to the value of `matchKind` the Kind.

```ts
...

const manifest = {
	type: 'headerApp',
	kind: 'button',
	...
};

...
```

## Kind example

In the following example, a kind is registered. This kind provides a default element for extensions utilizing this kind.

```ts
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest: UmbExtensionManifest = {
  type: 'kind',
  alias: 'Umb.Kind.MyButtonKind',
  matchType: 'headerApp',
  matchKind: 'button',
  manifest: {
    elementName: 'umb-header-app-button',
  },
};

umbExtensionsRegistry.register(manifest);
```

This enables other extensions to use this kind and inherit the manifest properties defined in the kind.

In this example a **Header App** is registered without defining an element, this is possible because the registration inherits the elementName from the kind.

```ts
import { extensionRegistry } from '@umbraco-cms/extension-registry';

const manifest = {
	type: 'headerApp',
	kind: 'button',
	name: 'My Header App Example',
	alias: 'My.HeaderApp.Example',
	meta: {
		label: 'My Example',
		icon: 'icon-home',
		href: '/some/path/to/open/when/clicked',
	},
};

extensionRegistry.register(extension);
```
