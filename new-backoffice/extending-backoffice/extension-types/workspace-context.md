---
description: Establish the bond for extensions to communication across the application
---

# Workspace Context

Workspace Contexts are used to bring additional context alongside the default context of a workspace.

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

We recommend using `UmbWorkspaceContext` as the Context Alias for your Context Token. This will ensure that the requester only retrieves this Context if it's present at their nearest Workspace Context. Use the Extension Manifest Alias as the API Alias for your Context Token.

[Read more about creating your own Context API here.](broken-reference)
