---
description: Global contexts in Umbraco provide a clean, type-safe way to share functionality across the backoffice.
---

# Global Context

The Global Context extension type allows extension authors to create a custom context of data and functions and make it available across the entire backoffice. Unlike other contexts that might be scoped to a specific workspace or view, a global context is available everywhere. These contexts are kept alive through the entire backoffice session.

Consider using a global context when you need to:

- **Share state across multiple extensions** - Track user preferences or application-wide settings
- **Provide utility functions** - Common operations that multiple parts of an extension
- **Manage centralized services** - API clients, notification handlers, or data repositories
- **Coordinate between different extensions** - Communication layer between dashboards, property editors, and other components
- **Share functionality with other extensions** - Allow other package developers to access features and functionality within the package

Extension authors should prefer to use other context types [Workspace Contexts](workspaces/workspace-context.md) over Global Contexts. Umbraco itself uses Global Contexts sparingly, for clipboard, current user, and icons.

## Registration of a Global Context

Global Context extensions can be registered using a manifest file like `umbraco-package.json`.

{% code title="umbraco-package.json" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My Global Context Package",
    "version": "1.0.0",
    "extensions": [
        {
            "type": "globalContext",
            "alias": "My.GlobalContext",
            "name": "My Global Context",
            "api": "/App_Plugins/my-global-context/dist/my-context.context.js"
        }
    ]
}
```
{% endcode %}

**Key fields:**
- `type`: Must be `"globalContext"`, see: [ManifestGlobalContext](https://apidocs.umbraco.com/v16/ui-api/interfaces/packages_core_extension-registry.ManifestGlobalContext.html)
- `alias`: A unique identifier for the context
- `name`: A human-readable name
- `api`: The path to the compiled JavaScript file

## Creating Your Global Context

### 1. Define a Context Token

First, create a context token. This is how other parts of an extension will reference the context:

{% code title="src/my-context.ts" %}
```typescript
import { UmbContextToken } from '@umbraco-cms/backoffice/context-api';

export interface MyGlobalContextInterface {
    getCurrentUser(): Promise<string>;
    setPreference(key: string, value: any): void;
    getPreference(key: string): any;
    getHostElement(): Element;
}

export const MY_GLOBAL_CONTEXT = new UmbContextToken<MyGlobalContextInterface>(
    'My.GlobalContext'
);
```
{% endcode %}

### 2. Implement the Context Class

Next, implement the context class:

{% code title="src/my-context.ts" %}
```typescript
import { UmbContextBase } from '@umbraco-cms/backoffice/class-api';
import { UmbControllerHost } from '@umbraco-cms/backoffice/controller-api';

export class MyGlobalContext
    extends UmbContextBase
    implements MyGlobalContextInterface
{
    #preferences: Map<string, any> = new Map();

    constructor(host: UmbControllerHost) {
        super(host, SERVICE_STATUS_CONTEXT);
    }

    async getCurrentUser(): Promise<string> {
        // In a real implementation, you'd fetch this from the API
        return "Current User";
    }

    setPreference(key: string, value: any): void {
        this.#preferences.set(key, value);
        console.log(`Preference set: ${key} = ${value}`);
    }

    getPreference(key: string): any {
        return this.#preferences.get(key);
    }

    getHostElement(): Element {
        return this;
    }
}

export default MyGlobalContext;
```
{% endcode %}

## Using Global Contexts

Once the global context extension is registered, it can be consumed in any web component throughout the backoffice.

{% code title="src/my-custom-dashboard.ts" %}
```typescript
import {
    LitElement,
    html,
    customElement,
} from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";
import {
    MY_GLOBAL_CONTEXT,
    MyGlobalContextInterface,
} from "./service-status-context.ts";

@customElement("my-custom-dashboard")
export class MyCustomDashboard extends UmbElementMixin(LitElement) {
    #myContext?: MyGlobalContextInterface;

    constructor() {
        super();

        // Consume the global context
        this.consumeContext(MY_GLOBAL_CONTEXT, (instance) => {
            this.#myContext = instance;
        });
    }

    async #handleClick() {
        if (!this.#myContext) return;

        // Use the context
        const user = await this.#myContext.getCurrentUser();
        this.#myContext.setPreference("lastVisit", new Date().toISOString());

        console.log(`Welcome back, ${user}!`);
    }

    render() {
        return html`
      <uui-button @click=${this.#handleClick} look="primary">
        Check User
      </uui-button>
    `;
    }
}
```
{% endcode %}
