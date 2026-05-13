---
description: >-
  Create reusable, standardized configurations for extensions, helping to
  streamline development, ensure consistency, and reduce duplication.
---

# Kinds

A Kind is a preset configuration that extensions inherit for consistency. It reduces redundancy by defining default properties. This simplifies maintenance for extensions sharing similar functionality.

Every Kind links to a specific extension type. Extensions of that type referencing a Kind automatically inherit its settings. This ensures uniformity across different extensions.

## Benefits of Using a Kind

* **Reduces redundancy** – Defines common settings once for reuse across extensions.
* **Ensures consistency** – Extensions using the same Kind follow a standardized structure.
* **Simplifies definitions** – Extensions inherit predefined properties to reduce manual configuration.

## Kind Registration

Register a Kind using the standard extension method. The key properties defining a Kind registration are:

* `type`: Always set this to `kind`.
* `alias`: A unique identifier for the Kind.
* `matchType`: Specifies the applicable extension type.
* `matchKind`: Defines the Kind alias referenced by extensions.
* `manifest`: Contains preset values for inheritance.

### Example: Registering a Button Kind for Header Apps

This example registers a Button Kind for [**Header Apps**](header-apps.md). It provides a preset button configuration for other extensions to reuse.

Properties:

* `type` is 'kind', registering it as a Kind extension.
* `matchType` is 'headerApp', targeting Header App extensions.
* `matchKind` is 'button', serving as the Kind's alias.
* The `manifest` holds default properties, like `elementName`, for inheritance.

```typescript
import type { UmbExtensionManifestKind } from "@umbraco-cms/backoffice/extension-registry";

export const customHeaderAppButton: UmbExtensionManifestKind = {
	type: 'kind',
	alias: 'Umb.Kind.MyButtonKind', 
	matchType: 'headerApp', 
	matchKind: 'button', 
	manifest: {
		// Add default properties for the 'button' Kind
    	elementName: 'umb-header-app-button',
	},
};
```

## Using the Kind in Other Extensions

Use a Kind by setting the `type` and `kind` properties. The extension then automatically inherits the Kind's properties.

### Example: Header App Extension Using the Button Kind

```typescript
const manifest = {
	type: 'headerApp', // Extension type
	kind: 'button', // References the 'button' Kind
	name: 'My Header App Example',
	alias: 'My.HeaderApp.Example',
	meta: {
		label: 'My Example',
		icon: 'icon-home',
		href: '/some/path/to/open/when/clicked',
  },
};
```

Here, the extension uses `kind: 'button'` to inherit `elementName`. It also adds custom metadata to further customize behavior or appearance.

## Custom Kind Example

The code below demonstrates how to create a custom kind. This `Kind` extension will allow extension developers to display welcome messages in the header that will greet backoffice users.

<figure><img src="../../../.gitbook/assets/kind-custom-header-app.png" alt="" width="401"><figcaption><p>Custom Header App Created Using a Kind</p></figcaption></figure>

### Create the Kind Extension

Start by defining and registering a new Kind extension. Select a unique name for the `matchKind` and `manifest.elementName` properties.

{% code title="kinds/manifests.ts" %}
```typescript
export const welcomeHeaderAppMessage: UmbExtensionManifestKind = {
    type: "kind",
    alias: "Umb.Kind.HeaderAppMessage", // Unique alias for the Kind
    matchType: "headerApp", // Applies to Header App extensions
    matchKind: "welcomeHeaderAppMessage", // Defines the Kind alias
    manifest: {
        // Add default properties for the 'button' Kind
        elementName: "welcome-header-app-message",
    },
};
```
{% endcode %}

### Create a Custom Component for `welcome-header-app-message`

Create a custom component to render our welcome message out to the backoffice user. The `manifest.elementName` property in the kind manifest should match the value of `@customElement` and `declare global { ...` declarations.

{% code title="kinds/welcome-header-app-message.ts" %}
```typescript
import {
  html,
  customElement,
  property,
} from "@umbraco-cms/backoffice/external/lit";
import { LitElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";
import type { ManifestHeaderApp } from "@umbraco-cms/backoffice/extension-registry";

// Define a TypeScript interface for your specific manifest structure
// This ensures strict typing for 'meta.message'
export interface ManifestHeaderAppMessage extends ManifestHeaderApp {
  meta: {
    message: string;
  };
}

@customElement("welcome-header-app-message")
export class UmbHeaderAppMessageElement extends UmbElementMixin(LitElement) {
  // The Umbraco extension renderer will automatically set this property
  @property({ attribute: false })
  manifest?: ManifestHeaderAppMessage;

  render() {
    return html`
      <div
        style="color: white; font-weight: bold; padding: 0 16px; display: flex; align-items: center; font-weight: bold;"
      >
        ${this.manifest?.meta.message ?? "No message defined"}
      </div>
    `;
  }
}

export default UmbHeaderAppMessageElement;

declare global {
  interface HTMLElementTagNameMap {
    "welcome-header-app-message": UmbHeaderAppMessageElement;
  }
}
```
{% endcode %}

### Derive Header Apps Using the Custom Kind Extension

Use the previously defined `Kind` extension, `welcomeHeaderAppMessage` to create messages to display to the user for each day of the week. Properties such as `manifest.elementName` that are defined in the `welcomeHeaderAppMessage` kind extension will fall through to derived extensions. These properties do not need to be redefined in extensions that inherit from the `welcomeHeaderAppMessage` kind.

* For each derived extension, the `kind` property must match the `matchKind` property on `welcomeHeaderAppMessage`.
* The `type` property must also match the `matchType` property on `welcomeHeaderAppMessage`.
* Use `element` to import the custom component.

{% code title="kinds/manifests.ts" %}
```typescript
// ...

export const wednesdayWelcomeMessageHeaderAppInstance = {
    type: "headerApp",
    kind: "welcomeHeaderAppMessage",
    name: "Wednesday Message Header App",
    alias: "My.HeaderApp.WednesdayMessage",
    element: () => import("./header-app-message.ts"),
    meta: {
        message: "Happy wonderful Wednesday",
    },
};

export const thursdayWelcomeMessageHeaderAppInstance = {
    type: "headerApp",
    kind: "welcomeHeaderAppMessage",
    name: "Thursday Message Header App",
    alias: "My.HeaderApp.ThursdayMessage",
    element: () => import("./header-app-message.ts"),
    meta: {
        message: "Happy thunderous Thursday",
    },
};

export const fridayWelcomeMessageHeaderAppInstance = {
    type: "headerApp",
    kind: "welcomeHeaderAppMessage",
    name: "Friday Message Header App",
    alias: "My.HeaderApp.FridayMessage",
    element: () => import("./header-app-message.ts"),
    meta: {
        message: "Happy funky Friday",
    },
};
```
{% endcode %}

### Register the Derived Extension

Use any standard practice to register the derived extension, in this case `thursdayWelcomeMessageHeaderAppInstance` is registered dynamically in an entrypoint.

{% code title="entrypoints/entrypoints.ts" %}
```typescript
import type {
    UmbEntryPointOnInit,
    UmbEntryPointOnUnload,
} from "@umbraco-cms/backoffice/extension-api";
import { umbExtensionsRegistry } from "@umbraco-cms/backoffice/extension-registry";
import {
    thursdayWelcomeMessageHeaderAppInstance,
} from "../kinds/manifests";

export const onInit: UmbEntryPointOnInit = (_host, _extensionRegistry) => {
    console.log("Hello from my extension 🎉");
    
    umbExtensionsRegistry.register(thursdayWelcomeMessageHeaderAppInstance);
};

export const onUnload: UmbEntryPointOnUnload = (_host, _extensionRegistry) => {
    console.log("Goodbye from my extension 👋");
};
```
{% endcode %}

Referencing the Kind ensures consistency by inheriting shared properties. This also simplifies updating configurations across multiple extensions.
