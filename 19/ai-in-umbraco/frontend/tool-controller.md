---
description: >-
    Controller for querying available AI tools and tool scopes from custom backoffice elements.
---

# Tool Controller

`UaiToolController` provides a frontend API for querying the available AI tools and tool scopes. Use this to build custom UI for tool selection or to display tool information in your backoffice extensions.

## Import

{% code title="Import" %}

```typescript
import { UaiToolController, UaiToolScope, UaiToolItem } from "@umbraco-ai/core";
```

{% endcode %}

## Constructor

{% code title="Constructor" %}

```typescript
new UaiToolController(host: UmbControllerHost)
```

{% endcode %}

| Parameter | Type                | Description                                           |
| --------- | ------------------- | ----------------------------------------------------- |
| `host`    | `UmbControllerHost` | The controller host (usually `this` in a Lit element) |

## Methods

### getToolScopes

Gets all available tool scopes.

{% code title="Signature" %}

```typescript
async getToolScopes(): Promise<{ data?: UaiToolScope[]; error?: unknown }>
```

{% endcode %}

**Returns**: Promise resolving to `{ data?, error? }` where `data` is an array of tool scopes.

### `getTools`

Gets all available tools.

{% code title="Signature" %}

```typescript
async getTools(): Promise<{ data?: UaiToolItem[]; error?: unknown }>
```

{% endcode %}

**Returns**: Promise resolving to `{ data?, error? }` where `data` is an array of tools.

### getToolCountsByScope

Gets the number of tools in each scope, including both backend and frontend tools.

{% code title="Signature" %}

```typescript
async getToolCountsByScope(): Promise<Record<string, number>>
```

{% endcode %}

**Returns**: Promise resolving to a record mapping scope IDs to tool counts. Returns `{}` on error.

## Types

{% code title="UaiToolScope" %}

```typescript
interface UaiToolScope {
    id: string;
    icon: string;
    isDestructive: boolean;
    domain: string;
}
```

{% endcode %}

{% code title="UaiToolItem" %}

```typescript
interface UaiToolItem {
    id: string;
    name: string;
    description: string;
    scopeId: string;
    isDestructive: boolean;
    tags: string[];
}
```

{% endcode %}

## Example

{% code title="tool-picker.element.ts" %}

```typescript
import { LitElement, html } from "lit";
import { customElement, state } from "lit/decorators.js";
import { UaiToolController, UaiToolScope, UaiToolItem } from "@umbraco-ai/core";

@customElement("tool-picker")
export class ToolPickerElement extends LitElement {
    #tools = new UaiToolController(this);

    @state()
    private _scopes: UaiToolScope[] = [];

    @state()
    private _toolCounts: Record<string, number> = {};

    async connectedCallback() {
        super.connectedCallback();

        const [scopeResult, counts] = await Promise.all([
            this.#tools.getToolScopes(),
            this.#tools.getToolCountsByScope(),
        ]);

        if (scopeResult.data) {
            this._scopes = scopeResult.data;
        }

        this._toolCounts = counts;
    }

    render() {
        return html`
            <ul>
                ${this._scopes.map(
                    (scope) => html`
                        <li>
                            ${scope.id} (${this._toolCounts[scope.id] ?? 0} tools)
                        </li>
                    `,
                )}
            </ul>
        `;
    }
}
```

{% endcode %}

## Related

- [Custom Tools](../extending/tools/README.md) - Creating backend tools
- [Agent Permissions](../add-ons/agent/permissions.md) - Tool permissions for agents
