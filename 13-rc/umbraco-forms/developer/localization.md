---
meta.Title: Localization
---

# Localization

The labels, descriptions, and buttons that make up the backoffice screens for Umbraco Forms can be translated into different languages.

When an editor chooses a language for their account, Umbraco CMS will render appropriate translations. The translations will contain a file for that language and a key for the label in question. If either of these can't be found, the label will be displayed in English (US).

## Language Files

Umbraco Forms ships with translations for the following languages:

 - Czech (`cs-cz.xml`)
 - Danish (`da-dk.xml`)
 - Spanish (`es-es.xml`)
 - French (`fr-fr.xml`)
 - Italian (`it-it.xml`)
 - Polish (`pl-pl.xml`)
 - UK English (`en-gb.xml`)
 - US English (`en-us.xml`)

If the language you require does not exist, it's possible to create your own by duplicating the default `en-us.xml` file.  You can then save it with the appropriate culture code for the language you need and replace the English text with the translated version.

As of Forms 10, the file no longer exists on disk and is shipped as part of the `Umbraco.Forms.StaticAssets` NuGet package. You can open this package, either locally using [Nuget Package Explorer](https://apps.microsoft.com/store/detail/nuget-package-explorer/9WZDNCRDMDM3?hl=en-gb&gl=gb&rtc=1), or [online](https://www.nuget.org/packages/Umbraco.Forms.StaticAssets/) by clicking the "Open in NuGet Package Explorer" link. You'll find the file at `staticwebassets/Lang/en-us.xml`.

Once translated, the new file should be saved into the `App_Plugins/UmbracoForms/app/lang/` folder.
