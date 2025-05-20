---
description: Establish an extension to communicate across the application.
---

# Workspace Context

The general Workspace Context is a container for the data of a workspace. It is a wrapper around the data of the entity that the workspace is working on. It is responsible for loading and saving the data to the server. Workspace Contexts are used to bring additional context alongside the default context of a workspace.

* A workspace context knows about its entity type (for example content, media, member, etc.) and holds its unique string (for example: key).
* Most workspace contexts hold a draft state of its entity data. It is a copy of the entity data that can be modified at runtime and sent to the server to be saved.

You can add additional Workspace Contexts using the `workspaceContext` Extension Type, which allows you to inject custom logic into your own Workspace or another one.

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

The code for such an API file might look like this:

```typescript
import {
    UmbController,
    UmbControllerHost,
} from "@umbraco-cms/backoffice/controller-api";
import { UmbContextBase } from '@umbraco-cms/backoffice/class-api';
import { UmbContextToken } from "@umbraco-cms/backoffice/context-api";
import { UmbNumberState } from "@umbraco-cms/backoffice/observable-api";

export class MyContextApi extends UmbContextBase {
    #counter = new UmbNumberState(0);
    readonly counter = this.#counter.asObservable();

    constructor(host: UmbControllerHost) {
        super(host, My_COUNTER_CONTEXT);
    }

    increment() {
        this.#counter.next(this.#counter.value + 1);
    }
}

// Important to export as api for the Extension Registry to pick up the class:
export const api = MyContextCounterApi;
```

A Context Token for a Workspace Context Extension should look like this:

```typescript
export const My_COUNTER_CONTEXT = new UmbContextToken<MyContextCounterApi>(
    "UmbWorkspaceContext",
    "My.WorkspaceContext.Counter"
);
```

It is recommended to use `UmbWorkspaceContext` as the Context Alias for your Context Token. This will ensure that the requester only retrieves this Context if it's present at their nearest Workspace Context. Use the Extension Manifest Alias as the API Alias for your Context Token to ensure its unique. For more information, see the [Context API](../../../foundation/working-with-data/context-api.md) article.

## Use the Workspace Context

The following example declares an element that will be present in the same workspace for which the workspace context is provided. In this particular example, it is a workspace view that will be registered to the `Umb.Workspace.Document` workspace.

```typescript
import { My_COUNTER_CONTEXT } from './example-workspace-context.js';
import { UmbTextStyles } from '@umbraco-cms/backoffice/style';
import { css, html, customElement, state, LitElement } from '@umbraco-cms/backoffice/external/lit';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';

@customElement('example-counter-workspace-view')
export class ExampleCounterWorkspaceView extends UmbElementMixin(LitElement) {
	
	#counterContext?: typeof My_COUNTER_CONTEXT.TYPE;

	@state()
	private count = 0;

	constructor() {
		super();
		this.consumeContext(My_COUNTER_CONTEXT, (context) => {
			this.#counterContext = context;
			this.observe(this.#counterContext.counter, (count) => {
			this.count = count;
		});
	}

	#onClick() {
		this.#counterContext?.increment();
	}

	override render() {
		return html`
			Current count value: ${this.count}
			<uui-button @click=${this.#onClick} label="Increment"></uui-button>
		`;
	}
}

// Important to export as 'element' otherwise the Extension Registry cannot pick up the class.
export const element = ExampleCounterWorkspaceView
```

Manifest to register this:

<pre><code>{
    type: 'workspaceView',
<strong>    name: 'Example Counter Workspace View',
</strong>    alias: 'example.workspaceView.counter',
    element: () => import('./example-workspace-view.js'),
    weight: 900,
    meta: {
        label: 'Counter',
        pathname: 'counter',
        icon: 'icon-lab',
    },
    conditions: [
        {
	    alias: UMB_WORKSPACE_CONDITION_ALIAS,
            match: 'Umb.Workspace.Document',
        },
    ],
}
</code></pre>

