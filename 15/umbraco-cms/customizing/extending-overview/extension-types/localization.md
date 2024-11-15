---
description: Learn how to manage and use the Backoffice UI Localization files.
---

# Localization

## Registering Localization

When registering localizations to a language, you must add a new manifest to the Extension API. The manifest can be added through the `umbraco-package.json` file. Usually, the localization keys are provided through a JavaScript module. In this example, we will use a file named `en.js`:

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
Read more about extensions in the [Package Manifest](../../umbraco-package.md) article.
{% endhint %}

## The Localization file

The localization files for the UI are JavaScript modules with a default export containing a key-value structure organized in sections.

{% code title="en.js" %}
```javascript
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

In this case, the `en.js` file is not required and we can remove the "js" property from the manifest. Only strings can be used in the meta-object.
