---
description: An extension begins with a Umbraco Package
---

# Umbraco Package

A Package is declared via an Umbraco Package JSON file. This describes the Package and declares one or more UI Extensions. The Package declaration is a JSON file that is stored in the `App_Plugins/{YourPackageName}` folder. The file is named `umbraco-package.json`.

## Sample

Here is a sample package. It should be stored in a folder in `App_Plugins/{YourPackageName}`, with the name `umbraco-package.json`. In this example, the package name is `SirTrevor` and is a text box property Data Type.

{% hint style="info" %}
Before Umbraco 14, a package was declared in a `package.manifest` file instead of `umbraco-package.json`. The old format is no longer supported, but you can migrate the contents to the new format.
{% endhint %}

{% code title="umbraco-package.json" lineNumbers="true" %}
```json
{
    "id": "My.Nuget.Package",
    "name": "Sir Trevor",
    "version": "1.0.0-beta",
    "extensions": [
        {
            "type": "propertyEditorUi",
            "alias": "Sir.Trevor",
            "name": "Sir Trevor Property Editor UI",
            "element": "/App_Plugins/SirTrevor/SirTrevor.js",
            "meta": {
                "label": "Sir Trevor",
                "propertyEditorSchemaAlias": "Umbraco.TextBox",
                "icon": "icon-code",
                "group": "Pickers"
            }
        }
    ]
}
```
{% endcode %}

## Root fields

The `umbraco-package` accepts these fields:

```json
{
    "id": "",
    "name": "",
    "version": "",
    "allowTelemetry": true,
    "allowPublicAccess": false,
    "importmap": {
        "imports": {
            "": ""
        },
        "scopes": {
            "": ""
        }
    },
    "extensions": []
}
```

### Id

The unique identifier for your package. This is used to identify your package and should be unique to your package. If you are creating a package that is distributed via NuGet, you should use the NuGet package ID as the ID for your package.

### Name

Allows you to specify a friendly name for your package that will be used for telemetry. If no name is specified the name of the folder will be used instead.

### Version

The version of your package, if this is not specified there will be no version-specific information for your package. This is used for telemetry and to help users understand what version of your package they are using. It is also used for package migrations. The version should follow the [Semantic Versioning](https://semver.org/) format.

### Allow Telemetry

With this field, you can control the telemetry of this package, this will provide Umbraco with the knowledge of how many installations use this package.

The default is `true`.

Also known as: `allowPackageTelemetry`

### Allow Public Access

This field is used to allow public access to the package. If set to `true`, the package will be available for anonymous usage, for example on the login screen. If set to `false`, the package will only be available to logged-in users.

The default is `false`.

### Importmap

The `importmap` field is an object that contains two properties: `imports` and `scopes`. This is used to define the import map for the package. The `imports` property is an object that contains the import map for the package. The `scopes` property is an object that contains the scopes for the package.

**Example**

This example shows how to define an import map for a module exported by a package:

{% code title="umbraco-package.json" lineNumbers="true" %}
```json
{
    "importmap": {
        "imports": {
            "mypackage/services": "/App_Plugins/MyPackage/services/index.js",
        }
    }
}
```
{% endcode %}

The `imports` object contains the import map for the package. The key is the specifier for the module that is being imported, and the value is the URL of the module.

This allows developers to consume modules that are exported by a package without having to know the exact path to the module:

{% code title="index.js" %}
```javascript
import { MyService } from 'mypackage/services';
```
{% endcode %}

Umbraco supports the current specification of the property as outlined on MDN Web Documentation: [importmap](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script/type/importmap).

### Extensions

The `extensions` field is an array of Extension Manifest objects. Each object describes a single client extension.

Read more about these in the [Extension Manifests article](extending-overview/extension-registry/extension-manifest.md).

These are the current types of UI Extensions:

| Type                       | Description                                                                                                                                                                                                                                                                                                                                                                         |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| authProvider               | An authentication provider for [external login](../reference/security/external-login-providers.md).                                                                                                                                                                                                                                                                                 |
| appEntryPoint              | An app entry point is a JavaScript module that is executed when any app is loaded (Login, Installer, Upgrader, and Backoffice). It will never be destroyed. Read more about [Entry Points](extending-overview/extension-types/app-entry-point.md).                                                                                                                           |
| backofficeEntryPoint       | A backoffice entry point is a JavaScript module that is executed when the backoffice is loaded. It will be destroyed when the backoffice is closed or logged out. Read more about [Entry Points](extending-overview/extension-types/backoffice-entry-point.md).                                                                                                                     |
| blockEditorCustomView      | A custom view for a block in the block editor.                                                                                                                                                                                                                                                                                                                                      |
| bundle                     | A bundle is a collection of other manifests that can be loaded together. You would use this in lieu of a `backofficeEntryPoint` if all you needed was to load extensions through JavaScript.                                                                                                                                                                                        |
| condition                  | A condition that can be used to control the visibility of other UI Extensions. Read more about [Conditions](extending-overview/extension-types/condition.md).                                                                                                                                                                                                                       |
| currentUserAction          | A current user action is a button that can be added to the current user view.                                                                                                                                                                                                                                                                                                       |
| dashboard                  | A dashboard is a view that can be added to any section. It is displayed in the dashboard view with tabs. Read more about [Dashboards](extending-overview/extension-types/dashboard.md).                                                                                                                                                                                             |
| dashboardCollection        | A dashboard collection is a view that can be added to a collection.                                                                                                                                                                                                                                                                                                                 |
| dynamicRootOrigin          | A dynamic root origin is a dynamic root origin that can be added to the Dynamic Root selector.                                                                                                                                                                                                                                                                                      |
| dynamicRootQueryStep       | A dynamic root query step is a query step that can be added to the Dynamic Root selector.                                                                                                                                                                                                                                                                                           |
| entityAction               | An entity action is a button that can be added to any entity, like a document, media, member, etc. It will be shown in the entity actions menu and in the entity actions menu.                                                                                                                                                                                                      |
| entityBulkAction           | An entity bulk action is a button that can be added to the bulk actions menu, which is shown when multiple entities are selected in a collection view.                                                                                                                                                                                                                              |
| entryPoint                 | (Deprecated) Old name for `backofficeEntryPoint`.                                                                                                                                                                                                                                                                                                                                   |
| globalContext              | A global context is a context instance that is available to all components in the Backoffice. It is used to share state between components and to provide a way to communicate between components. Read more about [Global Context](extending-overview/extension-types/global-context.md).                                                                                          |
| granularUserPermissions    | A granular user permission is a permission that can be added to a user. It is used to control access to specific parts of the Backoffice.                                                                                                                                                                                                                                           |
| headerApp                  | A header app is a component that can be added to the header such as a button or a link. Read more about [Header Apps](extending-overview/extension-types/header-apps.md).                                                                                                                                                                                                           |
| healthCheck                | A health check is a check that can be added to the health check dashboard. Read more about the backend side of [Health Checks](../reference/configuration/healthchecks.md).                                                                                                                                                                                                         |
| icons                      | An icon is a set of icons that can be added to the icon picker. Read more in the [Icons article](extending-overview/extension-types/icons.md).                                                                                                                                                                                                                                      |
| localization               | A localization is a set of translations that can be added to the localization service. Read more about [Localization](foundation/localization.md) in the UI.                                                                                                                                                                                                                        |
| menu                       | A menu is a component that can be added to the menu bar. Read more about [Menus](extending-overview/extension-types/menu.md).                                                                                                                                                                                                                                                       |
| menuItem                   | A menu item is a component that can be added to a menu.                                                                                                                                                                                                                                                                                                                             |
| mfaLoginProvider           | This type of login provider is the UI component of [Two-Factor Authentication](../reference/security/two-factor-authentication.md) used to enable/disable the provider.                                                                                                                                                                                                             |
| modal                      | A modal dialog. Read more about [Modals](extending-overview/extension-types/modals/).                                                                                                                                                                                                                                                                                               |
| monacoMarkdownEditorAction | A Monaco Markdown Editor action is a button that can be added to the toolbar of the [Markdown Property Editor](../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/markdown-editor.md).                                                                                                                                                                   |
| packageView                | A package view is an optional view that can be shown in the "Packages" section of the Backoffice. The user can navigate to this view to see more information about the package and to manage it.                                                                                                                                                                                    |
| previewAppProvider         | A preview app provider is a provider that can be used to provide a preview app for the Save and Preview action on a document.                                                                                                                                                                                                                                                       |
| propertyAction             | A property action is a button that can be added to the property actions menu.                                                                                                                                                                                                                                                                                                       |
| propertyEditorSchema       | A property editor schema is a model that describes a Data Editor and its properties from the backend to the UI. It is used by Property Editor UIs. Read more about [Property Editors](property-editors/).                                                                                                                                                                           |
| propertyEditorUi           | A property editor UI is a UI component that can be added to content types. It is used to render the UI of a Data Editor. Read more about [Property Editors](property-editors/).                                                                                                                                                                                                     |
| searchProvider             | A search provider is a provider that can be used to provide search results for the search bar in the Backoffice.                                                                                                                                                                                                                                                                    |
| searchResultItem           | A search result item is a component that can be added to the search results.                                                                                                                                                                                                                                                                                                        |
| theme                      | A theme is a set of styles that can be added to the Backoffice. The user can select their preferred theme in the current user modal.                                                                                                                                                                                                                                                |
| tinyMcePlugin              | A TinyMCE plugin is a plugin that can be added to the TinyMCE editor. Read more about [TinyMCE Plugins](../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor-tinymce/plugins.md).                                                                                                                                                             |
| tiptapExtension            | A Tiptap extension is a component that can be added to the [Rich text editor](../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor/README.md).                                                                                                                                                                                                 |
| tiptapToolbarExtension     | A Tiptap toolbar extension is a component that can be added to the toolbar of the [Rich text editor](../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor/README.md).                                                                                                                                                                        |
| tiptapStatusbarExtension | A Tiptap status bar extension is a component that can be added to the status bar of the [Rich text editor](../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor/README.md).                                                                                                                                                                     |
| treeItem                   | A tree item that can be added to the tree.                                                                                                                                                                                                                                                                                                                                          |
| tree                       | A tree that can be added to a section.                                                                                                                                                                                                                                                                                                                                              |
| ufmComponent               | This type of component is a formatter that can be added to the [Umbraco Flavoured Markdown](../reference/umbraco-flavored-markdown.md), which is used in property descriptions and advanced labels. |
| userProfileApp             | A user profile app is a component that can be added to the current user view.                                                                                                                                                                                                                                                                                                       |

**Collections**

| Type             | Description                                                                |
| ---------------- | -------------------------------------------------------------------------- |
| collection       | A collection to show a list of entities (documents, media, members, etc.). |
| collectionAction | A collection action is a button that can be added to a collection view.    |
| collectionView   | A collection view is a view that can be added to a collection.             |

**Stores and repositories**

| Type       | Description                                                                                                                                                                                                                                                                               |
| ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| repository | A repository is a class that can be used to interact with a data source. It is used either by context classes or elements directly to interact with the data source. It typically holds a `store` instance. Read more about [Repositories](foundation/working-with-data/repositories.md). |
| store      | A store is a context instance that is available to repositories. It is used by repositories to store data. Read more about [Stores](foundation/working-with-data/store.md).                                                                                                               |
| itemStore  | An item store is a store that can be used to store items. It is used by repositories to store items.                                                                                                                                                                                      |
| treeStore  | A tree store is a store that can be used to store tree data. It is used by tree repositories to store tree data.                                                                                                                                                                          |

**Sections**

| Type              | Description                                                                                                                                                                                                                                                                                                                                           |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| section           | A section is a section that can be added to the navigation bar of the Backoffice like the "Content" or "Media" sections that are built-in. Read more about [Sections](extending-overview/extension-types/sections/section.md).                                                                                                                        |
| sectionRoute      | A section route is a route that can be added to a section. It is used to define the URL of the view that is displayed in the main content area of the Backoffice.                                                                                                                                                                                     |
| sectionSidebarApp | A section sidebar app that can be added to the section sidebar. Read more about [Section Sidebar Apps](extending-overview/extension-types/sections/section-sidebar.md).                                                                                                                                                                               |
| sectionView       | A section view is a view that can be added to a section. It is displayed in the main content area of the Backoffice. More than one view can be added to a section, and the user can switch between them. In that case, the views are displayed as tabs. Read more about [Section Views](extending-overview/extension-types/sections/section-view.md). |

**Workspaces**

| Type                    | Description                                                                                                                                                                                                                                                                                                                                                       |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| workspace               | A workspace is a component that can be added to an entity type. This is the editor you see, when you edit an entity. Read more about [Workspaces](workspaces.md).                                                                                                                                                                                                 |
| workspaceActionMenuItem | A workspace action menu item is a button that can be added to the workspace action menu.                                                                                                                                                                                                                                                                          |
| workspaceAction         | A workspace action is a button that can be added to the workspace such as the "Save" button. Read more about [Workspace Actions](extending-overview/extension-types/workspaces/workspace-editor-actions.md).                                                                                                                                                      |
| workspaceContext        | A workspace context is a context instance that is available to all components in the workspace. It is used to share state between components and to provide a way to communicate between components. Read more about [Workspace Context](extending-overview/extension-types/workspaces/workspace-context.md).                                                     |
| workspaceFooterApp      | A workspace footer app is a component that can be added to the workspace footer.                                                                                                                                                                                                                                                                                  |
| workspaceView           | A workspace view is a view that can be added to a workspace. It is displayed in the main content area of the workspace. More than one view can be added to a workspace, and the user can switch between them. In that case, the views are displayed as tabs. Read more about [Workspace Views](extending-overview/extension-types/workspaces/workspace-views.md). |

Read more about [Extension Types](extending-overview/extension-types/README.md) in the Backoffice to get a better understanding of the different types of extensions.

## Package Manifest IntelliSense

Make your IDE be aware about the opportunities of the `umbraco-package.json` by adding a JSON schema. This gives your code editor abilities to autocomplete and knowledge about the format. This helps to avoid mistakes or errors when editing the `umbraco-package.json` file.

### Adding inline schema

Editors like Visual Studio can use the `$schema` notation in your file.

```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": ""
}
```

Hover over any of the properties to see the description of the property. You can also use the `Ctrl + Space` (Windows/Linux) or `CMD + Space` (macOS) shortcut to see the available properties.

## Load Package Manifest files

Umbraco scans the `App_Plugins` folder for `umbraco-package.json` files **two levels deep**. When found, the packages are loaded into the system.

You may need to restart the application, if you add a new file or modify an existing manifest:

If the runtime mode is `Production`, the manifests are cached for 30 days or until the application is restarted to improve performance. In other runtime modes, the cache is cleared every 10 seconds.

{% hint style="info" %}
You can implement the interface [IPackageManifestReader](https://apidocs.umbraco.com/v15/csharp/api/Umbraco.Cms.Infrastructure.Manifest.IPackageManifestReader.html) to provide your own package manifest reader. This can be useful if you want to load package manifests from a different location or source.
{% endhint %}

## Razor Class Library

Umbraco also supports [Razor Class Library (RCL)](https://learn.microsoft.com/en-us/aspnet/core/razor-pages/ui-class?view=aspnetcore-8.0\&tabs=visual-studio#create-an-rcl-with-static-assets) projects that contain static web assets. The `umbraco-package.json` file can be placed in the `wwwroot` folder of the RCL project. The package will be loaded when the RCL is referenced by the main project. You must map the web path to `App_Plugins` in your `.csproj` file:

{% code title="MyProject.Assets.csproj" %}
```xml
<PropertyGroup>
    <StaticWebAssetBasePath>App_Plugins/{YourPackageName}</StaticWebAssetBasePath>
</PropertyGroup>
```
{% endcode %}

Read more about getting set up for Backoffice development in the [Customize Backoffice](overview.md) section.
