---
description: >-
    An overview of general extension types available in the Umbraco backoffice.
---

# Extension Types

## General Features

Extension Types in Umbraco allow developers to extend and customize the behavior of the backoffice. Each type provides
unique functionality designed for specific tasks, such as creating custom dashboards, enhancing entity actions, or
enabling localization. Learn more about the shared properties and overall structure in the
[Extension Manifest](../extension-registry/extension-manifest.md) article.

## General Extension Types

The **Umbraco backoffice** provides **Extension Types** designed to meet a variety of customization needs. These include
extensions tailored for specific functionalities, as well as general-purpose extensions for broader use cases.

### [App Entry Point](app-entry-point.md)

The **App Entry Point** extension type is used to execute JavaScript code at Umbraco startup, and before the user has
logged into or initialized the backoffice.

### [Backoffice Entry Point](backoffice-entry-point.md)

The `backofficeEntryPoint` extension type is used to execute JavaScript upon initialization of the backoffice. This
extension type provides lifecycle hooks (startup, teardown) for extension developers to customize backoffice behavior.

### [Block Custom View](block-custom-view.md)

The `blockEditorCustomView` extension type is used to define a custom web component for representing blocks inside the
Umbraco block grid property editor.

### [Bundle](bundle.md)

The `bundle` extension type is used to aggregate multiple extension manifests into a single entity, which will be
registered at startup.

### [Dashboards](dashboard.md)

The `dashboard` extension type enables extension authors to create custom informational panels that can be displayed
in the Umbraco backoffice. These extensions can be added to existing Umbraco sections or to a custom section.

### [Entity Actions](entity-actions.md)

The `entityAction` extension type is used to create fly-out submenus that offer actionable functions towards an
entity (document nodes, media files). These commonly contain actions like: Trash, Duplicate To..., Publish and
Unpublish, or any action that an extension author creates.

### [Entity Bulk Actions](entity-bulk-actions.md)

The `entityBulkAction` extension type works similarly to the **Entity Actions** extension type, but with the
ability to perform the actions on a collection or selection of entities.

### [Entity Create Option Action](entity-create-option-action.md)

The `entityCreateOptionAction` extension type is used to provide custom entity creation actions via a dedicated
modal interface.

### [Extension Conditions](condition.md)

Most Extension Types support conditions which allow extension authors to control when and where the Extension is
available/visible. This Type enables extension authors to define their own conditions.

### [Global Context](global-context.md)

The `globalContext` extension type creates a custom context of data and functions, accessible throughout the entire
backoffice and the entirety of the session.

### [Header Apps](header-apps.md)

The `headerApp` extension type is used to place single-purpose extensions in the top-level navigation bar. These
extensions appear next to the user profile.

### [Icons](icons.md)

The `icons` extension type is used to make custom icon extension sets available in the Umbraco backoffice and in
custom Umbraco UI components. Extension authors provide SVG files and register them using this extension type.

### [Kinds](kind.md)

The `kind` extension type is used to create custom extension configurations that can be used as the basis of, or
inherited by, other custom extension types.

### [Localization](localization.md)

The `localization` extension type is used to register additional languages and files of translation strings that can
be used in Umbraco backoffice extensions.

### [Menu](menu.md)

The `menu` extension type is used to create custom menus that can be placed in sidebar extensions or displayed as a
fly-out from a button, header, or content app.

### [Modals](modals/README.md)

The `modal` extension type is used to configure and present dialogs and sidebars within the Umbraco backoffice.

### [Property Value Preset](property-value-preset.md)

The `propertyValuePreset` extension type is used to customize the default value of a property editor and allow for
dynamic behavior through hooks.

### [Sections](sections/README.md)

The `section` extension type is used to place top-level navigation items within the Umbraco backoffice. Custom
Section extensions appear alongside Content, Media, Settings, and others, as seen in the purple navigation bar.

### [Trees](tree.md)

The `tree` extension type is used to create a hierarchical structure composed of nodes, such as documents or media
items.

### [Workspaces](workspaces/README.md)

The `workspace` extension type provides functionality that operates within specific workspace environments, such as
document editing, media management, or member editing.

