# Default Document Types

On this page, you will find the default Document Types in Umbraco. If you want to use these document types, you can create them in the Settings section.

![Create Document Type](/15/umbraco-cms/fundamentals/data/images/CreateDoctype.png)

## Document type

Creating a Document Type (without a template) defines the content structure and fields that can be used across different content items. You might use document types without templates to create consistent, structured content that doesn't require a predefined page layout. For example blog posts or product listings.

## Document type with template

Creating document types with templates allows you to define both the content structure and the visual presentation of a particular type of content item. It ensures a consistent and cohesive look and feel across your website while also enabling structured content management. This approach helps separate content from design, making it easier to manage and update your website's content and appearance independently through templates.

## Element Type

An Element Type is a Document Type without a template containing schema configurations for repeating a set of properties. These are for defining schema in the Block List Editor, Block Grid Editor, or other Element Type-based editors.

Element Types cannot be used to create content in the Content tree. When you create an Element type, it automatically sets the **Is Element Type** flag to **True** on the **Permissions** tab.

![Element type](/15/umbraco-cms/fundamentals/data/images/element-type.png)

Element Types are created using the same workflow as regular Document Types but usually contain fewer properties. You can also create Element Types as part of configuring a Block Grid or Block List Data Type.

## Folder

Folders are a special type of Document Type that can be used to organize content in the Content tree. Folders can contain other content items, such as other folders or content nodes. They are useful for organizing content in a logical hierarchy, making it easier to manage and navigate your website's content. They cannot be used to create content displayed on the front end of your website.

## Compositions

Compositions provide a way to create reusable sets of properties that can be added to one or more Document Types. This can help simplify the management and consistency of content types across your website. Compositions can be used to define common properties shared across multiple Document Types, such as metadata fields or social media links.

To get started with compositions, you will first have to create the needed Document Types as described above. Later you can take advantage of nesting and use compositions by clicking on "**Compositions**..." option on the Document Type editor. Here you will be able to select the Document Types you want to use as compositions for the current Document Type. The fields of the selected compositions will hereafter be available on the current Document Type.

![Create group](/15/umbraco-cms/fundamentals/data/images/createGroup_new.png)
{% hint style="warning" %}

If you create 2 compositions that contain some common properties it is only possible to pick one of the compositions in a Document Type. If preferred, those compositions that cannot be used can be marked as hidden by check marking the `Hide unavailable options`.

![Composition](/15/umbraco-cms/fundamentals/data/images/composition.png)
{% endhint %}
