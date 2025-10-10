---
description: Create custom icon sets for use across the Umbraco backoffice.
---

# Icons

Umbraco extension authors can create custom icon sets for use across the Umbraco backoffice using an extension type called `icons`.

## Register a new set of icons

Icons must be registered in a manifest using the Extension API. The manifest can be added through the `umbraco-package.json` file, as shown below.

{% code title="umbraco-package.json" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My Package",
    "version": "0.1.0",
    "extensions": [
        {
            "type": "icons",
            "alias": "My.Icons.Unicorn",
            "name": "My Unicorn Icons",
            "js": "/App_Plugins/MyPackage/Icons/icons.js"
        }
    ]
}
```
{% endcode %}

The file set in the `js` field contains the details of your icons. These definitions should resemble the following:

{% code title="icons.js" %}
```javascript
export default [
    {
        name: "my-unicorn",
        path: () => import("./icon-unicorn.js"),
    },
    {
        name: "my-giraffe",
        path: () => import("./icon-giraffe.js"),
    }
]
```
{% endcode %}

Prefix each icon name to avoid collisions with other icons.

Each icon must define a path, either as a string or a dynamic import as shown above. This file must be a JavaScript file containing a default export of an SVG string. See an example below:

{% code title="icon-unicorn.js" %}
```javascript
export default `<svg ...></svg>`;
```
{% endcode %}

### Using Icons in your UI

The `umb-icon` element can automatically consume any registered icon.

```html
<umb-icon name="my-unicorn"></umb-icon>
```
