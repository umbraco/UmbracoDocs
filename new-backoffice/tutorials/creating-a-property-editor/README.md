---
description: A guide to creating a property editor in Umbraco
---

# Creating a Property Editor

{% hint style="info" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

This guide explains how to set up a property editor, hook it into Umbraco's Data Types, create a basic property editor, and how we can test our property editor.

The steps we will go through in part 1 are:

* ​[Setting up a Plugin](./#1.-setting-up-a-plugin)​
* ​[Creating a Web Component​](./#2.-creating-a-simple-web-component)
* ​[Registering the Data Type in Umbraco](./#3.-registering-the-data-type-in-umbraco)
* [Adding styling and setting up events in Web Components](./#4.-adding-styling-and-setting-up-events-in-the-web-components)

### Prerequisites

This tutorial uses Typescript and Lit with Umbraco, so it does not cover Typescript or Lit. It is expected that your package is already set up to use Typescript and Lit. To read about setting up an extension in Umbraco using Typescript and Lit, please read the article [Creating your first extension](../creating-your-first-extension.md).

For resources on Typescript or Lit, you can find some here:

* [Typescript Docs](https://www.typescriptlang.org/docs/)
* [Lit Docs](https://lit.dev/docs/)

There are a lot of parallels with Creating a Custom Dashboard. The tutorial [Creating a Custom Dashboard](../creating-a-custom-dashboard.md) is worth a read too.

### The End Result

By the end of this tutorial, we will have a Suggestions data type running inside of Umbraco, registered as a Data Type in the backoffice, and assigned to a Document Type. The data type can create and suggest values.

### 1. Setting up a plugin

Assuming you have read the tutorial [Creating your first extension](../creating-your-first-extension.md), you should have a folder named App\_Plugins in your project. Let's call our project Suggestions. Start by creating a folder in App\_Plugins called `Suggestions`.

Now create the manifest file named `umbraco-package.json` at the root of the `Suggestions` folder. Here we define and configure our dashboard.

Add the following code

```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My.AwesomePackage",
    "version": "0.1.0",
    "extensions": [
        {
            "type": "propertyEditorUi",
            "alias": "My.PropertyEditorUi.Suggestions",
            "name": "My Suggestions",
            "js": "/App_Plugins/Suggestions/my-property-editor-ui-suggestions.js",
            "elementName": "my-property-editor-ui-suggestions",
            "meta": {
                "label": "My Suggestions",
                "pathname": "my-suggestions",
                "icon": "umb:list",
                "group": "common",
                "propertyEditorSchemaAlias": "Umbraco.TextBox"
            }
        }
    ]
}
```

{% hint style="info" %}
Make sure to restart the application after you create and update`umbraco-package.json`
{% endhint %}

### 2. Creating a simple Web Component

Let's start with creating a folder `src` in our Suggestions folder. We want to start creating the web component we need for our property editor. Create a file in the `src` folder with the name `property-editor-ui-suggestions.element.ts`

In this new file, we will add the following code:

```typescript
import { LitElement, html } from "lit";
import { customElement, property } from "lit/decorators.js";
import { UmbPropertyEditorExtensionElement } from "@umbraco-cms/backoffice/extension-registry";

@customElement("my-property-editor-ui-suggestions")
export class MyPropertyEditorUISuggestionsElement
  extends LitElement
  implements UmbPropertyEditorExtensionElement
{
  @property({ type: String })
  public value = "";


  render() {
    return html`I'm a property editor!`;
  }
}

export default MyPropertyEditorUISuggestionsElement;

declare global {
  interface HTMLElementTagNameMap {
    "my-property-editor-ui-suggestions": MyPropertyEditorUISuggestionsElement;
  }
}
```

Now our basic parts of the editor are done, namely:

* The package manifest, telling Umbraco what to load
* The web component for the editor

### 3. Registering the Data Type in Umbraco

We will now restart our application. In the Document Type, let's add our newly added property editor "Suggestions" and save it.

<figure><img src="../../.gitbook/assets/spaces_OdQETpqkO0Kcv8KMquKL_uploads_git-blob-c7d7e59228a3b5738a1464489ef7601b7f8d350d_suggestion-property-editor.webp" alt=""><figcaption></figcaption></figure>

We can now edit the assigned property's value with our new property editor.

We should now have a property editor that looks like this:

<figure><img src="../../.gitbook/assets/NewPropertyEditor.png" alt=""><figcaption></figcaption></figure>

### 4. Adding styling and setting up events in the Web Components

Let's start by creating an input field and some buttons that we can style and hook up to events. In the `property-editor-ui-suggestions.element` file, update the render method to include some input fields and buttons:

{% hint style="info" %}
The Umbraco UI library is already a part of the backoffice, which means we can start using it
{% endhint %}

```typescript
render() {
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

Next, let's add a little bit of styling. Update the import from lit to include CSS:

```typescript
import { LitElement, html, css } from 'lit';
```

Then add the CSS:

```typescript
render() {
  ...
}

static styles = [
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

It should now look something like this:

<figure><img src="../../.gitbook/assets/NewPropertyEditorButtons.png" alt=""><figcaption></figcaption></figure>

It's starting to look good! Next, let's look into setting up the event logic.

Let's start with the input field. When we type something in the input field, we want the property editor's value to change to the input field's current value. We then have to dispatch an `property-value-change` event.

<pre class="language-typescript"><code class="lang-typescript">  #onInput(e: InputEvent) {
    this.value = (e.target as HTMLInputElement).value;
    this.#dispatchEvent()
  }

  #dispatchEvent() {
    this.dispatchEvent(new CustomEvent('property-value-change'));
  }

  render() {
    return html`
      &#x3C;uui-input
        id="suggestion-input"
        class="element"
        label="text input"
        .value=${this.value || ""}
        @input=${this.#onInput}
      >
      &#x3C;/uui-input>
      
      ....
<strong>  }
</strong></code></pre>

Let's look at the suggestions button next. When we press the suggestion button we want the text to update to the suggestion that we get. Just like the value of our property editor is going to change when we write in the input field, we also want the value to change when we press the suggestion button.

First, update the import for lit decorators and add some suggestions to the property editor:

```typescript
import { customElement, property, state } from "lit/decorators.js";
```

```typescript

  @property({ type: String })
  public value = "";

  @state()
  private _suggestions = [
    'You should take a break',
    'I suggest that you visit the Eiffel Tower',
    'How about starting a book club today or this week?',
    'Are you hungry?',
  ];

```

Then update the suggestion button in the render method to call a `onSuggestion` method when we press the button

<pre class="language-typescript"><code class="lang-typescript">  #onSuggestion() {
    const randomIndex = (this._suggestions.length * Math.random()) | 0;
    this.value = this._suggestions[randomIndex];
    this.#dispatchChangeEvent();
  }
  
 render() {
    return html`
    
    ...
    
<strong>        &#x3C;uui-button
</strong>          id="suggestion-button"
          class="element"
          look="primary"
          label="give me suggestions"
          @click=${this.#onSuggestion}
        >
          Give me suggestions!
        &#x3C;/uui-button>

    ...
    
  `;
 }
</code></pre>

The `property-editor-ui-suggestions.element` file should now look something like this:

```typescript
import { LitElement, css, html } from "lit";
import { customElement, property, state } from "lit/decorators.js";
import { UmbPropertyEditorExtensionElement } from "@umbraco-cms/backoffice/extension-registry";

@customElement("my-property-editor-ui-suggestions")
export class MyPropertyEditorUISuggestionsElement
  extends LitElement
  implements UmbPropertyEditorExtensionElement
{
  @property({ type: String })
  public value = "";

  @state()
  private _suggestions = [
    "You should take a break",
    "I suggest that you visit the Eiffel Tower",
    "How about starting a book club today or this week?",
    "Are you hungry?",
  ];

  #onInput(e: InputEvent) {
    this.value = (e.target as HTMLInputElement).value;
    this.#dispatchEvent();
  }

  #onSuggestion() {
    const randomIndex = (this._suggestions.length * Math.random()) | 0;
    this.value = this._suggestions[randomIndex];
    this.#dispatchEvent();
  }

  #dispatchEvent() {
    this.dispatchEvent(new CustomEvent("property-value-change"));
  }

  render() {
    return html`
      <uui-input
        id="suggestion-input"
        class="element"
        label="text input"
        .value=${this.value || ""}
        @input=${this.#onInput}
      >
      </uui-input>
      <div id="wrapper">
        <uui-button
          id="suggestion-button"
          class="element"
          look="primary"
          label="give me suggestions"
          @click=${this.#onSuggestion}
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

  static styles = [
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

export default MyPropertyEditorUISuggestionsElement;

declare global {
  interface HTMLElementTagNameMap {
    "my-property-editor-ui-suggestions": MyPropertyEditorUISuggestionsElement;
  }
}
```

Next, clear the cache, reload the document, and see the Suggestions Data Type running.

<figure><img src="../../.gitbook/assets/NewPropertyEditorSuggestions.png" alt=""><figcaption></figcaption></figure>

When we save or publish, the value of the Data Type is now automatically synced to the current content object and sent to the server.

Learn more about extending this service by visiting the [Property Editors page](../../extending/extension-types/property-editors/).
