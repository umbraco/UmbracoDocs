---
meta.Title: "Language file for packages"
description: "Information on how to use language files to make your Umbraco package UI support multiple languages"
---

# Language file for packages

Umbraco Core includes language files, but package authors must provide their own for multi-lingual UI.

## Including new language keys

For each language your package supports, you include an .xml file in the same format as the core language files, named with its language code. The language files must be located in a `Lang` folder inside your package folder in `App_Plugins`. If your package assets are in `/App_Plugins/mypackage` all language files must be placed in the following locations:

- English keys: `/App_Plugins/mypackage/Lang/en-US.xml`
- Danish keys: `/App_Plugins/mypackage/Lang/da-DK.xml`

{% hint style="info" %}
The `App_Plugins` version of the `Lang` directory is case sensitive on Linux systems, so make sure that it start with a capital `L`.
{% endhint %}

## Language file format

Each language file can include one or more area. Each area contains a collection of language keys with the translation.

For reference on the language file format see the core [language files on GitHub](https://github.com/umbraco/Umbraco-CMS/tree/main/src/Umbraco.Core/EmbeddedResources/Lang)

### Sample structure

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language alias="da" intName="Danish" localName="dansk" lcid="6" culture="da-DK">
    <creator>
        <name>The Umbraco community</name>
        <link>http://mydomain.com</link>
    </creator>
    <area alias="dialog">
        <key alias="myKey">Min nøgle</key>
        <key alias="otherKey">Min anden nøgle</key>
    </area>
</language>
```
