# Sorter Configuration Options

The [`UmbSorterController`](sorter.controller.ts) accepts a comprehensive configuration object. This guide covers all available options.

## Required Configuration

### `getUniqueOfElement`
```typescript
getUniqueOfElement: (element: ElementType) => string | symbol | number | null | undefined
```
Returns the unique identifier from a DOM element. Return `undefined` or `null` to cancel a move operation.

**Example:**
```typescript
getUniqueOfElement: (element) => element.getAttribute('data-id')
```

### `getUniqueOfModel`
```typescript
getUniqueOfModel: (modelEntry: T) => string | symbol | number | null | undefined
```
Returns the unique identifier from a model entry.

**Example:**
```typescript
getUniqueOfModel: (model) => model.id
```

### `itemSelector`
```typescript
itemSelector: string
```
A CSS selector matching the draggable items.

**Example:**
```typescript
itemSelector: '.sortable-item'
```

## Optional Configuration

### `identifier`
```typescript
identifier?: string | symbol | number
```
A unique identifier for the sorter instance. All sorters sharing the same identifier can interact with each other (drag items between them). Defaults to a new `Symbol()` if not provided.

**Example:**
```typescript
identifier: 'my-shared-sorter-group'
```

### `containerSelector`
```typescript
containerSelector?: string
```
A CSS selector for the container element. If not provided, the host element is used.

**Example:**
```typescript
containerSelector: '.items-container'
```

### `disabledItemSelector`
```typescript
disabledItemSelector?: string
```
A CSS selector for items that should not be draggable.

**Example:**
```typescript
disabledItemSelector: '.disabled-item'
```

### `ignorerSelector`
```typescript
ignorerSelector?: string
```
A CSS selector for elements within items that should not trigger dragging. Defaults to `'a,img,iframe,input,textarea,select,option'`.

**Example:**
```typescript
ignorerSelector: 'a,button,input'
```

### `placeholderClass`
```typescript
placeholderClass?: string
```
CSS class applied to the dragged element while dragging.

**Example:**
```typescript
placeholderClass: 'dragging-placeholder'
```

### `placeholderAttr`
```typescript
placeholderAttr?: string
```
Attribute set on the dragged element while dragging. If neither `placeholderClass` nor `placeholderAttr` is provided, defaults to `'drag-placeholder'`.

**Example:**
```typescript
placeholderAttr: 'data-dragging'
```

### `draggableSelector`
```typescript
draggableSelector?: string
```
CSS selector for the specific element within an item that should be draggable. Useful for adding a drag handle.

**Example:**
```typescript
draggableSelector: '.drag-handle'
```

### `handleSelector`
```typescript
handleSelector?: string
```
CSS selector for the interactive handle within an item. Only this element can initiate dragging.

**Example:**
```typescript
handleSelector: '.drag-handle-button'
```

## Callback Configuration

### `onChange`
```typescript
onChange?: (args: { item: T; model: Array<T> }) => void
```
Called whenever the model changes. Not called if more specific callbacks are provided.

**Example:**
```typescript
onChange: ({ model, item }) => {
    console.log('Model changed:', model);
    this._items = model;
}
```

### `onContainerChange`
```typescript
onContainerChange?: (args: { 
    item: T; 
    model: Array<T>; 
    from: UmbSorterController<T> | undefined 
}) => void
```
Called when an item moves from another container to this one.

**Example:**
```typescript
onContainerChange: ({ item, model, from }) => {
    console.log(`Item ${item.id} moved from another container`);
    this._items = model;
}
```

### `onStart`
```typescript
onStart?: (args: { item: T; element: ElementType }) => void
```
Called when dragging starts.

**Example:**
```typescript
onStart: ({ item }) => {
    console.log('Started dragging:', item.name);
}
```

### `onEnd`
```typescript
onEnd?: (args: { item: T; element: ElementType }) => void
```
Called when dragging ends.

**Example:**
```typescript
onEnd: ({ item }) => {
    console.log('Finished dragging:', item.name);
}
```

### `onRequestMove`
```typescript
onRequestMove?: (args: { item: T }) => boolean
```
Called to validate if an item can be moved into this container. Return `false` to prevent the move.

**Example:**
```typescript
onRequestMove: ({ item }) => {
    return item.type === 'allowed-type';
}
```

### `onDisallowed` / `onAllowed`
```typescript
onDisallowed?: (args: { item: T; element: ElementType }) => void
onAllowed?: (args: { item: T; element: ElementType }) => void
```
Visual feedback callbacks for when moves are disallowed/allowed.

**Example:**
```typescript
onDisallowed: ({ element }) => {
    element.classList.add('drop-not-allowed');
},
onAllowed: ({ element }) => {
    element.classList.remove('drop-not-allowed');
}
```

## Advanced Callbacks

### `performItemMove`
```typescript
performItemMove?: (args: { 
    item: T; 
    newIndex: number; 
    oldIndex: number 
}) => Promise<boolean> | boolean
```
Custom handler for moving items within the same container. Return `false` to cancel.

**Example:**
```typescript
performItemMove: async ({ item, newIndex, oldIndex }) => {
    await this.saveToServer(item, newIndex);
    return true;
}
```

### `performItemInsert`
```typescript
performItemInsert?: (args: { item: T; newIndex: number }) => Promise<boolean> | boolean
```
Custom handler for inserting items into the container.

### `performItemRemove`
```typescript
performItemRemove?: (args: { item: T }) => Promise<boolean> | boolean
```
Custom handler for removing items from the container.

### `resolvePlacement`
```typescript
resolvePlacement?: (args: UmbSorterResolvePlacementArgs<T>) => UmbSorterResolvePlacementReturn
```
Custom logic for determining where to place an item during drag. Return `true` to place after, `false` to place before, or `null` to cancel.

**Example:**
```typescript
resolvePlacement: ({ pointerY, relatedRect }) => {
    // Place after if pointer is in bottom half
    return pointerY > relatedRect.top + relatedRect.height * 0.5;
}
```