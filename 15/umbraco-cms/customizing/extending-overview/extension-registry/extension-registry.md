# Extension Registration

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The extension registry is the center piece of the Backoffice UI.
It holds information about most of the Backoffice UI, as most are extensions. This includes the built-in UI.
The registry can be manipulated at any time, meaning you can add or remove extensions at runtime.

To provide new UI to the backoffice, you must register them via an Extension Manifest. This can be initiated via an Umbraco Package JSON file on the server. This will be your starting point.

Declaring a new extension is done by declaring an [extension manifest](./extension-manifest.md). This can be done in one of two ways:

1. Via a manifest JSON file on the server.
2. In a JavaScript/TypeScript file.

These two options can be combined as you like.

A typical use case of such is achieved by registering a single extension manifest in your Umbraco Package JSON file. This manifest would then load a JS file, that registers the rest of your extensions.
Learn more about these abilities in the [bundle](../extension-types/bundle.md) or [backoffice entry point](../extension-types/entry-point.md) articles.

## Extension Manifest Data <a href="#extension-manifest" id="extension-manifest"></a>

The necessary properties that any extension manifest needs are:

* `type` - The type defines the type and purpose of the extension. It is used to determine where the extension will be used and defines the data needed for this manifest.
* `alias`- The alias is used to identify the extension. This has to be unique for each extension.
* `name` - The name of the extension. This is used to identify the extension in the UI.
