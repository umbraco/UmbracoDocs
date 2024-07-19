---

---

# Editor Service

The Angular `editorService` service is the primary resource used for opening overlays and handling infinite editing. Besides the `open` and `close` functions, the service also contains functions for opening specialized overlays/editors - eg. `contentPicker` or `mediaPicker`.

## Content Picker

The `contentPicker` function opens a Content Picker in infinite editing. Depending on the options, it may be used for picking a single content item or a set of content items. Options for the function is as following:

| Alias           | Description |
|-----------------|-------------|
| **multiPicker** | Indicates a boolean value for whether the editor should work as a single Content Picker (`false`) or a Multi Content Picker (`true`). |
| **submit**      | Is a callback function when the user selects and submits one or more content items.  |
| **close**       | Is a callback function when the close button is clicked. |

The Content Picker could be opened as:

```js
editorService.contentPicker({
    multiPicker: true,
    submit: function(model) {
        model.selection.forEach(item, function() {
            console.log(item.name);
        });
        editorService.close();
    },
    close: function() {
        editorService.close();
    }
});
```

This example snippet will open a new Multi Content Picker. If the user submits one or more content items, the name of each content item will be printed to the console. The user may also close the Content Picker without selecting any content items, in which case the `close` callback function is invoked.

## Document Type Editor

The `documentTypeEditor` function of the editor service can be used for opening a new overlay for creating a new Document Type. It can also be used for editing an existing Document Type.

The function supports the following options:

| Alias          | Description |
|----------------|-------------|
| **id**         | Indicates the numeric ID of the Document Type which should be opened for editing.  |
| **create**     | A boolean value indicating whether the overlay should be used for creating a new Document Type (opposed to editing an existing Document Type). |
| **noTemplate** | When part of a create-overlay, this option specifies whether the Document Type should be created without a corresponding Template. |
| **submit**     | A callback function for when the user submits/saves the Document Type. |
| **close**      | A callback function for when the close button is clicked. |

An overlay for creating a new Document Type may be opened as:

```javascript
editorService.documentTypeEditor({
    id: -1,
    create: true,
    submit: function (model) {
        console.log(model.documentTypeAlias);
     editorService.close();
    },
    close: function () {
        editorService.close();
    }
});
```

Notice that both the `id` and `create` options must be specified. When the overlay submits, you'll be able to get the alias of the created Document Type through `model.documentTypeAlias`.

Opening an overlay for editing an existing Document Type can be opened as:

```javascript
editorService.documentTypeEditor({
    id: 1103,
    submit: function (model) {
        console.log(model.documentTypeAlias);
        editorService.close();
    },
    close: function () {
        editorService.close();
    }
});
```
