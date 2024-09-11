---
description: >-
  In this article you can learn about how to create and use Document Blueprints
  in Umbraco.
---

# Document Blueprints

{% hint style="info" %}
Document Blueprints was previously called Content Templates.
{% endhint %}

## Document Blueprints Overview

Document Blueprints allows a content editor to create a blueprint for new content nodes based on an existing node.

### Create - Method 1

{% hint style="warning" %}
Before following this method you should have some [content](../data/defining-content/#3.-creating-the-content) created beforehand.
{% endhint %}

Select a **Content node** from the **Content** menu:

![Content-Menu](images/content-menu.png)

Click **...** next to the Content node and select the **Create Document Blueprint** option.

![Action Button](images/action-menu.png)

Give your document blueprint a **Name**:

![Document Blueprint Name Field](images/Name-Content-Template.png)

Click the **Save** button and if the creation was successful, you will see a success notification:

![Create Button](images/Save-Content-Template.png)

The new document blueprint will be created in **Document Blueprints** node of the **Settings** tree:

![New Document Blueprint](images/Find-Content-Template.png)

{% hint style="info" %}
Refresh your browser, if you do not see the new document blueprint in the **Document Blueprints** folder.
{% endhint %}

### Create - Method 2

Go to the **Settings** section:

![Settings Menu](images/Settings-Menu.png)

Click **...** next to the **Document Blueprints** tree and select the **Create Document Blueprint** menu item:

![Create Document Blueprint](images/Create-Content-Template.png)

Select the Document Type you want to create a document blueprint for:

![Select Content Type](images/Content-Type.png)

{% hint style="warning" %}
You can create document blueprints only from **Document Types** or **Document Types with Templates**
{% endhint %}

Give your document blueprint a **Name** and click the **Save** button:

![Document Blueprint Name Field](images/Save-Template.png)

The new document blueprint will be created in **Document Blueprints** folder of the **Settings** tree:

![New Document Blueprint](images/Find-Template.png)

### Edit

To edit an existing document blueprint, select a document blueprint from the **Document Blueprints** folder of the **Settings** tree. When you have finished editing click the **Save** button:

![Edit Document Blueprint](images/Edit-Content-Template.png)

### Use

Once you have created a document blueprint, you can use the template to create new content nodes. To use a document blueprint, Click **...** next to the **Content** tree and select **Create**:

![Create From Template](images/Create-From-Template.png)

When you click on a Document Type that has a document blueprint, you will see two options:

* Create a new node based on a document blueprint
* Create a blank one

![Select Template](images/Select-Template.png)
