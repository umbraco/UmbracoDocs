---
description: >-
  Learn about workspace extension types that provide shared functionality and enable communication within workspace environments.
---

# Extension Types: Workspaces

Workspace extensions are specialized components that enhance Umbraco's editing environments for documents, media, and members. They share state through workspace contexts. This enables coordinated functionality like synchronized actions, real-time status updates, and seamless data flow across the editing interface.

## Available Extension Types

Workspace extensions can be grouped into these types:

### Core Extensions
- **[Workspace Context](workspace-context.md)** - Provides shared state management and communication between workspace extensions
- **[Workspace](workspace.md)** - Defines the main workspace environment and routing

### User Interface Extensions  
- **[Workspace Views](workspace-views.md)** - Tab-based content areas for organizing different aspects of entity editing
- **[Workspace Footer Apps](workspace-footer-apps.md)** - Persistent status information and contextual data in the footer area

### Action Extensions
- **[Workspace Actions](workspace-editor-actions.md)** - Primary action buttons that appear in the workspace footer
- **[Workspace Action Menu Items](workspace-action-menu-items.md)** - Dropdown menu items that extend workspace actions with additional functionality

## Integration Patterns

Workspace extensions communicate through shared contexts using these patterns:

1. **[Workspace Context](workspace-context.md)** manages centralized state using observables that automatically notify subscribers of changes
2. **[Workspace Actions](workspace-editor-actions.md)** consume the context to modify state when users interact with buttons or menu items
3. **[Workspace Actions Menu Items](workspace-action-menu-items.md)** add additional options for workspace actions
4. **[Workspace Views](workspace-views.md)** observe context state to automatically update their UI when data changes  
5. **[Footer Apps](workspace-footer-apps.md)** monitor context state to display real-time status information

### Communication Flow

```
Workspace Context (State Management)
       ↕️
Workspace Actions (State Modification) 
       ↕️
Workspace Views (State Display)
       ↕️  
Footer Apps (Status Monitoring)
```

{% hint style="info" %}
All workspace extensions are automatically scoped to their workspace instance, ensuring that extensions in different workspaces cannot interfere with each other.
{% endhint %}
