# Workspace Actions

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

Workspace actions are a set of functionalities or operations that can be performed within a workspace. These actions involve creating documents within the workspace, organizing and categorizing documents, publishing content and so on.

**JavaScript Manifest example**

```javascript
import { extensionRegistry } from '@umbraco-cms/extension-registry';
import { MyWorkspaceAction } from './my-workspace-action';

const manifest = {
	type: 'workspaceAction',
	alias: 'My.WorkspaceAction',
	name: 'My Workspace Action',
	meta: {
		label: 'My Action',
		api: MyWorkspaceAction,
	},
	conditions: [
		{
			alias: 'Umb.Condition.WorkspaceAlias',
			match: 'My.Workspace',
		},
	],
};

extensionRegistry.register(manifest);
```

## The Workspace Action Class

As part of the Extension Manifest you can attach a class that will be instantiated as part of the action. It will have access to the host element and the Workspace Context. When the action is clicked the `execute` method on the API class will be run. When the action is completed, an event on the host element will be dispatched to notify any surrounding elements.

```ts
import { UmbWorkspaceActionBase } from '@umbraco-cms/backoffice/workspace';

export class MyWorkspaceAction extends UmbWorkspaceActionBase {
	execute() {
		this.workspaceContext.myAction(this.selection);
	}
}
```
