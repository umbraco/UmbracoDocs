# Bundle

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The `bundle` extension type enables you to gather many extension manifests into one.

It points to a single JavaScript file that via JavaScript Modules, exports or re-exports Extension Manifests written in JavaScript.

It can be used as the entry point for a package, or as a grouping for a set of manifests.

## Use Bundle as entry point for a package

If you like to declare your manifests in JavaScript/TypeScript, the Bundle is a great choice for you.

The following example shows a umbraco-package that referees to one bundle, which then can declare several manifests.

umbraco-package.json
```typescript
{
		name: 'My Package Name',
		version: '1.0.0',
		extensions: [
			{
				type: 'bundle',
				alias: 'My.Package.Bundle',
				name: 'My Package Bundle',
				js: '/App_Plugins/my-package/manifests.js',
			},
		],
	},
```

manifests.ts
```typescript
import type { ManifestTypes } from '@umbraco-cms/backoffice/extension-registry';

export const manifests: Array<ManifestTypes> = [
	{
		type: 'dashboard',
		name: 'Example Dashboard',
		alias: 'example.dashboard.demo',
		element: () => import('./demo-dashboard.js'),
		weight: 900,
		meta: {
			label: 'Demo example',
			pathname: 'demo-example',
		},
	},
	// ... insert as many manifests as you like
]
```
