---
description: Learn how to append and use Icons.
---

# Icons

This article describes how to add and use more icons in your UI.

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

## Register a new set of icons

New icons can be added via an extension type called `icons`.

You must add a new manifest to the Extension API to register icons. The manifest can be added through the `umbraco-package.json` file as shown in the snippet below.

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

The file set in the `js` field holds the details about your Icons. The file should resemble the following:

{% code title="icons.js" %}

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

{% endcode %}

The icon name needs to be prefixed to avoid collision with other icons.

Each icon must define a path, either as a string or a dynamic import as shown above. This file must be a JavaScript file containing a default export of an SVG string. See an example of this in the code snippet below.

{% code title="icon-unicorn.js" %}

```typescript
export default `<svg ...></svg>`;
```

{% endcode %}

### Using Icons in your UI

The `umb-icon` element is automatically able to consume any registered icon.

The following example shows how to make a button using the above-registered icon.

```html
<uui-button compact label="Make the unicorn dance">
    <umb-icon name="myPackage-unicorn"></umb-icon>
</uui-button>
```
