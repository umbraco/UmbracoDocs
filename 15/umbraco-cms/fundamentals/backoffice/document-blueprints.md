---
description: >-
  Learn how to create and use Document Blueprints in Umbraco.
---

# Document Blueprints

{% hint style="info" %}
Document Blueprints were previously called Content Templates.
{% endhint %}

## Document Blueprints Overview

A Document Blueprint allows editors to preconfigure a content node. It serves as a reusable starting point when creating new content.

### Method 1 – Create a Document Blueprint from the Content Section

{% hint style="warning" %}
Before using this method, make sure you have already [created some content](../data/defining-content/README.md#3-creating-the-content).
{% endhint %}

1. Go to the **Content** section and select an existing content node.

![Content-Menu](images/content-menu-DB.png)

2. Click the **...** menu next to the node and choose **Create Document Blueprint**.

![Action Button](images/action-menu-DB.png)

3. Enter a **Name** for the new blueprint.

![Document Blueprint Name Field](images/Name-Content-Template-DB.png)

4. Click **Save**.

The new blueprint will appear under the **Document Blueprints** folder in the **Settings** section.

![New Document Blueprint](images/Find-Content-Template-DB.png)

{% hint style="info" %}
If you don’t see the new blueprint, try refreshing your browser.
{% endhint %}

### Method 2 – Create a Document Blueprint from the Settings Section

1. Go to the **Settings** section.

2. Click the **...** menu next to the **Document Blueprints** tree.

3. Select **Create Document Blueprint**.

![Create Document Blueprint](images/Create-Content-Template-DB.png)

4. Choose the Document Type you want to base the blueprint on.

![Select Content Type](images/Content-Type-DB.png)

{% hint style="warning" %}
You can only create Document Blueprints from **Document Types** or **Document Types with Templates**.
{% endhint %}

5. Enter a **Name** for the blueprint.
6. Click **Save**.

The new blueprint will appear under the **Document Blueprints** folder in the **Settings** section.

### Edit a Document Blueprint

To edit an existing document blueprint, follow these steps:

1. Go to the **Settings** section.
2. Open the **Document Blueprints** folder.
3. Select the blueprint you want to edit.
4. Make your changes.
5. Click **Save**.

![Edit Document Blueprint](images/Edit-Content-Template-DB.png)

### Use a Document Blueprint

Once you have created a document blueprint, you can use it to create new content nodes.

To use a document blueprint, follow these steps:

1. Go to the **Content** section.
2. Click the **...** menu next to the root node and select **Create**.

![Create From Template](images/Create-From-Template-DB.png)

3. Select the **Document Type** that has an associated blueprint.

![Select the Document Type](images/select-doc-type-DB.png)

4. Choose how to create the new content:

    * Use the Document Blueprint
    * Start with a blank node

![Select Template](images/Select-Template-DB.png)
