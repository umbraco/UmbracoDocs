---
description: >-
  Information on how to use language files to make your Umbraco package UI
  support multiple languages
---

# Language file for packages

If you want your package to be available in different languages, you can use the existing localizations from Umbraco or register your own localizations. The localizations are written as a key-value pair pattern.

To register localizations to a language, you must add a new manifest to the Extension API. The manifest can be added through the `umbraco-package.json` file like this:

{% code title="umbraco-package.json" lineNumbers="true" %}
```
```
{% endcode %}

```json
{
  ...
  "name": "MyPackage",
  "extensions": [
    {
      "type": "localization",
      "alias": "MyPackage.Localize.En",
      "name": "English",
      "meta": {
        "culture": "en"
      },
      "js": "/App_Plugins/MyPackage/Localization/en-us.js"
    }
  ]
}
```

Read the [UI Localization documentation](../../customizing/foundation/localization.md) to learn in-depth on how you can use languages in your packages and Umbraco in general.
