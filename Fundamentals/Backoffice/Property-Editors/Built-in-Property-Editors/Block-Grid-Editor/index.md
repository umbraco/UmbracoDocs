---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Block Grid

`Alias: Umbraco.BlockGrid`

`Returns: BlockGridModel`

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

Rendering the stored value of your **Block Grid** property can be done in two ways.

### 1. Default rendering

You can choose to use the built-in rendering mechanism for rendering blocks using a partial view for each block.

The default rendering method is named `GetBlockGridHtmlAsync()` and comes with a few options to go with it. The typical use could be:

```csharp
@await Html.GetBlockGridHtmlAsync(Model, myGrid")
```

Where `"myGrid"` is the alias of the Block Grid editor.

If you are using ModelsBuilder, the example can be simplified:

Example:

```csharp
@await Html.GetBlockGridHtmlAsync(Model.MyGrid)
```

To make this work you will need to create a partial view for each block type. The partial view must be named by the alias of the Element Type that is being used as Content Model for the block type.

These partial views must be placed in this folder: `Views/Partials/BlockGrid/Components/`.
Example: `Views/Partials/BlockGrid/Components/MyElementTypeAliasOfContent.cshtml`.

The partial views will receive a model of type `Umbraco.Core.Models.Blocks.BlockGridItem`. This model contains the `Content` and `Settings` parts of your block, as well as the configured `RowSpan`, `ColumnSpan` and `Areas` of the block..

#### Rendering the block areas

> TODO: align area semantics when the rest of the article is written

The partial view for the block is responsible for rendering its own block areas. This is done using another built-in rendering mechanism:

```csharp
@await Html.GetBlockGridItemAreasHtmlAsync(Model)
```

Once again you will need to create a partial view for each block type within the block area, named by the alias of the Element Type that is being used as Content Model for the block type.

These partial views must be placed in the same folder as before (_Views/Partials/BlockGrid/Components/_), and will also receive a model of type `Umbraco.Core.Models.Blocks.BlockGridItem`.

#### Putting it all together

The following is an example of a partial view for a block type. Please note that the `MyElementTypeAliasOfContent`and `MyElementTypeAliasOfSettings` should correspond with the selected Element Type aliases for the given content and settings types in your block.

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<Umbraco.Cms.Core.Models.Blocks.BlockGridItem>;
@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;
@{
    var content = (ContentModels.MyElementTypeAliasOfContent)Model.Content;
    var settings = (ContentModels.MyElementTypeAliasOfSettings)Model.Settings;
}

@* Render the value of field with alias 'heading' from the Element Type selected as Content section *@
<h1>@content.Value("heading")</h1>

@* Render the block areas *@
@await Html.GetBlockGridItemAreasHtmlAsync(Model)
```

Again you can simplify the property rendering using ModelsBuilder:

```csharp
@* Render the value of field with alias 'heading' from the Element Type selected as Content section *@
<h1>@content.Heading</h1>
```

### 2. Build your own rendering

The built-in value converter for Block Grid lets you use the block data as you like. Call the `Value<T>` method with a type of `BlockGridModel` to have the stored value will be returned as a `BlockGridModel` instance.

`BlockGridModel` contains the block grid configuration (i.e. number of columns as `GridColumns`) whilst also being an implementation of `IEnumerable<BlockGridItem>` (see details for `BlockGridItem` above).

The following example mimics the built-in rendering mechanism for rendering blocks using partial views:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@using Umbraco.Cms.Core.Models.Blocks
@{
    var grid = Model.Value<BlockGridModel>("myGrid");

    // get the number of columns defined for the grid
    var gridColumns = grid.GridColumns;

    // iterate the block items
    foreach (var item in grid)
    {
        var content = item.Content;

        @await Html.PartialAsync("PathToMyFolderOfPartialViews/" + content.ContentType.Alias, item);
    }
}
```

If you don't want to use partial views, you can access the block item data directly within your rendering:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@using Umbraco.Cms.Core.Models.Blocks
@{
    var grid = Model.Value<BlockGridModel>("myGrid");

    // get the number of columns defined for the grid
    var gridColumns = grid.GridColumns;

    // iterate the block items
    foreach (var item in grid)
    {
        // get the content and settings of the block
        var content = item.Content;
        var settings = item.Settings;
        // get the areas of the block
        var areas = item.Areas;
        // get the dimensions of the block
        var rowSpan = item.RowSpan;
        var columnSpan = item.ColumnSpan;

        // render the block data
        <div style="background-color: #@(settings.Value<string>("color"))">
            <h2>@(content.Value<string>("title"))</h2>
            <span>This block is supposed to span <b>@rowSpan rows</b> and <b>@columnSpan columns</b></span>
        </div>
    }
}
```

## Write a Custom Layout Stylesheet

The default layout is arranged by CSS Grid, this can be modified or completely replaced to fit your use case.

### Adjusting Layout Stylesheet


### Write a new Layout Stylesheet


## Build a Custom Backoffice View

Building Custom Views for Block representations in Backoffice is the same for all Block Editors.
[Read about building a Custom View for Blocks here](../Block-Editor/build-custom-view-for-blocks.md)


## Creating Block Grid programmatically

In this example, we will be creating "spot" blocks in a Block Grid on a content item. The spot content consists of a _title_ and a _text_ field, while the spot settings contains a _featured_ checkbox.

The raw input data for the spots looks like this:

```csharp
new[]
{
    new { Title = "Item one", Text = "This is item one", Featured = false, ColumnSpan = 12, RowSpan = 1 },
    new { Title = "Item two", Text = "This is item two", Featured = true, ColumnSpan = 6, RowSpan = 2 }
}
```

The resulting JSON object stored for the Block Grid will look like this:

```json
{
    "layout": {
        "Umbraco.BlockGrid": [{
                "contentUdi": "umb://element/bb23fe28160941efa506da7aa314172d",
                "settingsUdi": "umb://element/9b832ee528464456a8e9a658b47a9801",
                "areas": [],
                "columnSpan": 12,
                "rowSpan": 1
            }, {
                "contentUdi": "umb://element/a11e06ca155d40b78189be0bdaf11c6d",
                "settingsUdi": "umb://element/d182a0d807fc4518b741b77c18aa73a1",
                "areas": [],
                "columnSpan": 6,
                "rowSpan": 2
            }
        ]
    },
    "contentData": [{
            "contentTypeKey": "0e9f8609-1904-4fd1-9801-ad1880825ff3",
            "udi": "umb://element/bb23fe28160941efa506da7aa314172d",
            "title": "Item one",
            "text": "This is item one"
        }, {
            "contentTypeKey": "0e9f8609-1904-4fd1-9801-ad1880825ff3",
            "udi": "umb://element/a11e06ca155d40b78189be0bdaf11c6d",
            "title": "Item two",
            "text": "This is item two"
        }
    ],
    "settingsData": [{
            "contentTypeKey": "22be457c-8249-42b8-8685-d33262f7ce2a",
            "udi": "umb://element/9b832ee528464456a8e9a658b47a9801",
            "featured": "0"
        }, {
            "contentTypeKey": "22be457c-8249-42b8-8685-d33262f7ce2a",
            "udi": "umb://element/d182a0d807fc4518b741b77c18aa73a1",
            "featured": "1"
        }
    ]
}
```

In other words: For each item in the raw data we need to create:

- One _contentData_ entry with the _title_ and _text_.
- One _settingsData_ entry with the _featured_ value (note that checkbox expects `"0"` or `"1"` as data value).
- One _layout_ entry with the desired column and row spans.

All _contentData_ and _layoutData_ entry need their own unique `Udi` as well as the ID (key) of their corresponding Element Types. In this sample we have only one Element Type for content (`spotElementType`) and one for settings (`spotSettingsType`), but in a real life scenario there could be any number of Element Type combinations.

First and foremost we need models to transform the raw data into Block Grid compatible JSON:

```csharp
using Newtonsoft.Json;
using Umbraco.Cms.Core;

namespace My.Site.Models;

// this is the "root" of the block grid data
public class BlockGridData
{
    public BlockGridData(BlockGridLayout layout, BlockGridElementData[] contentData, BlockGridElementData[] settingsData)
    {
        Layout = layout;
        ContentData = contentData;
        SettingsData = settingsData;
    }

    [JsonProperty("layout")]
    public BlockGridLayout Layout { get; }

    [JsonProperty("contentData")]
    public BlockGridElementData[] ContentData { get; }

    [JsonProperty("settingsData")]
    public BlockGridElementData[] SettingsData { get; }
}

// this is a wrapper for the block grid layout, purely required for correct serialization
public class BlockGridLayout
{
    public BlockGridLayout(BlockGridLayoutItem[] layoutItems) => LayoutItems = layoutItems;

    [JsonProperty("Umbraco.BlockGrid")]
    public BlockGridLayoutItem[] LayoutItems { get; }
}

// this represents an item in the block grid layout collection
public class BlockGridLayoutItem
{
    public BlockGridLayoutItem(Udi contentUdi, Udi settingsUdi, int columnSpan, int rowSpan)
    {
        ContentUdi = contentUdi;
        SettingsUdi = settingsUdi;
        ColumnSpan = columnSpan;
        RowSpan = rowSpan;
    }

    [JsonProperty("contentUdi")]
    public Udi ContentUdi { get; }

    [JsonProperty("settingsUdi")]
    public Udi SettingsUdi { get; }

    [JsonProperty("areas")]
    // areas are omitted from this sample for abbreviation
    public object[] Areas { get; } = { };

    [JsonProperty("columnSpan")]
    public int ColumnSpan { get; }

    [JsonProperty("rowSpan")]
    public int RowSpan { get; }
}

// this represents an item in the block grid content or settings data collection
public class BlockGridElementData
{
    public BlockGridElementData(Guid contentTypeKey, Udi udi, Dictionary<string, object> data)
    {
        ContentTypeKey = contentTypeKey;
        Udi = udi;
        Data = data;
    }

    [JsonProperty("contentTypeKey")]
    public Guid ContentTypeKey { get; }

    [JsonProperty("udi")]
    public Udi Udi { get; }

    [JsonExtensionData]
    public Dictionary<string, object> Data { get; }
}
```

Now by injecting [ContentService](../../../../../Reference/Management/Services/ContentService/) and [ContentTypeService](../../../../../Reference/Management/Services/ContentTypeService/) into an API controller, we can transform our raw data into Block Grid JSON and save it to our target content item:

```csharp
using Microsoft.AspNetCore.Mvc;
using My.Site.Models;
using Newtonsoft.Json;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Web.Common.Controllers;

namespace My.Site.Controllers;

public class BlockGridTestController : UmbracoApiController
{
    private readonly IContentService _contentService;
    private readonly IContentTypeService _contentTypeService;

    public BlockGridTestController(IContentService contentService, IContentTypeService contentTypeService)
    {
        _contentService = contentService;
        _contentTypeService = contentTypeService;
    }

    // POST: /umbraco/api/blockgridtest/create
    [HttpPost]
    public ActionResult Create()
    {
        // get the item content to modify
        IContent? content = _contentService.GetById(1203);
        if (content == null)
        {
            return NotFound("Could not find the content item to modify");
        }

        // get the element types for spot blocks (content and settings)
        IContentType? spotContentType = _contentTypeService.Get("spotElement");
        IContentType? spotSettingsType = _contentTypeService.Get("spotSettings");
        if (spotContentType == null || spotSettingsType == null)
        {
            return NotFound("Could not find one or more content types for block data");
        }

        // this is the raw data to insert into the block grid
        var rawData = new[]
        {
            new { Title = "Item one", Text = "This is item one", Featured = false, ColumnSpan = 12, RowSpan = 1 },
            new { Title = "Item two", Text = "This is item two", Featured = true, ColumnSpan = 6, RowSpan = 2 }
        };

        // build the individual parts of the block grid data from the raw data
        var layoutItems = new List<BlockGridLayoutItem>();
        var spotContentData = new List<BlockGridElementData>();
        var spotSettingsData = new List<BlockGridElementData>();
        foreach (var data in rawData)
        {
            // generate new UDIs for block content and settings
            var contentUdi = Udi.Create(Constants.UdiEntityType.Element, Guid.NewGuid());
            var settingsUdi = Udi.Create(Constants.UdiEntityType.Element, Guid.NewGuid());

            // create a new layout item
            layoutItems.Add(new BlockGridLayoutItem(contentUdi, settingsUdi, data.ColumnSpan, data.RowSpan));

            // create new content data
            spotContentData.Add(new BlockGridElementData(spotContentType.Key, contentUdi, new Dictionary<string, object>
            {
                { "title", data.Title },
                { "text", data.Text },
            }));

            // create new settings data
            spotSettingsData.Add(new BlockGridElementData(spotSettingsType.Key, settingsUdi, new Dictionary<string, object>
            {
                { "featured", data.Featured ? "1" : "0" },
            }));
        }

        // construct the block grid data from layout, content and settings
        var blockGridData = new BlockGridData(
            new BlockGridLayout(layoutItems.ToArray()),
            spotContentData.ToArray(),
            spotSettingsData.ToArray());

        // serialize the block grid data as JSON and save it to the "blockGrid" property on the content item
        var propertyValue = JsonConvert.SerializeObject(blockGridData);
        content.SetValue("blockGrid", propertyValue);
        _contentService.Save(content);

        return Ok("Saved");
    }
}
```
