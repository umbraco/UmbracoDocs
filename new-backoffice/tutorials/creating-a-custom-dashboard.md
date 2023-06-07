---
description: A guide to creating a custom dashboard in Umbraco
---

# Creating a Custom Dashboard

{% hint style="info" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

## Overview

This guide takes you through the steps to set up a Custom Dashboard in Umbraco.

The steps we will go through in part 1 are:

* [Setting up a plugin](creating-a-custom-dashboard.md#step-1-setting-up-a-plugin)
* [Creating the dashboard web component](creating-a-custom-dashboard.md#step-2-creating-the-dashboard-web-component)
* [Add language keys](creating-a-custom-dashboard.md#step-3-add-language-keys)

### What is a Dashboard?

A Dashboard is a tab on the right-hand side of a section eg. the Getting Started dashboard in the Content section:

![Welcome dashboard](<../../10/umbraco-cms/tutorials/images/whatisadashboard-v10 (1) (1).jpg>)

### Why provide a Custom Dashboard for your editors?

It is generally considered good practice to provide a custom dashboard to welcome your editors to the backoffice of your site. You can provide information about the site and/or provide a helpful gateway to common functionality the editors will use. This guide will show the basics of creating a custom 'Welcome Message' dashboard. The guide will also show how you can go a little further to provide interaction using Lit and Typescript.

The finished dashboard will give the editors an overview of which pages and media files they've worked on most recently.

Here's an overview of the steps that will be covered:

* Setting up the dashboard plugin
* Writing a basic Welcome Message view
* Configure the Custom Welcome Dashboard to be displayed
* Adding translations_\*_
* Adding styles
* Adding interactive functionality with Lit and Typescript
* Display the current user's name in our welcome message
* Display the most recent log viewer items
* You can do anything...

{% hint style="info" %}
\*Features are still a work in progress and therefore not available.
{% endhint %}

### Prerequisites

This tutorial uses Typescript and Lit with Umbraco, so it does not cover Typescript or Lit. It is expected that your package is already set up to use Typescript and Lit. To read about setting up an extension in Umbraco using Typescript and Lit, please read the article [Creating your first extension](creating-your-first-extension.md).

For resources on Typescript or Lit, you can find some here:

* [Typescript Docs](https://www.typescriptlang.org/docs/)
* [Lit Docs](https://lit.dev/docs/)

There are a lot of parallels with Creating a Property Editor. The tutorial '[Creating a Property Editor Tutorial](creating-a-property-editor/)' is worth a read too.

### The end result

At the end of this guide, we should have a friendly welcoming dashboard displaying a list of the most recent site logs.

## Step 1: Setting up a plugin

Assuming you have read the tutorial [Creating your first extension](creating-your-first-extension.md), you should have a folder named App\_Plugins in your project. Let's call our project WelcomeDashboard. Start by creating a folder in App\_Plugins called `WelcomeDashboard`.

Now create the manifest file named `umbraco-package.json` at the root of the `WelcomeDashboard` folder. Here we define and configure our dashboard.

Add the following code:

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
			"js": "/App_Plugins/CustomWelcomeDashboard/dist/welcomedashboard.js",
			"elementName": "my-welcome-dashboard",
			"weight": -1,
			"meta": {
				"label": "Welcome Dashboard",
				"pathname": "welcome-dashboard"
			},
			"conditions": {
				"sections": ["Umb.Section.Content"]
			}
		}
	]
}
```

For more information about the `umbraco-package.json` file, read the article [Package Manifest](../extending/package-manifest/). You should also read the [Dashboards](../extending/dashboards.md) article for more information about dashboard configurations.

{% hint style="info" %}
Please note that the umbraco-package.json file is loaded into memory when Umbraco starts up. If you are changing or adding new configurations you will need to start and stop your application for it to be loaded.
{% endhint %}

## Step 2: Creating the Dashboard Web Component

Next, inside the `src` folder let's create a new ts file called `welcome-dashboard.element.ts`. This file is our web component and will contain all of our HTML, CSS, and logic.

Let's start with setting it the web component with some simple HTML and CSS:

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}
```typescript
import { LitElement, css, html } from "lit";
import { customElement, property } from "lit/decorators.js";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

@customElement("my-welcome-dashboard")
export class MyWelcomeDashboardElement extends UmbElementMixin(LitElement) {

  render() {
    return html`
      <h1>Welcome Dashboard<h1>
      <div>
        <p>
          This is the Backoffice. From here, you can modify the content,
          media, and settings of your website.
        </p>
        <p>© Sample Company 20XX</p>
      </div>
    `;
  }
}

declare global {
  interface HTMLElementTagNameMap {
    "my-welcome-dashboard": MyWelcomeDashboardElement;
  }
}
```
{% endcode %}

You can now start up the backoffice and see our new dashboard in the Content section.

## Step 3: Add Language Keys

{% hint style="info" %}
Localization is not yet available in the new Backoffice. This section will be updated when it is ready.
{% endhint %}

## Going Further

With all of the steps completed, you should have a functional dashboard welcoming your users to the Backoffice.

In the next session, we will look into how to add more functionality to the dashboard using some of the resources and services that Umbraco offers.
