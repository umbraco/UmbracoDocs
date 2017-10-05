# Language file for packages
**Applies to version 7.3.0 and newer**

While the Umbraco Core ships with its own set of language files, package authors who wants their UI to be multi-lingual, will need to include their own set of language files as part of their package distribution.

## Including new language keys
For each language your package support, you include a .xml file in the same format as the core language files, named with its language code. The language files must be located in a `lang` folder inside your package folder in `app_plugins`. So if your package assets are in `/app_plugins/mypackage` all language files must be placed like so

- English keys: `/app_plugins/mypackage/lang/en-US.xml`
- Danish keys: `/app_plugins/mypackage/lang/da-DK.xml`

## Language file format
Each language file can include one or more areas of keys, and each area contains a collection of language keys with the translation.

For reference on the language file format see the core [language files on github](https://github.com/umbraco/Umbraco-CMS/tree/dev-v7/src/Umbraco.Web.UI/umbraco/config/lang)

### Sample structure:

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

