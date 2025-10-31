# Default Document Types

On this page, you will find the default Document Types in Umbraco. If you want to use these document types, you can create them in the Settings section.

<figure><img src="../images/v8Screenshots/createDoctype.PNG" alt=""><figcaption></figcaption></figure>

## Document type with template

Creating document types with templates allows you to define both the content structure and the visual presentation of a particular type of content item. It ensures a consistent and cohesive look and feel across your website while also enabling structured content management. This approach helps separate content from design, making it easier to manage and update your website's content and appearance independently through templates.

## Document type

Creating a Document Type (without a template) is about defining the content structure and fields that can be used across different content items. You might use document types without templates for creating consistent, structured content that doesn't require a predefined page layout. For example blog posts or product listings.

## Compositions

Compositions provide a way to create reusable sets of properties that can be added to one or more document types. This can help simplify the management and consistency of content types across your website.

When using a mixed setup, you can take advantage of nesting and use compositions by clicking on "**Compositions**..." option.

<figure><img src="../images/v8Screenshots/createGroup_new.png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
If you create 2 compositions that contain some common properties it is only possible to pick one of the compositions in a Document Type. If preferred, those compositions that cannot be used can be marked as hidden by checkmarking the `Hide unavailable options`.

<img src="../images/Composition-hide-unavailable-options (1).PNG" alt="" data-size="original">
{% endhint %}

## Element Type

An Element Type is a Document Type without a template containing schema configurations for repeating a set of properties. These are for defining schema in the Block List Editor, Block Grid Editor, or other Element Type based editors.

Element Types cannot be used to create content that resides in the Content tree. When you create an Element type, it automatically sets the **Is Element Type** flag to **True** on the **Permissions** tab.

<figure><img src="../images/Element-Type.png" alt=""><figcaption></figcaption></figure>

Element Types are created using the same workflow as regular Document Types but usually contain fewer properties. You can also create Element Types as part of configuring a Block Grid or Block List Data Type.
