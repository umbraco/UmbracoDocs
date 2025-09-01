---
description: Example how to work with extension registry
---

# Header Apps

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

A header app appears next to the user profile and global search icon on the top-right corner of Umbraco's backoffice.

In this article, you can find an example of an extension registry. This example details the creation of a Header App in two ways, similar to how the extension registry can be created:

1. [Using a manifest file](header-apps.md#button-header-app-with-manifest).
2. [Using the JavaScript/TypeScript file](header-apps.md#button-header-app-with-js-ts).

<figure><img src="../../../.gitbook/assets/header-apps.svg" alt=""><figcaption><p>Header Apps</p></figcaption></figure>

## **Button Header App with Manifest**

Below you can find an example of how to setup a Header App using the manifest file.

1. Follow the [Vite Package Setup](../../development-flow/vite-package-setup.md) to create a header app and name it "`header-app`" when using the guide.
2. Create a manifest file named `umbraco-package.json` at the root of the `header-app` folder. Here we define and configure our dashboard.
3. Add the following code to `umbraco-package.json`:

{% code title="umbraco-package.json" lineNumbers="true" %}
```typescript
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "My Header App",
  "version": "0.1.0",
  "extensions": [
    {
      "type": "headerApp",
      "alias": "My.HeaderApp",
      "name": "My Header App",
      "kind": "button",

      "meta": {
        "label": "Hello Umbraco",
        "icon": "icon-hearts",
        "href": "https://umbraco.com/"
      }
    }
  ]
}
```
{% endcode %}

* First we define the type which is a `headerApp`. Then we add a unique alias and a name to define the extension UI.
* Then we can define what kind of extension it is, where in this case we can use a pre-defined element called button.
* The button requires some : an icon, label of the button (name of the button) and a link which opens once clicked.

4. In the `header-app` folder run `npm run build` and then run the project. Then in the backoffice you will see our new Header App extension with **heart icon**:

<figure><img src="../../../.gitbook/assets/header-app-example.png" alt=""><figcaption><p>Header App in the Backoffice registered via Manifest File</p></figcaption></figure>

## **Button Header App with JS/TS**

Below you can find an example of how to setup a Header App using the TypeScript file.

This is a continuation of the above steps from the **Button Header App with Manifest** example. We will register a new Header App directly from the .ts file.

1. Add a reference to the .js file. Update the `umbraco-package.json` with the following:

{% code title="umbraco-package.json" lineNumbers="true" %}
```typescript
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "My Header App",
  "version": "0.1.0",
  "extensions": [
    {
      "type": "headerApp",
      "alias": "My.HeaderApp",
      "name": "My Header App",
      "kind": "button",
      "element": "/App_Plugins/header-app/dist/header-app.js",
      "meta": {
        "label": "Hello Umbraco",
        "icon": "icon-hearts",
        "href": "https://umbraco.com/"
      }
    }
  ]
}
```
{% endcode %}

2. Replace the content of the `src/my-element.ts file` with the following:

{% code title="my-element.ts" lineNumbers="true" %}
```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest: UmbExtensionManifest = {
  type: "headerApp",
  alias: "My.HeaderApp.Documentation",
  name: "My Header App Documentation",
  kind: "button",
  meta: {
    label: "Hello Documentation",
    icon: "icon-addressbook",
    href: "https://docs.umbraco.com/"
  }
};

umbExtensionsRegistry.register(manifest);
```
{% endcode %}

3. In the `header-app` folder run `npm run build` and then run the project. Then in the backoffice you will see our new Header App extension with **address book** **icon**:

<figure><img src="../../../.gitbook/assets/header-app-example-ts.png" alt=""><figcaption><p>Header App in Backoffice registered via ts File</p></figcaption></figure>
