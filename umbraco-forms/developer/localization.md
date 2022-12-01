---
meta.Title: Localization
---

# Localization

The labels, descriptions, and buttons that make up the backoffice screens for Umbraco Forms can be translated into different languages.

When an editor chooses a language for their account, Umbraco CMS will render appropriate translations. The translations will contain a file for that language and a key for the label in question. If either of these can't be found, the label will be displayed in English (US).

## Language Files

Umbraco Forms ships with translations for various languages, which can be found in the `App_Plugins/UmbracoForms/app/lang/` folder. If the language you require does not exist, it's possible to create your own by duplicating the default `en-us.xml` file, saving it with the appropriate culture code and replacing the English text with the translated version.
