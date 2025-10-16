# Workspaces

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

Workspaces provide dedicated editing environments for specific entity types in Umbraco. They create isolated areas where users can edit content, media, members, or other entities with specialized interfaces and functionality.

## Key Concepts

**Entity-Based Structure**: Each workspace is designed for a specific entity type (content, media, member, etc.) and is identified by a unique string (such as a key or ID).

**Draft State Management**: Workspaces maintain a draft copy of entity data that can be modified without affecting the published version until explicitly saved.

**Flexible Interface**: Workspaces can range from simple single-view interfaces to complex multi-tabbed editors with specialized functionality.

**Shared Communication**: Workspaces host workspace contexts that enable all extensions within the workspace to communicate and share state.

<figure><img src="../.gitbook/assets/workspace.svg" alt=""><figcaption><p>Workspace</p></figcaption></figure>

```ts
interface UmbWorkspaceElement {}
```

## Extension Types

Workspaces support several extension types that work together to create comprehensive editing experiences. These extensions communicate through shared workspace contexts to provide integrated functionality:

### [Workspace Context](extending-overview/extension-types/workspaces/workspace-context.md)
The foundation extension that provides shared state management and communication between all workspace extensions. Start here when building workspace functionality.

### [Workspace Views](extending-overview/extension-types/workspaces/workspace-views.md)
Create tab-based content areas within workspaces for organizing different aspects of entity editing. These appear as tabs in the main workspace area.

### [Workspace Actions](extending-overview/extension-types/workspaces/workspace-editor-actions.md)
Add primary action buttons to workspace footers for user interactions like save, publish, or custom operations.

### [Workspace Action Menu Items](extending-overview/extension-types/workspaces/workspace-action-menu-items.md)
Extend workspace actions with dropdown menu items to provide additional functionality without cluttering the footer.

### [Workspace Footer Apps](extending-overview/extension-types/workspaces/workspace-footer-apps.md)
Display persistent status information and contextual data in the workspace footer area for always-visible information.