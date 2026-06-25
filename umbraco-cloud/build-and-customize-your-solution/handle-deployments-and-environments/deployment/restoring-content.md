---
description: How to restore content, media and forms between your Cloud environments.
---

# Restore Items

When you have content in your Cloud environment and clone down your project to your local machine, you need to restore content, media, and forms. You will also need to use the restore option when setting up new Cloud environments.

The restore options also come in really handy when you have content editors creating content on different environments. You will be able to restore and work with that content on your different environments and locally.

To ensure the restore will succeed, [make sure that your environments have the same metadata and structure files](local-to-cloud.md).

There are three options for restoring content:

1. [Restore Environment](restoring-content.md#restore-environment)
2. [Tree Restore](restoring-content.md#tree-restore)
3. [Partial Restore](restoring-content.md#partial-restore)

{% hint style="info" %}
Restoring content, media, and forms will overwrite any items on the target that also exist in the source. However, it will not delete items that exist on the target but are missing from the source. This is a safety feature to prevent accidental data loss. To achieve a true mirror and remove orphaned items, manually empty the relevant sections, including the Recycle Bins, on the target environment. You can also use the [Import and Export](/broken/pages/l3EeYeflGLXT48PLjdw0) feature with a full export from the source environment.
{% endhint %}

## Restore Environment

It is possible to do a full restore of **all** content and media on your project. This is useful on a new instance or clone of your project.

The full environment restore can be done in two ways:

1. [As part of project initialization.](restoring-content.md#as-part-of-project-initialization)
2. [Via the Deploy Overview in the backoffice.](restoring-content.md#via-the-deploy-overview-in-the-backoffice)

### As part of project initialization

The first time you run your project locally, you will have the option to restore your content and media before going to the Umbraco backoffice.

1. Click the green **Restore** button that appears when spinning up your site locally for the first time.
   1. This will restore all content, media, and forms for the project.
2. Wait till the process completes - this might take a while, depending on the amount of content and media you have on your Umbraco site.
3. Select **Open Umbraco** to go to the backoffice.

You will now see all your content and media in the Umbraco backoffice.

![Restore from start-up](<../../../.gitbook/assets/Normal-Restore (1).gif>)

### Via the Deploy Overview in the Backoffice

This option can be used on an empty environment or when you already have content and media. Any restored items will overwrite the existing ones.

1. Click on the **Environment name** in the top-right corner to open the **Deploy Overview**.
2. Click on the ellipses in the top-right corner.

<figure><img src="../../../.gitbook/assets/restore-environment-backoffice.png" alt=""><figcaption></figcaption></figure>

3. Choose **Restore environment** from the menu.
4. Use the dropdown to select the environment you want to restore from.
5. Click **Restore from \[environment name]** to initiate the restore.

When completed, you will see your content reflected in the Content section and the media in the Media section.

{% hint style="info" %}
In some cases, it might be necessary to refresh the browser window to see the restored items in the backoffice.
{% endhint %}

## Tree Restore

The Tree Restore option gives you the option to restore only a single tree, like just the content tree or just the Media tree.

For example, if triggered from the content tree, only the content items will be restored. Only referenced (dependencies) elements, media, and forms will be included in the restore.

1. Click the ellipses next to the tree title (Content, Media, Elements, or Forms).
2. Choose **Tree restore** from the menu.

<figure><img src="../../../.gitbook/assets/partial-restore.png" alt=""><figcaption></figcaption></figure>

3. Use the dropdown to select the environment you want to restore from.
4. Click **Restore from \[environment name]** to initiate the restore.

When completed, click on the ellipses next to the tree title again and choose **Reload**.&#x20;

## Partial Restore

In some cases, you might not want to restore the entire content tree, but only the parts that you need. **Partial restores** let you restore specific parts of your content instead of everything.

You can use Partial Restore on:

* [Empty environments](restoring-content.md#empty-environment)
* [Environments with existing content or media](restoring-content.md#environment-with-existing-content-or-media)

### Empty environment

In this scenario, you've cloned your environment to your local machine or set up a new environment. The new environment has an empty Content section and empty Forms and Media sections.

Instead of having to restore everything, which could potentially take a long time, doing a partial restore shortens the waiting time and restores only the parts you need.

{% hint style="info" %}
This feature also restores all dependencies of the selected item.

For example, restoring a content item that references media, elements, or other content will also restore those items, including any ancestors they depend on.
{% endhint %}

Follow these steps to perform a partial restore to get only the parts you need:

1. Click the ellipses next to the tree title (Content, Media, Elements, or Forms).
2. Choose **Partial Restore**.
3. Select the environment that you would like to restore from.
4. Click **Select content to restore.**
   1. This will open a dialog with a _preview of the content tree_ from the environment you selected.
5. Select the items you would like to restore.
6. Choose whether to restore any available subitems.
7. Click **Restore** to start restoring the items.

To see the restored content, **reload** the content tree: Click on the ellipses next to the tree title to find this option.

{% hint style="info" %}
Keep in mind that if you select an item with ancestors/parents, all the ancestors above it, required for the item to exist, are restored as well.
{% endhint %}

<mark style="background-color:$danger;">UPDATE GIF</mark>&#x20;

![Partial restore on empty environment](../../../.gitbook/assets/partialRestore-onEmpty-v9.gif)

### Environment with existing content or media

It is possible to use the Partial Restore feature on environments where you already have content and media in place.

Imagine that you are working on your project locally. One of your content editors updates a section in the content tree on the production environment. You would like to see how this updated content looks with the new code you are working on.

Follow these steps to do a Partial Restore of the updated content node:

1. Click ellipses next to the item you want to restore.
2. Choose **Partial Restore**_._
3. Select the environment that you would like to restore content from.
4. Choose whether to restore any available subitems.
5. Click **Restore** to start restoring the items.

When the restore is done, reload the tree to see the changes.

<mark style="background-color:$danger;">UPDATE IMAGE</mark>&#x20;

![Partial restore](<../../../.gitbook/assets/partialRestore-onEnvWithContent (1).png>)
