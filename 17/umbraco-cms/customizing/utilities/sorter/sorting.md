---
description: Enable sorting elements via drag and drop
---

# Sorting

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The Umbraco Sorter enables you to make a list of elements sortable via drag-and-drop interaction. You must set up the sorter once on the element that renders the items to be sorted. As part of the configuration, you provide an `onChange` callback method that is executed every time the sorter changes the data.

## Configuration

The following example shows a basic setup of the Sorter:

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

The configuration properties are:

* `itemSelector`: A query selector that matches the items that can be dragged.
* `containerSelector`: A query selector that matches the parent element of the items.
* `getUniqueOfElement`: A method that returns the unique identifier of an element.
* `getUniqueOfModel`: A method that returns the unique identifier of a model entry.
* `onChange`: A method to retrieve the changed model. This is called every time the model changes, including when the user is dragging items.

## Data Model

The model provided to the Sorter must be an Array. The following example extends the previous example:

```typescript
const model: Array<ModelEntryType> = [
    {
        id: '1',
        name: 'First item'
    },
    {
        id: '2',
        name: 'Second item'
    },
    {
        id: '3',
        name: 'Third item'
    }
]

// Set the Model. If you have changes to the model not coming from the Sorter, set the model again:
this.#sorter.setModel(model);
```

## Rendering

The Sorter does not move elements. Instead, it updates the model as the user drags an item. This places higher demands on the rendering of the sortable elements. You must ensure that the rendering reuses the same element despite sorting the data differently.

Lit provides a render helper method called `repeat` that handles this. The following example shows a render method that continues the previous examples:

```typescript
render() {
    return html`
        <div class="sorter-container">
            ${repeat(
                this._items,
                (item) => item.id,
                (item) =>
                    html`<div class="sorter-item" data-sorter-id="${item.id}">
                        ${item.name}
                    </div>`,
            )}
        </div>
    `;
}
```
