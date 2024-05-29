---
description: An extension begins with a Package Manifest
---

# Package Manifest

A Package is declared via an Umbraco Package Manifest. This describes the Package and declares one or more UI Extensions.

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

### UI Extensions

JSON file format is used to describe one or more custom Umbraco extensions such as property editors, dashboards, sections, or entity actions. This page outlines the file format and properties found in the JSON.

## Sample Manifest

This is a sample manifest. It is always stored in a folder in `App_Plugins/{YourPackageName}`, with the name `umbraco-package.json`. In this example, the package name is `SirTrevor` and is a text box property Data Type.

{% hint style="info" %}
Before Umbraco 14, the manifest was declared in a `package.manifest` file instead of `umbraco-package.json.`
{% endhint %}

{% code title="umbraco-package.json" %}
```json
{
    "name": "Sir Trevor",
    "version": "1.0.0 beta",
    "allowPackageTelemetry": true,
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

## Sample Manifest with Csharp

{% hint style="warning" %}
This is a work in progress. It's currently not possible to register a manifest with Csharp such as it was supported in previous versions of Umbraco CMS.
{% endhint %}

## Root properties

The manifest takes four fields:

```json
{
    "name": "",
    "version": "",
    "allowPackageTelemetry": true,
    "extensions": []
}
```

### Name

Allows you to specify a friendly name for your package that will be used for telemetry. If no name is specified the name of the folder will be used instead.

### Version

The version of your package, if this is not specified there will be no version-specific information for your package.

### Allow Package Telemetry

With this field, you can control the telemetry of this package, this will provide Umbraco with the knowledge of how many installations use this package.

## Extensions

The `extensions` field is an array of UI Extension Manifests, each Manifest describes a single UI Extension. You can read more about this in the [UI Extension Types](broken-reference) article.

## Package Manifest IntelliSense

Make your IDE aware about the opportunities of the `umbraco-package.json` by adding a JSON schema. This gives your code editor abilities to autocomplete and knowledge about the format. This helps to avoid mistakes or errors when editing the `umbraco-package.json` file.

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

Umbraco will automatically pick up any `umbraco-package.json` files found in the `/App_Plugins` folder. You need to restart the application for new packages to be loaded or if you changed anything in existing files.
