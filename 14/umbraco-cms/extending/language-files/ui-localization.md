---
description: Learn how to manage and use the Backoffice UI Localization files.
---

# UI Localization

This article describes how you can translate the Umbraco Backoffice UI into different languages. You can use the existing localizations from Umbraco or register your own localizations. You can also use the localization in your custom elements and controllers.

## Registering Localization

To register localizations to a language, you must add a new manifest to the Extension API. The manifest can be added through the `umbraco-package.json` file. Usually, the localization keys are provided through a JavaScript module. In this example, we will use a file named `en.js`:

{% code title="umbraco-package.json" %}
```json
{
  "name": "MyPackage",
  "extensions": [
    {
      "type": "localization",
      "alias": "MyPackage.Localize.EnUS",
      "name": "English",
      "meta": {
        "culture": "en"
      },
      "js": "/App_Plugins/MyPackage/Localization/en.js"
    }
  ]
}
```
{% endcode %}

{% hint style="info" %}
Read more about extensions in the [Package Manifest](../package-manifest.md) article.
{% endhint %}

### Layout of the Localization Files

The localization files for the UI are JavaScript modules with a default export containing a key-value structure organized in sections.

{% code title="/App_Plugins/MyPackage/Localization/en.js" %}
```js
export default {
    section: {
        key1: 'value1',
        key2: 'value2',
    },
};
```
{% endcode %}

The sections and keys will be formatted into a map in Umbraco with the format `section_key1` and `section_key2.` These form the unique key they are requested.

If you do not have many translations, you can also choose to include them directly in the meta-object:

{% code title="umbraco-package.json" lineNumbers="true" %}
```json
{
  "name": "MyPackage",
  "extensions": [
    {
      "type": "localization",
      "alias": "MyPackage.Localize.EnUS",
      "name": "English",
      "meta": {
        "culture": "en",
        "translations": {
            "section": {
                "key1": "value1",
                "key2": "value2"
            }
        }
      },
    }
  ]
}
```
{% endcode %}

In this case, the `en.js` file is not needed and we can remove the "js" property from the manifest. Only strings can be used in the meta-object.

### Missing Localization Keys

As Umbraco is an evolving product, new text is regularly added to the English version of these files. Therefore, some of the languages may no longer be up-to-date.

If a key is not found in the current language, the fallback language will be used. The fallback language is **English** with the culture code **en**.

If a translation is missing, the default value within `umb-localize` will be shown in the user interface:

```html
<umb-localize key="general_ok_not_found">Default value</umb-localize>
```

Instead of showing the default value we can show the key alias if we set `debug="true"`:

```html
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

{% hint style="info" %}
You can have a look and try out the element in the [UI API Docs](https://apidocs.umbraco.com/v14/ui/?path=/docs/api-localization-umblocalizeelement--docs).
{% endhint %}

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

The arguments will be passed to the function in the localization file if it is a function.

#### Umbraco Controller

If you are working with an Umbraco Controller, then you need to initialize the Localization Controller on your own via the `UmbLocalizationController`:

```typescript
import { UmbControllerBase } from '@umbraco-cms/backoffice/class-api';
import { UmbLocalizationController } from '@umbraco-cms/backoffice/localization-api';

export class MyController extends UmbControllerBase {
    // Create a new instance of the controller and attach it to the element
    #localize = new UmbLocalizationController(this);

    render() {
        return html` <uui-button .label=${this.#localize.term('general_close')}></uui-button> `;
    }
}
```

## Using arguments

Sometimes you need to pass arguments to the localization to return different values based on the arguments. A localization value can be either a string or a function. Given a localization file like this, we can return different values based on the number of items:

```javascript
export default {
    section: {
        numberOfItems: (count) => {
            count = parseInt(count, 10);
            if (count === 0) return 'Showing nothing';
            if (count === 1) return 'Showing only one item';
            return `Showing ${count} items`;
        },
    },
};
```

{% hint style="info" %}
You can try out the arguments feature in the [UI API Docs](https://apidocs.umbraco.com/v14/ui/?path=/story/api-localization-umblocalizeelement--with-arguments).
{% endhint %}

**Using the Localize Element**

You can pass arguments to the localization by adding them as additional attributes:

```html
<!-- Outputs: Showing 5 items -->
<umb-localize key="section_numberOfItems" args="[5]">Showing items</umb-localize>
```

The arguments will be passed to the function in the localization file if it is a function. The `args` attribute must be JSON-serializable and each array value will be passed to the function as an extra argument.

**Using the Localize Controller**

You can pass arguments to the localization by calling the `term` method with the arguments:

```typescript
// Outputs: Showing 5 items
this.localize.term('section_numberOfItems', 5);
```

The arguments will be passed to the function in the localization file if it is a function. Each argument of `term` will be passed to the function as an extra argument.

### Using placeholders

You can also use placeholders in the localization keys to replace parts of the string with dynamic values. Placeholders are defined by curly braces `{0}` or percentage signs `%0%` in the localization key. The placeholders will be replaced one-to-one with the arguments passed to the localization. It works the same as the arguments feature, except you cannot calculate the value based on the arguments.

Given a localization file like this:

{% code title="en.js" %}
```javascript
export default {
    section: {
        numberOfItems: 'Showing {0} items',
    },
};
```
{% endcode %}

You can use the same `args` attribute to pass the arguments:

```html
<!-- Outputs: Showing 5 items -->
<umb-localize key="section_numberOfItems" args="[5]"></umb-localize>
```

## Examples

You can find a localization example in the [Adding localization to the dashboard](../../tutorials/creating-a-custom-dashboard/adding-localization-to-the-dashboard.md) article.
