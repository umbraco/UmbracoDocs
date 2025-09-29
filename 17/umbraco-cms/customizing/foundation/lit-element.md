---
description: >-
  Backoffice supports any native Web Components. But we choose to use a little
  framework to make it simpler.
---

# Lit Element

Since a small framework is chosen to build the Web Components, it is recommended to consider doing the same. There are no strict requirements for how to build your components. However, most of the code and documentation examples are based on Lit. That said, many users successfully use other frameworks as well.

To help you get started, here’s an overview of some relevant Lit features.

## Render HTML

To decide the content of your Element, you define a \`render\` method. It could look like this:

```typescript
render() {
	return html`The Rabbit went down a <b>bold</b> hole`;
}
```

## Bring Styles

Declare a static styles property with the CSS Declarations you want for your Component.&#x20;

{% hint style="info" %}
The Element uses Shadow DOM, meaning the styles apply only to the content of your Element. Nothing more, not even other Web Components integrated inside your Component
{% endhint %}

```typescript
static styles = [
	css`
		b {
			border-bottom: 2px solid var(--uui-color-divider);
		}
	`,
];
```

## Reactive Properties

Once your Element has some Data to represent, you most likely want to re-render the contents of your element when the data changes.

To enable this, you can decorate the Properties that should be reactive with either \`@property\` or \`@state\`; the difference between these two is whether it's a Public property (@property) or a protected property (@state).

```typescript
@customElement('name-of-example-component')
export class NameOfExampleComponent extends UmbLitElement {
	
	@property({ type: String })
	public name?: string
			
	render() {
		return html`The Rabbit has a name ${this.name}`;
	}
}
```

The Web Component above can then be used like this:

```html
<name-of-example-component name="CG Roumersen"></name-of-example-component>
```

## Parse value as JS properties

You might want to parse data directly to an element within the render method. The following example shows how to parse a complex object into another Web Component without it being parsed via the DOM. This can be done by setting it directly as a JavaScript property:

```typescript
#myComplexValue = { myString: "hey", myNumber: 123 }

override render() {
	return html`
		<another-element .myValue=${this.#myComplexValue}></uui-button>
	`;
}
```

Notice the `.` in front of the property name (`myValue`)

## Listen to DOM Events

You may like to listen to an event on one of the elements created via the render method. Luckily Lit enables you to do this. The following example shows how to assign an event listener to the 'click' event.

```typescript
	#onClick() {
		console.log("I got clicked")
	}

	override render() {
		return html`
			<uui-button @click=${this.#onClick} label="Click me"></uui-button>
		`;
	}
```

## Learn more

To explore more features, visit the [Lit documentation](https://lit.dev/).

{% hint style="warning" %}
It is recommended to use Lit for writing Web Components. It is not recommended to use Lit Controllers or the Lit Context API, as the Backoffice has its own APIs for those use cases.
{% endhint %}
