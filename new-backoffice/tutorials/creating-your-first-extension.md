# Creating your first extension

This guide will help you set up your first extension using vanilla Javascript or Vite, Typescript, and Lit and is part of the prerequisites for [Creating a Property Editor](broken-reference) and [Creating a Custom Dashboard](creating-a-custom-dashboard.md) tutorials.

## The end result:

By the end of this tutorial, we will have an extension up and running with a Web Component made with vanilla Javascript or set up with Vite, Typescript, and Lit.

{% hint style="info" %}
If you want to set up an extension with Vite, Typescript, and Lit, skip the "Extension with Vanilla Javascript" section.
{% endhint %}

## App\_Plugins

All extensions will go into a folder called `App_Plugins`. If you don't have this folder, you can create it at the root of your Umbraco project.

## Extension with Vanilla Javascript

Go to the `App_Plugins` folder and create a new folder called `my-package`

&#x20;Open the folder `my-package` in the terminal and paste the following in the terminal:

```bash
npm install -D @umbraco-cms/backoffice
```

Create a new file called `umbraco-package.json` in the root of `my-package` folder and paste the following code:

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
			"conditions": {
				"sections": ["Umb.Section.Content"]
			}
		}
	]
}
```

{% hint style="info" %}
Adding $schema to umbraco-package.json will give you some IntelliSense for this file to help you see different options for your package.
{% endhint %}

Create a new javascript file called `dashboard.js` and insert the following code:

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

## Extension with Vite, Typescript, and Lit

Navigate to the `App_Plugins` in the terminal and paste the following in the terminal:

```bash
npm create vite@latest -- --template lit-ts my-package
```

Go to the new folder and install the backoffice package.

```bash
cd my-package
npm install -D @umbraco-cms/backoffice
```

At the root of the `my-package` folder, create a new file called `vite.config.js` and insert the following code:

```javascript
import { defineConfig } from "vite";

export default defineConfig({
  build: {
    lib: {
      entry: "src/my-element.ts",
      formats: ["es"],
    },
    sourcemap: true,
    rollupOptions: {
      external: [/^@umbraco/],
    },
  },
});
```

{% hint style="info" %}
This alters the Vite default output into a "library mode", where the output is a javascript file with the same name from package.json.

You can read more about [Vite's build options here](https://vitejs.dev/config/build-options.html#build-lib).
{% endhint %}

There is a couple of files we won't need so let's clean it up a bit.

Delete the `public` folder and its contents and the file `index.html`.

In the `src` folder, you can delete the folder`assets` and its contents, and delete the files `index.css` and `vite-env.d.ts`

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

Then let's build the `ts` file so we can use it in our package

```bash
npm run build
```

Finally, add an `umbraco-package.json` file in the root of your package folder `my-package`.

<pre class="language-json"><code class="lang-json"><strong>{
</strong><strong>	"$schema": "../../umbraco-package-schema.json",
</strong>	"name": "My.Package",
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
			"conditions": {
				"sections": ["Umb.Section.Content"]
			}
		}
	]
}
</code></pre>

And that's it! Your extension is now ready and you can start up the backoffice by building and/or restarting the web application.
