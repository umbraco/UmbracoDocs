---
description: The Backoffice Entry Point extension type is used to run some JavaScript code at startup.
---

# Backoffice Entry Point

This manifest declares a single JavaScript file that will be loaded and run when the Backoffice starts. In other words, this can be used as an entry point for a package.

The `backofficeEntryPoint` extension is also the way to go if you want to load in external libraries such as jQuery, Angular, React, etc. You can use the `backofficeEntryPoint` to load in the external libraries to be shared by all your extensions. Additionally, **global CSS files** can also be used in the `backofficeEntryPoint` extension.

{% hint style="info" %}
See also the [App Entry Point](./app-entry-point.md) article for a similar extension type that runs before the user is logged in.
{% endhint %}

**Register a Backoffice Entry Point in the `umbraco-package.json` manifest**

{% code title="umbraco-package.json" %}
```json
{
    "name": "Name of your package",
    "alias": "My.Package",
    "extensions": [
        {
         "type": "backofficeEntryPoint",
         "alias": "My.EntryPoint",
         "js": "/App_Plugins/YourFolder/index.js"
        }
    ]
}
```
{% endcode %}

**Base structure of the entry point file**

{% hint style="info" %}
All examples are in TypeScript, but you can use JavaScript as well. Make sure to use a bundler such as [Vite](../../development-flow/vite-package-setup.md) to compile your TypeScript to JavaScript.
{% endhint %}

{% code title="index.ts" %}
```typescript
import type { UmbEntryPointOnInit } from '@umbraco-cms/backoffice/extension-api';

/**
 * Perform any initialization logic when the Backoffice starts
 */
export const onInit: UmbEntryPointOnInit = (host, extensionRegistry) => {
    // Your initialization logic here
}

/**
 * Perform any cleanup logic when the Backoffice and/or the package is unloaded
 */
export const onUnload: UmbEntryPointOnUnload = (host, extensionRegistry) => {
    // Your cleanup logic here
}
```
{% endcode %}

{% hint style="info" %}
The `onUnload` function is optional and can be used to perform cleanup logic when the Backoffice and/or the package is unloaded.
{% endhint %}

## Examples

### Register additional UI extensions in the entry point file

{% code title="index.ts" %}
```typescript
import type { UmbEntryPointOnInit } from '@umbraco-cms/backoffice/extension-api';

const manifest: UmbExtensionManifest = {
    type: '', // type of extension
    alias: '', // unique alias for the extension
    elementName: '', // unique name of the custom element
    js: '', // path to the javascript resource
    meta: {
        // additional props for the extension type
    }
};

export const onInit: UmbEntryPointOnInit = (host, extensionRegistry) => {
    // Register the extension
    extensionRegistry.register(manifest);
}

export const onUnload: UmbEntryPointOnUnload = (host, extensionRegistry) => {
    // Unregister the extension (optional)
    extensionRegistry.unregister(manifest);
}
```
{% endcode %}

{% hint style="info" %}
If you only need to register extensions, then consider using a [bundle](./bundle.md) type instead.
{% endhint %}

### Register global CSS

An entry point is a good place to load global CSS files for the whole application. You can do this by creating a link element and appending it to the head of the document:

{% code title="index.ts" %}
```typescript
import type { UmbEntryPointOnInit } from '@umbraco-cms/backoffice/extension-api';

export const onInit: UmbEntryPointOnInit = (host, extensionsRegistry) => {
    const css = document.createElement('link');
    css.rel = 'stylesheet';
    css.href = '/App_Plugins/YourFolder/global.css';
    document.head.appendChild(css);
}
```
{% endcode %}

Alternatively, you can import the CSS file directly in your JavaScript file:

{% code title="index.ts" %}
```typescript
import '/App_Plugins/YourFolder/global.css';
```
{% endcode %}

## Type IntelliSense

It is recommended to make use of the Type intellisense that we provide.

When writing your Manifest in TypeScript you should use the Type `UmbExtensionManifest`, see the [TypeScript setup](../../development-flow/typescript-setup.md) article to make sure you have Types correctly configured.

{% code title="index.ts" %}
```typescript
import type { UmbEntryPointOnInit } from '@umbraco-cms/backoffice/extension-api';

const manifests: Array<UmbExtensionManifest> = [
    {
        type: '...',
        alias: 'my.customization',
        name: 'My customization'
        ...
    },
    ...
];

export const onInit: UmbEntryPointOnInit = (host, extensionRegistry) => {
    // Register the extensions
    extensionRegistry.registerMany(manifests);
}
```
{% endcode %}

## What's next?

See the Extension Types article for more information about all the different extension types available in Umbraco:

{% content-ref url="./" %}
[README](./)
{% endcontent-ref %}

Read about running code before log in using an `appEntryPoint`:

{% content-ref url="./app-entry-point.md" %}
[App Entry Point](./app-entry-point.md)
{% endcontent-ref %}
