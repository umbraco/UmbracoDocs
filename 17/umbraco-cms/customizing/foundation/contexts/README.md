---
description: Contexts are APIs that are made available via the Context API. This section describes how some of the most commonly used Contexts work and how they can be utilized.
---

# Contexts

The following section describes a specific Context. It is recommended to learn the Context API first. [Read more about the Context API here](../context-api/README.md).

## Common Contexts

### Current User Context

Provides access to the authenticated backoffice user. Use this to retrieve user details, check permissions, or customize experiences based on the current user.

### Section Context

Provides information about the currently active backoffice section, including its alias, path name, and label. Use this to adapt UI and behavior based on which section the user is working in.

### Workspace Context

Manages the editing environment for a specific entity. Handles entity data, tracks differences between new and existing state, manages validation and save operations, and controls workspace routing.

### [Property Dataset Context](property-dataset-context.md)

**This is the recommended context for Property Editors.**

Provides access to property values for reading and writing. This is the only context always available from a Property Editor perspective. It works consistently across documents, media, blocks, and Data Type configs.

### Property Context

Represents a single property on a content item. Provides access to the property's value, configuration, validation settings, variant information, and metadata like alias, label, and description.

### Modal Context

Manages modal dialog lifecycle and data flow. Used to read input data, set return values, and control how the modal closes (via submit or cancel).

### Entity Context

Identifies the entity currently in scope by providing the entity type and unique ID. Use this to target entity actions, enable conditional UI, or identify the current entity.

### App Language Context

Manages the currently selected content language for editing. Tracks which language variant is being viewed/edited and provides the list of configured languages.

### Workspace Split View Context

Manages a single pane in split-view editing. Tracks which variant is displayed in the pane and enables switching variants or opening/closing panes for side-by-side comparison.

### Block Entry Context

Manages a single block instance within Block List, Block Grid, or Rich Text Editor. Provides access to block data, settings, and operations like edit, delete, and expose.

### Parent Entity Context

Provides information about the immediate parent entity in hierarchical structures. Use this for creating child entities or building navigation.

### Ancestors Entity Context

Provides the full ancestor path from root to current entity. Use this for permission inheritance, breadcrumbs, or validating move/copy operations.
