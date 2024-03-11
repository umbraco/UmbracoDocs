---
description: Learn how to manage and use the UI Localization files.
---

# UI Localization

This article describes how you can use the UI Localization files via the [Package Manifest](../package-manifest.md).&#x20;

## Default Localization

If you want the dashboard to be available in different languages, you can use the existing localizations from Umbraco or register your own localizations. The localizations are written as a key-value pair pattern.

To register localizations to a language, you need to add a new manifest to the Extension API. The manifest can be added through the `umbraco-package.json` file like this:

{% code title="umbraco-package.json" %}
```typescript
{
  ...
  "name": "MyPackage",
  "extensions": [
    {
      "type": "localization",
      "alias": "MyPackage.Localize.EnUS",
      "name": "English (United States)",
      "meta": {
        "culture": "en-us"
      },
      "js": "/App_Plugins/MyPackage/Localization/en-us.js"
    }
  ]
}
```
{% endcode %}

If you do not have many translations, you can also choose to include them directly in the meta-object like so:

```typescript
"meta": {
	"culture": "en-us",
	"translations": {
		"section": {
			"key1": "value1",
			"key2": "value2"
		}
	}
}
```

### Layout of the Localization Files

The localization files for the UI are JS modules with a default export containing a key-value structure organized in sections.

```js
export default {
	section: {
		key1: 'value1',
		key2: 'value2',
	},
};
```

The sections and keys will be formatted into a map in Umbraco with the format `section_key1` and `section_key2.` These form the unique key they are requested.

The values can be either a string or a function that returns a string:

```js
export default {
	section: {
		key1: 'value1',
		key2: (count) => {
			count = parseInt(count, 10);
			if (count === 0) return 'Nothing';
			if (count === 1) return 'One thing';
			return 'Many things';
		},
	},
};	
```

### Missing Localization Keys

As Umbraco is an evolving product, new text is regularly added to the English version of these files. Therefore, some of the above languages may no longer be up-to-date.

If a key is not found in the current language, the fallback language will be used. The fallback language is **English (United States)**.

If a translation is missing, the default value within `umb-localize` will be shown in the user interface:

```markup
<umb-localize key="general_ok_not_found">Default value</umb-localize>
```

Instead of showing the default value we can show the key alias if we set `debug="true"`:

```markup
<umb-localize key="general_ok_not_found" debug="true"></umb-localize>
```

## Using the Localizations

### Localize Element

The following example shows how you can display localized text with the `umb-localize` element:

```html
<button>
    <umb-localize key="dialog_myKey"></umb-localize>
</button>
```

### **Localize Controller**

In some situations, you need the localization as a variable that can be parsed. In this case, the Localization Controller can be used in your `element.ts` file. This can be setup in two ways:

* Using [Umbraco Element](ui-localization.md#umbraco-element)
* Using [Umbraco Controller](ui-localization.md#umbraco-controller)

#### Umbraco Element

When using an [**Umbraco Element**](../umbraco-element/)**,** the **Localization Controller** is already initialized on the `localize` property via the `UmbElementMixin`.

```typescript
import { LitElement, css, html } from "lit";
import { customElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

export default class MyElement extends UmbElementMixin(LitElement) {
    render() {
        return html`<uui-button .label=${this.localize.term('general_close')}>
        </uui-button>`;
    }
}
```

#### Umbraco Controller

If you are working with an Umbraco Controller, then you need to initialize the Localization Controller on your own via the `UmbLocalizationController`:

```typescript
import { UmbBaseController } from '@umbraco-cms/backoffice/class-api';
import { UmbLocalizationController } from '@umbraco-cms/backoffice/localization-api';

export class MyController extends UmbBaseController {
    // Create a new instance of the controller and attach it to the element
    private localize = new UmbLocalizationController(this);
    
    render() {
	return html` <uui-button .label=${this.localize.localize('general_close')}></uui-button> `;
	}
}
```

{% hint style="info" %}
You can find a localization example in the [Adding localization to the dashboard](../../tutorials/creating-a-custom-dashboard/adding-localization-to-the-dashboard.md) article.
{% endhint %}
