---
description: Enable sorting elements via drag and drop
---

# Sorting of elements

The Umbraco Sorter enables you to make a list of elements sortable via drag-and-drop interaction.
You have to set up the sorter once on the Element that renders the items to be sorted.
As part of the configuration, you shall provide an `onChange` callback method, which will be executed every time the sorter makes a difference to the data.

### Configuration

The following example shows a basic setup of the Sorter.

<pre class="language-typescript"><code class="lang-typescript">
type ModelEntryType = {
    id: string;
    name: string;
}

this.#sorter = new UmbSorterController<ModelEntryType, HTMLElement>(this, {
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
</code></pre>

The properties provided are the following:

-   `itemSelector`: A query selector that matches the items that should be draggable.
-   `containerSelector`: A query elector that matches the parent element of the items.
-   `getUniqueOfElement`: A method that returns the unique element
-   getUniqueOfModel: Provide a method that returns the unique of a given model entry
-   onChange: Provide a method to retrieve the changed model. This is called every time the model is changed, including when the user is dragging around.

### Data Model

The model given to the Sorter must be an Array, the following example extends the example from above:

<pre class="language-typescript"><code class="lang-typescript">
    const model: Array<ModelEntryType> = [
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

    // Set the Model, if you have changes to the model not coming from the Sorter, then set the model again:
    this.#sorter.setModel(model);
</code></pre>

### Rendering

The Sorter does not move elements, instead it updates the model as the user drags an item around. This puts higher pressure on the rendering of the sortable Elements. This means we need to make sure that the rendering re-uses the same element despite sorting the data differently.

Lit does provide a render helper method called 'repeat' that does this for us, the following example shows a render method that continues the work of the examples above:

<pre class="language-typescript"><code class="lang-typescript">

    render() {
		return html`
			<div class="sorter-container">
				${repeat(
					this._items,
					(item) => item.id,
					(item) =>
						html`<div data-sorter-id=${item.name}>${item.name}</div>
						</div>`,
				)}
			</div>
		`;
	}
</code></pre>
