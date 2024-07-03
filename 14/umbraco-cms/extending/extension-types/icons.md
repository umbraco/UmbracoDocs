---
description: Learn how to append and use Icons.
---

# Icons

This article describes how you can add more icons and use them in your UI.

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

## Register new set of icons

You may new to add more icons to the system, this can be done via a extension type called `icons`.

To register icons, you need to add a new manifest to the Extension API. The manifest can be added through the `umbraco-package.json` file like this:

{% code title="umbraco-package.json" %}
```json
{
  "name": "MyPackage",
  "extensions": [
    {
      "type": "icons",
      "alias": "MyPackage.Icons.Unicorn",
      "name": "MyPackage Unicorn Icons",
      "js": "/App_Plugins/MyPackage/Icons/icons.js"
    }
  ]
}
```
{% endcode %}

The file pointed to in the field `js` holds the details about your Icons, and should look like this:

```typescript
export default [
    {
        name: "myPackage-unicorn",
        path: () => import("./icon-unicorn.js"),
    },
    {
        name: "myPackage-giraffe",
        path: () => import("./icon-giraffe.js"),
    }
]
```

Notice how the name of each Icon has to be prefixed to avoid collision with other icons.

Each icon must define a path, either as a string or a dynamic import as shown above. This file must be a js file containing a default export of a SVG string. Looking like this:

```typescript
export default `<svg ...></svg>`;
```

### Using Icons in your UI

The element `umb-icon` automatically becomes able to consume any icon that is registered.
The following example shows how to make a button using the icon registered above.

```html
<uui-button compact label="Make the unicorn dance">
    <umb-icon name="myPackage-unicorn"></umb-icon>
</uui-button>
```
