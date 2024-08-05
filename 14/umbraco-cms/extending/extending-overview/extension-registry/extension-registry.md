# Extension Registration

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The extension registry is the center piece of the Backoffice UI.
This holds information about most UI, as most of the UI of Backoffice is extensions. Also the build-in UI.
The registry can be manipulated at any time, meaning you can add or remove extensions at run-time.

To provide new UI to backoffice, you need to register them via an extension manifest. This has to be initiated via a file the server, a Umbraco Package JSON file. This will be your starting point, which enables you to register one or more extensions.

Declaring a new extension is done by declaring an extension manifest. Depending where you are declaring it you have these two options:

1. Via a manifest JSON file on the server.
2. In JavaScript/TypeScript file.

These two options can be combined as you like.

A typical use case of such is achieved by registering a single extension manifest in your Umbraco Package JSON file, which then loads a JS file, that registers the rest of your the extensions.
Learn more about these abilities in the articles of [`bundle`](../extension-types/bundle.md) or [`backofficeEntryPoint`](../extension-types/entry-point.md).

#### Extension Manifest Data <a href="#extension-manifest" id="extension-manifest"></a>

The necessary properties that any extension manifest needs are:

* `type` - The type defines the type and purpose of the extension. It is used to determine where the extension will be used and defines the data needed for this manifest.
* `alias`- The alias is used to identify the extension. This has to be unique for each extension.
* `name` - The name of the extension. This is used to identify the extension in the UI.
