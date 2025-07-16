# Blocks

Blocks enable editors to insert structured content elements directly into the Rich Text Editor. These elements are defined by [Element Types](../../../../../../data/defining-content/#element-types) and can be configured with custom properties, styling, and behavior.

Blocks can be added to the Rich Text Editor when:

-   Block Types are defined as part of the Rich Text Editor Data Type configuration
-   The **Blocks** toolbar option is enabled in the Rich Text Editor

## Configure Blocks

Configure the Blocks functionality through the Rich Text Editor Data Type configuration in the **Settings** section.

1. Navigate to **Settings** > **Data Types**.
2. Select your Rich Text Editor Data Type or create a new one.
3. In the **Available Blocks** section, add the Element Types you want to make available as blocks.
4. Configure each Block Type with the options described below.

_Screenshot placeholder: Rich Text Editor Data Type configuration showing the Available Blocks section_

The Data Type configuration includes these key properties:

-   **Available Blocks** - Define which Block Types are available for use in the Rich Text Editor
-   **Blocks Live editing mode** - Enable real-time editing of blocks directly within the Rich Text Editor

## Setup Block Types

Block Types are Element Types that must be created before configuring them as blocks in the Rich Text Editor. You can create Element Types either:

-   Directly from the Rich Text Editor Data Type setup process
-   Beforehand in the **Settings** > **Document Types** section

Once you add an Element Type as a Block Type, additional configuration options become available:

_Screenshot placeholder: Block Type configuration interface showing the various settings sections_

### Editor Appearance

Configure how blocks appear and behave in the Content section:

-   **Label** - Define how the block appears in the editor. Supports template syntax to display property values (e.g., `{{title}}`)
-   **Display Inline with text** - When enabled, blocks remain inline with surrounding text. When disabled, blocks appear on separate lines
-   **Custom view** - Override the default block presentation with a custom view for enhanced visual representation
-   **Custom stylesheet** - Apply custom CSS styling to the block in the Content editor. This creates a scoped styling environment
-   **Overlay editor size** - Set the size of the editing overlay when editors work with the block content

### Data Models

Configure the content structure for your blocks:

-   **Content model** - The Element Type that defines the main content properties for the block (required)
-   **Settings model** - Optional Element Type that defines additional settings or configuration options for the block

### Catalogue Appearance

Control how blocks appear in the block picker:

-   **Background color** - Background color displayed behind the block icon or thumbnail (e.g., `#424242`)
-   **Icon Color** - Color of the Element Type icon (e.g., `#242424`)
-   **Thumbnail** - Custom image or SVG to replace the default Element Type icon

Block thumbnails should use a 16:10 aspect ratio with a recommended resolution of 400px × 250px.

### Advanced

Additional configuration options for custom implementations:

-   **Force hide content editor** - Hide the default content editor when using custom views that provide their own editing interface

## Working with Blocks

### Adding Blocks to Content

Editors can add blocks to rich text content using the **Blocks** toolbar button:

1. Position the cursor where you want to insert the block
2. Click the **Blocks** button in the Rich Text Editor toolbar
3. Select the desired Block Type from the available options
4. Configure the block content and settings
5. The block appears in the editor as a structured element

_Screenshot placeholder: Rich Text Editor showing the Blocks toolbar button and block picker_

### Editing Blocks

Blocks can be edited in two ways:

-   **Inline editing** - When live editing mode is enabled, blocks are editable directly in the Rich Text Editor
-   **Overlay editing** - Click on a block to open the editing overlay with dedicated forms for content and settings

### Block Positioning

Blocks can be positioned within the rich text content:

-   **Block elements** - Appear on their own line and cannot be mixed with text
-   **Inline block elements** - Can be positioned inline with text and other elements

The positioning behavior depends on the **Display Inline with text** setting in the Block Type configuration.

## Rendering Blocks

To display blocks on the frontend, create Partial Views for each Block Type.

{% hint style="info" %}
Rich Text Editor blocks use a different view location than Block List blocks. RTE blocks are placed in `Views/Partials/RichText/Components/`, while Block List blocks use `Views/Partials/BlockList/Components/`.
{% endhint %}

### File Structure

-   **Location**: `Views/Partials/RichText/Components/`
-   **Naming**: Use the Element Type alias with Pascal case (e.g., `MyBlockType.cshtml`)
-   **Model**: `Umbraco.Cms.Core.Models.Blocks.RichTextBlockItem`

The different folder structure ensures that RTE blocks and Block List blocks can have separate rendering implementations, even when using the same Element Types.

### Example Partial View

For a Block Type with Element Type alias `myBlockType`:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<Umbraco.Cms.Core.Models.Blocks.RichTextBlockItem>

@* Access content properties *@
<div class="my-block">
    <h3>@Model.Content.Value("title")</h3>
    <p>@Model.Content.Value("description")</p>
</div>

@* Access settings properties if available *@
@if (Model.Settings != null)
{
    <div style="background-color: @Model.Settings.Value("backgroundColor")">
        <!-- Additional settings-based rendering -->
    </div>
}
```

### Type-Safe Rendering with Models Builder

When using Models Builder, specify the Content and Settings models for type-safe access:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<Umbraco.Cms.Core.Models.Blocks.RichTextBlockItem<MyBlockType, MyBlockSettingsType>>
@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;

<div class="my-block">
    <h3>@Model.Content.Title</h3>
    <p>@Model.Content.Description</p>
</div>

@if (Model.Settings != null)
{
    <div style="background-color: @Model.Settings.BackgroundColor">
        <!-- Settings-based rendering with strong typing -->
    </div>
}
```

## Best Practices

### Content Design

-   Design blocks for reusable content patterns
-   Keep block content focused on a single purpose
-   Use descriptive labels that help editors understand the block's function

### Performance

-   Avoid creating too many Block Types - this can overwhelm content editors
-   Use appropriate caching strategies for block rendering
-   Consider the impact of complex blocks on editor performance

### Accessibility

-   Ensure block markup follows accessibility guidelines
-   Provide meaningful labels and descriptions
-   Test block rendering with screen readers

## Troubleshooting

### Block Not Appearing

-   Verify the Block Type is added to the Rich Text Editor Data Type
-   Check that the **Blocks** toolbar option is enabled
-   Confirm the Element Type is properly configured

### Rendering Issues

-   Check that the Partial View exists in the correct location (`Views/Partials/RichText/Components/`)
-   Verify the file name matches the Element Type alias
-   Ensure the model inheritance is correct
-   **Important**: Do not confuse RTE block views with Block List views - they use different folder structures

### Common View Location Confusion

If you're familiar with Block List editors, note that Rich Text Editor blocks use a different view location:

-   **Rich Text Editor blocks**: `Views/Partials/RichText/Components/`
-   **Block List blocks**: `Views/Partials/BlockList/Components/`
-   **Block Grid blocks**: `Views/Partials/BlockGrid/Components/`

This separation allows the same Element Type to have different rendering implementations across different block editors.

### Missing Block Data

-   Verify the Element Type properties are correctly mapped
-   Check for any validation errors in the block configuration
-   Confirm the block content has been saved properly

## Build Custom Backoffice Views

For advanced scenarios, create custom views to enhance the block editing experience. This allows for:

-   Custom editing interfaces
-   Enhanced visual previews
-   Integration with external systems
-   Specialized input controls

_Placeholder: This section would benefit from detailed information about the custom view API and implementation examples for the current Tiptap-based architecture._

## Related Articles

-   [Element Types](../../../../../../data/defining-content/#element-types)
-   [Rich Text Editor Configuration](../configuration.md)
-   [Rich Text Editor Extensions](../extensions.md)
