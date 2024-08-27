# Integrate Validation

The Validation System provides the abilities to validate various Form Controls. Such can be native or custom, like a Property Editor.
It also allows for binding server validation to the Form Controls. Making the validation experience as synergetic as possible.

## Validation Context

The core of the system is a Validation Context, which is the hub of the Validation.
Everything that hold opinions about the Validation, we call a Validator, such is connected to the Validation Context.

You can ask the Validation Context to Validate, this will evaluate all Validators and once all Validator instances have been validated successfully the Validation Context will be valid.

## Validators

We provide a few built in Validators which handles most cases. Here is listed a few:

### Form Control Validator

This Validator binds a Form Control Element with the Validation Context. When the Form Control becomes Invalid, its Validation Message is appended to the Validation Context.

Notice this one also comes as a Lit Directive called `umbBindToValidation`, this enables you to integrate a element with one line of code within a Lit Render method. This is demonstrated in the following example:

{% code %}
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
{% endcode %}

## Integrate Umb-Property Elements

The `umb-property` element automatically binds to its nearest validation context.
This is demonstrated in the example below:

{% code %}
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
{% endcode %}



## Server Validatiion and more

This documentation is not available at the moment. But for the moment you can find more information in the Backoffice repo at `src/packages/core/validation/README.md`
