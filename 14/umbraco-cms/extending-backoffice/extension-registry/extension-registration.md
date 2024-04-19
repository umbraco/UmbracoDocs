# Extension Registration

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

Registering UI extensions happens through the global extension registry.

1. Via a manifest JSON file on the server.
2. In JavaScript code.

There are two ways to register UI extensions:

These two options can be combined by defining a small extension in a JSON Manifest, which uses the extension type `entryPoint` or `bundle` to register a JS file, which then registers the rest of the extensions.

#### Extension Manifest <a href="#extension-manifest" id="extension-manifest"></a>

TODO: Describe the extension manifest format.

* `type` - The type define the type of extension. The type is used to determine where extension is will be used, this defines the data needed for this manifest.
* `alias`- The alias is used to identify the extension. This has to be unique for each extension.
* `name` - The name of the extension. This is used to identify the extension in the UI.

#### Registration via a Package Manifest <a href="#registration-via-a-package-manifest" id="registration-via-a-package-manifest"></a>

#### Registering via a Manifest in JS. <a href="#registering-via-a-manifest-in-js" id="registering-via-a-manifest-in-js"></a>

#### Using the Entry Point Extension Type via Package Manifest <a href="#using-the-entry-point-extension-type-via-pakcage-manifest" id="using-the-entry-point-extension-type-via-pakcage-manifest"></a>

#### Using the Bundle Extension Type via Package Manifest <a href="#using-the-bundle-extension-type-via-pakcage-manifest" id="using-the-bundle-extension-type-via-pakcage-manifest"></a>
