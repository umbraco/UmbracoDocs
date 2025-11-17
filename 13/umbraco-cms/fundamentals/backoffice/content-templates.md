---
description: >-
  In this article you can learn about how to create and use Content Templates in
  Umbraco.
---

# Content Templates

Content Templates allows a content editor to create a blueprint for new content nodes based on an existing node.

{% embed url="https://youtu.be/tz7dRStOo2Y" %}
Learn how to use the Content Templates in Umbraco
{% endembed %}

## Create - Method 1

{% hint style="warning" %}
Before following this method you should have some [content](../data/defining-content/#3.-creating-the-content) created beforehand.
{% endhint %}

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

{% hint style="info" %}
Refresh your browser, if you do not see the new content template in the **Content Templates** folder.
{% endhint %}

## Create - Method 2

Click on the **Settings** menu:

![Settings Menu](images/v8-07-Settings-Menu.png)

Right-click on the **Content Templates** tree and select the **Create** menu item:

![Create Content Template](images/v8-08-Create-Content-Template.png)

Select the Document Type you want to create a content template for:

![Select Content Type](images/v8-09-Select-Content-Type.png)

{% hint style="warning" %}
You can create content templates only from **Document Types** or **Document Types with Templates**
{% endhint %}

Give your content template a **Name** and click the **Save** button:

![Content Template Name Field](images/v8-10-Save-Template.png)

The new content template will be created in **Content Templates** folder of the **Settings** tree:

![New Content Template](images/v8-11-Find-Template.png)

## Edit

To edit an existing content template, select a content template from the **Content Templates** folder of the **Settings** tree. When you have finished editing click the **Save** button:

![Edit Content Template](images/v8-06-Edit-Content-Template.png)

## Use

Once you have created a content template, you can use the template to create new content nodes. To use a content template, right-click the **Content** tree and select **Create**:

![Create From Template](images/v8-12-Create-From-Template.png)

When you click on a Document Type that has a content template you will see two options:

* Create a new node based on a content template
* Create a blank one

![Select Template](images/v8-13-Select-Template.png)
