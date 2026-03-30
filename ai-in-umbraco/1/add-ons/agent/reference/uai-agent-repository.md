---
description: >-
    Read-only repository for fetching active agents in frontend components.
---

# UaiAgentRepository

The `UaiAgentRepository` is a lightweight, read-only repository for fetching active agents in frontend components. It provides a simple API for consumers that only need to read active agent data without the complexity of full CRUD operations.

## Overview

This repository is useful when you need to:

- Display a list of active agents in a dropdown or picker
- Filter agents by scope (e.g., "copilot" agents only)
- Build custom UI components that consume agent data

**Key features:**

- Read-only operations (no create/update/delete)
- Automatic filtering to active agents only
- Scope-based filtering support
- Pagination control
- Type-safe agent item models

## Installation

The repository is included in the `@umbraco-ai/agent` package:

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Agent
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Agent
```

{% endcode %}

## Import

{% code title="TypeScript" %}

```typescript
import { UaiAgentRepository, type UaiAgentRepositoryOptions } from "@umbraco-ai/agent";
```

{% endcode %}

## Quick Start

{% code title="Basic Usage" %}

```typescript
import { LitElement } from "lit";
import { customElement, state } from "lit/decorators.js";
import { UaiAgentRepository, type UaiAgentItemModel } from "@umbraco-ai/agent";

@customElement("my-agent-picker")
export class MyAgentPicker extends LitElement {
    #repository: UaiAgentRepository;

    @state()
    private _agents: UaiAgentItemModel[] = [];

    constructor() {
        super();
        this.#repository = new UaiAgentRepository(this);
    }

    async connectedCallback() {
        super.connectedCallback();
        await this.#loadAgents();
    }

    async #loadAgents() {
        const result = await this.#repository.fetchActiveAgents();
        if (result.data) {
            this._agents = result.data.items;
        }
    }

    render() {
        return html`
            <select>
                ${this._agents.map((agent) => html` <option value=${agent.unique}>${agent.name}</option> `)}
            </select>
        `;
    }
}
```

{% endcode %}

## API Reference

### Constructor

#### `new UaiAgentRepository(host)`

Creates a new repository instance.

**Parameters:**

| Parameter | Type                | Required | Description                                                 |
| --------- | ------------------- | -------- | ----------------------------------------------------------- |
| `host`    | `UmbControllerHost` | Yes      | Umbraco controller host (typically `this` in a Lit element) |

**Example:**

```typescript
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

class MyElement extends UmbElementMixin(LitElement) {
    #repository = new UaiAgentRepository(this);
}
```

### Methods

#### `fetchActiveAgents(options?)`

Fetches active agents with optional filtering and pagination. Only returns agents where `isActive` is `true`.

**Parameters:**

| Parameter | Type                        | Required | Description                      |
| --------- | --------------------------- | -------- | -------------------------------- |
| `options` | `UaiAgentRepositoryOptions` | No       | Filtering and pagination options |

**Returns:** `Promise<{ data?: { items: UaiAgentItemModel[], total: number }, error?: any }>`

**Example:**

```typescript
// Fetch all active agents
const result = await repository.fetchActiveAgents();
if (result.data) {
    console.log(`Found ${result.data.total} active agents`);
    console.log(result.data.items);
}

// Fetch copilot agents only
const copilotResult = await repository.fetchActiveAgents({
    scopeId: "copilot",
});

// Fetch with pagination
const pagedResult = await repository.fetchActiveAgents({
    take: 10,
    scopeId: "copilot",
});
```

## Options

### UaiAgentRepositoryOptions

Configuration object for filtering and pagination.

```typescript
interface UaiAgentRepositoryOptions {
    /**
     * Filter agents by scope ID (e.g., "copilot").
     */
    scopeId?: string;

    /**
     * Maximum number of agents to return.
     * Default: 100
     */
    take?: number;
}
```

**Examples:**

{% code title="Filter by Scope" %}

```typescript
// Fetch only copilot agents
const result = await repository.fetchActiveAgents({
    scopeId: "copilot",
});
```

{% endcode %}

{% code title="Limit Results" %}

```typescript
// Fetch first 5 active agents
const result = await repository.fetchActiveAgents({
    take: 5,
});
```

{% endcode %}

{% code title="Combined Filtering" %}

```typescript
// Fetch 3 copilot agents
const result = await repository.fetchActiveAgents({
    scopeId: "copilot",
    take: 3,
});
```

{% endcode %}

## Response Model

### UaiAgentItemModel

The repository returns agents as `UaiAgentItemModel` objects:

```typescript
interface UaiAgentItemModel {
    /** Unique identifier (GUID as string) */
    unique: string;

    /** Display name */
    name: string;

    /** URL-safe alias */
    alias: string;

    /** Optional description */
    description?: string;

    /** Scope IDs (e.g., ["copilot"]) */
    scopeIds?: string[];

    /** Active status (always true from this repository) */
    isActive: boolean;

    /** Associated profile ID */
    profileId?: string;
}
```

## Complete Examples

### Agent Dropdown Picker

{% code title="Agent Picker Component" %}

```typescript
import { LitElement, html, css } from "lit";
import { customElement, property, state } from "lit/decorators.js";
import { UaiAgentRepository, type UaiAgentItemModel } from "@umbraco-ai/agent";

@customElement("uai-agent-picker")
export class UaiAgentPicker extends LitElement {
    static styles = css`
        select {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .loading {
            opacity: 0.5;
        }
    `;

    #repository = new UaiAgentRepository(this);

    @property({ type: String })
    scopeId?: string;

    @property({ type: String })
    value?: string;

    @state()
    private _agents: UaiAgentItemModel[] = [];

    @state()
    private _loading = false;

    async connectedCallback() {
        super.connectedCallback();
        await this.#loadAgents();
    }

    async #loadAgents() {
        this._loading = true;

        const result = await this.#repository.fetchActiveAgents({
            scopeId: this.scopeId,
        });

        if (result.data) {
            this._agents = result.data.items;
        } else if (result.error) {
            console.error("Failed to load agents:", result.error);
        }

        this._loading = false;
    }

    #onChange(e: Event) {
        const select = e.target as HTMLSelectElement;
        this.value = select.value;
        this.dispatchEvent(
            new CustomEvent("change", {
                detail: { agentId: this.value },
            }),
        );
    }

    render() {
        return html`
            <select
                class=${this._loading ? "loading" : ""}
                .value=${this.value || ""}
                @change=${this.#onChange}
                ?disabled=${this._loading}
            >
                <option value="">Select an agent...</option>
                ${this._agents.map(
                    (agent) => html`
                        <option value=${agent.unique}>
                            ${agent.name}${agent.description ? ` - ${agent.description}` : ""}
                        </option>
                    `,
                )}
            </select>
        `;
    }
}
```

{% endcode %}

### Agent List with Filtering

{% code title="Filterable Agent List" %}

```typescript
import { LitElement, html, css } from "lit";
import { customElement, state } from "lit/decorators.js";
import { UaiAgentRepository, type UaiAgentItemModel } from "@umbraco-ai/agent";

@customElement("uai-agent-list")
export class UaiAgentList extends LitElement {
    static styles = css`
        .filter {
            margin-bottom: 1rem;
        }
        .agent-card {
            border: 1px solid #ddd;
            padding: 1rem;
            margin-bottom: 0.5rem;
            border-radius: 4px;
        }
        .agent-card h3 {
            margin: 0 0 0.5rem 0;
        }
        .scope-tags {
            display: flex;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }
        .scope-tag {
            background: #e3f2fd;
            padding: 0.25rem 0.5rem;
            border-radius: 3px;
            font-size: 0.875rem;
        }
    `;

    #repository = new UaiAgentRepository(this);

    @state()
    private _agents: UaiAgentItemModel[] = [];

    @state()
    private _selectedScope = "";

    @state()
    private _loading = false;

    async connectedCallback() {
        super.connectedCallback();
        await this.#loadAgents();
    }

    async #loadAgents() {
        this._loading = true;

        const result = await this.#repository.fetchActiveAgents({
            scopeId: this._selectedScope || undefined,
        });

        if (result.data) {
            this._agents = result.data.items;
        }

        this._loading = false;
    }

    async #onScopeChange(e: Event) {
        const select = e.target as HTMLSelectElement;
        this._selectedScope = select.value;
        await this.#loadAgents();
    }

    render() {
        return html`
            <div class="filter">
                <label>
                    Filter by scope:
                    <select @change=${this.#onScopeChange}>
                        <option value="">All scopes</option>
                        <option value="copilot">Copilot</option>
                        <option value="custom">Custom</option>
                    </select>
                </label>
            </div>

            ${this._loading ? html`<div>Loading...</div>` : ""}
            ${this._agents.map(
                (agent) => html`
                    <div class="agent-card">
                        <h3>${agent.name}</h3>
                        <p>${agent.description || "No description"}</p>
                        <div><strong>Alias:</strong> ${agent.alias}</div>
                        ${agent.scopeIds?.length
                            ? html`
                                  <div class="scope-tags">
                                      ${agent.scopeIds.map((scope) => html` <span class="scope-tag">${scope}</span> `)}
                                  </div>
                              `
                            : ""}
                    </div>
                `,
            )}
        `;
    }
}
```

{% endcode %}

### Reactive Agent Count

{% code title="Agent Counter" %}

```typescript
import { LitElement, html } from "lit";
import { customElement, state } from "lit/decorators.js";
import { UaiAgentRepository } from "@umbraco-ai/agent";

@customElement("uai-agent-counter")
export class UaiAgentCounter extends LitElement {
    #repository = new UaiAgentRepository(this);

    @state()
    private _count = 0;

    async connectedCallback() {
        super.connectedCallback();
        await this.#updateCount();

        // Listen for agent changes to update count
        this.addEventListener("uai:agent:created", () => this.#updateCount());
        this.addEventListener("uai:agent:updated", () => this.#updateCount());
        this.addEventListener("uai:agent:deleted", () => this.#updateCount());
    }

    async #updateCount() {
        const result = await this.#repository.fetchActiveAgents();
        if (result.data) {
            this._count = result.data.total;
        }
    }

    render() {
        return html` <div>Active Agents: ${this._count}</div> `;
    }
}
```

{% endcode %}

## Error Handling

The repository returns errors in the result object rather than throwing exceptions:

{% code title="Error Handling" %}

```typescript
const result = await repository.fetchActiveAgents();

if (result.error) {
    console.error("Failed to fetch agents:", result.error);
    // Handle error (show notification, fallback UI, etc.)
} else if (result.data) {
    console.log("Loaded agents:", result.data.items);
    // Use the data
}
```

{% endcode %}

## When to Use This Repository

**Use `UaiAgentRepository` when:**

- You need a simple read-only list of active agents
- You're building pickers, dropdowns, or read-only lists
- You want to filter agents by scope
- You don't need full CRUD operations

**Use `UaiAgentDetailRepository` instead when:**

- You need to create, update, or delete agents
- You need full agent details with all properties
- You're building the agent management UI

**Use `UaiAgentCollectionRepository` instead when:**

- You're implementing a full collection view with Umbraco's collection patterns
- You need advanced filtering and sorting

## Related Repositories

| Repository                     | Purpose                  | Use Case                               |
| ------------------------------ | ------------------------ | -------------------------------------- |
| `UaiAgentRepository`           | Read-only active agents  | Pickers, dropdowns, simple lists       |
| `UaiAgentDetailRepository`     | Full CRUD operations     | Agent editor, management dashboard     |
| `UaiAgentCollectionRepository` | Collection view patterns | Agent list view with sorting/filtering |

## Related

- [Agent Detail Repository](uai-agent-detail-repository.md) - Full CRUD repository
- [UaiAgentClient](../frontend-client.md) - Client for running agents
- [Agent Concepts](../concepts.md) - Understanding agents and scopes
- [Scopes](../scopes.md) - Agent categorization system
