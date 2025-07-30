---
meta.Title: Localization
---

# Localization

The labels, descriptions, and buttons that make up the backoffice screens for Umbraco Forms can be translated into different languages.

When an editor chooses a language for their account, Umbraco CMS will render appropriate translations. The translations will contain a file for that language and a key for the label in question. If either of these can't be found, the label will be displayed in English (US).

## Language Files

Umbraco Forms ships with translations for the following languages:

 - Czech (`cs-cz.js`)
 - Danish (`da-dk.js`)
 - Spanish (`es-es.js`)
 - French (`fr-fr.js`)
 - Italian (`it-it.js`)
 - Polish (`pl-pl.js`)
 - UK English (`en-gb.js`)
 - US English (`en-us.js`)
 - Dutch (`nl-nl.js`)

If the language you require does not exist, it's possible to create your own by duplicating the default `en-us.js` file.  You can then save it with the appropriate culture code for the language you need and replace the English text with the translated version.

As of Forms 10, the file no longer exists on disk and is shipped as part of the `Umbraco.Forms.StaticAssets` NuGet package. You can open this package, either locally using [Nuget Package Explorer](https://apps.microsoft.com/store/detail/nuget-package-explorer/9WZDNCRDMDM3?hl=en-gb&gl=gb&rtc=1), or [online](https://www.nuget.org/packages/Umbraco.Forms.StaticAssets/) by clicking the "Open in NuGet Package Explorer" link. You'll find the file at `staticwebassets/en-us.js`.

Once translated, the new file should be saved somewhere in the `App_Plugins` folder for example `App_Plugins/UmbracoFormsLocalization/`. The final step is to register the localization file. This can be done by creating a `umbraco-package.json` like so: 

```json
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "Umbraco.Forms.Extensions",
  "extensions": [
    {
      "type": "localization",
      "alias": "UmbracoForms.Localize.DeDE",
      "name": "	German (Germany)",
      "meta": {
        "culture": "de-de"
      },
      "js": "/App_Plugins/UmbracoFormsLocalization/de-de.js"
    }
  ]
}
```
