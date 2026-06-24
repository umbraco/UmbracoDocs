---
description: >-
  A list of all backoffice extension skills organized by category, with
  composition examples and working blueprints.
---

# Overview

65 skills covering every Umbraco backoffice extension type. This is the core of the skills marketplace.

## The Mental Model

Backoffice customizations are **combinations of extension types** working together:

* A "custom admin area" = Section + Menu + Dashboard
* A "data management tool" = Section + Menu + Workspace
* A "hierarchical browser" = Section + Menu + Tree + Workspace

No single extension type does everything. Understanding how they combine is key to building the right thing.

## The Backbone: `umbraco-backoffice`

The most important skill. It provides:

* **Complete Extension Map:** Visual diagram showing where all extension types appear in the backoffice UI.
* **Working Blueprints:**  Copy-and-adapt examples for common patterns.
* **Sub-Skill Reference:** Links to all other skills organized by category.

Use this skill when starting a new backoffice project, understanding how extension types connect, or finding the right skill for a specific UI location.

```bash
/umbraco-backoffice
```

## Skills by Category

### Foundation

Core architectural concepts used across all extensions:

| Skill                        | Description                                         |
| ---------------------------- | --------------------------------------------------- |
| `umbraco-context-api`        | Provider-consumer pattern for data sharing.         |
| `umbraco-repository-pattern` | Data access layer abstraction.                      |
| `umbraco-extension-registry` | Dynamic extension registration.                     |
| `umbraco-conditions`         | Control where extensions appear.                    |
| `umbraco-state-management`   | Reactive UI with @state.                            |
| `umbraco-localization`       | Multi-language support.                             |
| `umbraco-routing`            | URL structure and navigation.                       |
| `umbraco-notifications`      | Toast messages and events.                          |
| `umbraco-umbraco-element`    | Base class for components.                          |
| `umbraco-controllers`        | C# API endpoints.                                   |
| `umbraco-sorter`             | Drag-and-drop sorting with UmbSorterController.     |
| `umbraco-manifest-picker`    | Pick registered extensions with umb-input-manifest. |
| `umbraco-validation-context` | Form validation with UmbValidationContext.          |

### Extension Types

UI extensions for the backoffice:

**Navigation & Sections**

* `umbraco-sections` — Top-level navigation
* `umbraco-menu` / `umbraco-menu-items` — Sidebar menus
* `umbraco-header-apps` — Header bar apps

**Content Areas**

* `umbraco-dashboard` — Welcome panels
* `umbraco-workspace` — Entity editing views
* `umbraco-tree` / `umbraco-tree-item` — Hierarchical navigation
* `umbraco-collection` / `umbraco-collection-view` / `umbraco-collection-action` — List/grid views

**Actions**

* `umbraco-entity-actions` — Context menu actions
* `umbraco-entity-bulk-actions` — Multi-select operations
* `umbraco-entity-create-option-action` — Create menu options
* `umbraco-current-user-action` — User profile actions

**UI Components**

* `umbraco-modals` — Dialogs and sidebars
* `umbraco-icons` — Custom icon sets
* `umbraco-theme` — Backoffice themes
* `umbraco-ufm-component` — Umbraco Flavored Markdown

**Search & Preview**

* `umbraco-search-provider` — Global search
* `umbraco-search-result-item` — Custom result rendering
* `umbraco-preview-app-provider` — Content preview apps

**Advanced**

* `umbraco-global-context` — App-wide shared state
* `umbraco-kinds` — Reusable manifest templates
* `umbraco-dynamic-root` — Content picker configuration
* `umbraco-user-profile-app` — User profile tabs
* `umbraco-health-check` — System health checks
* `umbraco-package-view` — Package configuration UI
* `umbraco-entry-point` / `umbraco-bundle` — Extension lifecycle

### Property Editors

Custom Data Type editors:

| Skill                              | Description                |
| ---------------------------------- | -------------------------- |
| `umbraco-property-editor-ui`       | Visual editor component    |
| `umbraco-property-editor-schema`   | Data validation            |
| `umbraco-property-action`          | Property buttons           |
| `umbraco-property-value-preset`    | Default value templates    |
| `umbraco-file-upload-preview`      | Upload previews            |
| `umbraco-block-editor-custom-view` | Block rendering            |
| `umbraco-picker-data-source`       | Custom picker data sources |

### Rich Text

Tiptap editor customization:

| Skill                                   | Description          |
| --------------------------------------- | -------------------- |
| `umbraco-tiptap-extension`              | Core editor behavior |
| `umbraco-tiptap-toolbar-extension`      | Toolbar buttons      |
| `umbraco-tiptap-statusbar-extension`    | Status bar items     |
| `umbraco-monaco-markdown-editor-action` | Markdown buttons     |

### Backend

Authentication and API integration:

| Skill                               | Description                       |
| ----------------------------------- | --------------------------------- |
| `umbraco-openapi-client`            | **Required for custom API calls** |
| `umbraco-auth-provider`             | External login (OAuth)            |
| `umbraco-mfa-login-provider`        | Two-factor authentication         |
| `umbraco-granular-user-permissions` | Fine-grained access               |

### Tooling

Setup, validation, and project management:

| Skill                             | Description                                                        |
| --------------------------------- | ------------------------------------------------------------------ |
| `umbraco-quickstart`              | Quick setup for extension development.                             |
| `umbraco-extension-template`      | Create extensions using the dotnet template.                       |
| `umbraco-add-extension-reference` | Add extension project references to your solution.                 |
| `package-script-writer`           | Generate installation scripts using the Package Script Writer CLI. |
| `umbraco-validation-checks`       | Browser validation checks for manual testing.                      |
| `umbraco-review-checks`           | Review checks reference for validating extensions.                 |

## How Skills Compose

Skills are designed to work together. Here is how a typical flow looks:

**"I need a custom admin section with a tree and editing workspace."**

1. `umbraco-backoffice` : Understand the pattern, pick the right blueprint.
2. `umbraco-sections` : Create the section (top-level nav tab).
3. `umbraco-menu` + `umbraco-menu-items` : Add sidebar navigation.
4. `umbraco-tree` + `umbraco-tree-item` : Add a hierarchical tree.
5. `umbraco-workspace` : Create the editing workspace.
6. `umbraco-context-api` : Wire up data sharing between components.
7. `umbraco-controllers` + `umbraco-openapi-client` : Backend API if needed.

Each skill provides the correct patterns for its piece. The `umbraco-backoffice` skill shows how the pieces connect.
