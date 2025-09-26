---
description: >-
  Almost any UI in the Backoffice is an extension. All managed by the Extension
  Registry on the Client at Runtime. Giving you enormous flexibility.
---

# Extension Registry
The Umbraco backoffice is built with extensibility in mind. The backoffice without extensions is more or less a blank canvas that is build out using extensions. These extensions dictate how the backoffice functions and looks. All visual elements in an Umbraco installation, like the sections, menus, trees and buttons, are extensions. But extensions also dictate behaviour and the editing experience. So everything in the backoffice is governed (and extendable) by extensions.

{% hint style="info" %}
You can see which extensions are registered in the backoffice by going to Settings > Extensions Insights.
{% endhint %}

All extensions are registered in the extension registry. The registry can be manipulated at any time, meaning you can add or remove extensions at runtime. You as a developer have the same possibilities as an Umbraco HQ developer, which means what HQ can do, you can do. This also means that you can change almost everything that is by default present in Umbraco. 

## [Introduction to a Extension Manifest](extension-manifest.md)
An Extension Manifest is a declaration on what you want to register in the Umbraco backoffice. This articles handles the layout and requirements of an Extension Manifest.

## [Register an extension](extension-registry.md)
This article handles how to register an extension using an umbraco-package.json file.

## [Change an existing extension](replace-exclude-or-unregister.md)
Once you understand how to declare your own, you may want to replace or remove existing ones.
