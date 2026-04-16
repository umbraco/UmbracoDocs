---
description: A guide to creating a property editor in Umbraco.
---

# Creating a Property Editor

## Overview

This guide covers setting up a Property Editor and registering it as a Data Type in Umbraco

The steps covered in part one are:

* [Setting up a Plugin](./#setting-up-a-plugin)
* [Creating a Web Component](./#creating-a-web-component)
* [Registering the Data Type in Umbraco](./#registering-the-data-type-in-umbraco)
* [Adding styling and setting up events in Web Components](./#adding-styling-and-setting-up-events-in-the-web-components)
* [Setup Event Logic](./#setup-event-logic)

This tutorial uses TypeScript and Lit. Make sure your package is already [set up before continuing](../../customizing/development-flow/vite-package-setup.md).

o set up an extension using TypeScript and Lit, see the [Creating your first extension](../creating-your-first-extension.md) article.

### Resources

This tutorial will not go in-depth on how TypeScript and Lit work. To learn about TypeScript and Lit, you can find their documentation below:

* [TypeScript documentation](https://www.typescriptlang.org/docs/)
* [Lit documentation](https://lit.dev/docs/)

### The End Result

By the end of this tutorial, you will have a Suggestions Data Type, registered in the backoffice, and assigned to a Document Type. This Data Type can create and suggest values.

{% hint style="info" %}
At the end of the final step, a dropdown displaying the entire `suggestions-property-editor-ui.element.ts` and `umbraco-package.json` files is available.
{% endhint %}

## Setting up a plugin

1. Follow the [Vite Package Setup](../../customizing/development-flow/vite-package-setup.md) by creating a new project folder called "`suggestions`" in `App_Plugins`.
2. Create a manifest file to define and configure the property editor using either JSON or TypeScript.

{% tabs %}
{% tab title="JSON Manifest" %}
Create a manifest file named `umbraco-package.json` at the root of the `suggestions` folder, and add the following code:

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
{% endtab %}
{% tab title="TypeScript Manifest" %}

Extension authors define the property editor UI manifest, then register it dynamically during runtime using a [Backoffice Entry Point](../../customizing/extending-overview/extension-types/backoffice-entry-point.md) extension.

Create a manifest file named `manifests.ts` and add the following code:

{% code title="manifests.ts" %}
```typescript
import type { ManifestPropertyEditorUi } from '@umbraco-cms/backoffice/property-editor';

export const propertyEditorUiManifest: ManifestPropertyEditorUi[] = [
    {
        type: 'propertyEditorUi',
        alias: 'My.PropertyEditorUi.Suggestions',
        name: 'My Suggestions Property Editor UI',
        element: () => import('./suggestions-property-editor-ui.element.js'),
        elementName: 'my-suggestions-property-editor-ui',
        meta: {
            label: 'Suggestions',
            icon: 'icon-list',
            group: 'common',
            propertyEditorSchemaAlias: 'Umbraco.Plain.String'
        }
    }
];
```
{% endcode %}
{% endtab %}
{% endtabs %}

{% hint style="info" %}
The `umbraco-package.json` files are cached by the server. When creating new `umbraco-package.json` files, it might take a few seconds before those are loaded into the server cache.
{% endhint %}

{% hint style="info" %}
It is important to select the right `propertyEditorSchemaAlias` as it affects how the Property Editor data is made available when rendering the website.

In this example, `Umbraco.Plain.String` is selected because a string value is expected. For more options, see the [default Property Editor Schema aliases](default-property-editor-schema-aliases.md) article.
{% endhint %}

## Creating a Web Component

Create the web component for the property editor.

1. Create a file in the `src` folder with the name `suggestions-property-editor-ui.element.ts`
2. In this new file, add the following code:

{% code title="suggestions-property-editor-ui.element.ts" lineNumbers="true" %}
```typescript
import { LitElement, html, customElement, property } from '@umbraco-cms/backoffice/external/lit';
import type { UmbPropertyEditorUiElement } from '@umbraco-cms/backoffice/property-editor';

@customElement('my-suggestions-property-editor-ui')
export default class MySuggestionsPropertyEditorUIElement extends LitElement implements UmbPropertyEditorUiElement {
    @property({ type: String })
    public value = '';

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

3.  In the `vite.config.ts` file, replace the following:

  - `entry` to the newly created `.ts` file.
  - `outDir: 'dist'` so the output lands in `App_Plugins/suggestions/dist/`.

{% code title="vite.config.ts" lineNumbers="true" %}

```typescript
  import { defineConfig } from "vite";
  
  export default defineConfig({
      build: {
          lib: {
        entry: "src/suggestions-property-editor-ui.element.ts", // your web component source file
        formats: ["es"],
        fileName: "suggestions",
          },
          outDir: "dist", // all compiled files will be placed here
          emptyOutDir: true,
          sourcemap: true,
          rollupOptions: {
        external: [/^@umbraco-cms\/.*/], // ignore the Umbraco Backoffice package in the build
          },
      },
      base: "/App_Plugins/client/", // the base path of the app in the browser (used for assets)
  });
```

{% endcode %}

The basic parts of the editor are now in place:

* The package manifest, telling Umbraco what to load
* The web component for the editor

4. Run the build. In your terminal, go to the `suggestions` folder and run:

```cs
npm run build
```

5. Reload the backoffice.

## Registering the Data Type in Umbraco

1. Add the newly added property editor "Suggestions" in the Document Type and save it.

![Suggestions Property Editor](../../.gitbook/assets/suggestions-property-editor.png)

The property can now be edited using the new Property Editor.

2. Check out the content where you will see the property editor that looks like this:

<figure><img src="../../.gitbook/assets/NewPropertyEditor.png" alt="The Suggestions property editor displayed in the Umbraco content editor."><figcaption><p>The Suggestions property editor in the content editor.</p></figcaption></figure>

## Adding styling and setting up events in the Web Components

Start by creating an input field and some buttons to style and hook up to events.

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
The Umbraco UI library is already a part of the backoffice, which means it can be used immediately.
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

<details>

<summary>See the entire `suggestions-property-editor-ui.element.ts` file</summary>

{% code title="suggestions-property-editor-ui.element.ts" lineNumbers="true" %}
```typescript
import { LitElement, html, css, customElement, property } from '@umbraco-cms/backoffice/external/lit';
import type { UmbPropertyEditorUiElement } from '@umbraco-cms/backoffice/property-editor';
import { UmbTextStyles } from '@umbraco-cms/backoffice/style';

@customElement('my-suggestions-property-editor-ui')
export default class MySuggestionsPropertyEditorUIElement extends LitElement implements UmbPropertyEditorUiElement {
    @property({ type: String })
    public value = '';

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

4. Run the build. In your terminal, go to the `suggestions` folder and run:

```cs
npm run build
```

5. Reload the backoffice.

It should now look something like this:

<figure><img src="../../.gitbook/assets/NewPropertyEditorButtons.png" alt="The Suggestions property editor with an input field and two buttons."><figcaption><p>The property editor after adding the input field and buttons.</p></figcaption></figure>

Next, set up the event logic.

## Setup Event Logic

### Setup Input Field

Start with the input field. When typing something in the input field, the property editor's value should change to the input field's current value.

Dispatch a `change` event using one of two approaches:

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

Look at the suggestions button next.

### Setup Suggestions Button

* When pressing the suggestion button, the text should update to the suggestion received. Similar to how the value of the property editor changes when writing in the input field.
* The value should also change when pressing the suggestion button.

1. Update the import for Lit:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { LitElement, html, css, customElement, property, state } from '@umbraco-cms/backoffice/external/lit';
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

3. Update the suggestion button in the render method to call a `onSuggestion` method when pressing the button:

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

{% code title="suggestions-property-editor-ui.element.ts" overflow="wrap" lineNumbers="true" %}
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

4. Run the build. In your terminal, go to the `suggestions` folder and run:

```cs
npm run build
```

5. Clear your cache and reload the backoffice.
6. Click on the **Give me suggestions** button to see the Suggestions Data Type in action.

<figure><img src="../../.gitbook/assets/NewPropertyEditorSuggestions.png" alt="The Suggestions property editor displaying a randomly selected suggestion value."><figcaption><p>The completed Suggestions property editor with event logic in place.</p></figcaption></figure>

When saving or publishing, the value of the Data Type is automatically synced to the current content object and sent to the server.

To learn more, visit the [Property Editors](../../customizing/property-editors/composition/) page.

## Going further

The Suggestions Data Type is now set up and running. The next part covers adding configurations to the property editor.
