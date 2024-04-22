# Extension Registration

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

An extensions registry is a registration of an UI extension. It can be manipulated at any time, meaning we can add or remove extensions at run-time.&#x20;

Declaring a new extension is done using an extension manifest depending where you are declaring it:

1. Via a manifest JSON file on the server.
2. In JavaScript code.

These two options can be combined by defining a small extension in a JSON Manifest, which uses the extension type `entryPoint` or `bundle` to register a JS file, which then registers the rest of the extensions.

#### Extension Manifest <a href="#extension-manifest" id="extension-manifest"></a>

The extension manifest format:

* `type` - The type defines the type and purpose of the extension. It is used to determine where the extension will be used and defines the data needed for this manifest.
* `alias`- The alias is used to identify the extension. This has to be unique for each extension.
* `name` - The name of the extension. This is used to identify the extension in the UI.
