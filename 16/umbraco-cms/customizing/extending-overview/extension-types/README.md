---
description: >-
    An overview of general extension types available in the Umbraco backoffice.
---

# Extension Types

## General Features

Extension Types in Umbraco allow developers to extend and customize the behavior of the backoffice. Each type provides unique functionality, such as creating custom dashboards, enhancing entity actions, or enabling localization. Learn more about the shared properties and overall structure in the [Extension Manifest](../extension-registry/extension-manifest.md) article.

## Common Extension Types

The **Umbraco backoffice** provides **Extension Types** designed to meet a variety of customization needs. These include extensions tailored for specific functionalities, as well as general-purpose extensions for broader use cases.

### [App Entry Point](app-entry-point.md)

The `App Entry Point` extension type is used to execute JavaScript when Umbraco starts up. The code will run before the user has logged in or the backoffice has initialized.

### [Backoffice Entry Point](backoffice-entry-point.md)

The `backofficeEntryPoint` extension type is used to execute JavaScript upon initialization of the backoffice. This extension type provides lifecycle hooks (startup, teardown) for extension developers to customize backoffice behavior.

### [Block Custom View](block-custom-view.md)

The `blockEditorCustomView` extension type is used to define a custom web component for representing blocks inside the Umbraco block grid property editor.

### [Bundle](bundle.md)

The `bundle` extension type is used to aggregate multiple extension manifests into a single entity, which will be registered at startup.

### [Dashboards](dashboard.md)

The `dashboard` extension type enables extension authors to create custom informational panels that can be displayed in the Umbraco backoffice. These extensions can be added to existing Umbraco sections or to a custom section.

### [Entity Actions](entity-actions.md)

The `entityAction` extension type is used to create menus for operations on an entity such as a document or media item. Built-in backoffice examples include: "Trash", "Duplicate to...", "Publish" etc.

### [Entity Bulk Actions](entity-bulk-actions.md)

The `entityBulkAction` extension type works similarly to the **Entity Actions** extension type, but performs the actions on a selection of entities from a collection.

### [Entity Create Option Action](entity-create-option-action.md)

The `entityCreateOptionAction` extension type is used to provide custom entity creation actions via a dedicated modal interface.

### [Extension Conditions](condition.md)

Most extension types support conditions which allow extension authors to control when and where the extension is available. This type enables extension authors to define their own conditions.

### [Global Context](global-context.md)

The `globalContext` extension type creates a custom context of data and functions, accessible throughout the entire backoffice and the entirety of the session.

### [Header Apps](header-apps.md)

The `headerApp` extension type is used to place single-purpose extensions in the top-level navigation bar. These extensions appear next to the user profile.

### [Icons](icons.md)

The `icons` extension type is used to make custom icon extension sets available in the Umbraco backoffice and in custom Umbraco UI components. Extension authors provide SVG files and register them using this extension type.

### [Kinds](kind.md)

The `kind` extension type is used to create custom extension configurations to be used as the basis of other custom extension types. They can be inherited by other extension types.

### [Localization](localization.md)

The `localization` extension type is used to register additional languages and files of translation strings that can be used in Umbraco backoffice extensions.

### [Menu](menu.md)

The `menu` extension type is used to create custom menus. These can be placed in sidebar extensions or displayed as a fly-out from a button, header, or workspace view.

### [Modals](modals/README.md)

The `modal` extension type is used to configure and present dialogs and sidebars within the Umbraco backoffice.

### [Property Value Preset](property-value-preset.md)

The `propertyValuePreset` extension type is used to customize the default value of a property editor and allow for dynamic behavior through hooks.

### [Sections](sections/README.md)

The `section` extension type is used to place top-level navigation items within the Umbraco backoffice. Custom Section extensions appear alongside Content, Media, Settings, and others, as seen in the purple navigation bar.

### [Trees](tree.md)

The `tree` extension type is used to create a hierarchical structure composed of nodes, such as documents, media extensions, or toolbar extensions.

### [Workspaces](workspaces/README.md)

The `workspace` extension type provides functionality that operates within specific workspace environments, such as document editing, media management, or member editing.

## Even More Extension Types

### [Property Level UI Permissions](../../property-level-ui-permissions.md)

Umbraco allows system administrators to define read and write permissions on an individual property basis. `Property Level UI Permissions` can be created to define customized rules to fit any use case.

### [Tip-Tap Extensions](../../../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor/extensions.md)

The Tip-Tap editor is the default text editor in Umbraco. Tip-Tap can be extended with either native extensions or toolbar button extensions.

### [Umbraco Flavored Markup Components](../../../reference/umbraco-flavored-markdown.md)

`Umbraco Flavored Markup (UFM) Components`, are used to create descriptions and labels for entities across the backoffice. These replace the previous "Label Property Configuration" feature. Extension authors can create custom components that go beyond textual labels, including creating hooks that allow for imperative programming tasks and custom markup.

## Extension Insights Browser

Umbraco provides a number of additional extension types that can be used to extend the backoffice. The backoffice contains an interactive browser for exploring all available extension types. This feature also allows users to confirm that their own backoffice extensions are found and loaded by the backoffice.

To use the Extension Insights browser, navigate to the **Settings** section of the backoffice and select **Extension Insights** from the sidebar. A comprehensive list of available types can be found in the dropdown menu to the right.

<figure><img src="../../../.gitbook/assets/extension-types-backoffice-browser.png" alt=""><figcaption><p>Backoffice extension browser</p></figcaption></figure>
