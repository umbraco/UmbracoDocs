---
description: A guide to creating a property editor in Umbraco.
---

# Creating a Property Editor

## Overview

This guide explains how to set up a property editor and hook it into Umbraco's Data Types. It also covers the creation of a basic property editor and how we can test our property editor.

The steps we will go through in part one are:

* [Setting up a Plugin](./#setting-up-a-plugin)
* [Creating a Web Component](./#creating-a-web-component)
* [Registering the Data Type in Umbraco](./#registering-the-data-type-in-umbraco)
* [Adding styling and setting up events in Web Components](./#adding-styling-and-setting-up-events-in-the-web-components)
* [Setup Event Logic](./#setup-event-logic)

This tutorial uses TypeScript and Lit with Umbraco, It is expected that your package is already [set up to use TypeScript and Lit](../../customizing/development-flow/vite-package-setup.md).

To see how to set up an extension in Umbraco using TypeScript and Lit, read the article [Creating your first extension](../creating-your-first-extension.md).

### **Resources**

This tutorial will not go in-depth on how TypeScript and Lit work. To learn about TypeScript and Lit, you can find their documentation below:

* [TypeScript documentation](https://www.typescriptlang.org/docs/)
* [Lit documentation](https://lit.dev/docs/)

### The End Result

At the tutorial's end, we'll have a Umbraco Suggestions Data Type, registered in the backoffice, and assigned to a Document Type. This Data Type can create and suggest values.

{% hint style="info" %}
At each step, you will find a dropdown for `suggestions-property-editor-ui.element.ts and umbraco-package.json` to confirm your placement for code snippets.
{% endhint %}

## Setting up a plugin

1. Follow the [Vite Package Setup](../../customizing/development-flow/vite-package-setup.md) by creating a new project folder called "`suggestions`" in `App_Plugins`.
2. Then create the manifest file named `umbraco-package.json` at the root of the `suggestions` folder. Here we define and configure our dashboard.
3. Add the following code to `umbraco-package.json`:

{% code title="umbraco-package.json" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My.AwesomePackage",
    "version": "0.1.0",
    "extensions": [
        {
            "type": "propertyEditorUi",
            "alias": "My.PropertyEditorUi.Suggestions",
            "name": "My Suggestions Property Editor UI",
            "element": "/App_Plugins/Suggestions/dist/suggestions.js",
            "elementName": "my-suggestions-property-editor-ui",
            "meta": {
                "label": "Suggestions",
                "icon": "icon-list",
                "group": "common",
                "propertyEditorSchemaAlias": "Umbraco.Plain.String"
            }
        }
    ]
}
```
{% endcode %}

{% hint style="info" %}
The `umbraco-package.json` files are cached by the server. When creating new `umbraco-package.json` files, it might take a few seconds before those are loaded into the server cache.
{% endhint %}

{% hint style="info" %}
It is important to select the right `propertyEditorSchemaAlias` as it affects how the Property Editor data is made available when rendering the website.

In this example, we selected the `Umbraco.Plain.String` because we want a string value. For more options, see the [default Property Editor Schema aliases](default-property-editor-schema-aliases.md) article.
{% endhint %}

## Creating a Web Component

Now let's create the web component we need for our property editor.

1. Create a file in the `src` folder with the name `suggestions-property-editor-ui.element.ts`
2. In this new file, add the following code:

{% code title="suggestions-property-editor-ui.element.ts" lineNumbers="true" %}
```typescript
import { LitElement, html, customElement, property } from '@umbraco-cms/backoffice/external/lit';
import type { UmbPropertyEditorUiElement } from '@umbraco-cms/backoffice/property-editor';

@customElement('my-suggestions-property-editor-ui')
export default class MySuggestionsPropertyEditorUIElement extends LitElement implements UmbPropertyEditorUiElement {
    @property({ type: String })
    public value = "";

    override render() {
        return html`I'm a property editor!`;
    }
}

declare global {
    interface HTMLElementTagNameMap {
        'my-suggestions-property-editor-ui': MySuggestionsPropertyEditorUIElement;
    }
}
```
{% endcode %}

3.  In the `vite.config.ts` file replace the `entry` to our newly created `.ts` file:

    ```typescript
    entry: "src/suggestions-property-editor-ui.element.ts"
    ```

Now our basic parts of the editor are done, namely:

* The package manifest, telling Umbraco what to load
* The web component for the editor

4. Reload the backoffice.

## Registering the Data Type in Umbraco

1. Add our newly added property editor "Suggestions" in the Document Type and save it.

![Suggestions Property Editor](images/suggestions-property-editor.png)

We can now edit the assigned property's value with our new property editor.

2. Check out the content where you will see the property editor that looks like this:

<figure><img src="../../.gitbook/assets/NewPropertyEditor (1).png" alt=""><figcaption></figcaption></figure>

## Adding styling and setting up events in the Web Components

Let's start by creating an input field and some buttons that we can style and hook up to events.

1. Update the render method to include some input fields and buttons in the `suggestions-property-editor-ui.element.ts` file:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
override render() {
    return html`
      <uui-input
        id="suggestion-input"
        class="element"
        label="text input"
        .value=${this.value || ""}
      >
      </uui-input>
      <div id="wrapper">
        <uui-button
          id="suggestion-button"
          class="element"
          look="primary"
          label="give me suggestions"
        >
          Give me suggestions!
        </uui-button>
        <uui-button
          id="suggestion-trimmer"
          class="element"
          look="outline"
          label="Trim text"
        >
          Trim text
        </uui-button>
      </div>
    `;
  }
```
{% endcode %}

{% hint style="info" %}
The Umbraco UI library is already a part of the backoffice, which means we can start using it.
{% endhint %}

2. Add some styling. Update the import from lit to include `css` and `UmbTextStyles`:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { LitElement, html, css, customElement, property } from '@umbraco-cms/backoffice/external/lit';
import { UmbTextStyles } from '@umbraco-cms/backoffice/style';
```
{% endcode %}

3. Add the CSS:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
render() {
  ...
}

static override readonly styles = [
  UmbTextStyles,
  css`
    #wrapper {
      margin-top: 10px;
      display: flex;
      gap: 10px;
    }
    .element {
      width: 100%;
    }
  `,
];
```
{% endcode %}

It should now look something like this:

<figure><img src="../../.gitbook/assets/NewPropertyEditorButtons (1).png" alt=""><figcaption></figcaption></figure>

<details>

<summary>See the file: suggestions-property-editor-ui.element.ts</summary>

{% code title="suggestions-property-editor-ui.element.ts" lineNumbers="true" %}
```typescript
import { LitElement, html, css, customElement, property } from "@umbraco-cms/backoffice/external/lit";
import type { UmbPropertyEditorUiElement } from "@umbraco-cms/backoffice/property-editor";
import { UmbTextStyles } from '@umbraco-cms/backoffice/style';

@customElement('my-suggestions-property-editor-ui')
export default class MySuggestionsPropertyEditorUIElement extends LitElement implements UmbPropertyEditorUiElement {
    @property({ type: String })
    public value = "";

    override render() {
        return html`
          <uui-input
            id="suggestion-input"
            class="element"
            label="text input"
            .value=${this.value || ""}
          >
          </uui-input>
          <div id="wrapper">
            <uui-button
              id="suggestion-button"
              class="element"
              look="primary"
              label="give me suggestions"
            >
              Give me suggestions!
            </uui-button>
            <uui-button
              id="suggestion-trimmer"
              class="element"
              look="outline"
              label="Trim text"
            >
              Trim text
            </uui-button>
          </div>
        `;
    }

    static override readonly styles = [
        UmbTextStyles,
        css`
          #wrapper {
            margin-top: 10px;
            display: flex;
            gap: 10px;
          }
          .element {
            width: 100%;
          }
        `,
      ];

}


declare global {
    interface HTMLElementTagNameMap {
        'my-suggestions-property-editor-ui': MySuggestionsPropertyEditorUIElement;
    }
}
```
{% endcode %}

</details>

It's starting to look good! Next, let's look into setting up the event logic.

## Setup Event Logic

### Setup Input Field

Let's start with the input field. When we type something in the input field, we want the property editor's value to change to the input field's current value.

We then have to dispatch a `change` event which can be done in two ways:

* Using `new CustomEvent('change')` or
* Using `new UmbChangeEvent()` which is recommended as you can leverage the core class

1. Add the import so the event can be used:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { UmbChangeEvent } from '@umbraco-cms/backoffice/event';
```
{% endcode %}

2. Add the event to the property editor:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
  #onInput(e: InputEvent) {
    this.value = (e.target as HTMLInputElement).value;
    this.#dispatchChangeEvent();
  }

  #dispatchChangeEvent() {
    this.dispatchEvent(new UmbChangeEvent());
  }

  override render() {
    return html`
      <uui-input
        id="suggestion-input"
        class="element"
        label="text input"
        .value=${this.value || ""}
        @input=${this.#onInput}
      >
      </uui-input>

      ....
}
```
{% endcode %}

Let's look at the suggestions button next.

### Setup Suggestions Button

* When we press the suggestion button we want the text to update to the suggestion that we get. Similar to how the value of our property editor changes when we write in the input field.
* We also want the value to change when we press the suggestion button.

1. Update the import for Lit:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { LitElement, html, css, customElement, property, state } from "@umbraco-cms/backoffice/external/lit";
```
{% endcode %}

2. Add suggestions to the property editor:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
  @state()
  private _suggestions = [
    'You should take a break',
    'I suggest that you visit the Eiffel Tower',
    'How about starting a book club today or this week?',
    'Are you hungry?',
  ];

  override render() {...}
```
{% endcode %}

3. Update the suggestion button in the render method to call a `onSuggestion` method when we press the button:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
#onSuggestion() {
    const randomIndex = (this._suggestions.length * Math.random()) | 0;
    this.value = this._suggestions[randomIndex];
    this.#dispatchChangeEvent();
}

override render() {
    return html`

    ...

    <uui-button
        id="suggestion-button"
        class="element"
        look="primary"
        label="give me suggestions"
        @click=${this.#onSuggestion}
        >
        Give me suggestions!
        </uui-button>
    ...
    `;
}
```
{% endcode %}

<details>

<summary>See the entire file: suggestions-property-editor-ui.element.ts</summary>

{% code title="suggestions-property-editor-ui.element.ts" lineNumbers="true" overflow="wrap" %}
```typescript
import { UmbChangeEvent } from '@umbraco-cms/backoffice/event';
import { css, customElement, html, LitElement, property, state } from '@umbraco-cms/backoffice/external/lit';
import type { UmbPropertyEditorUiElement } from '@umbraco-cms/backoffice/property-editor';
import { UmbTextStyles } from '@umbraco-cms/backoffice/style';

@customElement('my-suggestions-property-editor-ui')
export default class MySuggestionsPropertyEditorUIElement extends LitElement implements UmbPropertyEditorUiElement {
	@property({ type: String })
	public value = '';

	@state()
	private _suggestions = [
		'You should take a break',
		'I suggest that you visit the Eiffel Tower',
		'How about starting a book club today or this week?',
		'Are you hungry?',
	];

	#onInput(e: InputEvent) {
		this.value = (e.target as HTMLInputElement).value;
		this.#dispatchChangeEvent();
	}

	#onSuggestion() {
		const randomIndex = (this._suggestions.length * Math.random()) | 0;
		this.value = this._suggestions[randomIndex];
		this.#dispatchChangeEvent();
	}

	#dispatchChangeEvent() {
		this.dispatchEvent(new UmbChangeEvent());
	}

	override render() {
		return html`
			<uui-input
				id="suggestion-input"
				class="element"
				label="text input"
				.value=${this.value || ''}
				@input=${this.#onInput}>
			</uui-input>
			<div id="wrapper">
				<uui-button
					id="suggestion-button"
					class="element"
					look="primary"
					label="give me suggestions"
					@click=${this.#onSuggestion}>
					Give me suggestions!
				</uui-button>
				<uui-button id="suggestion-trimmer" class="element" look="outline" label="Trim text"> Trim text </uui-button>
			</div>
		`;
	}

	static override readonly styles = [
		UmbTextStyles,
		css`
			#wrapper {
				margin-top: 10px;
				display: flex;
				gap: 10px;
			}
			.element {
				width: 100%;
			}
		`,
	];
}

declare global {
	interface HTMLElementTagNameMap {
		'my-suggestions-property-editor-ui': MySuggestionsPropertyEditorUIElement;
	}
}
```
{% endcode %}

</details>

4. Clear your cache, reload the document, and see the Suggestions Data Type running.

<figure><img src="../../.gitbook/assets/NewPropertyEditorSuggestions (1).png" alt=""><figcaption></figcaption></figure>

When we save or publish, the value of the Data Type is now automatically synced to the current content object and sent to the server.

Learn more about extending this service by visiting the [Property Editors](../../customizing/property-editors/composition/) page.

## Going further

With all the steps completed, we have created a Suggestion Data Type running in our property editor.

In the next part, we will look at adding configurations to our property editor.
