# Build a Block Editor

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

Before reading this document we highly recommend that you familiarise yourself with [the basics of developing a custom Property Editor for Umbraco](../../tutorials/creating-a-property-editor/).

## Setup your Property Editor as a Block Property Editor

In order for your editor to become a Block Editor, you must first declare it using C#:

{% code title="UnicornBlocksPropertyEditor.cs" %}
```csharp
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Core.Serialization;
using Umbraco.Cms.Core.PropertyEditors;

namespace UmbracoDocs.Samples;

[DataEditor("MyOwn.UnicornBlocksEditor", ValueType = ValueTypes.Json, ValueEditorIsReusable = false)]
public class UnicornBlocksPropertyEditor : BlockListPropertyEditorBase
{
    private readonly IIOHelper _ioHelper;

    public UnicornBlocksPropertyEditor(
        IDataValueEditorFactory dataValueEditorFactory,
        IBlockValuePropertyIndexValueFactory blockValuePropertyIndexValueFactory,
        IJsonSerializer jsonSerializer,
        IOHelper ioHelper)
        : base(dataValueEditorFactory, blockValuePropertyIndexValueFactory, jsonSerializer)
        => _ioHelper = ioHelper;

    protected override IConfigurationEditor CreateConfigurationEditor() =>
        new UnicornBlocksConfigurationEditor(_ioHelper);
}
```
{% endcode %}

{% code title="UnicornBlocksConfigurationEditor.cs" %}
```csharp
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Core.PropertyEditors;

namespace UmbracoDocs.Samples;

public class UnicornBlocksConfigurationEditor : ConfigurationEditor<BlockListConfiguration>
{
    public UnicornBlocksConfigurationEditor(IIOHelper ioHelper)
        : base(ioHelper)
    {
    }
}
```
{% endcode %}

{% hint style="info" %}
It is not strictly necessary to define your own property editor in C#. As outlined in the [Composition](composition/) article, all Umbraco core property editors can be reused.

The code sample above inherits all functionality from Block List and adds no new functionality. If this is sufficient, you can use the Block List property editor alias `"Umbraco.BlockList"` as Property Editor Schema in your [package manifest](../../customize-the-backoffice/umbraco-package.md).

It is, however, recommended to declare your own Block Editors in C#. As you will see in the following, the property editor alias (`"MyOwn.UnicornBlocksEditor"`) will be part of the data structure. For any eventual future extensibility, it is good to have the correct alias in the content structure from the beginning.
{% endhint %}

## Data structure of Block Editors

The Block Editor data structure consists of three main parts:

**Layout**: The Layout defines Blocks that each will reference (by UDI) a content item in the list of data. The Layout object pairs keys with Property Editor aliases and their value type varies based on setup.

**ContentData**: A list of content items based on ElementTypes (IPublishedElement).

**SettingsData**: A list of content items based on ElementTypes (IPublishedElement).

In the following example the layout object "MyOwn.UnicornBlocksEditor" is of type Array.

```json
{
  "layout": {
    "MyOwn.UnicornBlocksEditor": [
      {
        "contentUdi": "umb://element/fffba547615b4e9ab4ab2a7674845bc9"
      },
      {
        "contentUdi": "umb://element/e7dba547615b4e9ab4ab2a7674845bc9",
        "settingsUdi": "umb://element/a47667bcba54845b15b4e9ab4ab2a7c8"
      }
    ]
  },
  "contentData": [
    {
      "udi": "umb://element/fffba547615b4e9ab4ab2a7674845bc9",
      "contentTypeKey": "09876595489865786897",
      "__yourPropertyAlias__": "Hello world"
    },
    {
      "udi": "umb://element/e7dba547615b4e9ab4ab2a7674845bc9",
      "contentTypeKey": "123456789097654323456",
      "__yourPropertyAlias1__": "Hello world",
      "__yourPropertyAlias2__": "Hello world",
      "__yourPropertyAlias3__": "Hello world"
    }
  ],
  "settingsData": [
    {
      "udi": "umb://element/a47667bcba54845b15b4e9ab4ab2a7c8",
      "contentTypeKey": "09876595489865786897",
      "__yourPropertyAlias__": "Hello world"
    }
  ]
}
```

## Client side code

### Basic knowledge for understanding how to work with Block Editor data

We created the BlockEditorModelObject to aid in managing the presented Data Structure in the Block Editor.

To get a better understanding of what the Model Object does for you, we need to look at some usages of the Model Object.

### Maintain and work with the Layout of a Block Editor

The `layout` of a Block Editor can be any structure. Therefore the Model Object (BlockEditorModelObject) cannot maintain this data. Our usage of the Model Object becomes complex. We give it a reference to a `layout` entry and perform an action that may need to reflect changes back to the `layout`.

Since the origin of blocks is in the `layout` the Model Object only can serve as a helper to maintain and create data. Therefore the Property Editor code will be using the `layout` as origin, using the Model Object to help manage specific parts.

This is explained in more detail below.

### The basic setup for a Block Editor

Instantiate a Model Object and load dependencies. Provide the basic structure for the `layout` property when receiving the reference to it:

```js
// We must get a scope that exists in all the lifetime of this data. Across variants and split-view.
var scopeOfExistence = $scope;
// Setup your component to require umbVariantContentEditors and vm.umbElementEditorContent. If one of them is avaiable use the method getScope to retrieve a shared scope for multiple editors of this content.
if(vm.umbVariantContentEditors && vm.umbVariantContentEditors.getScope) {
    scopeOfExistence = vm.umbVariantContentEditors.getScope();
} else if(vm.umbElementEditorContent && vm.umbElementEditorContent.getScope) {
    scopeOfExistence = vm.umbElementEditorContent.getScope();
}
// Define variables for layout and modelObject as you will be using these throughout your property editor.
vm.layout;
var modelObject;

// When we are ready we can instantiate the Model Object and load any dependencies.
vm.$onInit = function() {
  modelObject = blockEditorService.createModelObject(vm.model.value, vm.model.editor, vm.model.config.blocks, scopeOfExistence);
  modelObject.load().then(onLoaded);
}
function onLoaded() {
  // Define the default layout, this is used when there is no data stored for this property.
  var defaultLayout = [];
  // We store a reference to layout as we have to maintain this.
  // The getLayout method gives us a reference to the layout-object based on the property-editor alias. The defaultLayout will be initialized if it does not exist.
  vm.layout = modelObject.getLayout(defaultLayout);
}
```

### Create a Block

Use the Model Object to create a Block and append the returned layout-entry to the `layout`.

In the following example we will create a new block and append it at the appropriate location in the 'layout' object:

```js
// continuing from previous example.

// Creates a block and returns a layout entry. The layout entry is not part of layout yet as its not managed by the Model Object.
var layoutEntry = modelObject.create(contentTypeKey);
if (layoutEntry === null) {
  // The creation was not successful, therefore exit and without appending anything to our 'layout' object.
  return false;
}
// If we reach this line, we are good to add the layoutEntry to layout model.
// In this example our layout is an array and we would like to append the new block as the last entry.
vm.layout.push(layoutEntry);
```

### Working with Blocks

The layout-entries alone do not provide much value when displaying or editing Blocks.

Our Model Object allows obtaining a Block Object by parsing a block's layout-entry for a specific Block.

The Block Object provides data of interest. The most important of these properties are: Block configuration, a label and the Block content in the Element Type Data Model format. This Content-model is useful for building the UI for editing the Content of a Block.

This example uses the Model Object to retrive a Block Object for outputting its label in the console.

```js
// continuing from the basic setup example.

if (vm.layout.length > 0) {
  // Get first entry of from the layout, which is an array in this example.
  var firstLayoutEntry = vm.layout[0];

  // Create a Block Object for that entry.
  var block = modelObject.getBlockObject(firstLayoutEntry);

  // Check if the Block Object creation went well. (If a block is supported by the configuration of the Property Editor)
  if (block !== null) {
    console.log(block.label);
  }
}
```

This similar example uses the Block Object for setting a value on the first property in the Blocks Content.

```js
// continuing from the basic setup example.

if (vm.layout.length > 0) {
  // Get first entry of from the layout, which is an array in this example.
  var firstLayoutEntry = vm.layout[0];

  // Create a Block Object for that entry.
  var block = modelObject.getBlockObject(firstLayoutEntry);

  // Check if the Block Object creation went well. (If a block is supported by the configuration of the Property Editor)
  if (block !== null) {

    // This line edits the value of 'myProp' directly, available by 'block.data':
    block.data.myProp = "Hello world";

    // Alternatively you can use this line, which edits the data throught the Element Type data model avaiable in 'block.content':
    block.content.variants[0].tabs[0].properties[0].value = "Hello world"; // This value will automatically be synced to the Property Editors Data Model, ´block.data.myProp´
  }
}
```

## Remove a Block

Removing a Block and destroying its data is done by calling the `removeDataAndDestroyModel` method of the Model Object, which allows us to maintain the 'layout' object.

Your code will be based on working with Block Objects and therefore removal of a Block is be done by referring to a Block Object.

This example shows how to remove the first Block of our imaginary Block Editor and remove the block from our layout.

```js
// continuing from the basic setup example.

if (vm.layout.length > 0) {
  // Get first entry of from the layout, which is an array in this sample.
  var firstLayoutEntry = vm.layout[0];

  // Create a Block Object for that entry.
  var block = modelObject.getBlockObject(firstLayoutEntry);

  // Check if the Block Object creation went well. (If a block isnt supported by the configuration of the Property Editor)
  if(block !== null) {

    modelObject.removeDataAndDestroyModel(block);// Removing the data of our block and destroying the Block Object for performance reasons.

    // We need to maintain the 'layout' object, so therefor its up to our code to remove the block from the 'layout' object.
    const index = array.indexOf(5);
    if (index > -1) {
      vm.layout.splice(index, 1);
    }
  }
}
```

## Manage Block Objects for general use through out your Property Editor

Block Objects are used extensively and should be available throughout your Block Editor's runtime, rather than created for each action.

You probably want to use BlockObjects for your property-editor view. We append them to layout entries, so you can access them as properties from the layout object.

```js
// continuing from the basic setup example.

var invalidLayoutItems = [];

// Append the blockObjects to our layout.
vm.layout.forEach(entry => {

// As we might have the same property-editor displayed multiple times on screen (splitview) we only need to initialize a BlockObject if its not already in place.

    // $block must have the 'data' property to be a valid BlockObject, if not it is considered a destroyed blockObject.
    if (entry.$block === undefined || entry.$block === null || entry.$block.data === undefined) {
        var block = modelObject.getBlockObject(entry);

        // If this entry was not supported by our property-editor it would return 'null'.
        if (block !== null) {
            entry.$block = block;
        } else {
          // We didnt succeed initializing this Block, therefore we need to filter this out of 'layout'. This only happens if the content data of the block couldn't be found.
            invalidLayoutItems.push(entry);
        }
    }
});

// remove the ones that are invalid
invalidLayoutItems.forEach(entry => {
    var index = vm.layout.findIndex(x => x === entry);
    if (index >= 0) {
        vm.layout.splice(index, 1);
    }
});
```

The following example loops through a layout array to display the contentUdi of each block:

```html
<div ng-repeat="layoutEntry in vm.layout track by layoutEntry.$block.key">

    <h3 ng-bind="layout.$block.data.udi"></h3>

</div>
```
