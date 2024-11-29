# Workspace Actions

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

Workspace actions are a set of functionalities or operations that can be performed within a workspace. These actions involve creating documents within the workspace, organizing and categorizing documents, publishing content and so on.

Workspace action relates to a workspace alias (Umb.Workspace.Document) and has Access to the workspace context.

<figure><img src="../../../../.gitbook/assets/workspace-actions.svg" alt=""><figcaption><p>Workspace Actions</p></figcaption></figure>

**JavaScript Manifest example**

<pre class="language-javascript"><code class="lang-javascript"><strong>import { extensionRegistry } from '@umbraco-cms/extension-registry';
</strong>import { MyWorkspaceAction } from './my-workspace-action';

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
</code></pre>

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

**Default Element**

```typescript
interface UmbWorkspaceActionElement {}
```
