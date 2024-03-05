---
description: Ease the integration with Backoffice by using a Umbraco Element
---

# Umbraco Element

{% hint style="warning" %}
This page is a work in progress.
{% endhint %}

This provides a few methods to connect with the Backoffice, giving you the ability to:

* Consume a Context — [Learn more about Consuming Contexts](../context-api/)
* Provide Context — [Learn more about Providing Contexts](../context-api/README.md#provide-a-context-api)
* Observe a State — [Learn more about States](../states.md#observe-a-state-via-umbraco-element-or-umbraco-controller)
* Localization — [Learn more about Localization](../localization/)
* Host Controllers — [Learn more about Controllers](controllers/)

## Create an Umbraco Element

You can turn any Web Component into an Umbraco Element by using the Umbraco Element Mixin, as done in the following example:

```ts
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api'

class MyExtensionElement extends UmbElementMixin(HTMLElement) {

}
```
