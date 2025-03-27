---
description: A guide to creating a custom dashboard in Umbraco
---

# Creating a Custom Dashboard

## Overview

This guide takes you through the steps to set up a Custom Dashboard in Umbraco.

The steps we will go through in part one are:

1. [Setting up a Package](./#setting-up-a-package)
2. [Creating the Dashboard Web Component](./#creating-the-dashboard-web-component)

### What is a Dashboard?

A Dashboard is a tab on the right-hand side of a section eg. the Getting Started dashboard in the Content section:

![Welcome dashboard](../images/welcome-dashboard.png)

#### Why provide a Custom Dashboard for your editors?

It is generally considered good practice to provide a custom dashboard to welcome your editors to the backoffice of your site. You can provide information about the site and/or provide a helpful gateway to common functionality the editors will use.

This guide will show the basics of creating a custom 'Welcome Message' dashboard. The guide will also show how you can go a little further to provide interaction using Lit and TypeScript.

The finished dashboard will give the editors an overview of which pages and media files they've worked on most recently.

This tutorial uses TypeScript and Lit with Umbraco, It is expected that your package is already [set up to use TypeScript and Lit](../../customizing/development-flow/vite-package-setup.md).

To see how to set up an extension in Umbraco using TypeScript and Lit, read the article [Creating your first extension](../creating-your-first-extension.md).

### Resources

This tutorial will not go in-depth on how TypeScript and Lit work. To learn about TypeScript and Lit, you can find their documentation below:

* [TypeScript documentation](https://www.typescriptlang.org/docs/)
* [Lit documentation](https://lit.dev/docs/)

There are a lot of parallels with Creating a Property Editor. The tutorial '[Creating a Property Editor Tutorial](../creating-a-property-editor/)' is worth a read too.

### The end result

At the end of this guide, we will have a friendly welcoming dashboard displaying a list of the most recent site logs.

{% hint style="info" %}
At each step, you will find a dropdown for `welcome-dashboard.element.ts`, `and umbraco-package.json`to confirm your placement for code snippets.
{% endhint %}

## Setting up a package

1. Follow the [Vite Package Setup](../../customizing/development-flow/vite-package-setup.md) by creating a new project folder called "`welcome-dashboard`" in `App_Plugins`.
2. Create a manifest file named `umbraco-package.json` at the root of the `welcome-dashboard` folder. Here we define and configure our dashboard.
3. Add the following code to `umbraco-package.json`:

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
      "weight": 30,
      "meta": {
        "label": "Welcome Dashboard",
        "pathname": "welcome-dashboard"
      },
      "conditions": [
        {
          "alias": "Umb.Condition.SectionAlias",
          "match": "Umb.Section.Content"
        }
      ]
    }
  ]
}
```
{% endcode %}

For more information about the `umbraco-package.json` file, read the article [Extension Manifest](../../customizing/extending-overview/extension-registry/extension-manifest.md). For more information about the dashboard configurations read the [Dashboards](../../customizing/extending-overview/extension-types/dashboard.md) article.

{% hint style="info" %}
The `umbraco-package.json` files are cached by the server. If you are running your site in development mode, the cache is short-lived (\~10 seconds). If changes to `umbraco-package.json` files are not reflected immediately, try reloading the backoffice a few seconds later.

When running the site in production mode, the cache is long-lived. You can read more about runtime modes in the [Runtime Modes article](../../fundamentals/setup/server-setup/runtime-modes.md).
{% endhint %}

## Creating the Dashboard Web Component

Now let's create the web component we need for our property editor. This web component contains all our HTML, CSS, and logic.

1. Create a file in the `src` folder with the name `welcome-dashboard.element.ts`
2. In this new file, add the following code:

{% code title="welcome-dashboard.element.ts" lineNumbers="true" overflow="wrap" %}
```typescript
import { LitElement, css, html, customElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";

@customElement('my-welcome-dashboard')
export class MyWelcomeDashboardElement extends UmbLitElement {

  override render() {
    return html`
      <h1>Welcome Dashboard</h1>
      <div>
        <p>
          This is the Backoffice. From here, you can modify the content,
          media, and settings of your website.
        </p>
        <p>© Sample Company 20XX</p>
      </div>
    `;
  }

  static override readonly styles = [
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

3. In the `vite.config.ts` file replace the `entry` to our newly created `.ts` file:

```typescript
entry: "src/welcome-dashboard.element.ts"
```

4. In the `welcome-dashboard` folder run `npm run build` and then run the project. Then in the content section of the Backoffice you will see our new dashboard:

<figure><img src="../../.gitbook/assets/spaces_G1Byxw7XfiZAj8zDMCTD_uploads_PtBQkEyVcGmoVx3ysAOJ_welcome (1).webp" alt=""><figcaption><p>First look of the dashboard</p></figcaption></figure>

## Going Further

With all the steps completed, you should have a dashboard welcoming your users to the Backoffice.

In the next part, we will look into how to add localization to the dashboard using our own custom translations.
