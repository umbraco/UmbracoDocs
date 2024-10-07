---
description: Establish an extension to communicate across the application.
---

# Workspace Context

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

A Workspace context is a container for the data of a workspace. It is a wrapper around the data of the entity that the workspace is working on. It is responsible for loading and saving the data to the server. Workspace Contexts are used to bring additional context alongside the default context of a workspace.

* A workspace context knows about its entity type (for example content, media, member, etc.) and holds its unique string (for example: key).
* Most workspace contexts hold a draft state of its entity data. It is a copy of the entity data that can be modified at runtime and sent to the server to be saved.

If a workspace wants to utilize Property Editor UIs, then it must provide a variant context for the property editors. The variant-context is the generic interface between workspace and property editors.&#x20;

```ts
interface UmbWorkspaceContext {}
```

## Example of Workspace

## Example of Workspace Context

The API will be initiated with the same host as the default Workspace Context.

```typescript
{
    type: 'workspaceContext',
    alias: 'My.WorkspaceContext.Counter',
    name: 'My Counter Context',
    api: 'my-workspace-counter.context.js',
    conditions: [
        {
            alias: 'Umb.Condition.WorkspaceAlias',
            match: 'Umb.Workspace.Document',
        }
    ]
}
```

The code of such an API file could look like this:

```typescript
import {
    UmbController,
    UmbControllerHost,
} from "@umbraco-cms/backoffice/controller-api";
import { UmbContextToken } from "@umbraco-cms/backoffice/context-api";
import { UmbNumberState } from "@umbraco-cms/backoffice/observable-api";

export class MyContextApi extends UmbController {
    #counter = new UmbNumberState(0);
    readonly counter = this.#counter.asObservable();

    constructor(host: UmbControllerHost) {
        super(host);
        this.provideContext(UMB_APP_CONTEXT, this);
    }

    increment() {
        this.#counter.next(this.#counter.value + 1);
    }
}

export const api = MyContextCounterApi;
```

{% hint style="info" %}
Context APIs have to be self-providing. To do so it has to be an Umbraco Controller.
{% endhint %}

A Context Token for a Workspace Context Extension should look like this:

```typescript
export const UMB_APP_CONTEXT = new UmbContextToken<MyContextCounterApi>(
    "UmbWorkspaceContext",
    "My.WorkspaceContext.Counter"
);
```

We recommend using `UmbWorkspaceContext` as the Context Alias for your Context Token. This will ensure that the requester only retrieves this Context if it's present at their nearest Workspace Context. Use the Extension Manifest Alias as the API Alias for your Context Token. For more information, see the [Context API](../../../customizing/foundation/working-with-data/context-api.md) article.
