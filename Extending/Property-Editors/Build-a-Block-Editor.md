---
versionFrom: 8.0.0
---

# Build a Block Editor

To read this document you must make your self confident with the basics of developing a custom Property Editor for Umbraco.
[Read more](https://our.umbraco.com/documentation/Extending/Property-Editors/)


## Setup your Property Editor as a Block Property Editor

In order for your editor to become a Block Editor you must setup your property editor through C#

```csharp
using ClientDependency.Core;
using Umbraco.Core.Logging;
using Umbraco.Core.PropertyEditors;
using Umbraco.Web.PropertyEditors;
// TODO: Make sure we dont miss some dependencies?

namespace UmbracoEightExamples.PropertyEditors
{

    
    [DataEditor(
        "MyOwn.UnicornBlocksEditor",
        "Unicorn Blocks,
        "unicornblocks",
        ValueType = ValueTypes.Json,
        Group = Constants.PropertyEditors.Groups.Lists,
        Icon = "icon-thumbnail-list")]
    [PropertyEditorAsset(ClientDependencyType.Javascript, "/App_Plugins/UnicornBlocks/UnicornBlocks.controller.js")]
    public class UnicornBlocksPropertyEditor : BlockEditorPropertyEditor
    {
    	
    	public UnicornBlocksPropertyEditor(ILogger logger, Lazy<PropertyEditorCollection> propertyEditors, IDataTypeService dataTypeService, IContentTypeService contentTypeService)
            : base(logger, propertyEditors, dataTypeService, contentTypeService, new DataHelper())
        { }
    	
    }

}
```

Notice how the `PropertyEditorAsset` attribute is used to load the `UnicornBlocks.controller.js` JavaScript file.

Your Property Editor would as well need a `PropertyValueConverter`.

TODO: write something about PropertyValueConverter, or provide a link to something about that?


### Data structure of Block Editors.

The data of Block Editors consist of two main parts:

Layout: The Layout defines Blocks that each will reference a content item located in the list of data by it's UDI. The Layout object will be key/value pairs where the key is the Property Editor alias. The value type depends on your Property Editors setup.

Data: A list of content items based on ElementTypes(IPublishedElement).

In the following example the layout object "MyOwn.UnicornBlocksEditor" is of type Array.

```json
{
  "layout": {
    "MyOwn.UnicornBlocksEditor": [
      {
        "udi": "umb://element/fffba547615b4e9ab4ab2a7674845bc9",
        "settings": {}
      }, 
      {
        "udi": "umb://element/e7dba547615b4e9ab4ab2a7674845bc9",
        "settings": {
        	"__yourPropertyAlias5__": "FooBar"
        }
      }
    ]
  },
  "data": [
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
  ]
}
```




### Client side code

#### Basic knowledge for understanding how to work with Block Editor data.
There is a few things we need to understand before we can use the Model Object(BlockEditorModelObject).
The data structure of a Block Editor contains two main properties 'layout' and 'data'.
- The 'layout' property is the origin of the data, this object defines the blocks of this property including the the order and layout of those.
- The 'data' property is the data of your blocks and is managed by the Model Object therefor it can be ignored for most use.
To get a better understanding of what this means as a user of the Model Object, we need to look at some simple usages of the Model Object:

#### Maintain and work with the Layout of a Block Editor.
The 'layout' of a Block Editor can be of any structure. Therefor the Model Object(BlockEditorModelObject) cannot maintain this data.
Since the origin of blocks is in the 'layout' the Model Object only can serve as a helper to maintain and create data.
Therefor the Property Editor code will be using the 'layout' as origin, using the Model Object help managing speicfic parts.<br/>
To give an unstanding of what that means please read the following documentation of how to create a block.

#### The basic setup for a Block Editor.

##### Instantiate a Model Object and load dependencies. And provide the basic structure for the 'layout' property when reciving the reference to it:

<pre>
	// We must get a scope that exists in all the lifetime of this data. Across variants and split-view.
	var scopeOfExistence = $scope;
	// Setup your component to require umbVariantContentEditors and use the method getScope to retrive a shared scope for multiple editors of this content.
	if(vm.umbVariantContentEditors && vm.umbVariantContentEditors.getScope) {
	    scopeOfExistence = vm.umbVariantContentEditors.getScope();
	}
	// Define variables for layout and modelObject as you will be using these through our your property-editor.
	var layout;
	var modelObject;
	    
	// When we are ready we can instantiate the Model Object can load the dependencies of it.
	vm.$onInit = function() {
	    modelObject = blockEditorService.createModelObject(vm.model.value, vm.model.editor, vm.model.config.blocks, scopeOfExistence);
	    modelObject.load().then(onLoaded);
	}
	function onLoaded() {
	  // Define the default layout, this is used when there is no data jet stored for this property.
	  var defaultLayout = [];
	  // We store a reference to layout as we have to maintain this.
	  layout = modelObject.getLayout(defaultLayout);
	}
</pre>
### <b>Create a Block.</b>
Use the Model Object to create a Block and append the returned layout-entry to the 'layout'.

##### In the following example we will create a new block and append it at the decidered location in the 'layout' object:

<pre>
	// continuing from previous example.
	 
	// Creates a block and returns a layout entry. The layout entry is not part of layout jet as its not managed by the Model Object.
	var layoutEntry = modelObject.create(contentTypeKey);
	if (layoutEntry === null) {
		// The creation was not successful, therefore exit and without appending anything to our 'layout' object.
		return false;
	}
	// If we reach this line, we are good to add the layoutEntry to layout model.
	// In this example our layout is an array and we would like to append the new block as the last entry.
	layout.push(layoutEntry);
	 
</pre>

### <b>Working with Blocks</b>
The layout-entries does not provide much value when it comes to displaying or editing Blocks.
Our Model Object provides the option to get a Block Object for a given Block. Retrived by parsing the layout-entry of the block we would like.
The Block Object provides data of interest, the most important of these properties are: Block configuration, A label and the Block content in the Element Type Data Model format, this Content-model is very usefull to make UI for editing the Content of a Block.

##### This example uses the Model Object to retrive a Block Object for outputting its label in the console.<br/>

<pre>
	// We store blocks in the layout
	var layout = modelObject.getLayout([]);
	if (layout.length > 0) {
	// Get first entry of from the layout, which is an array in this sample.
	var firstLayoutEntry = layout[0];
	// Create a Block Object for that entry.
	var block = modelObject.getBlockObject(firstLayoutEntry);
	// Check if the Block Object creation went well. (If a block isnt supported by the configuration of the Property Editor)
	if (block !== null) {
		console.log(block.label);
	}
}
</pre>

##### This similar example uses the Block Object for settings a value on the first property in the Blocks Content.<br/>

<pre>
	// We store blocks in the layout
	var layout = modelObject.getLayout([]);
	if (layout.length > 0) {
		
		// Get first entry of from the layout, which is an array in this sample.
		var firstLayoutEntry = layout[0];
		
		// Create a Block Object for that entry.
		var block = modelObject.getBlockObject(firstLayoutEntry);
		
		// Check if the Block Object creation went well. (If a block isnt supported by the configuration of the Property Editor)
		if (block !== null) {
			// this line is an example of how you can use the content model to edit data:
			block.content.variants[0].tabs[0].properties[0].value = "Hello world";// This value will automaticly be synced to the Property Editors Data Model, in other words ´block.data.myProp´
		}
	}
</pre>

See [blockEditorModelObject](https://our.umbraco.com/apidocs/v8/ui/#/api/umbraco.services.blockEditorModelObject#methods_getBlockObject) for the getBlockObject method for more information on the properties avaiable on a Block Object.


## <b>Remove a Block</b>
Removing a Block and destroying the data of it is done by calling one method of the Model Object, but we have remember that we need to maintain the 'layout' object and this case is a great example of how thats done.
You will find that your code will very much be based on working with Block Objects and therefor removal of a Block is be done by refering a Block Object.
##### This example shows how to remove the first Block of our imaginary Block Editor and removing the block from our layout.
 
<pre>

	var layout = modelObject.getLayout([]);
	
	if (layout.length > 0) {
		// Get first entry of from the layout, which is an array in this sample.
		var firstLayoutEntry = layout[0];
		
		// Create a Block Object for that entry.
		var block = modelObject.getBlockObject(firstLayoutEntry);
		
		// Check if the Block Object creation went well. (If a block isnt supported by the configuration of the Property Editor)
		if(block !== null) {

			modelObject.removeDataAndDestroyModel(block);// Removing the data of our block and destroying the Block Object for performance reasons.
			
			// We need to maintain the 'layout' object, so therefor its up to our code to remove the block from the 'layout' object.
			const index = array.indexOf(5);
			if (index > -1) {
				layout.splice(index, 1);
			}
		}
	}
 	
</pre>


##### Manage a Render Model for Displaying Blocks in the Property Editor
For Rendering a Block in our AngularJS view

<pre>
    // TODO to be done.
</pre>
