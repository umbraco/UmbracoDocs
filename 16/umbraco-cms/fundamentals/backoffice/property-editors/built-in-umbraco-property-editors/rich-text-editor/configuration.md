# Configuration

In this article you can learn about the different options you have for configuring the Rich Text Editor (RTE).

## Toolbar

You have full control over which options should be available on the RTE.

![Toolbar: All options enabled](images/rte-tiptap-all-toolbar-items.png)

In the example above, all the options have been enabled. These options include font styles like bold and italics, bullet lists, and options to embed videos and insert images.

You can customize the look of the toolbar:

* Enhance the capabilities of the toolbar by enabling or disabling extensions.
* Use the Toolbar designer to group together items and add additional rows if needed.

![Enhance and customize the capabilities of the Rich Text Editor toolbar](images/rte-tiptap-capabilities-and-toolbar.png)

## Statusbar

As well as the toolbar, you can configure extensions for the statusbar.

![Statusbar with Word Count extension enabled](images/rte-tiptap-statusbar.png)

## Stylesheets

To apply custom styles to the Rich Text Editor, you can select from any existing stylesheets.

Stylesheets can be created in the **Settings** section. To learn more about this feature, see the [Stylesheets in the Backoffice](../../../../design/stylesheets-javascript.md) article.

## Dimensions

Define `height` and `width` of the editor displayed in the content section.

## Maximum size for inserted images

Define the maximum size for images added through the Rich Text Editor.

If inserted images are larger than the dimensions defined here, the images will be resized automatically.

## Overlay Size

Select the width of the link picker overlay. The overlay size comes in three sizes: Small, Medium, Large, and Full.

## Available Blocks

Blocks can be added as elements in the Rich Text Editor. Configuration and rendering of Blocks are described in the [Blocks in Rich Text Editor](blocks.md) article.

## Image Upload Folder

Images added through the RTE are by default added to the root of the Media library.

Sometimes you might want to add the images to a specific folder. This folder can be configured using the "Image Upload Folder" setting.

## Ignore User Start Nodes

Some of the backoffice users might be restricted to a specific part of the content tree. When the "Ignore User Start Nodes" is checked, the users can pick any piece of content from the content tree, when adding internal links through the RTE.
