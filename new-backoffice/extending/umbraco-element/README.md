---
description: Ease the integration with Backoffice by using a Umbraco Element
---

# Umbraco Element

{% hint style="warning" %}
This page is a work in progress.&#x20;
{% endhint %}

This provides a few methods to connect with the Backoffice, giving you the ability to:

* Consume a Contex — [Learn more about Consuming Contexts](../context-api/)
* Provide Context — TBD
* Observe a State — [Learn more on States](../states.md#observe-a-state-via-umbraco-element-or-umbraco-controller)
* Localization — [Learn about Localization](../localization/use-localizations.md#localize-controller)
* Host Controllers — [ Learn more on Controllers here](controllers/)

## Create an Umbraco Element

You can turn any Web Component into an Umbraco Element by using the Umbraco Element Mixin, as done in the following example:

<pre class="language-csharp"><code class="lang-csharp"><strong>import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api'
</strong><strong>
</strong><strong>class MyExtensionElement extends UmbElementMixin(HTMLElement) {
</strong><strong>
</strong><strong>}
</strong></code></pre>
