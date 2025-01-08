# Entry Point

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The `backofficeEntryPoint` extension type can be used to run some JavaScript code at startup.\
The entry point declares a single JavaScript file that will be loaded and run when the Backoffice starts. In other words this can be used as an entry point for a package.

The `backofficeEntryPoint` extension is also the way to go if you want to load in external libraries such as jQuery, Angular, React, etc. You can use the `backofficeEntryPoint` to load in the external libraries to be shared by all your extensions. Additionally, **global CSS files** can also be used in the `backofficeEntryPoint` extension.

The Entry Point manifest type is used to register an entry point for the backoffice. An entry point is a single JavaScript file that is loaded when the backoffice is initialized. This file can be used to do anything, this enables more complex logic to take place on startup.

**Register an entry point in the `umbraco-package.json` manifest**

```json
{
    "name": "Name of your package",
    "extensions": [
        {
         "type": "backofficeEntryPoint",
         "alias": "My.EntryPoint",
         "js": "/App_Plugins/YourFolder/index.js"
        }
    ]
}
```

**Register additional UI extensions in the entry point file**

```typescript
import { extensionRegistry } from "@umbraco-cms/extension-registry"

const manifest = {
  {
    type: '', // type of extension
    alias: '', // unique alias for the extension
    elementName: '', // unique name of the custom element
    js: '', // path to the javascript resource
    meta: {
      // additional props for the extension type
    }
  }
};

extensionRegistry.register(extension);
```
