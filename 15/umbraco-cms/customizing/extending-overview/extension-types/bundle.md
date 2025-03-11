---
description: Gather Extension Manifests in one file
---

# Bundle

The `bundle` Extension Type points to a single JavaScript file that exports or re-exports Extension Manifests written in JavaScript.

It can be used as the entry point for a package, or as a grouping for a set of manifests. A Bundle can reference other Bundles.

## Use Bundle as an entry point for a package

If you want to declare your manifests in JavaScript/TypeScript, the Bundle is a great choice.

The following example shows an `umbraco-package.json` that refers to one bundle, which can then declare manifests.

{% code title="umbraco-package.json" %}
```json
    {
		"name": "My Package Name",
		"version": "1.0.0",
		"extensions": [
			{
				"type": "bundle",
				"alias": "My.Package.Bundle",
				"name": "My Package Bundle",
				"js": "/App_Plugins/my-package/manifests.js"
			}
		]
	}
```
{% endcode %}

{% code title="manifests.ts" %}
```typescript
export const manifests: Array<UmbExtensionManifest> = [
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
{% endcode %}

{% hint style="info" %}
Ensure you have set up your `tsconfig.json` to include the extension-types as global types. Like this:

```json
{
    "compilerOptions": {
        ...
        "types": [
            "@umbraco-cms/backoffice/extension-types"
        ]
    }
}
```
{% endhint %}
