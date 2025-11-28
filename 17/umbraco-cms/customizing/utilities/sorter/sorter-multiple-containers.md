# Sorting Across Multiple Containers

The Sorter supports dragging items between multiple containers by using a shared `identifier`. This allows you to create complex drag-and-drop interfaces.

If you want to test it out and see it used, there are two examples available.
One for a sorter with nested containers, and another for two sorter containers.
It can be found in [Examples and Playground](https://docs.umbraco.com/umbraco-cms/customizing/examples-and-playground)


## Configuration

To enable cross-container sorting, ensure all sorter instances use the same `identifier`:

```typescript
const sharedIdentifier = 'my-shared-sorter-group';

// Container 1
#sorter1 = new UmbSorterController(this, {
    identifier: sharedIdentifier,
    // ... other config
});

// Container 2
#sorter2 = new UmbSorterController(this, {
    identifier: sharedIdentifier,
    // ... other config
});
```

## Example: Two Connected Containers

This example shows two independent containers that can exchange items:

```typescript
export type ModelEntryType = {
    name: string;
};

@customElement('example-sorter-group')
export class ExampleSorterGroup extends UmbElementMixin(LitElement) {
    @property({ type: Array, attribute: false })
    public get items(): ModelEntryType[] {
        return this._items ?? [];
    }
    public set items(value: ModelEntryType[]) {
        // Only set model initially, not on re-renders
        if (this._items !== undefined) return;
        this._items = value;
        this.#sorter.setModel(this._items);
    }
    private _items?: ModelEntryType[];

    #sorter = new UmbSorterController<ModelEntryType, ExampleSorterItem>(this, {
        getUniqueOfElement: (element) => element.name,
        getUniqueOfModel: (modelEntry) => modelEntry.name,
        // This identifier connects all sorter instances
        identifier: 'string-that-identifies-all-example-sorters',
        itemSelector: 'example-sorter-item',
        containerSelector: '.sorter-container',
        onChange: ({ model }) => {
            const oldValue = this._items;
            this._items = model;
            this.requestUpdate('items', oldValue);
        },
    });

    removeItem = (item: ModelEntryType) => {
        this._items = this._items!.filter((r) => r.name !== item.name);
        this.#sorter.setModel(this._items);
    };

    override render() {
        return html`
            <div class="sorter-container">
                ${repeat(
                    this.items,
                    (item) => item.name,
                    (item) => html`
                        <example-sorter-item name=${item.name}>
                            <button slot="action" @click=${() => this.removeItem(item)}>
                                Delete
                            </button>
                        </example-sorter-item>
                    `
                )}
            </div>
        `;
    }
}
```

### Usage

```html
<example-sorter-group .items=${[
    { name: 'Item 1' },
    { name: 'Item 2' }
]}></example-sorter-group>

<example-sorter-group .items=${[
    { name: 'Item 3' },
    { name: 'Item 4' }
]}></example-sorter-group>
```

## Key Points

- **Shared Identifier**: All containers must use the same `identifier` value
- **Independent Models**: Each container maintains its own model via `setModel()`
- **Automatic Updates**: The `onChange` callback handles model updates when items are moved between containers
- **Item Removal**: When setting the model after removing an item, call `setModel()` to sync the state

## Validation

Use `onRequestMove` to control which items can be dropped into specific containers:

```typescript
#sorter = new UmbSorterController(this, {
    // ... other config
    onRequestMove: ({ item }) => {
        // Only allow items of a specific type
        return item.type === 'allowed-in-this-container';
    },
});
```
