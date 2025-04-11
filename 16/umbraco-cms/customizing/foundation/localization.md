---
description: Learn how to manage and use the Backoffice UI Localization files.
---

# Backoffice Localization

This article describes how you can translate the Umbraco Backoffice UI into different languages. You can use the existing localizations from Umbraco or register your own localizations. You can also use the localization in your custom elements and controllers.

## Registering Localization

Localizations can be registered via the Extension Registry. [Read more about the Localization Extension Type](../extending-overview/extension-types/localization.md).

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
You can have a look and try out the element in the [UI API Documentation](https://apidocs.umbraco.com/v15/ui/?path=/docs/api-localization-umblocalizeelement--docs).
{% endhint %}

### **Localize Controller**

In some situations, you need the localization as a variable that can be parsed. In this case, the Localization Controller can be used in your `element.ts` file. This can be setup in two ways:

* Using [Umbraco Element](localization.md#umbraco-element)
* Using [Umbraco Controller](localization.md#umbraco-controller)

#### Umbraco Element

When using an [**Umbraco Element**](../../customizing/foundation/umbraco-element/)**,** the **Localization Controller** is already initialized on the `localize` property via the `UmbElementMixin`.

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
You can try out the arguments feature in the [UI API Documentation](https://apidocs.umbraco.com/v15/ui/?path=/story/api-localization-umblocalizeelement--with-arguments).
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

### Using with manifests
You can localize values in a manifest. For example, prefix the name of the dashboard tab visible in the UI with a `#`.

#### Example
A manifest registering a dashboard with `umbraco-package.json` or JavaScript can localize the `label` property in the `meta` object like this.

{% code title="umbraco-package.json" lineNumbers="true" %}

```json
{
  "name": "My.WelcomePackage",
  "extensions": [
    {
      "type": "dashboard",
      ...
      "meta": {
        "label": "#welcomeDashboard_label", 
        "pathname": "welcome-dashboard"
      },
    },
  ]
}
```

{% endcode %}


## Examples

You can add your own localization keys using the principles you have learned, and apply them in a number of ways:

### Using localization in a custom element

You can find a localization example in the [Adding localization to the dashboard](../../tutorials/creating-a-custom-dashboard/adding-localization-to-the-dashboard.md) article. This will get you started with using localization in your custom elements. You can apply the same principles to all extensions.

### Using localization in property descriptions and labels

Property descriptions and labels can also be localized. They are formatted as Markdown and can contain localization keys using the built-in [Umbraco Flavored Markdown](../../reference/umbraco-flavored-markdown.md) syntax.
