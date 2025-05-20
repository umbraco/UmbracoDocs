---
description: Ease the integration with Backoffice by using a Umbraco Element
---

# Umbraco Element

This provides a few methods to ease the connection with Backoffice, giving you the ability to:

* Consume a Context — [Learn more about Consuming Contexts](../context-api/consume-a-context.md)
* Provide Context — [Learn more about Providing Contexts](../context-api/provide-a-context.md)
* Observe a State — [Learn more about States](../working-with-data/states.md#observe-a-state-via-umbraco-element-or-umbraco-controller)
* Use localization — [Learn more about Localization](../../../extending/language-files/)
* Host Controllers — [Learn more about Controllers](../umbraco-controller/)

## Create an Umbraco Element

You can turn any Web Component into an Umbraco Element by using the Umbraco Element Mixin, as done in the following example:

```ts
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api'

@customElement('my-extension-element')
class MyExtensionElement extends UmbElementMixin(HTMLElement) {
    ...
}
```

This means you can use any base class, whether it’s a Web Component or a base class from your framework of choice. As long as it’s compatible with Web Components, it can be enhanced to become an Umbraco Element:

<pre class="language-typescript"><code class="lang-typescript"><strong>import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api'
</strong>import { UUIButtonElement } from '@umbraco-cms/backoffice/external/uui'

@customElement('my-extension-element')
class MyExtensionElement extends UmbElementMixin(UUIButtonElement) {
    ...
}
</code></pre>

The Backoffice is generally built with Lit. To simplify things for those who prefer using the Lit version provided by the Backoffice, you can create your Web Components as Umbraco Elements like this:

<pre class="language-typescript"><code class="lang-typescript">import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element'
<strong>
</strong><strong>@customElement('my-extension-element')
</strong>export class MyExtensionElement extends UmbLitElement {
    ...
}
</code></pre>

Notice that it is identical to this:

<pre class="language-typescript"><code class="lang-typescript"><strong>import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api'
</strong>import { LitElement } from '@umbraco-cms/backoffice/external/lit'

@customElement('my-extension-element')
class MyExtensionElement extends UmbElementMixin(LitElement) {
    ...
}
</code></pre>

Learn more about how to write Web Components with Lit in the [Lit Element article](../lit-element.md).
