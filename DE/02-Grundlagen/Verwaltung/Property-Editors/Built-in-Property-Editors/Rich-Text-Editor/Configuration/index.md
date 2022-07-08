---
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Rich Text Editor Configuration

The Rich Text Editor (RTE) in Umbraco can be configured in many different ways, and you have full control over which options you want to give you content editors.

In this article you can learn about the various ways you can configure the RTE.

## Toolbar

You have full control over which options should be available on the RTE. 

![Toolbar: All options enabled](images/toolbar-full.png)

In the examble above, all 34 options have been enabled. The options include copy/paste buttons, font styles like bold and italics, bullet lists and options to embed videos and insert images.

## Stylesheets

It is possible to define specific styles that can be used when editing content using the RTE. You can use as many of these styles with the RTE as you want.

The RTE styles are defined in CSS files which can be created in the **Settings** section. Read the [RTE Styles](../RTE-Styles) article to learn more about this feature.

## Dimensions

Define `height` and `width` of the editor displayed in the content section.

## Maximum size for inserted images

Define the maximum size for images added through the Rich Text Editor.

If inserted images are larger than the dimensions defined here, the images will be resized automatically.

## Mode

The Rich Text Editor comes in two different modes: Classic and Distraction Free.

- Classic

    The default mode, which displays the toolbar in the top.

    ![RTE Mode: Classic](images/rte-mode-classic.png)

- Distraction Free

    In this mode the toolbar is hidden, and only shows up when content in the editor is highlighted.

    ![RTE Mode: Distraction Free](images/rte-mode-distractionfree.png)

## Overlay Size

Select the width of the link picker overlay. The overlay size comes in three sizes: Small, Medium, and Large.

## Hide Label

When this option is checked the label and description for the RTE property will be hidden.

## Ignore User Start Nodes

Some of the backoffice users might be restricted to a specific part of the content tree. When the "Ignore User Start Nodes" is checked, the users can pick any piece of content from the content tree, when adding internal links through the RTE.

## Image Upload Folder

Images added through the RTE is by default added to the root of the Media library.

Sometimes you might want to add the images to a specific folder. This folder can be configured using the "Image Upload Folder" setting.
