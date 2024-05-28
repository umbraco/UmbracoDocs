# Extension Registration

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

An extensions registry is a registration of an UI extension. It can be manipulated at any time, meaning we can add or remove extensions at run-time.

To provide new UI to backoffice, you need to register them via an extension manifest. This has to initially happen on the server, via a JSON Package Manifest. This will enable you to register one or more extensions.

Declaring a new extension is done using an extension manifest depending where you are declaring it:

1. Via a manifest JSON file on the server.
2. In JavaScript/TypeScript file.

These two options can be combined by defining a small extension in a JSON Manifest. This uses the extension type [`backofficeEntryPoint`](entry-point.md) or [`bundle`](bundle.md) to register a JS file, which then registers the rest of the extensions.

#### Extension Manifest <a href="#extension-manifest" id="extension-manifest"></a>

The necessary properties that any extension manifest needs are:

* `type` - The type defines the type and purpose of the extension. It is used to determine where the extension will be used and defines the data needed for this manifest.
* `alias`- The alias is used to identify the extension. This has to be unique for each extension.
* `name` - The name of the extension. This is used to identify the extension in the UI.
