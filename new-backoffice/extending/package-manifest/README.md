# Package Manifest

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

{% hint style="info" %}
The Umbraco Package Manifest file has been renamed from `package.manifest` to `umbraco-package.json` in version 14.0.0. This separates the new package manifest from the old package manifest, and ensures that the file extension indicates the JSON-format within.
{% endhint %}

The `umbraco-package.json` JSON file format is used to describe one or more custom Umbraco extensions such as property editors, dashboards, sections, or entity actions. This page outlines the file format and properties found in the JSON.

## Sample Manifest

This is a sample manifest, it is always stored in a folder in `/App_Plugins/{YourPackageName}`, with the name `umbraco-package.json`

```json
{
    "name": "Sir Trevor",
    "version": "1.0.0 beta",
    "allowPackageTelemetry": true,
    "extensions": [
        {
            "type": "propertyEditorUI",
            "alias": "Sir.Trevor",
            "name": "Sir Trevor Property Editor UI",
            "js": "/App_Plugins/SirTrevor/SirTrevor.js",
            "meta": {
                "label": "Sir Trevor",
                "propertyEditorModel": "Umbraco.JSON",
                "icon": "umb:code",
                "group": "Pickers"
            }
        }
    ]
}
```

## Sample Manifest with Csharp

{% hint style="info" %}
It is currently not possible to register a manifest with Csharp such as it was supported in previous versions of Umbraco CMS. This is a work in progress.
{% endhint %}

## Root elements

The manifest can contain four root collections, none of them are mandatory:

```json
{
    "name": "",
    "version": "",
    "allowPackageTelemetry": true,
    "extensions": []
}
```

### Telemetry elements

In version 9.2 some additional root elements were added. The purpose of these are to control and facilitate telemetry about the package, none of these are mandatory. The properties are:

-   `name` - Allows you to specify a friendly name for your package that will be used for telemetry, if no name is specified the name of the folder will be used instead
-   `version` - The version of your package, if this is not specified there will be no version specific information for your package
-   `allowPackageTelemetry` - Allows you to entirely disable telemetry for your package if set to false, defaults to true.

Example `umbraco-package.json` with telemetry elements:

```json
{
    "name": "My Awesome Package",
    "version": "1.0.0",
    "allowPackageTelemetry": true
}
```

## Extensions

The `extensions` collection is an array of extension objects, each object describes a single extension. The `type` property is mandatory, and must be one of the following values:

-   `entryPoint`
-   `collectionView`
-   `dashboard`
-   `dashboardCollection`
-   `entityAction`
-   `entityBulkAction`
-   `headerApp`
-   `healthCheck`
-   `itemStore`
-   `menu`
-   `menuItem`
-   `modal`
-   `packageView`
-   `propertyAction`
-   `propertyEditorModel`
-   `propertyEditorUI`
-   `repository`
-   `section`
-   `sectionSidebarApp`
-   `sectionView`
-   `store`
-   `theme`
-   `tree`
-   `treeItem`
-   `treeStore`
-   `userProfileApp`
-   `workspace`
-   `workspaceAction`
-   `workspaceEditorView`
-   `workspaceViewCollection`

## A special note about `entryPoint`

The `entryPoint` extension type is special, it is used to specify the entry point for a package. This is the only extension type that can be used to specify the entry point for a package. An entry point is a single JavaScript file that will be loaded when the Backoffice starts. This is useful if you want to load a single JavaScript file that will then load all the other files for your package.

You can apply any conditional logic when registering your entry point such as:

-   Check if the user is logged in.
-   Check if the user has access to a specific section before registering additional extensions.

The `entryPoint` extension is also the way to go if you want to load in external libraries such as jQuery, Angular, React, etc. You can use the `entryPoint` to load in the external libraries to be shared by all your extensions. You can also load global CSS files in the `entryPoint` extension.

Read more about the `entryPoint` extension type in the [Entry Point](./entry-point.md) article.

## Bundling

{% hint style="info" %}
From version 14.0.0 Umbraco will not automatically try to bundle the static assets of packages. This is to avoid any potential conflicts with other bundling packages and to allow for more flexibility in how you want to bundle your assets.
{% endhint %}

If you want to bundle your assets such as JavaScript, CSS, or images, you need to set up a bundler. You can read more about bundling in the [Development Flow](./development-flow/README.md) article.

## JSON Schema

The `umbraco-package.json` file has a JSON schema file that allows editors such as Visual Studio, Rider and Visual Studio Code to have autocomplete/IntelliSense support when creating and editing `umbraco-package.json` files. This helps to avoid mistakes or errors.

### Adding inline schema

Editors like Visual Studio can use the `$schema` notation in your file.

```json
{
    "$schema": "../../umbraco-package-schema.json",
    "other properties": ""
}
```

Hover over any of the properties to see the description of the property. You can also use the `Ctrl + Space` (Windows/Linux) or `CMD + Space` (MacOS) shortcut to see the available properties.

## Load Package Manifest files

Umbraco will automatically pick up any `umbraco-package.json` files found in the `/App_Plugins` folder. You need to restart the application for new packages to be loaded or if you changed anything in existing files.
