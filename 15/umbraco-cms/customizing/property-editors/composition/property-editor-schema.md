---
description: The Server side part of a Property Editor
---

# Property Editor Schema

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The Property Editor Schema is server code, written in C#. This handles the storage of a Property Editor and defines _Server Side Validation_ and _Property Value Converters_.

### Property Editor Schema

The Property Editor Schema settings are used for configuration that the server needs to know about.

**Manifest**

```json
{
	"type": "propertyEditorSchema",
	"name": "Text Box",
	"alias": "Umbraco.TextBox",
};
```
