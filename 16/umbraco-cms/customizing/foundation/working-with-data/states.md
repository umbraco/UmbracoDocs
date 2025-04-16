---
description: Make reactivity with Umbraco States
---

# States

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

Umbraco States enables you to create [Observables](states.md#observables) based on a State. The Observables can then be observed, and when a change to the State occurs, all observers of Observables will be triggered.

## State types

Umbraco comes with a State type for the most common types of data:

* Array State
* Boolean State
* Class State
* Number State
* Object State
* String State

## Observables

### Observe a state via Umbraco Element or Umbraco Controller

The Umbraco Element or Controllers comes with the ability to observe an Observable.

While observing all changes will result in the callback being executed.

The example below creates a State and then turns the whole state into an Observable, which then can be observed.

<pre class="language-typescript"><code class="lang-typescript">import { UmbArrayState } from '@umbraco-cms/backoffice/observable-api';

<strong>...
</strong>
<strong>this.#selectionState = UmbArrayState&#x3C;string>(['item1', 'item2']);
</strong>this.selection = this.#selectionState.asObservable();

<strong>this.observe(
</strong>	this.selection,
	(selection) => {
		// This call will be executed initially and on each change of the state
	}
);
</code></pre>

### Change the value of a state

The value of a state can be changed via the `setValue` method. This replaces the current data with new data.

The following example shows how to change the value of the state to hold `item2` and `item3`. As the example extends the example from above, it means that `item1` is no longer part of the value of this state.

<pre class="language-typescript"><code class="lang-typescript">import { UmbArrayState } from '@umbraco-cms/backoffice/observable-api';

<strong>...
</strong>
this.#selectionState.setValue(['item2', 'item3']);

</code></pre>

**Observe part of a state**

With the `asObservablePart` method, you can set up an Observable that provides a transformed outcome, based on the State.

```typescript
this.selectionLength = this.#selectionState.asObservablePart(data => data.length);

this.observe(
    this.selectionLength, (length) => {
        // This call will be executed, initially and on each change of the specific value that this observer provides.
        // This means that this will only be executed when the length changed. Not if the value was replaced with a new value value with the exact same length.
        console.log("Length of selection is now ", length)
	}
);
```

In the above example, the `asObservablePart` mapping function will be executed every time there is a change to the State. If the result of the method is different than before it will trigger an update to its observers.
