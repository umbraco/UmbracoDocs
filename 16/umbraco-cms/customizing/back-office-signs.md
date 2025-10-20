---
description: Describes how to use sign information provided in management API responses to present additional details to consumers.
---

# Backoffice Signs

When trees, collections and items are presented in the backoffice, additional information can be displayed in the form of Signs.

A Backoffice sign is a client-side extension point that determines how each sign is displayed in the backoffice.

A Sign can utilize conditions in the same way as other Extensions or it can be bound to a Flag coming from the Management API.

For example, a Document scheduled for future publishing will have a Flag defined as part of trees, collections and item response:

```json
  "flags": [
    {
      "alias": "Umb.ScheduledForPublish"
    }
  ],
```

A Flag can be the determinant for a Sign by declaring the `forEntityFlags` as part of its Manifest.

Example:

```json
...
forEntityFlags: "Umb.ScheduledForPublish",
...
```

Using this binding lets the server determine which signs are present in the response via the registered collection of [flag providers](../extending/flag-providers.md).

## Displaying a Sign

To display a Sign in the backoffice, you register an entitySign extension and bind it to one or more flags using the forEntityFlags property. If you're using an icon variant, you must set kind: "icon" and provide both meta.iconName and meta.label, so the UI has the necessary visual and accessible information to render.

Example:

```typescript
import type { UmbExtensionManifest } from "@umbraco-cms/backoffice/extension-registry";
import { UMB_DOCUMENT_ENTITY_TYPE } from "@umbraco-cms/backoffice/document";

export const manifests: UmbExtensionManifest = {
    type: "entitySign",
    kind: "icon",
    alias: "Umb.EntitySign.Document.IsProtected",
    name: "Is Protected Document Entity Sign",
    forEntityTypes: [UMB_DOCUMENT_ENTITY_TYPE], // Where it can appear
    forEntityFlags: ["Umb.IsProtected"], // <---Binding part-When it should appear
    weight: 1000,
    meta: {
        iconName: "icon-lock", // Built-in or custom icon name
        label: "Protected", // Visible/accessible label
        iconColorAlias: "red",
    },
};
```

When an entity includes the Umb.IsProtected flag, this Sign appears next to it in the UI, indicating that the item is protected.

{% hint style="info" %}
The client extension for backoffice signs will be available in Umbraco 16.4 / 17.0.
{% endhint %}
