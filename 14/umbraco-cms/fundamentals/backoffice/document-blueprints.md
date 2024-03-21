---
description: >-
  In this article you can learn about how to create and use Document Blueprints in
  Umbraco.
---

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

# Document Blueprints

Document Blueprints allows a content editor to create a blueprint for new content nodes based on an existing node.

{% embed url="https://youtu.be/tz7dRStOo2Y" %}
Learn how to use the Document Blueprints in Umbraco
{% endembed %}

## Create - Method 1

{% hint style="warning" %}
Before following this method you should have some [content](../data/defining-content/#3.-creating-the-content) created beforehand.
{% endhint %}

Select a **Content node** from the **Content** menu:

![Content Menu](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-01-Content-Menu.png)

Right-click the Content node and select the **Create Document Blueprint** option. Alternatively, select the **Actions** dropdown of the content node and select the **Create Document Blueprint** option:

![Actions Button](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-02-Actions-Menu.png)

Give your document blueprint a **Name**:

![Document Blueprint Name Field](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-03-Name-Content-Template.png)

Click the **Create** button and if the creation was successful, you will see a success notification:

![Create Button](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-04-Save-Content-Template.png)

The new document blueprint will be created in **Document Blueprints** node of the **Settings** tree:

![New Document Blueprint](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-05-Find-Content-Template.png)

{% hint style="info" %}
Refresh your browser, if you do not see the new document blueprint in the **Document Blueprints** folder.
{% endhint %}

## Create - Method 2

Click on the **Settings** menu:

![Settings Menu](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-07-Settings-Menu.png)

Right-click on the **Document Blueprints** tree and select the **Create** menu item:

![Create Document Blueprint](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-08-Create-Content-Template.png)

Select the Document Type you want to create a document blueprint for:

![Select Content Type](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-09-Select-Content-Type.png)

{% hint style="warning" %}
You can create document blueprints only from **Document Types** or **Document Types with Templates**
{% endhint %}

Give your document blueprint a **Name** and click the **Save** button:

![Document Blueprint Name Field](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-10-Save-Template.png)

The new document blueprint will be created in **Document Blueprints** folder of the **Settings** tree:

![New Document Blueprint](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-11-Find-Template.png)

## Edit

To edit an existing document blueprint, select a document blueprint from the **Document Blueprints** folder of the **Settings** tree. When you have finished editing click the **Save** button:

![Edit Document Blueprint](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-06-Edit-Content-Template.png)

## Use

Once you have created a document blueprint, you can use the template to create new content nodes. To use a document blueprint, right-click the **Content** tree and select **Create**:

![Create From Template](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-12-Create-From-Template.png)

When you click on a Document Type that has a document blueprint you will see to options:

* Create a new node based on a document blueprint
* Create a blank one

![Select Template](../../../../10/umbraco-cms/fundamentals/backoffice/images/v8-13-Select-Template.png)
