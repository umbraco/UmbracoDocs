# Workspaces

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

A Workspace is the editor for a specific entity type. It can either be a view of data or a complex editor with multiple views.

* A workspace is based on an entity type (for example content, media, member, etc.) and a unique string (ex: key).
* Most workspaces hold a draft state of an entity. It is a copy of the entity data that can be modified at runtime and sent to the server to be saved.
* A workspace can be a single view or consist of multiple views.
* A workspace should host a workspace context, with which anything within can communicate.

<figure><img src="../.gitbook/assets/workspace.svg" alt=""><figcaption><p>Workspace</p></figcaption></figure>

```ts
interface UmbWorkspaceElement {}
```

## Extension Types

Workspaces support several extension types that work together to create comprehensive editing experiences:

### [Workspace Context](extending-overview/extension-types/workspaces/workspace-context.md)
Provides shared state management and communication between workspace extensions.

### [Workspace Views](extending-overview/extension-types/workspaces/workspace-views.md)
Create tab-based content areas within workspaces for organizing different aspects of entity editing.

### [Workspace Actions](extending-overview/extension-types/workspaces/workspace-editor-actions.md)
Add action buttons to workspace footers for primary user interactions.

### [Workspace Action Menu Items](extending-overview/extension-types/workspaces/workspace-action-menu-item.md)
Extend workspace actions with dropdown menu items for additional functionality.

### [Workspace Footer Apps](extending-overview/extension-types/workspaces/workspace-footer-app.md)
Display persistent status information and contextual data in the workspace footer.

## Complete Integration Example

{% content-ref url="../../examples/workspace-context-counter/" %}
[Workspace Extensions Complete Example](../../examples/workspace-context-counter/)
{% endcontent-ref %}

The workspace-context-counter example demonstrates all 5 workspace extension types working together as an integrated system, showcasing how they communicate through shared workspace context to create cohesive functionality.
