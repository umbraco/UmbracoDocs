# Enabling and Disabling the Sorter

The Sorter can be dynamically enabled or disabled based on your application's state. This is useful when you want to toggle between viewing and editing modes.

## Methods

### `enable()`
Enables the sorter, allowing sorting interactions to occur.

### `disable()`
Disables the sorter, preventing any sorting interactions.

## Example Usage

The following example shows how to toggle the sorter based on a "sort mode" state:

```typescript
export class UmbContentTypeDesignEditorElement extends UmbLitElement {
    #sorter = new UmbSorterController<ModelType, HTMLElement>(this, {
        getUniqueOfElement: (element) => element.getAttribute('data-id'),
        getUniqueOfModel: (model) => model.id,
        itemSelector: '.sortable-item',
        containerSelector: '.sortable-container',
        onChange: ({ model }) => {
            this._items = model;
        },
    });


    @state()
    private _sortModeActive = false;

    // Initially disable the sorter
	constructor() {
		super();
		this.#sorter.disable();
	}

    #toggleSortMode() {
        this._sortModeActive = !this._sortModeActive;
        if (this._sortModeActive) {
            this.#sorter.enable();
        } else {
            this.#sorter.disable();
        }
    }

    override render() {
        return html`
            <uui-button 
                @click=${this.#toggleSortMode}
                label=${this._sortModeActive ? 'Done Sorting' : 'Sort Items'}>
                ${this._sortModeActive ? 'Done' : 'Sort'}
            </uui-button>
            
            <div class="sortable-container">
                ${repeat(
                    this._items,
                    (item) => item.id,
                    (item) => html`
                        <div class="sortable-item" data-id=${item.id}>
                            ${item.name}
                        </div>
                    `
                )}
            </div>
        `;
    }
}
```

## Key Points

- The sorter is **enabled by default** when instantiated
- Call [`disable()`](sorter.controller.ts) to prevent sorting interactions
- Call [`enable()`](sorter.controller.ts) to re-enable sorting
- These methods are idempotent - calling them multiple times has no additional effect
- Disabling the sorter removes all drag event listeners, improving performance when sorting is not needed
