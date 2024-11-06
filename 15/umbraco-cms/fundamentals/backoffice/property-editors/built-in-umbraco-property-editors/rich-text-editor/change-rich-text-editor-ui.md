# Change Rich Text Editor UI

{% hint style="info" %}
Umbraco 15 ships with two UI options for working with rich text, Tiptap and TinyMCE. The latter will eventually be removed from the CMS.

This article will guide you through switching from using the TinyMCE UI to using the new Tiptap UI.
{% endhint %}

The following steps will guide you through changing the property editor used for rich text on an existing Document Type.

## Create a new Data Type

The first step in this guide is to create a new Rich Text Editor Data Type using the Tiptap UI.

As an alternative, you can create a new Data Type with the Tiptap UI when updating the Document Type.

{% hint style="info" %}
When swapping the UI used for the Rich Text Editor, you need to reconfigure the toolbar.
{% endhint %}

1. Navigate to the **Settings** section of the Umbraco Backoffice.
2. Select **+** next to the Data Types folder.
3. Select **New Data Type...**.

![Click on + next to the Data Types folder to create a new Data Type](images/rte-swap-new-data-type.png)

4. Give the new Data Type a name.
5. Click **Select a property editor**.
6. Choose **Rich Text Editor [Tiptap]**.

![Search for and choose the Rich Text Editor Tiptap UI](images/rte-swap-select-ui.png)

7. [Configure the Data Type](./configuration.md) to match your needs.
8. **Save** the Data Type.

## Update the Document Type(s)

Once you have prepared the new Data Type you need to update the Document Types that should use it.

1. Expand the **Document Types** folder.
2. Select a Document Type that needs to be updated.
3. Click on the Property used for rich text.

![Click on the property used for rich Text in the Document Type editor](images/rte-swap-change-property.png)

4. Hover over the selected property editor and click **Change**.
5. Search for the newly created Data Type and select it.

![Search for the new Data Type and select it](images/rte-swap-search-and-find-new-ui.png)

6. **Submit** the changes.
7. **Save** the Document Type.
8. Repeat steps 2-7 for each Document Type that needs to use the new Data Type.

## Verify your content

When you have updated all the relevant Document Types, it is recommend to verify the content that uses the rich text editor.
