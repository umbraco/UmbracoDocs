---
description: >-
  A Mixin that turns your Web Component into a Form Control. Enabling you to
  append validation rules to your Element.
---

# Form Control Mixin

Whether you are building an Input or a Property Editor, you likely want to integrate some Validation rules.

### Implement Form Control Mixin

The Mixin is used in this way:

```typescript
export class UmbInputNumberRangeElement extends UmbFormControlMixin(UmbLitElement) {
```

This declares a `value` property on your Element, which should hold the value. Any changes to it will trigger an evaluation of the validation rules.

### Write validation rules

The Mixin then brings a method to simplify declaring rules. The rules hook into the Native Form Control Validation System. First, find a Validity State that resembles the validation rule you will implement.

You can find all Validation States here: [https://developer.mozilla.org/en-US/docs/Web/API/ValidityState](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState)

Once you know the string for a meaningful Validation State, then you can declare it in this way:

```typescript
this.addValidator(
	'patternMismatch',
	() => {
		return 'Enter between 10 and 20 characters';
	},
	() => {
		return this.value?.length < 10 && this.value?.length > 20;
	},
);
```

### Connect inner Form Controls

If you are building a Property Editor that consists of one or more Inputs, then you might want the validation of these to affect the validation of your Element.

The Form Control Mixin simplifies this via a method called `addFormControlElement`

On a Lit Element, it can be utilized in this way:

```typescript
protected override firstUpdated(): void {
    this.addFormControlElement(this.shadowRoot!.querySelector('uui-toggle')!);
}
```

