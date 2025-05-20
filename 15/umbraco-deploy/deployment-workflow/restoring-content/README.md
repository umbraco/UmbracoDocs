---
description: How to restore content in Umbraco Deploy
---

# Restoring content

When you have content on your environment and you clone down your Umbraco project to your local machine, you will need to do an extra step, in order to see your content locally.

The restore option also comes in really handy when you have content editors creating content on different environments. You will be able to restore and work with that content on your different environments and locally.

## Step-by-step

There are four options when it comes to restoring content.

1. [Restore when starting up the project locally](./#restore-when-starting-up-the-project-locally)
2. [Restore everything through the Umbraco backoffice](./#restore-everything-through-the-umbraco-backoffice)
3. [Restore a single tree through the Umbraco backoffice](./#restore-a-single-tree-through-the-umbraco-backoffice)
4. [Partial Restores](partial-restore.md)

### Restore when starting up the project locally

The first time you run your project locally you will have the option to restore your content and media before going to the Umbraco backoffice.

{% hint style="info" %}
This will restore **all** content and media, plus any other entities configured for back-office transfer.
{% endhint %}

1. When your site is done spinning up, click the green _Restore_ button - this will restore all content and media.
2. Wait till the process completes - this might take a while, depending on the amount of content and media you have on your Umbraco site.
3. When it's complete select _Open Umbraco_ to go to the backoffice.
4. You will now see all your content and media in the Umbraco backoffice.

![Restore from start-up](images/Normal-Restore.gif)

### Restore everything through the Umbraco backoffice

The second option for restoring your content and media is found in the Umbraco backoffice.

1. Go to the Umbraco backoffice on the environment you want to restore content and media to.
2. Click **...** next to the Content Tree.
3. Choose _Workspace restore..._ from the menu.
4. You will now have the option to restore content from any environment that's _to the right of_ the current environment in the deployment workflow.
5. To ensure the restore will succeed, [make sure that your environments have the same meta data and structure files](../deploying-changes.md).
6. Click _Restore from .._ and wait till the process completes - this might take a while, depending on the amount of content and media you have on your project.
7. When it's done, click **...** next to the Content tree again and choose _Reload_ to see your content in the tree.

{% hint style="info" %}
As well as content, media and any other entities configured for back-office transfer, will also be restored in the process.

To see the media, go to the Media section and _Reload_ the tree.
{% endhint %}

{% embed url="https://www.youtube.com/embed/poRzuBB11pc?rel=0" %}
Umbraco Deploy - Content transfer and restore
{% endembed %}

### Restore a single tree through the Umbraco backoffice

The operation is triggered in the same way as when restoring everything, but instead the _Tree restore..._ menu option should be selected.

For example, if triggered from the content tree, only content entities will be restored. This will also restore any media that’s referenced in that content, but it won’t attempt to restore the full media library, nor any other entities.

### [Partial Restore](partial-restore.md)

By using the Partial Restore option, you can make sure that you only restore the part of the content that you need to work with. You can either restore a single item, or include all the descendents of that item too.
