# Setting the Sorter Model

The sorter's model must be set using the `setModel()` method whenever the data changes from an external source. This guide covers different scenarios for managing the model.

## The setModel() Method

```typescript
setModel(model: Array<T> | undefined): void
```

This method updates the sorter's internal model. Call it whenever:
- Initial data is loaded
- Data is fetched from a server
- Data is updated programmatically (not via drag-and-drop)
- Items are added or removed from the list

## Scenario 1: Property Setter with Initial Data

When data is provided via a property and should only be set once:

```typescript
@customElement('my-sortable-list')
export class MySortableList extends UmbLitElement {
    @property({ type: Array, attribute: false })
    public get items(): ModelEntryType[] {
        return this._items ?? [];
    }
    public set items(value: ModelEntryType[]) {
        // Only set model initially, prevent re-setting on re-renders
        if (this._items !== undefined) return;
        this._items = value;
        this.#sorter.setModel(this._items);
    }
    private _items?: ModelEntryType[];

    #sorter = new UmbSorterController<ModelEntryType, HTMLElement>(this, {
        getUniqueOfElement: (element) => element.getAttribute('data-id'),
        getUniqueOfModel: (model) => model.id,
        itemSelector: '.item',
        containerSelector: '.container',
        onChange: ({ model }) => {
            const oldValue = this._items;
            this._items = model;
            this.requestUpdate('items', oldValue);
        },
    });
}
```

**Why the guard?** The `if (this._items !== undefined) return;` prevents re-setting the model when Lit re-renders, which would interfere with drag-and-drop operations.

## Scenario 2: Fetching Data

When data is loaded asynchronously from a server:

```typescript
@customElement('my-async-list')
export class MyAsyncList extends UmbLitElement {
    @state()
    private _items?: ModelEntryType[];

    #sorter = new UmbSorterController<ModelEntryType, HTMLElement>(this, {
        getUniqueOfElement: (element) => element.getAttribute('data-id'),
        getUniqueOfModel: (model) => model.id,
        itemSelector: '.item',
        containerSelector: '.container',
        onChange: ({ model }) => {
            this._items = model;
        },
    });

    override async connectedCallback() {
        super.connectedCallback();
        await this.#loadData();
    }

    async #loadData() {
        try {
            const response = await fetch('/api/items');
            const items = await response.json();
            this._items = items;
            // Set the model after fetching
            this.#sorter.setModel(this._items);
        } catch (error) {
            console.error('Failed to load items:', error);
        }
    }

    async #refreshData() {
        await this.#loadData();
    }

    override render() {
        return html`
            <button @click=${this.#refreshData}>Refresh</button>
            <div class="container">
                ${repeat(
                    this._items ?? [],
                    (item) => item.id,
                    (item) => html`
                        <div class="item" data-id=${item.id}>
                            ${item.name}
                        </div>
                    `
                )}
            </div>
        `;
    }
}
```

## Scenario 3: Using willUpdate() for Reactive Updates

When you need to synchronize external changes to the sorter model:

```typescript
@customElement('my-async-list')
export class MyAsyncList extends UmbLitElement {
    #sorter = new UmbSorterController<ModelEntryType, HTMLElement>(this, {
        getUniqueOfElement: (element) => element.getAttribute('data-id'),
        getUniqueOfModel: (model) => model.id,
        itemSelector: '.item',
        containerSelector: '.container',
        onChange: ({ model }) => {
            const oldValue = this._items;
            this._items = model;
            this.requestUpdate('_items', oldValue);
        },
    });

    @state()
    private _items?: ModelEntryType[];

    override willUpdate(changedProperties: PropertyValues) {
        if (changedProperties.has('_items')) {
            // Sync model whenever _items changes
            this.#sorter.setModel(this._items);
        }
    }

    #addItem() {
        const newItem: ModelEntryType = {
            id: crypto.randomUUID(),
            name: `Item ${this._items.length + 1}`
        };
        this._items = [...this._items, newItem];
    }

    #removeItem(item: ModelEntryType) {
        this._items = this._items.filter(i => i.id !== item.id);
    }

    override render() {
        return html`
            <button @click=${this.#addItem}>Add Item</button>
            <div class="container">
                ${repeat(
                    this._items,
                    (item) => item.id,
                    (item) => html`
                        <div class="item" data-id=${item.id}>
                            ${item.name}
                            <button @click=${() => this.#removeItem(item)}>Remove</button>
                        </div>
                    `
                )}
            </div>
        `;
    }
}
```

**Why use `willUpdate()`?**
- Centralizes model synchronization in one place
- Automatically syncs whenever `_items` changes
- Works for adds, removes, and external updates
- Cleaner than calling `setModel()` in every method that modifies `_items`

## Scenario 4: Manual Item Management

When adding or removing items programmatically:

```typescript
@customElement('my-managed-list')
export class MyManagedList extends UmbLitElement {
    @state()
    private _items: ModelEntryType[] = [];

    #sorter = new UmbSorterController<ModelEntryType, HTMLElement>(this, {
        getUniqueOfElement: (element) => element.getAttribute('data-id'),
        getUniqueOfModel: (model) => model.id,
        itemSelector: '.item',
        containerSelector: '.container',
        onChange: ({ model }) => {
            this._items = model;
        },
    });

    #addItem() {
        const newItem: ModelEntryType = {
            id: crypto.randomUUID(),
            name: `Item ${this._items.length + 1}`
        };
        this._items = [...this._items, newItem];
        // Update sorter model after manual change
        this.#sorter.setModel(this._items);
    }

    #removeItem(item: ModelEntryType) {
        this._items = this._items.filter(i => i.id !== item.id);
        // Update sorter model after manual change
        this.#sorter.setModel(this._items);
    }

    override render() {
        return html`
            <button @click=${this.#addItem}>Add Item</button>
            <div class="container">
                ${repeat(
                    this._items,
                    (item) => item.id,
                    (item) => html`
                        <div class="item" data-id=${item.id}>
                            ${item.name}
                            <button @click=${() => this.#removeItem(item)}>Remove</button>
                        </div>
                    `
                )}
            </div>
        `;
    }
}
```

## Best Practices

1. **Always call `setModel()` after programmatic changes** to the item array
2. **Don't call `setModel()` in the `onChange` callback** - this creates an infinite loop
3. **Use guards in setters** to prevent unnecessary updates during re-renders
4. **Maintain immutability** - create new arrays instead of mutating existing ones
5. **Use `willUpdate()`** for reactive updates based on property changes

## Common Pitfalls

❌ **Don't do this:**
```typescript
// Calling setModel in onChange creates a loop
onChange: ({ model }) => {
    this._items = model;
    this.#sorter.setModel(model); // ❌ Wrong!
}
```

❌ **Don't do this:**
```typescript
// Mutating without updating the sorter
#addItem() {
    this._items.push(newItem); // ❌ Mutation without setModel
}
```

✅ **Do this:**
```typescript
// Create new array and update sorter
#addItem() {
    this._items = [...this._items, newItem];
    this.#sorter.setModel(this._items); // ✅ Correct!
}
```
