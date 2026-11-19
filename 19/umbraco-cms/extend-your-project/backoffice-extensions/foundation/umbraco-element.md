---
description: Ease the integration with Backoffice by using a Umbraco Element
---

# Umbraco Element

This provides a few methods to ease the connection with Backoffice, giving you the ability to:

* Consume a Context — [Learn more about Consuming Contexts](context-api/consume-a-context.md)
* Provide Context — [Learn more about Providing Contexts](context-api/provide-a-context.md)
* Observe a State — [Learn more about States](states.md#observe)
* Use localization — [Learn more about Localization](../../server-side-extensions/language-files/)
* Host Controllers — [Learn more about Controllers](umbraco-controller/)

## Create an Umbraco Element

You can turn any Web Component into an Umbraco Element by using the Umbraco Element Mixin, as done in the following example:

{% code title="my-element.ts" %}
```typescript
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api'
import { customElement } from '@umbraco-cms/backoffice/external/lit'

@customElement('my-extension-element')
class MyExtensionElement extends UmbElementMixin(HTMLElement) {
    ...
}
```
{% endcode %}

This means you can use any base class, whether it’s a Web Component or a base class from your framework of choice. As long as it’s compatible with Web Components, it can be enhanced to become an Umbraco Element:

{% code title="my-element.ts" %}
```typescript
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api'
import { customElement } from '@umbraco-cms/backoffice/external/lit'
import { UUIButtonElement } from '@umbraco-cms/backoffice/external/uui'

@customElement('my-extension-element')
class MyExtensionElement extends UmbElementMixin(UUIButtonElement) {
    ...
}
```
{% endcode %}

The Backoffice is generally built with Lit. To simplify things for those who prefer using the Lit version provided by the Backoffice, you can create your Web Components as Umbraco Elements like this:

{% code title="my-element.ts" %}
```typescript
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element'
import { customElement } from '@umbraco-cms/backoffice/external/lit'

@customElement('my-extension-element')
export class MyExtensionElement extends UmbLitElement {
    ...
}
```
{% endcode %}

Notice that it is identical to this:

{% code title="my-element.ts" %}
```typescript
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api'
import { customElement, LitElement } from '@umbraco-cms/backoffice/external/lit'

@customElement('my-extension-element')
class MyExtensionElement extends UmbElementMixin(LitElement) {
    ...
}
```
{% endcode %}

Learn more about how to write Web Components with Lit in the [Lit Element article](lit-element.md).
