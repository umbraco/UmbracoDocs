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
    "allowCacheBusting": true,
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

The version also acts as the cache key for your package's `/App_Plugins` assets. Read more in the [Cache busting](#cache-busting) section.

### Allow Telemetry

With this field, you can control the telemetry of this package, this will provide Umbraco with the knowledge of how many installations use this package.

The default is `true`.

Also known as: `allowPackageTelemetry`

### Allow Public Access

This field is used to allow public access to the package. If set to `true`, the package will be available for anonymous usage, for example on the login screen. If set to `false`, the package will only be available to logged-in users.

The default is `false`.

### Allow Cache Busting

This field controls whether Umbraco appends a cache-busting query string to the package's `/App_Plugins` assets. Set it to `false` to opt out. Read more in the [Cache busting](#cache-busting) section.

The default is `true`.

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

Read more about Extension Types in the Backoffice to get a better understanding of the different types of extensions:

{% content-ref url="extending-overview/extension-types/README.md#full-list-of-extension-types" %}
[#full-list-of-extension-types](extending-overview/extension-types/README.md#full-list-of-extension-types)
{% endcontent-ref %}

#### The `conditions` property

Each extension in the `extensions` array can include an optional `conditions` property. This is an array of condition objects that must all be satisfied before the extension is loaded and activated. It gives you fine-grained control over where and when an extension appears in the backoffice.

**Structure**

```json
{
    "type": "workspaceAction",
    "alias": "My.WorkspaceAction",
    "name": "My Workspace Action",
    "element": "/App_Plugins/MyPackage/my-action.js",
    "conditions": [
        {
            "alias": "Umb.Condition.WorkspaceAlias",
            "match": "Umb.Workspace.Document"
        }
    ]
}
```

Each condition object requires at minimum an `alias` identifying which condition to evaluate. Many conditions also accept a `match` value specifying what to match against.

Common aliases include:

* `Umb.Condition.WorkspaceAlias`
* `Umb.Condition.SectionAlias`
* `Umb.Condition.WorkspaceEntityType`
* `Umb.Condition.UserPermission.Document`.

For a full list and details, see the [Extension Conditions](extending-overview/extension-types/condition.md) article.

## Cache busting

{% hint style="info" %}
Automatic cache busting for package assets is available from Umbraco 17.6.
{% endhint %}

Browsers cache the assets that your package serves from `/App_Plugins`. Without cache busting, users can keep running old JavaScript and CSS after you ship an update. To prevent this, Umbraco appends a cache-busting query string to your package's asset URLs.

The value is derived from the `version` field in your `umbraco-package.json` file. Umbraco appends it as `?umb__rnd={value}` to:

* Import map entries pointing to `/App_Plugins` in the server-rendered import map.
* Asset URLs of your registered extensions, for example `element` and `js` paths. The Backoffice appends the value when the extensions are loaded. This also covers the login screen and the preview pane.

For example, with `"version": "1.2.3"` an asset URL is rendered as `/App_Plugins/MyPackage/dist/index.js?umb__rnd=1.2.3`.

The host can configure a `Cachebuster` value as described in the [Plugins settings](../../develop-with-umbraco/configuration/pluginssettings.md) article. When set, Umbraco appends a short hash of that value to the version (for example, `?umb__rnd=1.2.3-7bb8e1f`).

### The version is your cache key

The cache-busting value works both ways. When the version stays the same, browsers reuse the assets they already downloaded. When the version changes, browsers fetch the new files. Bump the `version` field whenever the assets you ship change.

{% hint style="warning" %}
If you change assets without bumping the version, the asset URLs stay the same. Browsers can then keep serving the old files from their cache. Treat a version bump as mandatory for every release that changes assets.
{% endhint %}

If your package has no `version`, the cache-busting value falls back to a hash of the host's `Cachebuster` value. That hash only changes when the host changes the setting, described in the [Plugins settings](../../develop-with-umbraco/configuration/pluginssettings.md) article. If neither is set, no query string is appended at all. Set a version to control cache busting yourself.

### What is not stamped

Umbraco leaves these URLs untouched:

* URLs that already contain a query string. You manage the caching of these yourself.
* URLs outside `/App_Plugins`, for example absolute URLs to a Content Delivery Network (CDN).
* Bare module specifiers, for example `@umbraco-cms/backoffice/extension-api`.

### Bundle your assets

The cache buster covers the entry points that you declare in your manifest and import map. Files that those entry points import at runtime, for example code-split chunks, are requested without the query string.

Use a bundler such as Vite to build your package. Bundlers add a content hash to the file names of generated chunks by default. A content-hashed file name changes whenever the file content changes, so those files bust their own cache.

### Manage the version yourself

You can also take control of the versioning yourself. There are two alternatives.

#### Add your own query string

Umbraco leaves URLs that already contain a query string untouched. You can therefore version an asset yourself:

{% code title="umbraco-package.json" %}
```json
{
    "type": "propertyEditorUi",
    "alias": "My.PropertyEditorUi",
    "name": "My Property Editor UI",
    "element": "/App_Plugins/MyPackage/dist/my-editor.js?v=1.2.3"
}
```
{% endcode %}

You take over the responsibility with this approach. Remember to update the value whenever the file changes.

#### Read the version from your assembly

You can provide the package manifest from code instead of a `umbraco-package.json` file. Implement the `IPackageManifestReader` interface and read the version from your assembly. This keeps the manifest version in sync with your NuGet package version on every release.

{% code title="MyPackageManifestReader.cs" %}
```csharp
using Umbraco.Cms.Core.Manifest;
using Umbraco.Cms.Infrastructure.Manifest;

namespace MyPackage;

public class MyPackageManifestReader : IPackageManifestReader
{
    public Task<IEnumerable<PackageManifest>> ReadPackageManifestsAsync()
    {
        var version = typeof(MyPackageManifestReader).Assembly.GetName().Version?.ToString(3) ?? "0.0.0";

        PackageManifest manifest = new()
        {
            Id = "My.Package",
            Name = "My Package",
            Version = version,
            Extensions =
            [
                new Dictionary<string, object>
                {
                    ["type"] = "propertyEditorUi",
                    ["alias"] = "My.PropertyEditorUi",
                    ["name"] = "My Property Editor UI",
                    ["element"] = "/App_Plugins/MyPackage/dist/my-editor.js",
                },
            ],
        };

        return Task.FromResult<IEnumerable<PackageManifest>>([manifest]);
    }
}
```
{% endcode %}

Register the reader in a composer:

{% code title="MyPackageComposer.cs" %}
```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Infrastructure.Manifest;

namespace MyPackage;

public class MyPackageComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddSingleton<IPackageManifestReader, MyPackageManifestReader>();
    }
}
```
{% endcode %}

{% hint style="info" %}
The manifest reader replaces the `umbraco-package.json` file. Remove the file from your package to avoid registering the extensions twice.
{% endhint %}

### Opting out

Set `allowCacheBusting` to `false` in your `umbraco-package.json` file to opt out of the automatic stamping:

{% code title="umbraco-package.json" %}
```json
{
    "name": "My Package",
    "version": "1.2.3",
    "allowCacheBusting": false
}
```
{% endcode %}

Omitting the `version` field also stops the version-based cache busting. This is not recommended, as the version is also used for package migrations and telemetry. Keep in mind that the host's `Cachebuster` value is still applied when set.

{% hint style="warning" %}
The legacy `%CACHE_BUSTER%` token still resolves to Umbraco's global cache-busting hash. That hash only changes when Umbraco itself is updated. The token is deprecated and is scheduled for removal in Umbraco 20. Rely on the automatic stamping instead.
{% endhint %}

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
You can implement the interface [IPackageManifestReader](https://apidocs.umbraco.com/v17/csharp/api/Umbraco.Cms.Infrastructure.Manifest.IPackageManifestReader.html) to provide your own package manifest reader. This can be useful if you want to load package manifests from a different location or source.
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

