---
description: Enable sorting elements via drag and drop
---

# Sorting

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The Umbraco Sorter enables you to make a list of elements sortable via drag-and-drop interaction. You have to set up the sorter once on the Element that renders the items to be sorted. As part of the configuration, you shall provide an `onChange` callback method, which will be executed every time the sorter makes a difference to the data.

### Configuration

The following example shows a basic setup of the Sorter.

```typescript

type ModelEntryType = {
    id: string;
    name: string;
}

this.#sorter = new UmbSorterController(this, {
    itemSelector: '.sorter-item',
    containerSelector: '.sorter-container',
    getUniqueOfElement: (element) => {
        return element.getAttribute('data-sorter-id');
    },
    getUniqueOfModel: (modelEntry) => {
        return modelEntry.id;
    },
    onChange: ({ model }) => {
        const oldValue = this._items;
        this._items = model;
        this.requestUpdate('_items', oldValue);
    },
});
```

The properties provided are the following:

* `itemSelector`: A query selector that matches the items that should be draggable.
* `containerSelector`: A query elector that matches the parent element of the items.
* `getUniqueOfElement`: A method that returns the unique element
* `getUniqueOfModel`: Provide a method that returns the unique of a given model entry
* `onChange`: Provide a method to retrieve the changed model. This is called every time the model is changed, including when the user is dragging around.

### Data Model

The model given to the Sorter must be an Array. The following example extends the example from above:

```typescript

    const model: Array = [
        {
            id: 1,
            name: 'First item'
        },
        {
            id: 2,
            name: 'second item'
        }
        {
            id: 3,
            name: 'Third item'
        }
    ]

    // Set the Model, if you have changes to the model not coming from the Sorter. Then set the model again:
    this.#sorter.setModel(model);
```

### Rendering

The Sorter does not move elements, instead, it updates the model as the user drags an item around. This puts higher pressure on the rendering of the sortable Elements. This means we need to make sure that the rendering re-uses the same element despite sorting the data differently.

Lit does provide a render helper method called `repeat` that does this for us. The following example shows a render method that continues the work of the examples above:

```typescript


    render() {
		return html`
			
				${repeat(
					this._items,
					(item) => item.id,
					(item) =>
						html`${item.name}
						`,
				)}
			
		`;
	}
```
