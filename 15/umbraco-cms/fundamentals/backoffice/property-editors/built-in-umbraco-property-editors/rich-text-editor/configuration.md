# Configuration

In this article you can learn about the various ways you can configure the Rich Text Editor.

## Toolbar

You have full control over which options should be available on the RTE.

![Toolbar: All options enabled](../../built-in-property-editors/rich-text-editor/images/toolbar-full-11.png)

In the examble above, all 34 options have been enabled. The options include copy/paste buttons, font styles like bold and italics, bullet lists and options to embed videos and insert images.

## Stylesheets

It is possible to define specific styles that can be used when editing content using the RTE. You can use as many of these styles with the RTE as you want.

The RTE styles are defined in CSS files which can be created in the **Settings** section. Read the [RTE Styles](rte-styles.md) article to learn more about this feature.

## Dimensions

Define `height` and `width` of the editor displayed in the content section.

## Maximum size for inserted images

Define the maximum size for images added through the Rich Text Editor.

If inserted images are larger than the dimensions defined here, the images will be resized automatically.

## Mode

The Rich Text Editor comes in two different modes: Classic and Inline.

### Classic

The default mode which displays the toolbar at the top.

![RTE Mode: Classic](../../built-in-property-editors/rich-text-editor/images/rte-mode-classic-11.png)

### Inline

In this mode the toolbar is hidden, and only shows up when content in the editor is highlighted.

![Rich Text Editor Inline mode](../../built-in-property-editors/rich-text-editor/images/inline-mode-new.png)

## Blocks

Blocks can be added as elements in the Rich Text Editor. Configuration and rendering of Blocks is described in the [Blocks in Rich Text Editor](rte-blocks.md) article.

## Overlay Size

Select the width of the link picker overlay. The overlay size comes in three sizes: Small, Medium, and Large.

## Hide Label

When this option is checked the label and description for the RTE property will be hidden.

## Ignore User Start Nodes

Some of the backoffice users might be restricted to a specific part of the content tree. When the "Ignore User Start Nodes" is checked, the users can pick any piece of content from the content tree, when adding internal links through the RTE.

## Image Upload Folder

Images added through the RTE is by default added to the root of the Media library.

Sometimes you might want to add the images to a specific folder. This folder can be configured using the "Image Upload Folder" setting.
