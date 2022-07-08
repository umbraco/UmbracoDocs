---
versionFrom: 8.0.0
versionTo: 10.0.0
meta.Title: "Content Templates in Umbraco"
meta.Description: "In this article you can learn about how to create and use Content Templates in Umbraco."
---

# Content Templates

_This tutorial was last tested on **Umbraco 9.0**_

Content Templates allows a content editor to create a blueprint for new content nodes based on an existing node.

## Create - Method 1

Select a **Content node** from the **Content** menu:

![Content Menu](images/v8-01-Content-Menu.png)

Right-click the Content node and select the **Create Content Template** option. Alternatively, select the **Actions** dropdown of the content node and select the **Create Content Template** option:

![Actions Button](images/v8-02-Actions-Menu.png)

Give your content template a **Name**:

![Content Template Name Field](images/v8-03-Name-Content-Template.png)

Click the **Create** button and if the creation was successful, you will see a success notification:

![Create Button](images/v8-04-Save-Content-Template.png)

The new content template will be created in **Content Templates** node of the **Settings** tree:

![New Content Template](images/v8-05-Find-Content-Template.png)

:::note
Refresh your browser, if you do not see the new content template in the **Content Templates** folder.
:::

## Create - Method 2

Click on the **Settings** menu:

![Settings Menu](images/v8-07-Settings-Menu.png)

Right-click on the **Content Templates** tree and select the **Create** menu item:

![Create Content Template](images/v8-08-Create-Content-Template.png)

Select the document type you want to create a content template for:

![Select Content Type](images/v8-09-Select-Content-Type.png)

Give your content template a **Name** and click the **Save** button:

![Content Template Name Field](images/v8-10-Save-Template.png)

The new content template will be created in **Content Templates** folder of the **Settings** tree:

![New Content Template](images/v8-11-Find-Template.png)

## Edit

To edit an existing content template, select a content template from the **Content Templates** folder of the **Settings** tree and click the **Save** button when you have finished editing:

![Edit Content Template](images/v8-06-Edit-Content-Template.png)

## Use

Once you have created a content template, you can use the template to create new content nodes. To use a content template, right-click the **Content** tree and select **Create**:

![Create From Template](images/v8-12-Create-From-Template.png)

When you click a document type that has content templates, Umbraco lets you choose to create a new node based on a content template or a blank one:

![Select Template](images/v8-13-Select-Template.png)
