---
description: >-
  Learn how to bind and use the validation system when working with Form
  Controls and Umbraco CMS backoffice.
---

# Integrate Validation

The Validation System provides abilities to validate different Form Controls. Such can be native or custom, like a Property Editor.

It also allows for binding server validation to the Form Controls making the validation experience as synergetic as possible.

## Validation Context

Validation Context, the hub of the Validation, is the core of this system. Everything that holds opinions about the Validation, is a Validator and is connected to the Validation Context.

You can ask the Validation Context to validate. This will evaluate all validators, and once all validator instances have been validated successfully, the Validation Context will be valid.

## Validators

We provide a few built-in Validators that handle most cases.

### Form Control Validator

This Validator binds a Form Control Element with the Validation Context. When the Form Control becomes Invalid, its Validation Message is appended to the Validation Context.

Notice this one also comes as a Lit Directive called `umbBindToValidation`. This enables you to integrate an element with one line of code within a Lit Render method. See the following example for a demonstration:

```typescript

#validation = new UmbValidationContext(this);

#validate = () => {
    this.#validation.validate().then(() => {
        console.log('Valid');
    }, () => {
        console.log('Invalid');
    });
}

render() {
    return html`
        <uui-form-validation-message>
            <uui-input
                ...
                required
                ${umbBindToValidation(this)}
            ></uui-input>
        </uui-form-validation-message>
        <uui-button @click=${this.#validate}>Validate</uui-button>
    `;
}
```

## Integrate Umb-Property Elements

The `umb-property` element automatically binds to its nearest validation context.

This is demonstrated in the example below:

```typescript

#validation = new UmbValidationContext(this);

#validate = () => {
    this.#validation.validate().then(() => {
        console.log('Valid');
    }, () => {
        console.log('Invalid');
    });
}

render() {
    return html`
        <umb-property
			alias="myProperty"
			property-editor-ui-alias="Umb.PropertyEditorUi.TextBox"
			...
        >
		</umb-property>
        <uui-button @click=${this.#validate}>Validate</uui-button>
    `;
}
```

## Server Validation and more

This documentation is not available at the moment. For the moment you can find more information in the [Backoffice repository](https://github.com/umbraco/Umbraco.CMS.Backoffice/tree/main/src/packages/core/validation).
