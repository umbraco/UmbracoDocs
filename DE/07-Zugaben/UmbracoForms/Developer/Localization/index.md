---
versionFrom: 8.0.0
versionTo: 10.0.0
meta.Title: "Localization"
---

# Localization

From versions 8.10 and 9.2, the various labels, descriptions and buttons that make up the backoffice screens for Umbraco Forms can be translated into different languages.

When an editor chooses a language for their account, the Umbraco CMS will be rendered with appropriate translations where a file for that language exists and a key for the label in question is available.  If either of these these can't be found, the label will be displayed in English (US).

## Language Files

Umbraco Forms ships with translations for various languages, which can be found in the `App_Plugins/UmbracoForms/app/lang/` folder.  If the language you require does not exist, it's possible to create your own by duplicating the default `en-us.xml` file, saving it with the appropriate [culture code](https://app.slack.com/client/T025KPYEV/G8LFSGMFB) and replacing the English text with the translated version.

---

Prev: [Healthchecks](../Healthchecks/index.md) &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Next: [Content Apps](../ContentApps/index.md)
