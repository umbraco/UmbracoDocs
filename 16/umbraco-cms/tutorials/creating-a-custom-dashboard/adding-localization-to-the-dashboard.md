---
description: Set up localization for your dashboard.
---

# Adding localization to the dashboard

## Overview

This is the second part of our guide to building a Custom Dashboard. This part continues work on the dashboard we built in part one: [Creating a Custom Dashboard](./). It further shows how to handle localization in a custom dashboard.

The steps we will go through in second part are:

1. [Setup localization files](adding-localization-to-the-dashboard.md#setup-localization-files)
2. [Register localization files](adding-localization-to-the-dashboard.md#register-localization-files)
3. [Use the localization files](adding-localization-to-the-dashboard.md#using-the-localization-files)

## Setup Localization Files

1. In the `welcome-dashboard` folder create a new folder called "`Localization`"
2. Then create two new files `en.js` and `da-dk.js`:

* Add the following code to `en.js`

{% code title="/App_Plugins/welcome-dashboard/Localization/en.js" lineNumbers="true" %}

```javascript
export default {
  welcomeDashboard: {
    label: "Welcome Dashboard",
    heading: "Welcome",
    bodytext: "This is the Backoffice. From here, you can modify the content, media, and settings of your website.",
    copyright: "© Sample Company 20XX",
  }
};
```

{% endcode %}

* Add the following code to `da-dk.js`

{% code title="/App_Plugins/welcome-dashboard/Localization/da-dk.js" lineNumbers="true" %}

```javascript
export default {
  welcomeDashboard: {
    label: "Velkomst Dashboard",
    heading: "Velkommen",
    bodytext: "Dette er Backoffice. Herfra kan du ændre indholdet, medierne og indstillingerne på din hjemmeside.",
    copyright: "© Sample Selskab 20XX",
  }
};
```

{% endcode %}

## Register Localization Files

Now let's update the `umbraco-package.json` file from the `welcome-dashboard` folder to register our new localization files:

{% code title="umbraco-package.json" lineNumbers="true" %}

```typescript
{
  ...
  "extensions": [
    {...},
    {
      "type": "localization",
      "alias": "MyPackage.Localize.En",
      "name": "English",
      "meta": {
        "culture": "en"
      },
      "js": "/App_Plugins/welcome-dashboard/Localization/en.js"
    },
    {
      "type": "localization",
      "alias": "MyPackage.Localize.DaDK",
      "name": "Danish",
      "meta": {
        "culture": "da-dk"
      },
      "js": "/App_Plugins/welcome-dashboard/Localization/da-dk.js"
    }
  ]
}
```

{% endcode %}

Run `npm run build` in the `welcome-dashboard` folder and then run the project.

<details>

<summary>See the entire file: umbraco-package.json</summary>

{% code title="umbraco-package.json" lineNumbers="true" %}

```json
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "My.WelcomePackage",
  "version": "0.1.0",
  "extensions": [
    {
      "type": "dashboard",
      "alias": "my.welcome.dashboard",
      "name": "My Welcome Dashboard",
      "element": "/App_Plugins/welcome-dashboard/dist/welcome-dashboard.js",
      "elementName": "my-welcome-dashboard",
      "weight": -1,
      "meta": {
        "label": "#welcomeDashboard_label",
        "pathname": "welcome-dashboard"
      },
      "conditions": [
        {
          "alias": "Umb.Condition.SectionAlias",
          "match": "Umb.Section.Content"
        }
      ]
    },
    {
      "type": "localization",
      "alias": "MyPackage.Localize.En",
      "name": "English",
      "meta": {
        "culture": "en"
      },
      "js": "/App_Plugins/welcome-dashboard/Localization/en.js"
    },
    {
      "type": "localization",
      "alias": "MyPackage.Localize.DaDK",
      "name": "Danish",
      "meta": {
        "culture": "da-dk"
      },
      "js": "/App_Plugins/welcome-dashboard/Localization/da-dk.js"
    }
  ]
}
```

{% endcode %}

</details>

We can use the `umb-localize` element to get the localizations out, which takes a key property in.

## Using the Localization Files

Let's start using the localizations. In the `umbraco-package.json` file, we will already be using the `#welcomeDashboard_label` key for the dashboard label. Go ahead and replace `"label": "Welcome Dashboard"` with `"label": "#welcomeDashboard_label"`.

{% hint style="info" %}
The `#` is used to indicate that the value is a key and not a string.
{% endhint %}

We will now use the `umb-localize` element to get the translations for the dashboard. Update the `welcome-dashboard.element.ts`:

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}
```typescript
render() {
    return html`
      <h1>
        <umb-localize key="welcomeDashboard_heading">Welcome</umb-localize>
        Dashboard
      </h1>
      <div>
        <p>
          <umb-localize key="welcomeDashboard_bodytext">
            This is the Backoffice. From here, you can modify the content,
            media, and settings of your website.
          </umb-localize>
        </p>
        <p>
          <umb-localize key="welcomeDashboard_copyright">
            © Sample Company 20XX
          </umb-localize>
        </p>
      </div>
    `;
  }
```
{% endcode %}

Run `npm run build` in the `welcome-dashboard` folder and then run the project.

<details>

<summary>See the entire file: welcome-dashboard.element.ts</summary>

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}

```typescript
import { LitElement, css, html, customElement} from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

@customElement('my-welcome-dashboard')
export class MyWelcomeDashboardElement extends UmbElementMixin(LitElement) {

  render() {
    return html`
      <h1>
        <umb-localize key="welcomeDashboard_heading">Welcome</umb-localize>
        Dashboard
      </h1>
      <div>
        <p>
          <umb-localize key="welcomeDashboard_bodytext">
            This is the Backoffice. From here, you can modify the content,
            media, and settings of your website.
          </umb-localize>
        </p>
        <p>
          <umb-localize key="welcomeDashboard_copyright">
            © Sample Company 20XX
          </umb-localize>
        </p>
      </div>
    `;
  }

  static styles = [
    css`
      :host {
        display: block;
        padding: 24px;
      }
    `,
  ];
}

export default MyWelcomeDashboardElement;

declare global {
  interface HTMLElementTagNameMap {
    'my-welcome-dashboard': MyWelcomeDashboardElement;
  }
}
```

{% endcode %}

</details>

The dashboard's text will appear depending on the user's language.

* If the user's language is Danish, the dashboard will use the text from our `da-dk` file.
* If the user's language is English, the dashboard will use the text from our `en` file.
* If the key is not found in the current language, the fallback language (`en`) will be used.

{% hint style="info" %}
The text between the open and close tags of `umb-localize` is the fallback value. This is used in case the key can't be found at all.
{% endhint %}

This is how our dashboard should now look like:

<div>

<figure><img src="../../.gitbook/assets/welcome-eng (1).png" alt=""><figcaption><p>Dashboard if the user's language is English / Fallback</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/welcome-da (1).png" alt=""><figcaption><p>Dashboard if the user's language is Danish</p></figcaption></figure>

</div>

{% hint style="info" %}
Tip: If you do not have many translations, you can also choose to include the localizations directly in the meta-object. Read more about translations in the [**Localization**](../../extending/language-files/README.md) article.
{% endhint %}

## Going Further

With the part completed, you should have a dashboard welcoming your users' language.

In the next part, we will look into how to add more functionality to the dashboard using some of the Contexts that Umbraco offers.
