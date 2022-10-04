---
versionFrom: 10.0.0
---

# Block Grid

`Alias: Umbraco.BlockGrid`

`Returns: BlockGridModel`

The **Block Grid** enables the editor to layout their content in the Umbraco backoffice. The content is made of blocks, which can contain different types of data.

## Configure the Block Grid

The Block Grid property editor is configured via the Data Types backoffice interface.

To set up your Block Grid Editor property, follow these steps:

1. Navigate to the **Settings** section in the Umbraco backoffice.
2. Locate and right-click the **Data Types** folder.
3. **Create a new Data Type**.
4. Select **Block Grid** from the list of available property editors.

You will see the configuration options for a Block Grid as shown below.

![Block Grid - Data Type Definition](images/BlockListEditor_DataType.jpg)
> TODO: screenshot

The Data Type editor allows you to configure the following properties:

- **Blocks** - Define the Block Types to be available for use in the property. Read more on how to set up Block Types below.
- **Amount** - Sets the minimum and/or the maximum number of blocks that should be allowed at the root of the layout.
- **Live editing mode** - Enabling this will enable you to see the changes you make as you are making them.
- **Editor width** - Overwrite the width of the property editor. This field takes any valid CSS value for "max-width". Like 100% or 800px.
- **Grid Columns** - Define the number of columns in your grid layout. The default is 12 columns.
- **Layout Stylesheet** - Replace the built-in Layout Stylesheet. Additionally, you can retrieve the default layout stylesheet to use as a base for your own or inspiration for writing your own.
- **Create Button Label** - Overwrite the label of the create button.

## Setup Block Types

Block Types are based on **Element Types**. These can be created beforehand or while setting up your Block Types.

Once you have added an Element Type as a Block Type on your Block Grid Data Type you have the option to configure it.

![Block List - Data Type Block Configuration](images/BlockListEditor_DataType_Blocks.png)
> TODO: screenshot

### Groups

Blocks can also be grouped, this will be visible in the Block Catalogue. This can also be used to allow a group of Blocks in a Area.

## Block Configuration

Each Block has a set of properties that are optional to configure. These are described below.

### General

Customize the user experience for your content editors when they work with the blocks in the Content section.

- **Label** - Define a label for the appearance of the Block in the editor. The label can use AngularJS template-string-syntax to display values of properties.

  :::tip
  Label example: "My Block {{myPropertyAlias}}" will be shown as: "My Block FooBar".
  
  You can also use more advanced expression using AngularJS filters, like `{{myPropertyAlias | limitTo:100}}` or for a property using Richtext editor `{{myPropertyAlias | ncRichText | truncate:true:100}}`. It is also possible to use properties from the Settings model by using `{{$settings.propertyAlias}}`.

  Get more tips on how to use AngularJS filters in Umbraco CMS in this community-made [Umbraco AngularJS filter cheat sheet](https://joe.gl/ombek/blog/umbraco-angularjs-filter-cheat-sheet/).
  :::

- **Content model** - This presents the Element Type used as model for the Content section of this Block. This cannot be changed, but you can open the Element Type to perform edits or view the properties available. Useful when writing your Label.
- **Settings model** - Add a Settings section to your Block based on a given Element Type. When selected you can open the Element Type or choose to remove the Settings section again.

### Size options

Customize the Blocks size in the Grid, if you define multiple options the Block becomes scalable.

By default a Block takes up the full-width of the content. 

There are two ways a Block can become smaller:

1: When a Block is placed in a Area it will fit to the Areas width. [Learn more about Areas below](#areas).
2. A Block can have one or more Column Span options defined. 

A Column Span option is used to define the width of a Block. With multiple Column Span options defined, the Content Editor can scale the Block to fit specific needs.

> TODO: Perhaps an animated gif showing a block being resized to different widths in an area can help explain this text more visually for the visual learners like myself

Additionally, Blocks can be configured to span rows, this enables one Block to be placed next to a few rows containing other blocks.

- **Available column spans i** - Define one or more columns this Block spans across. Example in a 12 columns grid, 6 columns is equivalent to half width. By enabling 6 columns and 12 columns, the Block can be scaled to either be half width or full width.
- **Available row spans i** - Define the amount of rows this Block spans across.

### Catalogue appearance

These properties refer to how the Block is presented in the Block catalogue when editors choose which Blocks to use for their content.

- **Background color** - Define a background color to be displayed beneath the icon or thumbnail. Example: `#424242`.
- **Icon color** - Change the color of the Element Type icon. Example: `#242424`.
- **Thumbnail** - Pick an image or Scalable Vector Graphics (SVG) file to replace the icon of this Block in the catalogue.

The thumbnails for the catalogue are presented in the format of 16:10, and we recommend a resolution of 400px width and 250px height.

### Allowance

- **Allow in root color** - Determine wether this Block can be created in the root of your layout.
- **Allow in area** - Determine wether this Block can be created inside Areas of other Blocks.

### Areas

Blocks can nest other Blocks to support specific compositions. These compositions can be used as layout for other Blocks.

To achieve nesting, a Block must have one or more Areas defined. Each Area can contain one or more Blocks.

The each area has a size, defined by column and rows spans. The grid for the Areas are based on the same amount of columns as your root grid, unless you choose to change it

To scale an Area, click and drag the little scale-button in the bottom-right corner with your mouse.

- **Grid Columns for Areas** - Overwrite the amount of columns used for the grid of Areas.
- **Allow in area** - Determine wether this Block can be created inside Areas of other Blocks.

### Area configuration

> Missing screenshot of Area configuration

**MISSING DESCRIPTION OF AREA CONFIG**
Mention that the alias can be used to target this Area via the Layout Stylesheet.

**Create Button Label** is to overwrite the Create Button Label of that Area.

**Number of blocks** is for the total amount of Blocks in the Area.

**TODO...**
Mention that you can pick groups for allowance, in that case the required number is for Blocks of the group.
Mention that you can pick individual Blocks, this Block can be picked and will be valid though its not allow for Areas.
Individual Block validation(required number) is just for that block-type.

### Advanced

These properties are relevant when you working with custom views or complex projects.

- **Custom view** - Overwrite the AngularJS view for the block presentation in the Content editor. Use this to make a more visual presentation of the block or make your own editing experience by adding your own AngularJS controller to the view.

- **Custom stylesheet** - Pick your own stylesheet to be used for this block in the Content editor. By adding a stylesheet the styling of this block will become scoped. This means that the default backoffice styles are no longer present for the view of this block.

- **Overlay editor size** - Set the size for the Content editor overlay for editing this block.

- **Hide content editor** - Hide the UI for editing the content in a Block Editor. This is only relevant if you made a custom view that provides the UI for editing of content.

## Editing Blocks

When viewing a **Block Grid** editor in the Content section for the first time, you will be presented with the option to Add content.

![Block List - Add Content](images/BlockListEditor_AddContent.png)
> TODO: screenshot

Clicking the Add content button brings up the **Block Catalogue**.

![Block List - Setup](images/BlockListEditor_BlockPicker_simplesetup.jpg)
> TODO: screenshot

The Block Catalogue looks different depending on the amount of available Blocks and their catalogue appearance.

![Block List - example setup from Umbraco.com](images/BlockListEditor_BlockPicker.jpg)
> TODO: screenshot

Click the Block Type you wish to create and a new Block will appear in the layout.

More Blocks can be added to the layout by clicking the Add content button. Alternatively, use the Add content button that appears on hover to add new blocks between, besides or above existing Blocks.

![Block List - Add Content](images/BlockListEditor_AddContentInline.jpg)
> TODO: screenshot

To delete a Block click the trashbin icon whichs appears on hover.

## Sorting Blocks

Blocks can be rearranged using the click and drag feature. Move them up or down to place them in the desired order.

Moving a Block from one Area to another is done in the same way. If a Blocks is not allowed in the given position the area will display red and neglect the new position.

> TODO: Screenshot of red overlay when trying to drop a Block in a disallowed area.

## Rendering Block Grid Content

Rendering the stored value of your **Block Grid** property can be done in two ways: 

1. [Default rendering](#1-default-rendering)
2. [Build your own rendering](#2-build-your-own-rendering)

### 1. Default rendering

You can choose to use the built-in rendering mechanism for rendering blocks using a Partial View for each block.

The default rendering method is named `GetBlockGridHtmlAsync()` and comes with a few options.

Example use-case:

```csharp
@await Html.GetBlockGridHtmlAsync(Model, "myGrid")
```

In the sample above `"myGrid"` is the alias of the Block Grid editor.

If you are using ModelsBuilder, the example will look like this:

Example:

```csharp
@await Html.GetBlockGridHtmlAsync(Model.MyGrid)
```

To use the `GetBlockGridHtmlAsync()` method you will need to create a Partial View for each Block Type. The Partial View must be named using the alias of the Element Type that is being used as Content Model for the Block Type.

These Partial View files need to go into the `Views/Partials/BlockGrid/Components/` folder.

Example: `Views/Partials/BlockGrid/Components/MyElementTypeAliasOfContent.cshtml`.

The Partial Views will receive a model of type `Umbraco.Core.Models.Blocks.BlockGridItem`. This model contains `Content` and `Settings` from your block, as well as the configured `RowSpan`, `ColumnSpan`, `ForceLeft`, `ForceRight` and `Areas` of the block.

#### Rendering the block areas

The Partial View for the block is responsible for rendering its own Block Areas. This is done using another built-in rendering mechanism:

```csharp
@await Html.GetBlockGridItemAreasHtmlAsync(Model)
```

Here you will need to create a Partial View for each Block Type within the Block Area. For the name, use the alias of the Element Type that is being used as Content Model for the Block Type.

These Partial Views must be placed in the same folder as before, (`Views/Partials/BlockGrid/Components/`), and will receive a model of type `Umbraco.Core.Models.Blocks.BlockGridItem`.

#### Putting it all together

The following is an example of a Partial View for a Block Type. It is important that the `MyElementTypeAliasOfContent`and `MyElementTypeAliasOfSettings` corresponds with the selected Element Type aliases for the given Content and Settings in your block.

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

You can simplify the property rendering using ModelsBuilder by replacing `@content.Value("heading")` with `@content.Heading`.

### 2. Build your own rendering

The built-in value converter for the Block Grid lets you use the block data as you like. Call the `Value<T>` method with a type of `BlockGridModel` to have the stored value returned as a `BlockGridModel` instance.

`BlockGridModel` contains the Block Grid configuration (like the number of columns as `GridColumns`) whilst also being an implementation of `IEnumerable<BlockGridItem>` (see details for `BlockGridItem` above).

The following example mimics the built-in rendering mechanism for rendering blocks using Partial Views:

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

If you do not want to use Partial Views, you can access the block item data directly within your rendering:

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
        // get forced placement of the block
        var forceLeft = item.ForceLeft;
        var forceRight = item.ForceRight;

        // render the block data
        <div style="background-color: #@(settings.Value<string>("color"))">
            <h2>@(content.Value<string>("title"))</h2>
            <span>This block is supposed to span <b>@rowSpan rows</b> and <b>@columnSpan columns</b></span>
        </div>
    }
}
```

## Write a Custom Layout Stylesheet

The default layout stylesheet and mechanism is using CSS Grid. This can be modified to fit your implementation and your project.

### Adjusting Layout Stylesheet

To make additions or overwrite parts of the default layout stylesheet, importing the default stylesheet in the top of your own file:

```css
@import '/umbraco/assets/css/blockgridlayout.css';

...
```

### Write a new Layout Stylesheet

In this case you would have to write the layout from scratch.

You are free to pick any style, meaning there is no requirement to use CSS Grid. It is, however, recommended to use CSS Grid to ensure complete compatibility with the Umbraco backoffice.

### CSS Class structure and available data

When extending or writing your own layout, you need to know the structure and what data is available.

This can be exemplified by writing out the HTML structure:

```html
<div class="umb-block-grid"
     style="--umb-block-grid--grid-columns: 12;"
>
    
    <!-- Notice this is the same markup used every time we will be printing a list of blocks: -->
    <div class="umb-block-grid__layout-container">

        <!-- repeated for each layout entry -->
        <div
            class="umb-block-grid__layout-item"
            data-content-element-type-alias="MyElementTypeAlias"
            data-content-element-type-key="00000000-0000-0000-0000-000000000000"
            data-element-udi="00000000-0000-0000-0000-000000000000"
            data-col-span="6"
            data-row-span="1"
            ?data-force-left
            ?data-force-right
            style="
            --umb-block-grid--item-column-span: 6;
            --umb-block-grid--item-row-span: 1;
            "
        >

            <!-- Here the Razor View or Custom View for this block will be rendered. -->
            
            <!-- Each razor view must render the 'area-container' them self.
            This can be done by the Razor helper method:

            @await Html.GetBlockGridItemAreasHtmlAsync(Model)

            The structure will be as printed below,
            Do notice targeting the 'area-container' needs a double selector as markup will be different in Backoffice.
            Here is an example of the CSS selector:
                .umb-block-grid__area-container, .umb-block-grid__block--view::part(area-container) {
                    position: relative;
                }
            -->
            <div
                class="umb-block-grid__area-container"
                style="--umb-block-grid--area-grid-columns: 9;"
            >

                <!-- repeated for each area for this block type. -->
                <div
                    class="umb-block-grid__area"
                    data-area-col-span="3"
                    data-area-row-span="1"
                    data-area-alias="MyAreaAlias"
                    style="
                    --umb-block-grid--grid-columns: 3;
                    --umb-block-grid--area-column-span: 3;
                    --umb-block-grid--area-row-span: 1;
                    ">

                        <!-- Notice here we print the same markup as when we print a list of blocks(same as the one in the root of this structure..):
                        <div class="umb-block-grid__layout-container">
                            ...
                        </div>
                        End of notice.  -->
                </div>
                <!-- end of repeat -->

            </div>


        </div>
        <!-- end of repeat -->
        
    </div>

</div>
```

## Build a Custom Backoffice View

Building Custom Views for Block representations in Backoffice is based on the same API for all Block Editors.

[Read about building a Custom View for Blocks here](../Block-Editor/build-custom-view-for-blocks.md)

## Creating a Block Grid programmatically

In this example, we will be creating "spot" blocks in a Block Grid on a content item. The spot content consists of a *titl* and a *text* field, while the spot settings contains a *featured* checkbox.

The raw input data for the spots looks like this:

```csharp
new[]
{
    new { Title = "Item one", Text = "This is item one", Featured = false, ColumnSpan = 12, RowSpan = 1, ForceLeft = false, ForceRight = false },
    new { Title = "Item two", Text = "This is item two", Featured = true, ColumnSpan = 6, RowSpan = 2, ForceLeft = false, ForceRight = false }
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
                "rowSpan": 1,
                "forceLeft": false,
                "forceRight": false
            }, {
                "contentUdi": "umb://element/a11e06ca155d40b78189be0bdaf11c6d",
                "settingsUdi": "umb://element/d182a0d807fc4518b741b77c18aa73a1",
                "areas": [],
                "columnSpan": 6,
                "rowSpan": 2,
                "forceLeft": false,
                "forceRight": false
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

For each item in the raw data we need to create:

- One `contentData` entry with the *title* and *text*.
- One `settingsData` entry with the *featured* value (the checkbox expects `"0"` or `"1"` as data value).
- One `layout` entry with the desired column and row spans.

All `contentData` and `layoutData` entries need their own unique `Udi` as well as the ID (key) of their corresponding Element Types. In this sample we have only one Element Type for content (`spotElementType`) and one for settings (`spotSettingsType`). In a real life scenario there could be any number of Element Type combinations.

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
    public BlockGridLayoutItem(Udi contentUdi, Udi settingsUdi, int columnSpan, int rowSpan, bool forceLeft, bool forceRight)
    {
        ContentUdi = contentUdi;
        SettingsUdi = settingsUdi;
        ColumnSpan = columnSpan;
        RowSpan = rowSpan;
        ForceLeft = forceLeft;
        ForceRight = forceRight;
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

    [JsonProperty("forceLeft")]
    public bool ForceLeft { get; }

    [JsonProperty("forceRight")]
    public bool ForceRight { get; }

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

By injecting [ContentService](../../../../../Reference/Management/Services/ContentService/) and [ContentTypeService](../../../../../Reference/Management/Services/ContentTypeService/) into an API controller, we can transform the raw data into Block Grid JSON. It can then be save to the target content item:

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
            new { Title = "Item one", Text = "This is item one", Featured = false, ColumnSpan = 12, RowSpan = 1, ForceLeft = false, ForceRight = false },
            new { Title = "Item two", Text = "This is item two", Featured = true, ColumnSpan = 6, RowSpan = 2, ForceLeft = false, ForceRight = false }
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
            layoutItems.Add(new BlockGridLayoutItem(contentUdi, settingsUdi, data.ColumnSpan, data.RowSpan, data.ForceLeft, data.ForceRight));

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
