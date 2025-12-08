---
description: Presenting the Editing Experience of a Property Editor
---

# Property Editor UI
The Property Editor UI is the client-side component that renders the editing interface in the Umbraco backoffice. It provides the visual interface for content editors to interact with their data. While the Property Editor Schema validates and stores data on the server, the Property Editor UI focuses on providing an intuitive editing experience in the browser.


## Creating a Property Editor UI
A Property Editor UI is a purely frontend extension in the shape of a web component. In this example, we will create a Property Editor UI using an Umbraco Lit element step by step. At the end, the full example is provided. To create a Property Editor UI, the following needs to be done:

* Implement the Umbraco Lit component - the actual visible part
* Register the Property Editor UI using a manifest

### Implement the interface
What makes a standard Umbraco Lit component a Property Editor UI is the implementation of the `UmbPropertyEditorUiElement` interface. The `UmbPropertyEditorUiElement` interface ensures that your element has the necessary properties and methods to be used as a Property Editor UI element. See the [UI API documentation](https://apidocs.umbraco.com/v17/ui-api/interfaces/packages_core_property-editor.UmbPropertyEditorUiElement.html) for the full interface definition.

```typescript
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import type { UmbPropertyEditorUiElement } from '@umbraco-cms/backoffice/property-editor';

// Implement the UmbPropertyEditorUiElement
export default class UmbPropertyEditorUITextBoxElement extends UmbLitElement implements UmbPropertyEditorUiElement {
	...
}
```

This interface gives access to important information about the data and configuration through a number of properties. None of them are technically required to implement, but in practice you need `value` and probably also `config`.

* `value`: Contains the actual value that will be processed and stored when the content is saved and retrieved. The value is automatically populated when the component loads. When saved, the value is sent to be processed and saved to the database.
* `config`: The configuration as set on the Data Type.
* `readonly`: If you support read-only mode, this will indicate whether the component should be read-only.

{% hint style="info" %}
For the full interface properties of the `UmbPropertyEditorUiElement`, see the [UI API documentation](https://apidocs.umbraco.com/v17/ui-api/interfaces/packages_core_property-editor.UmbPropertyEditorUiElement.html) for more information.
{% endhint %}

A minimal implementation where the value is read and placed in a textbox looks like this:

```typescript
export default class UmbPropertyEditorUITextBoxElement extends UmbLitElement implements UmbPropertyEditorUiElement {
	/* Represents the value of the content */
	@property()
	value?: string;

	/* this.value will automatically get set and display in the textbox */
	override render() {
		return html`<uui-input .value=${this.value ?? ''} type="text"></uui-input>`;
	}
}
```

### Handle value changes
In the previous example, the value is read and placed in a text box. However, it will not react to changes in the value. When the value needs to be changed, it is required to dispatch an `UmbChangeEvent`. 

```typescript
export default class UmbPropertyEditorUITextBoxElement extends UmbLitElement implements UmbPropertyEditorUiElement {
	/* Represents the value of the content */
	@property()
	value?: string;

	/* Fires when the text of the text box changes */
	#onInput(e: InputEvent) {
		// Get the value from the text box and set it to the value property
		this.value = (e.target as HTMLInputElement).value;
		
		// Dispatch event that the value has changed
		this.dispatchEvent(new UmbChangeEvent());
	}

	/* this.value will automatically get set and display in the text box */
	override render() {
		return html`<uui-input .value=${this.value ?? ''} type="text" @input=${this.#onInput}></uui-input>`;
	}
}
```

### Handle configuration
As discussed before, both the Property Editor UI and the Property Editor Schema can have settings that are set when creating a Data Type. You can access these settings like this:

```typescript
export default class UmbPropertyEditorUITextBoxElement extends UmbLitElement implements UmbPropertyEditorUiElement {
    @property()
    value?: string;

	/* Property to store the 'maxLength' setting in */
    @state()
    private maxLength?: number;

    /* 
     * When the config property is set (which happens automatically):
     * Get the configuration value of the configuration with the alias 'maxLength'
     * Store it in a property to make it easier to work with
     */
    @property({ attribute: false })
    public set config(config: UmbPropertyEditorConfigCollection | undefined) {
        if (!config) return;
        this.maxLength = config.getValueByAlias("maxLength") ?? undefined;
    }

   /* 
	* When this.maxLength has a value, the max length is set on the text box
	* This prevents the user from entering more characters
	*/
    override render() {
        return html`<uui-input 
                        type="text"
                        .value=${this.value ?? ''}
                        maxlength=${ifDefined(this.maxLength)}></uui-input>`;
    }
}
```
{% hint style="warning" %}
Setting the `maxlength` attribute is only used for client-side validation and to help editors adhere to data validation rules. This does not automatically trigger server-side validation on save. If you need server-side validation, the Property Editor Schema needs to explicitly implement this.
{% endhint %}

### Handle mandatory and validation
When an editor is creating a Document Type in the backoffice and adds properties, properties can be marked as mandatory. There is also an option to add a custom validation message for that property.

When a property is marked as mandatory, it will automatically perform validation when the content node with that property is saved. This validates whether the `value` property has a value or not. If not, the custom validation message is displayed.

This validation is automatically handled by Umbraco. However, if it makes sense in the context of your Property Editor UI, you can access both the mandatory flag and the custom error message.

```typescript
export default class UmbPropertyEditorUITextBoxElement extends UmbLitElement implements UmbPropertyEditorUiElement {
    @property()
    value?: string;

    /*
     * Automatically set by Umbraco when the property is marked as mandatory.
     * Makes the field required for validation.
     */
    @property({ type: Boolean })
    mandatory?: boolean;

    /**
     * Custom validation message when mandatory field is empty.
     * Set in the Document Type property settings in the backoffice
     * and is automatically populated.
     */
    @property({ type: String })
    mandatoryMessage = UMB_VALIDATION_EMPTY_LOCALIZATION_KEY;

    override render() {
        return html`<uui-input 
                        type="text"
                        .value=${this.value ?? ''}
                        ?required=${this.mandatory}
                        .requiredMessage=${this.mandatoryMessage}></uui-input>`;
    }
}
```
This validation is only performed on the value of the property editor as a whole. When you have complex Property Editor UIs with multiple inputs and advanced validation, you need more advanced validation techniques. See the [UI Library Form Validation documentation](../../ui-library.md#form-validation) on how to implement advanced validation.

### Handle readonly
The `readonly` property indicates whether the Property Editor should be in read-only mode. This happens automatically based on:

- User permissions - The current user does not have update permissions for this content
- Content locks - Another user is currently editing the content
- Workflow states - Content is in a state that prevents editing (for example, awaiting approval)
- Variant restrictions - Editing a culture/segment variant without proper permissions

By default, Umbraco places an overlay on the Property Editor if it needs to be read-only. In most cases, this is sufficient. However, you can also handle read-only mode in the Property Editor more gracefully.

If you want to properly support read-only mode, the manifest should set the `supportsReadOnly` property to `true` and you need to handle read-only yourself. This means you need to ensure the editor cannot change any content in read-only mode.

 ```typescript
export default class UmbPropertyEditorUITextBoxElement extends UmbLitElement implements UmbPropertyEditorUiElement {
    @property()
    value?: string;

	/*
     * Indicates if the Property Editor is in read-only mode
     */
    @property({ type: Boolean })
    readonly?: boolean;

    override render() {
        return html`<uui-input 
                        type="text"
                        .value=${this.value ?? ''}
						?readonly=${this.readonly}></uui-input>`;
    }
}
```

### Full example
This is a full example based on all the previous examples. This example Property Editor UI:
* Reads and updates the value
* Handles configuration
* Handles mandatory and the mandatory message
* Handles read-only mode

```typescript
import { html, customElement, property, state, ifDefined } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { UmbChangeEvent } from '@umbraco-cms/backoffice/event';
import { UMB_VALIDATION_EMPTY_LOCALIZATION_KEY } from '@umbraco-cms/backoffice/validation';
import type { 
    UmbPropertyEditorUiElement, 
    UmbPropertyEditorConfigCollection 
} from '@umbraco-cms/backoffice/property-editor';

/**
 * Property Editor UI for a text box with configurable max length
 */
@customElement('umb-property-editor-ui-text-box')
export default class UmbPropertyEditorUITextBoxElement 
    extends UmbLitElement 
    implements UmbPropertyEditorUiElement {
    
    /**
     * The current value of the property.
     * Automatically set by Umbraco and updated when the user types.
     */
    @property()
    value?: string;

    /**
     * Indicates if the property is required/mandatory.
     * Automatically set by Umbraco based on Document Type property settings.
     */
    @property({ type: Boolean })
    mandatory?: boolean;

    /**
     * Custom validation message when mandatory field is empty.
     * Set in the Document Type property settings in the backoffice.
     * Defaults to a localized "This field is required" message.
     */
    @property({ type: String })
    mandatoryMessage = UMB_VALIDATION_EMPTY_LOCALIZATION_KEY;

    /**
     * Indicates if the Property Editor is in read-only mode.
     * Set automatically by Umbraco based on user permissions, content locks, etc.
     * When true, the value can be read and selected but not modified.
     */
    @property({ type: Boolean })
    readonly?: boolean;

    /**
     * Maximum allowed characters for the text input.
     * Configured via the Data Type settings.
     */
    @state()
    private maxLength?: number;

    /**
     * Configuration from the Data Type.
     * Automatically set by Umbraco when the Property Editor is initialized.
     * Extracts settings like maxLength for use in the UI.
     */
    @property({ attribute: false })
    public set config(config: UmbPropertyEditorConfigCollection | undefined) {
        if (!config) return;
        this.maxLength = config.getValueByAlias<number>("maxLength") ?? undefined;
    }

    /**
     * Handles input events from the text box.
     * Updates the value and notifies Umbraco of the change.
     */
    #onInput(e: InputEvent) {
        const newValue = (e.target as HTMLInputElement).value;
        if (newValue === this.value) return;
        
        // Update the value
        this.value = newValue;
        
        // Notify Umbraco that the value has changed
        this.dispatchEvent(new UmbChangeEvent());
    }

    /**
     * Renders the text input with all configured properties
     */
    override render() {
        return html`<uui-input 
                        type="text"
                        .value=${this.value ?? ''}
                        maxlength=${ifDefined(this.maxLength)}
                        ?required=${this.mandatory}
                        .requiredMessage=${this.mandatoryMessage}
                        ?readonly=${this.readonly}
                        @input=${this.#onInput}></uui-input>`;
    }
}

declare global {
    interface HTMLElementTagNameMap {
        'umb-property-editor-ui-text-box': UmbPropertyEditorUITextBoxElement;
    }
}
```
## Register the Property Editor UI
To make your Property Editor UI available in Umbraco, you need to register it using a manifest. The manifest defines the alias, element location, and metadata like the label, icon, and which schema it works with.

For details on the manifest structure and all available options, see the [Property Editor UI Extension Type](../../extending-overview/extension-types/property-editor-ui.md) documentation.

### Basic example
{% code title="umbraco-package.json" %}
```json
{
  "type": "propertyEditorUi",
  "alias": "My.PropertyEditorUI.TextBox",
  "name": "My Text Box Property Editor UI",
  "element": "/App_Plugins/my-text-box/dist/my-text-box.js",
  "meta": {
    "label": "My Text Box",
    "propertyEditorSchemaAlias": "Umbraco.TextBox",
    "icon": "icon-autofill",
    "group": "common"
  }
}
```
{% endcode %}