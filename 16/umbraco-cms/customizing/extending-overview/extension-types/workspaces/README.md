---
description: >-
  Learn about workspace extension types that provide shared functionality and communication within workspace environments.
---

# Extension Types: Workspaces

Workspace extensions provide functionality that operates within specific workspace environments, such as document editing, media management, or member editing. These extensions can communicate through shared workspace contexts to create cohesive, integrated functionality.

## Available Extension Types

Workspace extensions include several types that work together through shared state management:

### Core Extensions
- **[Workspace Context](workspace-context.md)** - Provides shared state management and communication between workspace extensions
- **[Workspace](workspace.md)** - Defines the main workspace environment and routing

### User Interface Extensions  
- **[Workspace Views](workspace-views.md)** - Tab-based content areas for organizing different aspects of entity editing
- **[Workspace Footer Apps](workspace-footer-app.md)** - Persistent status information and contextual data in the footer area

### Action Extensions
- **[Workspace Actions](workspace-editor-actions.md)** - Primary action buttons that appear in the workspace footer
- **[Workspace Action Menu Items](workspace-action-menu-item.md)** - Dropdown menu items that extend workspace actions with additional functionality

## Integration Patterns

Workspace extensions communicate through shared contexts using these patterns:

1. **Workspace Context** manages centralized state using observables that automatically notify subscribers of changes
2. **Workspace Actions** consume the context to modify state when users interact with buttons or menu items
3. **Workspace Views** observe context state to automatically update their UI when data changes  
4. **Footer Apps** monitor context state to display real-time status information

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

## Getting Started

To create a complete workspace extension system:

1. **Start with a [Workspace Context](workspace-context.md)** to provide shared state management
2. **Add [Workspace Actions](workspace-editor-actions.md)** for primary user interactions
3. **Create [Workspace Views](workspace-views.md)** for dedicated editing interfaces
4. **Include [Footer Apps](workspace-footer-app.md)** for persistent status information
5. **Extend actions with [Menu Items](workspace-action-menu-item.md)** for additional functionality

{% hint style="info" %}
All workspace extensions are automatically scoped to their workspace instance, ensuring that extensions in different workspaces cannot interfere with each other.
{% endhint %}

## Example Implementation

For a complete working example that demonstrates all workspace extension types working together, see:

{% content-ref url="../../../../../examples/workspace-context-counter/" %}
[Complete Integration Example](../../../../../examples/workspace-context-counter/)
{% endcontent-ref %}