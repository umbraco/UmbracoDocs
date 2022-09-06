---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Block Grid

`Alias: Umbraco.BlockGrid`

`Returns: IEnumerable<BlockGridItem>`
> TODO: Someone with C# knowledge correct this type ^^

**Block Grid** enables the editor to layout their content. The content is made of blocks, which can contain simple or very complex data. By defining column span and row span, each Block gets a size, this makes them to appear next to together or even in formations.
Additionally Blocks can nest other Blocks forming more complex or strict compositions.

The default provided layout mechanism is based on CSS Grid, this can be adjusted or replaced to achieve the right layout for your project.

## Configure Block Grid

The Block Grid property editor is configured in the same way as any standard property editor, via the *Data Types* admin interface.

To set up your Block Grid Editor property, create a new *Data Type* and select **Block Grid** from the list of available property editors.

Then you will see the configuration options for a Block Grid as shown below.

![Block Grid - Data Type Definition](images/BlockListEditor_DataType.jpg)
> TODO: screenshot

The Data Type editor allows you to configure the following properties:

- **Available Blocks** - Here you will define the Block Types to be available for use in the property. Read more on how to set up Block Types below.
- **Amount** - Sets the minimum and/or maximum number of blocks that should be allowed in the root of the layout.
- **Live editing mode** - Enabling this will make editing of a block happening directly to the document model, making changes appear as you type.
- **Property editor width** - Overwrite the width of the property editor. This field takes any valid css value for "max-width".
- **Grid Columns** - Define the number of columns in your grid layout. Default is 12 columns.
- **Layout Stylesheet** - Replace the build-in Layout Stylesheet. Additionally you can retrieve the default layout stylesheet, to use as base for your own or inspiration for writhing your own.

## Setup Block Types

Block Types is based upon **Element Types**, these can be created beforehand or while setting up your Block Types.

Once you have added an Element Type as a Block Type on your Block Grid Data Type you will have the option to configure it further.

![Block List - Data Type Block Configuration](images/BlockListEditor_DataType_Blocks.png)
> TODO: screenshot

Each Block has a set of properties that are optional to configure. They are described below.

### Editor Appearance

By configuring the properties in the group you can customize the user experience for your content editors when they work with the blocks in the Content section.

- **Label** - Define a label for the appearance of the Block in the editor. The label can use AngularJS template string syntax to display values of properties. Example: "My Block {{myPropertyAlias}}" will be shown as: "My Block FooBar". You can also use more advanced expression using AngularJS filters, e.g. `{{myPropertyAlias | limitTo:100}}` or for a property using Richtext editor `{{myPropertyAlias | ncRichText | truncate:true:100}}`. It is also possible to use properties from the settings model by using `{{$settings.propertyAlias}}`.
- **Custom view** - Overwrite the AngularJS view for the block presentation in the Content editor. Use this to make a more visual presentation of the block or even make your own editing experience by adding your own AngularJS controller to the view.
- **Custom stylesheet** - Pick your own stylesheet to be used for this block in the Content editor. By adding a stylesheet the styling of this block will become scoped. Meaning that backoffice styles are no longer present for the view of this block.
- **Overlay editor size** - Set the size for the Content editor overlay for editing this block.

### Data Models

It is possible to use two separate Element Types for your Block Types. Its required to have one for Content and optional to add one for Settings.

- **Content model** - This presents the Element Type used as model for the content section of this Block. This cannot be changed, but you can open the Element Type to perform edits or view the properties available. Useful when writing your Label.
- **Settings model** - Add a Settings section to your Block based on a given Element Type. When picked you can open the Element Type or choose to remove the settings section again.

### Catalogue appearance

These properties refers to how the Block is presented in the Block catalogue, when editors choose which Blocks to use for their content.

- **Background color** - Define a background color to be displayed beneath the icon or thumbnail.  Eg. `#424242`.
- **Icon color** - Change the color of the Element Type icon. Eg. `#242424`.
- **Thumbnail** - Pick an image or SVG file to replace the icon of this Block in the catalogue.

The thumbnails for the catalogue are presented in the format of 16:10, and we recommend a resolution of 400px width and 250px height.

### Advanced

These properties are relevant when you work with custom views.

- **Force hide content editor** - If you made a custom view that enables you to edit the content part of a Block. Then you might want to hide the content-editor from the block editor overlay.

## Editing Blocks

When viewing a **Block Grid** editor in the Content section for the first time, you will be presented with the option to Add content.

![Block List - Add Content](images/BlockListEditor_AddContent.png)
> TODO: screenshot

Clicking the Add content button brings up the Block Catalogue.

![Block List - Setup](images/BlockListEditor_BlockPicker_simplesetup.jpg)
> TODO: screenshot

The Block Catalogue looks different depending on the amount of available Blocks and their catalogue appearance.

![Block List - example setup from Umbraco.com](images/BlockListEditor_BlockPicker.jpg)
> TODO: screenshot

Click the Block Type you wish to create and a new Block will appear in the layout.

More Blocks can be added to the layout by clicking the Add content button or using the inline Add content button that appears on hover between, besides or above existing Blocks.

![Block List - Add Content](images/BlockListEditor_AddContentInline.jpg)
> TODO: screenshot

To reorder the Blocks, click and drag a Block up or down to place in the desired order.

To delete a Block click the trash-bin icon appearing on hover.

## Rendering Block Grid Content

> TODO: have someone with C# expertise writting this part.

Rendering the stored value of your **Block Grid** property can be done in two ways.

### 1. Default rendering

> TODO: C# person should write this:

You can choose to use the built-in rendering mechanism for rendering blocks via a Partial View for each block.

The default rendering method is named `GetBlockListHtml()` and comes with a few options to go with it. The typical use could be:

```csharp
@Html.GetBlockListHtml(Model, "MyBlocks")
```

"MyBlocks" above is the alias for the Block List editor.

If using ModelsBuilder the example can be simplified:

Example:

```csharp
@Html.GetBlockListHtml(Model.MyBlocks)
```

To make this work you will need to create a Partial View for each block, named by the alias of the Element Type that is being used as Content Model.

These partial views must be placed in this folder: `Views/Partials/BlockList/Components/`.
Example: `Views/Partials/BlockList/Components/MyElementTypeAliasOfContent.cshtml`.

A Partial View will receive the model of `Umbraco.Core.Models.Blocks.BlockListItem`. This gives you the option to access properties of the Content and Settings section of your Block.

In the following example of a Partial view for a Block Type, please note that the `MyElementTypeAliasOfContent`and `MyElementTypeAliasOfSettings` should correspond with the selected Element Type Alias for the given model in your case.

Example:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<Umbraco.Cms.Core.Models.Blocks.BlockListItem>;
@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;
@{
    var content = (ContentModels.MyElementTypeAliasOfContent)Model.Content;
    var settings = (ContentModels.MyElementTypeAliasOfSettings)Model.Settings;
}

// Output the value of field with alias 'heading' from the Element Type selected as Content section
<h1>@content.Value("heading")</h1>

```

With ModelsBuilder:

```csharp

// Output the value of field with alias 'heading' from the Element Type selected as Content section
<h1>@content.Heading</h1>

```

<iframe width="800" height="450" title="Working with Block List Editor" src="https://www.youtube.com/embed/ltZTgfIoCtg?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### 2. Build your own rendering

A built-in value converter is available to use the data as you like. Call the `Value<T>` method with a generic type of `IEnumerable<BlockListItem>` and the stored value will be returned as a list of `BlockListItem` entities.

Example:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage;
@using Umbraco.Cms.Core.Models.Blocks;
@{
    var blocks = Model.Value<IEnumerable<BlockListItem>>("myBlocksProperty");
    foreach (var block in blocks)
    {
        var content = block.Content;

        @Html.Partial("MyFolderOfBlocks/" + content.ContentType.Alias, block)
    }
}
```

Each item is a `BlockListItem` entity that contains two main properties `Content` and `Settings`. Each of these is a `IPublishedElement` which means you can use all the value converters you are used to using.

Example:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage;
@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;
@using Umbraco.Cms.Core.Models.Blocks;
@{
    var blocks = Model.Value<IEnumerable<BlockListItem>>("myBlocksProperty");
    foreach (var block in blocks)
    {
        var content = (ContentModels.MyAliasOfContentElementType)block.Content;
        var settings = (ContentModels.MyAliasOfSettingsElementType)block.Settings;

        <h1>@content.MyExampleHeadlinePropertyAlias</h1>
    }
}
```

## Extract Block Grid Content data

In some cases, you might want to use the Block List Editor to hold some data and not necessarily render a view since the data should be presented in different areas on a page.
An example could be a product page with variants stored in a Block List Editor.

In this case, you can extract the variant's data using the following, which returns `IEnumerable<IPublishedElement>`.

Example:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage;
@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;
@using Umbraco.Cms.Core.Models.Blocks;
@{
    var variants = Model.Value<IEnumerable<BlockListItem>>("variants").Select(x => x.Content);
    foreach (var variant in variants)
    {
        <h4>@variant.Value("variantName")</h4>
        <p>@variant.Value("description")</p>
    }
}
```

If using ModelsBuilder the example can be simplified:

Example:

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage
@using ContentModels = Umbraco.Web.PublishedModels;
@{
    var variants = Model.Variants.Select(x => x.Content).OfType<ProductVariant>();
    foreach (var variant in variants)
    {
        <h4>@variant.VariantName</h4>
        <p>@variant.Description</h4>
    }
}
```

If you know the Block Grid Editor only uses a single block, you can cast the collection to a specific type `T` using `.OfType<T>()` otherwise the return value will be `IEnumerable<IPublishedElement>`.


## Write a Custom Layout Stylesheet

The default layout is arranged by CSS Grid, this can be modified or completely replaced to fit your use case.

### Adjusting Layout Stylesheet


### Write a new Layout Stylesheet


## Build a Custom Backoffice View

Building Custom Views for Block representations in Backoffice is the same for all Block Editors.
[Read about building a Custom View for Blocks here](../Block-Editor/build-custom-view-for-blocks.md)


## Creating Block Grid programmatically

> TODO: have someone with C# expertise writting this part.

In this example, we will be creating some Block List objects under the `People` property in the `Home` Document Type. The `People` property implements a Block List Data Type where a `Person` Document Type can be created. The `Person` Document Type has two properties - `user_name` and `user_email`.

The approach to saving Blocklist content programmatically is similar to Nested Content - though the JSON schema is a bit different.

The JSON object we will pass into the `People` property will look like this:

```json
{
   "layout":{
      "Umbraco.BlockList":[
         {
            "contentUdi":"umb://element/0da576e5fc7445bd9d789c5ee9fe9c54",
            "settingsUdi":"umb://element/7073a102dbcc487986962a3d51820de7"
         },
         {
            "contentUdi":"umb://element/c6e23e8137d24b409bb5ef41bdb705b9",
            "settingsUdi":"umb://element/0467ceb158cc49a1acfd1516f63eccf6"
         }
      ]
   },
   "contentData":[
      {
         "contentTypeKey":"aca1158a-bad0-49fc-af6e-365c40683a92",
         "udi":"umb://element/0da576e5fc7445bd9d789c5ee9fe9c54",
         "user_name":"Janice",
         "user_email":"janice@janiceindustries.com"
      },
      {
         "contentTypeKey":"aca1158a-bad0-49fc-af6e-365c40683a92",
         "udi":"umb://element/c6e23e8137d24b409bb5ef41bdb705b9",
         "user_name":"John",
         "user_email":"john@johnindustries.com"
      }
   ],
   "settingsData":[
      {
         "contentTypeKey":"aca1158a-bad0-49fc-af6e-365c40683a92",
         "udi":"umb://element/7073a102dbcc487986962a3d51820de7",
         "role":"content editor"
      },
      {
         "contentTypeKey":"aca1158a-bad0-49fc-af6e-365c40683a92",
         "udi":"umb://element/0467ceb158cc49a1acfd1516f63eccf6",
         "role":"admin"
      }
   ]
}
```

We will be adding two people in `contentData` , whose `udi` values have to be referenced in the `layout` up above.
The `contentTypeKey` is in this context the Key value of the Document Type we are using in the Block List (`Person`), and the `udi` we will generate manually.

One of the approaches would be creating a basic model which we will later serialize into JSON:

```csharp
using Newtonsoft.Json;
using System.Collections.Generic;
//this class is used to mock the correct JSON structure when the object is serialized
public class Blocklist
{
    public BlockListUdi layout { get; set; }
    public List<Dictionary<string, string>> contentData { get; set; }
    public List<Dictionary<string, string>> settingsData { get; set; }
}
//this is a subclass which corresponds to the "Umbraco.BlockList" section in JSON
public class BlockListUdi
{
    //we mock the Umbraco.BlockList name with JsonPropertyAttribute to match the requested JSON structure
    [JsonProperty("Umbraco.BlockList")]
    public List<Dictionary<string, string>> contentUdi { get; set; }
    //we do not serialize settingsUdi
    [JsonIgnore]
    public List<Dictionary<string, string>> settingsUdi { get; set; }
    public BlockListUdi(List<Dictionary<string, string>> items, List<Dictionary<string, string>> settings)
    {
        this.contentUdi = items;
        this.settingsUdi = settings;
    }
}
//this is our Blocklist's allowed nested element. We make a model for it so we can create some dummy data
public class Person
{
    public string user_name { get; set; }
    public string user_email { get; set; }
    public Person(string user_name, string user_email)
    {
        this.user_name = user_name;
        this.user_email = user_email;
    }
}
```

After injecting [ContentService](../../../../../Reference/Management/Services/ContentService/) and [ContentTypeService](../../../../../Reference/Management/Services/ContentTypeService/), we can do the following:

```csharp
            @using Umbraco.Cms.Core.Services;
            @using Umbraco.Cms.Core;
            @using Umbraco.Cms.Core.Models;
            @inject IContentService Services;
            @inject IContentTypeService _contentTypeService;

           //if the class containing our code inherits SurfaceController, UmbracoApiController, or UmbracoAuthorizedApiController, we can get ContentService from Services namespace
            var contentService = Services;
            //not to be confused with ContentService, this service will be useful for getting some Document Type IDs
            IContentTypeService contentTypeService = _contentTypeService;
            //we are creating two people to be added to Blocklist, which means we need two new Guids
            GuidUdi contentUdi1 = new GuidUdi("element", System.Guid.NewGuid());
            //Since these will be BLock List objects the Guids need to mention the "element" keyword  
            GuidUdi contentUdi2 = new GuidUdi("element", System.Guid.NewGuid());
            //We need to do something similar for the settings data
            GuidUdi settingsUdi1 = new GuidUdi("element", System.Guid.NewGuid());
            GuidUdi settingsUdi2 = new GuidUdi("element", System.Guid.NewGuid());
            //using Content Service, we create a new root node with the name Home and Document Type home
            IContent request = contentService.Create(nodeName, -1, "home", -1);
            //we create some dummy users
            Person person1 = new Person("Janice", "janice@janiceindustries.com");
            Person person2 = new Person("John", "john@johnindustries.com");
            //initialize our new empty model to mimic proper JSON structure
            Blocklist blocklistNew = new Blocklist();
            //initialize empty person list where we will add our users
            var personList = new List<Dictionary<string, string>>();
            //initalize empty settings list as well
            var settingsList = new List<Dictionary<string, string>>();
            //we get the Content Types to later get the Person Document Type key from
            var contentTypes = contentTypeService.GetAll();
            //using the above types, we locate the one that corresponds to the Person Document Type
            var personType = contentTypes.Where(n => n.Alias == "person").FirstOrDefault();
            //the dictionaryUdi list here will be passed in the first section of our final JSON object
            var dictionaryUdi = new List<Dictionary<string, string>>();
            //we also initialize a List for settings configuration
            var settingUdi = new List<Dictionary<string, string>>();
            //add person1
            personList.Add(new Dictionary<string, string>
            {
                //we need to pass the key of the Block List item type, we used ContentTypeService to obtain it
                {"contentTypeKey", personType.Key.ToString()},  
                //each item should also have a unique udi. We are passing the one we generated before
                {"udi", contentUdi1.ToString()},  
                //Document Type custom property
                {"user_name", person1.user_name},  
                //Document Type custom property
                {"user_email", person1.user_email}
            });
            settingsList.Add(new Dictionary<string, string>
            {
                //in this case the settings is set to use the contentTypeKey as the content - Person document type
                {"contentTypeKey", personType.Key.ToString()},
                {"udi", settingsUdi1.ToString()},
                //role is our setting for this blocklist - not a property for the actual content
                {"role", "content editor"}
            });
            //with person 1 added to the contentData section of our JSON, we also add a reference to layout section
            dictionaryUdi.Add(new Dictionary<string, string> { { "contentUdi", contentUdi1.ToString() }, { "settingsUdi", settingsUdi1.ToString() } });
            //add person2
            personList.Add(new Dictionary<string, string>
            {
                {"contentTypeKey", personType.Key.ToString()},
                {"udi", contentUdi2.ToString()},
                {"user_name", person2.user_name},
                {"user_email", person2.user_email}
            });
            settingsList.Add(new Dictionary<string, string>
            {
                {"contentTypeKey", personType.Key.ToString()},
                {"udi", settingsUdi2.ToString()},
                {"role", "admin"}
            });
            dictionaryUdi.Add(new Dictionary<string, string> { { "contentUdi", contentUdi2.ToString() }, { "settingsUdi", settingsUdi2.ToString() } });

            //first section of JSON must contain udi references to whatever is in contentData
            blocklistNew.layout = new BlockListUdi(dictionaryUdi, settingUdi);
            //contentData is a list of our Person objects
            blocklistNew.contentData = personList;
            //we bind the previously made settings list to our model to be serialized
            blocklistNew.settingsData = settingsList;
            //bind the serialized JSON data to our property alias, "people"
            request.SetValue("people", JsonConvert.SerializeObject(blocklistNew));
            //save and publish the node
            contentService.SaveAndPublish(request);
```

When adding several items, it is important that each item added in `contentData` section has the corresponding Udi mentioned in the `layout` section as well - otherwise the item will not show.
