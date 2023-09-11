---
description: Learn how to create your first extension for Umbraco.
---

# Creating your first extension

This guide will help you set up your first extension using vanilla JavaScript or Vite, Typescript, and Lit. This is part of the prerequisites for [Creating a Property Editor](creating-a-property-editor/) and [Creating a Custom Dashboard](creating-a-custom-dashboard.md) tutorials.

## The end result

By the end of this tutorial, we will have an extension up and running. This contains a Web Component made with vanilla JavaScript or set up with Vite, Typescript, and Lit.

{% hint style="info" %}
If you want to set up an extension with Vite, Typescript, and Lit, skip the "Extension with Vanilla JavaScript" section.
{% endhint %}

## App\_Plugins

All extensions will go into a folder called `App_Plugins`. If you don't have this folder, you can create it at the root of your Umbraco project.

## Extension with Vanilla JavaScript

We consider it best practice to use at least TypeScript and some kind of build system for extension development. However, Umbraco's extension system is written in JavaScript. Therefore, it's possible to create extensions with vanilla JavaScript. For the sake of posterity, we will briefly go through what that looks like:

Go to the `App_Plugins` folder and create a new folder called `my-package`

Create a new file inside the `my-package` folder called `umbraco-package.json` and paste the following code to instruct Umbraco what kind of extension we are building:

```json
{
	"$schema": "../../umbraco-package-schema.json",
	"name": "My.Package",
	"version": "0.1.0",
	"extensions": [
		{
			"type": "dashboard",
			"alias": "my.custom.dashboard",
			"name": "My Dashboard",
			"js": "/App_Plugins/my-package/dashboard.js",
			"elementName": "my-custom-dashboard",
			"weight": -1,
			"meta": {
				"label": "My Dashboard",
				"pathname": "my-dashboard"
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

The code above tells Umbraco to load an extension of type "dashboard" through the JavaScript module found at `/App_Plugins/my-package/dashboard.js`.

{% hint style="info" %}
Adding "$schema" to umbraco-package.json will give you IntelliSense for this file to help you see different options for your package.
{% endhint %}

Next, create a new JavaScript file called `dashboard.js` and insert the following code:

```javascript
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { UMB_NOTIFICATION_CONTEXT_TOKEN } from '@umbraco-cms/backoffice/notification';

const template = document.createElement('template');
template.innerHTML = `
  <style>
    :host {
      padding: 20px;
      display: block;
      box-sizing: border-box;
    }
  </style>

  <uui-box>
    <h1>Welcome to my dashboard</h1>
    <p>Example of vanilla JS code</p>

    <uui-button label="Click me" id="clickMe" look="secondary"></uui-button>
  </uui-box>
`;

export default class MyDashboardElement extends UmbElementMixin(HTMLElement) {
	/** @type {import('@umbraco-cms/backoffice/notification').UmbNotificationContext} */
	#notificationContext;

	constructor() {
		super();
		this.attachShadow({ mode: 'open' });
		this.shadowRoot.appendChild(template.content.cloneNode(true));

		this.shadowRoot.getElementById('clickMe').addEventListener('click', this.onClick.bind(this));

		this.consumeContext(UMB_NOTIFICATION_CONTEXT_TOKEN, (_instance) => {
			this.#notificationContext = _instance;
		});
	}

	onClick = () => {
		this.#notificationContext?.peek('positive', { data: { headline: 'Hello' } });
	};
}

customElements.define('my-custom-dashboard', MyDashboardElement);
```

The code above defines a Web Component as `my-custom-dashboard` for later insertion into a browser using a similar code:

```html
<my-custom-dashboard></my-custom-dashboard>
```

Umbraco does this for you automatically, since we already referred to the "elementName" back in the `umbraco-package.json` file.

### Running it

Now that we have a JavaScript entry module and linked it up through the manifest file, we are ready to start up the website. Press the F5 button in your favorite IDE or run `dotnet run` in a command line. You should be able to see the new dashboard show up in the Content section.ent section.

You can read more on how to run Umbraco in the [Installation article](../fundamentals/setup/installation/).

## Extension with Vite, Typescript, and Lit

The best way to build extensions is to use a setup with at least TypeScript and a build system. Umbraco expects you to hand it a native Web Component to wrap extensions. A really good way to build those is to use a library such as [Lit](https://lit.dev/) which we will be using throughout this guide.

### Getting Started With Vite

Vite comes with a set of really good presets to get you quickly up and running. Libraries and languages such as Lit, Svelte, and vanilla Web Components are included with both JavaScript and TypeScript.

We will use their preset of Lit and TypeScript here. So, navigate to the root of your project and create a folder called "src" (or wherever you want to keep source files). Go into that folder and paste the following in the command line.

```bash
npm create vite@latest -- --template lit-ts my-package
```

Now go into the newly created `my-package` and install the dependencies:

```bash
npm install
```

If you see any errors during this process, make sure that you have the right tools installed (Node, .NET, and so on). Also, make sure you have followed the steps on how to [Setup Your Development Environment](../extending/development-flow.md).

Next, create a new file called `vite.config.ts` and insert the following code:

```javascript
import { defineConfig } from "vite";

export default defineConfig({
  build: {
    lib: {
      entry: "src/my-element.ts",
      formats: ["es"],
    },
    outDir: "../App_Plugins/my-package/dist",
    sourcemap: true,
    rollupOptions: {
      external: [/^@umbraco/],
    },
  },
});
```

This alters the Vite default output into a "library mode", where the output is a JavaScript file with the same name from package.json.

{% hint style="info" %}
You can read more about [Vite's build options here](https://vitejs.dev/config/build-options.html#build-lib).
{% endhint %}

Then go to the element located in `src/my-element.ts` and replace it with the following code:

```typescript
import { LitElement, html } from "lit";
import { customElement } from "lit/decorators.js";
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { UmbNotificationContext, UMB_NOTIFICATION_CONTEXT_TOKEN } from '@umbraco-cms/backoffice/notification';

@customElement('my-element')
export default class MyElement extends UmbElementMixin(LitElement) {
	private _notificationContext?: UmbNotificationContext;

	constructor() {
		super();
		this.consumeContext(UMB_NOTIFICATION_CONTEXT_TOKEN, (_instance) => {
			this._notificationContext = _instance;
		});
	}

	onClick() {
		this._notificationContext?.peek('positive', { data: { message: '#h5yr' } });
	}

	render() {
		return html`
			<uui-box headline="Welcome">
				<p>A TypeScript Lit Dashboard</p>
				<uui-button look="primary" label="Click me" @click=${() => this.onClick()}></uui-button>
			</uui-box>
		`;
	}
}

declare global {
	interface HTMLElementTagNameMap {
		'my-element': MyElement;
	}
}
```

This adds a LitElement that contains a button which can open a notification with a message to the user.

Then let's build the `ts` file so we can use it in our package

```bash
npm run build
```

Finally, add an `umbraco-package.json` file in the root of your package folder `/App_Plugins/my-package`.

```json
{
	"$schema": "../../umbraco-package-schema.json",
	"name": "My.Package",
	"version": "0.1.0",
	"extensions": [
		{
			"type": "dashboard",
			"alias": "my.custom.dashboard",
			"name": "My Dashboard",
			"js": "/App_Plugins/my-package/dist/my-package.js",
			"elementName": "my-element",
			"weight": -1,
			"meta": {
				"label": "My Dashboard",
				"pathname": "my-dashboard"
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

The code above tells Umbraco to load an extension of type "dashboard" through the JavaScript module found at `/App_Plugins/my-package/dist/my-package.js`.

### Running it

Now that we have a JavaScript entry module and linked it up through the manifest file, we are ready to start up the website. Press the F5 button in your favorite IDE or run `dotnet run` in a command line. Now you should be able to see the new dashboard show up in the Content section.

You can read more on how to run Umbraco in the [Installation article](../fundamentals/setup/installation/).
