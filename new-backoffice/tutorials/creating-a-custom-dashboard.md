---
description: A guide to creating a custom dashboard in Umbraco
---

# Creating a Custom Dashboard

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

## Overview

This guide takes you through the steps to set up a Custom Dashboard in Umbraco.

The guide is divided into four parts. The first part will go through the following:

1. [Setting up a package](creating-a-custom-dashboard.md#1.-setting-up-a-package)
2. [Creating the dashboard web component](creating-a-custom-dashboard.md#2.-creating-the-dashboard-web-component)

### What is a Dashboard?

A Dashboard is a tab on the right-hand side of a section eg. the Getting Started dashboard in the Content section:

![Welcome dashboard](<../../10/umbraco-cms/tutorials/images/whatisadashboard-v10 (1) (1).jpg>)

#### Why provide a Custom Dashboard for your editors?

It is generally considered good practice to provide a custom dashboard to welcome your editors to the backoffice of your site. You can provide information about the site and/or provide a helpful gateway to common functionality the editors will use. This guide will show the basics of creating a custom 'Welcome Message' dashboard. The guide will also show how you can go a little further to provide interaction using Lit and Typescript.

The finished dashboard will give the editors an overview of which pages and media files they've worked on most recently.

Here's an overview of the steps that will be covered:

* Setting up the dashboard plugin
* Writing a basic Welcome Message view
* Configure the Custom Welcome Dashboard to be displayed
* Adding translations
* Adding styles
* Adding interactive functionality with Lit and Typescript
* Display the current user's name in our welcome message
* Display the most recent log viewer items
* You can do anything...

### Prerequisites

This tutorial uses Typescript and Lit with Umbraco, so it does not cover Typescript or Lit. It is expected that your package is already set up to use Typescript and Lit. To read about setting up an extension in Umbraco using Typescript and Lit, please read the article [Creating your first extension](creating-your-first-extension.md).

For resources on Typescript or Lit, you can find some here:

* [Typescript Docs](https://www.typescriptlang.org/docs/)
* [Lit Docs](https://lit.dev/docs/)

There are a lot of parallels with Creating a Property Editor. The tutorial '[Creating a Property Editor Tutorial](creating-a-property-editor/)' is worth a read too.

### The end result

At the end of this guide, we should have a friendly welcoming dashboard displaying a list of the most recent site logs.

## 1. Setting up a package

Assuming you have read the tutorial [Creating your first extension](creating-your-first-extension.md), you should have a folder named App\_Plugins in your project. Let's call our project WelcomeDashboard. Start by creating a folder in App\_Plugins called `WelcomeDashboard`.

Create the manifest file `umbraco-package.json` at the root of the folder `WelcomeDashboard`. Here we define and configure our dashboard.

Add the following code:

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
			"js": "/App_Plugins/WelcomeDashboard/dashboard.js",
			"elementName": "my-welcome-dashboard",
			"weight": -1,
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

Notice that the file for our dashboard extension is in the root of our WelcomeDashboard folder and is called `dashboard.js`with the element name `my-welcome-dashboard`.

For more information about the `umbraco-package.json` file, read the article [Package Manifest](../extending/package-manifest.md). You should also read the [Dashboards](../extending/dashboards.md) article for more information about dashboard configurations.

{% hint style="info" %}
Please note that the file`umbraco-package.json` is loaded into memory when Umbraco starts up. If you are changing or adding new configurations you will need to start and stop your application for it to be loaded.
{% endhint %}

## 2. Creating the Dashboard Web Component

Next, let's create a new ts file called `welcome-dashboard.element.ts`. This file is our web component and will contain all our HTML, CSS, and logic.

Let's start with setting the web component with some HTML and CSS:

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}
```typescript
import { LitElement, css, html } from "lit";
import { customElement } from "lit/decorators.js";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

@customElement("my-welcome-dashboard")
export class MyWelcomeDashboardElement extends UmbElementMixin(LitElement) {

  render() {
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

  static styles = [
    css`
      :host {
        display: block;
        padding: 24px;
      }
    `,
  ];
}

declare global {
  interface HTMLElementTagNameMap {
    "my-welcome-dashboard": MyWelcomeDashboardElement;
  }
}
```
{% endcode %}

Build the `ts` file and make sure to copy the output file to `dashboard.js` under `/App_Plugins/WelcomeDashboard/`.

You can now start up the Backoffice and see our new dashboard in the content section:

<figure><img src="../.gitbook/assets/spaces_G1Byxw7XfiZAj8zDMCTD_uploads_PtBQkEyVcGmoVx3ysAOJ_welcome.webp" alt=""><figcaption><p>First look of the dashboard</p></figcaption></figure>

## Going Further

With all the steps completed, you should have a dashboard welcoming your users to the Backoffice.

In the next part, we will look into how to add localization to the dashboard using our own custom translations.
