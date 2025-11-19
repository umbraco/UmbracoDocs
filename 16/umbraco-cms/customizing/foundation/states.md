---
description: >-
  Enable reactivity with Umbraco States, allowing you to provide a value that
  others can observe and update when the value changes.
---

# States

{% hint style="info" %}
Umbraco States are not related to Web Components reactivity. For more information, see the [Lit Element](lit-element.md) article.
{% endhint %}

An Umbraco State is a container for a value. You create [Observables](states.md#observe), which are hooks into the State's value. An Observable can then be observed to access the current value. If the State changes, all Observables are updated accordingly.

A typical use case is to bring reactivity across class instances. For example, a Context may provide a value that an Element needs to utilize.

In this case, the Context would implement a State and an Observable of it. The Element would then observe the Observable of the Context.

You can see an example of this pattern in the [Extension Type Workspace Context](../extending-overview/extension-types/workspaces/workspace-context.md) article.

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

Umbraco provides built-in state types for common data structures:

* Array State
* Boolean State
* Class State
* Number State
* Object State
* String State

Use the one fitting for your value type.

## Observation

Observations are the act of reading the value of a State and reacting to future changes in the value.

### Observe

The Umbraco Element or Controllers provides the ability to observe an Observable. This example shows how you can observe the value of a State with these.

The example below creates a State and exposes the entire value via an Observable, which can then be observed.

<pre class="language-typescript"><code class="lang-typescript">import { UmbArrayState } from '@umbraco-cms/backoffice/observable-api';

<strong>...
</strong>
<strong>this.#selectionState = UmbArrayState&#x3C;string>(['item1', 'item2']);
</strong>this.selection = this.#selectionState.asObservable();

<strong>this.observe(
</strong>	this.selection,
    (selection) => {
        // This call will be executed initially and on each state change.
        console.log(selection)
    }
);
</code></pre>

This will result in the following log:

<pre><code><strong>> ['item1', 'item2']
</strong></code></pre>

### Change the value of a State

The value of a state can be changed via the `setValue` method. This replaces the current data with new data and notifies the relevant observers.

The following example shows how to change the value of the state to hold `item2` and `item3`. As this builds on the previous example, it means that `item1` is no longer part of the value of this state:

<pre class="language-typescript"><code class="lang-typescript">import { UmbArrayState } from '@umbraco-cms/backoffice/observable-api';

<strong>...
</strong>
this.#selectionState.setValue(['item2', 'item3']);

</code></pre>

This will result in the following log, in addition to the one above:

<pre><code><strong>> ['item2', 'item3']
</strong></code></pre>

### Observe part of a State value

The `asObservablePart` method creates an Observable that provides a scoped or transformed outcome based on the State.

The following example provides an observable for the first selected item in the selection:&#x20;

```typescript

this.firstSelected = this.#selectionState.asObservablePart(data => data?.[0]);

this.observe(
    this.firstSelected, (firstSelected) => {
        // This call will be executed initially and on each change of the specific value that this observer provides.
        // This means that this will only be executed when the first selected item changes.
         console.log("The first selected item is now ", firstSelected)
    }
);
```

In the above example, the `asObservablePart` mapping function will be executed whenever the State changes. If the method's result differs from before, it will trigger an update to its observers.

The following example computes the length&#x20;

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

As in the previous example, the mapper will be triggered whenever the State values change. But observers of this Observable will only be notified if the outcome value differs.

### Summary example

The example below revisits the earlier scenario to see how an Observable Part is triggered in relation to the value of the state.

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
myState.setValue('six');// note that it contains only three letters
```

This example will result in the following logs:

<pre><code><strong>> value: 'four'
</strong>> length: 4
> value: 'five'
> value: 'six'
> length: 3
</code></pre>

The `length` observation was triggered when the length actually differed.
