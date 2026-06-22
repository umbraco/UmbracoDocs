---
description: >-
  Learn how to add translations for new languages or override existing strings in the Umbraco.Cloud.Cms backoffice UI.
---

# Customizing Translations in Umbraco.Cloud.Cms

The `Umbraco.Cloud.Cms` package includes backoffice translations for English and Danish. You can add translations for additional languages or override specific strings for existing languages.

{% hint style="info" %}
Localization in `Umbraco.Cloud.Cms` is available from version 17.1.4 and later.
{% endhint %}

## Available translation keys

All translations belong to the `umbracoIdentity` namespace. The table below lists every key and its default English value.

| Key | Default (English) |
|-----|-------------------|
| `signIn` | Sign in with Umbraco ID |
| `timedOut` | You have been signed out from {providerName}. |
| `loggedOutBackoffice` | You have logged out of the Umbraco Backoffice. |
| `sessionStillActive` | The session in {providerName} is still active. |
| `alsoRecommend` | We also recommend that you also log out of the session in {providerName}. |
| `signOutSession` | Sign out of the Umbraco ID session, |
| `clickHere` | click here |
| `returnToPortal` | To return to the Umbraco Cloud Portal, |
| `goToPortal` | Go to the Umbraco Cloud Portal |
| `boxHeadlineUmbracoId` | Umbraco ID |
| `boxHeadlineExternalLoginProvider` | External Login Provider |
| `providerLabel` | Provider: |
| `versionLabel` | Umbraco ID: |
| `localDevWarning` | Profile edit and password change, is not available when doing local development |
| `editProfile` | Edit Umbraco ID Profile |
| `changePassword` | Change Umbraco ID Password |
| `userProfileAppLabel` | Umbraco ID |

Keys with `{providerName}` accept a string argument at runtime.

## Adding or overriding translations

`Umbraco.Cloud.Cms` uses the same localization extension system as Umbraco CMS. See [Localization](https://docs.umbraco.com/umbraco-cms/extend-your-project/backoffice-extensions/extending-overview/extension-types/localization) in the CMS documentation for the full reference.

Register a localization extension in your Cloud project's `App_Plugins` folder. You only need to include the keys you want to change. The package's default values apply to any keys you do not provide.

### 1. Create a translation file

Create a JavaScript file that exports a default object with the `umbracoIdentity` namespace. Include only the keys you want to add or override.

{% code title="App_Plugins/MyCloudCustomizations/lang/en.js" %}
```javascript
export default {
    umbracoIdentity: {
        signIn: 'Log in with your company account',
        editProfile: 'Edit your profile',
    }
};
```
{% endcode %}

To add a new language, provide all the keys you want to translate. The backoffice falls back to English for any keys not found in the requested language.

{% code title="App_Plugins/MyCloudCustomizations/lang/de.js" %}
```javascript
export default {
    umbracoIdentity: {
        signIn: 'Mit Umbraco ID anmelden',
        loggedOutBackoffice: 'Sie wurden vom Umbraco Backoffice abgemeldet.',
        goToPortal: 'Zum Umbraco Cloud Portal',
        editProfile: 'Umbraco ID-Profil bearbeiten',
        changePassword: 'Umbraco ID-Passwort ändern',
    }
};
```
{% endcode %}

### 2. Register the localization extension

Create or update the `umbraco-package.json` in your `App_Plugins` folder. Add an entry with type `localization` and point it to your translation file.

{% code title="App_Plugins/MyCloudCustomizations/umbraco-package.json" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My Cloud Customizations",
    "extensions": [
        {
            "type": "localization",
            "alias": "MyCloudCustomizations.Localization.En",
            "name": "English",
            "meta": {
                "culture": "en"
            },
            "js": "/App_Plugins/MyCloudCustomizations/lang/en.js"
        }
    ]
}
```
{% endcode %}

Use a unique `alias` to avoid conflicts with other extensions. Add one entry per language file.

### 3. Deploy to Umbraco Cloud

Commit the new files to your Cloud project repository. The translations deploy with your code through normal Umbraco Cloud workflows. See [Deploying Changes](../../build-and-customize-your-solution/handle-deployments-and-environments/deployment/local-to-cloud.md) for details.
