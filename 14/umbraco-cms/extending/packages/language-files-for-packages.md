---
description: "Information on how to use language files to make your Umbraco package UI support multiple languages"
---

# Languages for packages

If you want your package to be available in different languages, you can use the existing localizations from Umbraco or register your own localizations. The localizations are written as a key-value pair pattern.
To register localizations to a language, you must add a new manifest to the Extension API. The manifest can be added through the `umbraco-package.json` file like this:

{% code title="umbraco-package.json" lineNumbers="true" %}

```json
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


## Layout of the Localization Files

The localization files for the UI are JS modules with a default export containing a key-value structure organized in sections.
```Javascript
export default {
 section: {
  key1: 'value1',
  key2: 'value2',
 },
};
```
The sections and keys will be formatted into a map in Umbraco with the format section_key1 and section_key2. These form the unique key they are requested.
The values can be either a string or a function that returns a string:

```Javascript
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
Read the [UI Localization documentation](../language-files/ui-localization.md) to learn more about using languages in Umbraco.