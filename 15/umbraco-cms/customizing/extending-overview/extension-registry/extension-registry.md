# Extension Registration

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The extension registry is the center piece of the Backoffice UI. It holds information about most of the Backoffice UI, as most are extensions. This includes the built-in UI. The registry can be manipulated at any time, meaning you can add or remove extensions at runtime.

To provide new UI to the backoffice, you must register them via an Extension Manifest. This can be initiated via an Umbraco Package JSON file on the server. This will be your starting point.

Declaring a new extension is done by declaring an [extension manifest](extension-manifest.md). This can be done in one of two ways:

1. Via a manifest JSON file on the server.
2. In a JavaScript/TypeScript file.

These two options can be combined as you like.

A typical use case of such is achieved by registering a single extension manifest in your Umbraco Package JSON file. This manifest would then load a JS file, that registers the rest of your extensions. Learn more about these abilities in the [bundle](../extension-types/bundle.md) or [backoffice entry point](../extension-types/backoffice-entry-point.md) articles.
