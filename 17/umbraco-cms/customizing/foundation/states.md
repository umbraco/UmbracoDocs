---
description: >-
  Make reactivity with Umbraco States, enabling you to provide a value that
  others can observe and thereby be updated when the value changes.
---

# States

{% hint style="info" %}
Umbraco States are not relevant when dealing with the reactivity of a Web Component. For more information, see the [Lit Element](lit-element.md) article.
{% endhint %}

An Umbraco State is a container for a value. You create [Observables](states.md#observables), which is the name of a hook into the State's value. An Observable can then be observed, providing the current value, and if the value of the State changes, all Observables will be updated accordingly.

A typical use case is to bring reactivity across class instances. For example, a Context may provide a value that an Element needs to utilize.

In this case, the Context would implement a State and an Observable of it. The Element would then observe the Observable of the Context.

You can see an example of this pattern in the [Extension Type Workspace Context](../extending-overview/extension-types/workspaces/workspace-context.md) article.

### Implementing a State

The example below demonstrates the basics of working with a State and observing its changes:

```
const myState = UmbStringState('the initial value');
const myObservable = myState.asObservable();

this.observe(myObservable, (value) => {
    console.log(value);
});

myState.setValue('updated value');
```

This example will result in the following logs:

<pre><code><strong>> 'the initial value'
</strong>> 'updated value'
</code></pre>

## State Types

Umbraco provides built-in State types for common data structures:

* Array State
* Boolean State
* Class State
* Number State
* Object State
* String State

Use the one fitting for your value type.

## Observe

### Observe a state via Umbraco Element or Umbraco Controller

The Umbraco Element or Controllers come with the ability to observe an Observable.

Observing all changes will result in the callback being executed.

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
        // This call will be executed initially and on each change of the specific value that this observer provides.
        // This means that this will only be executed when the length changes. Not if the value was replaced with a new value with the exact same length.
         console.log("Length of selection is now ", length)
    }
);
```

In the above example, the `asObservablePart` mapping function will be executed every time there is a change to the State. If the result of the method is different than before, it will trigger an update to its observers.

Let's return to the example at the start of this article, to see how an observablePart is triggered in relation to the value of the state.

```
const myState = UmbStringState('four');
const myObservable = myState.asObservable();
const myObservablePart = myState.asObservablePart((value) => value.length);

this.observe(myObservable, (value) => {
    console.log("value:", value);
});
this.observe(myObservablePart, (value) => {
    console.log("length: ", value);
});

myState.setValue('five');
myState.setValue('six');// notice only 3 letters
```

This example will result in the following logs:

<pre><code><strong>> value: 'four'
</strong>> length: 4
> value: 'five'
> value: 'six'
> length: 3
</code></pre>

The `length` observation only got triggered when the length actually differed.
