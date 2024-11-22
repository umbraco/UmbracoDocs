---
description: How to restore content in Umbraco Deploy using the deployment dashboard
---

# Transferring Content, Media and Forms

Once all code and meta data is in sync between your environments, it's time to transfer your content and media. This is done from the Umbraco Backoffice.

Content and media transfers are flexible which means you have complete control over which content nodes and/or media items you want to transfer. You can transfer it all in one go, a few at a time or transfer only a single node.

Transferring content will overwrite any existing nodes on the target environment - content transfers will transfer the items that you select in the "source" environment to the "target" environment exactly the same as it was in the "source". This means that if you have some content on the target environment already, this will be replaced by the new content from the source environment.

**Important**: Content and Media transfers will only work if you've deployed all changes to your meta data before hand. Please refer to our documentation on how to deploy meta data from [Deploying Content](deploying-changes.md).

## Step-by-step

Let’s go through a content transfer step by step. Imagine you’ve finished working on new content for your project locally and you are ready to transfer the changes to your development site.

You want to transfer the whole site. You start from the `Home` node and choose to transfer everything under it:

1. Click on the ellipsis next to the `Home` node in the Content tree.
2. Choose "Do something else".
3. There you get the choice of **Queue for transfer**.
   * If you’re currently editing the Home page you could also use the Actions dropdown to find **Queue for transfer**.
4. Choose if you want to include all pages under the chosen page or only transfer the chosen node.
   * If you wish to transfer all your content at once, _right-click_ the top of the Content tree where you will also find **Queue for transfer** - this will queue all your content for transfer.
5. Select the language versions that you want to queue for transfer. Only languages for which you have permission to access will be selectable.
6.  Set the publish date and time if you want to change when the transferred content should be published.

    {% hint style="info" %}
    By default, the content will be transferred in its current published state. So if the content is published in the current environment, the changes will be deployed and the item immediately be published in the destination. If you prefer to schedule the publishing of the changes, you can do so by selecting a publish date.
    {% endhint %}
7.  Click **Queue** to add the content item to the transfer queue.

    ![Queue for transfer window](images/queue-for-transfer-dialog.png)
8. Go to the Deployment dashboard by clicking on the Content section header.
   * You will be able to see which items are currently ready to be transferred - this will include both content and media that you've _queued for transfer_.
9.  Confirm by clicking **Transfer toDevelopment** and monitor the progress of the transfer.

    ![Transfer queue](images/transfer-queue.png)

If everything went well, you will see the confirmation screen saying that the transfer has succeeded.

### Media items

Media items are transferred the same way as content:

1. In the Media section _Right-click_ the items you want to transfer and choose **Queue for transfer**.
   * Or _right-click_ the top of the Media section to transfer all you media at once.
2. Go to the Deployment dashboard in the Content section to see the items you've queued for transfer and to transfer your items.

### Umbraco Forms

In order for Deploy to handle Forms data as content, you will need to ensure that the `transferFormsAsContent` setting in configuration is set to `true`. See details in the [Deploy Settings for Umbraco 9+](../getting-started/deploy-settings.md) article.

Once the setting have been added to the source and target environment forms can be transferred the same way as content and media:

1. In the Forms section _Right-click_ the items you want to transfer and choose **Queue for transfer**.
   * Or _right-click_ the top of the Forms section to transfer all your Forms at once.
2. Go to the Deployment dashboard in the Content section to see the items you've queued for transfer and to transfer your items.

{% hint style="info" %}
This does not include entries submitted via the forms.
{% endhint %}

## Schema Mismatches

Sometimes a content transfer might not be possible. For example if you add a new property to the HomePage Document type and you don’t have that property in both environments, you’ll get an error with a hint on how to fix this.

![clone dialog](images/schema-mismatch.png)

If you are seeing this type of issue when trying to transfer content, head over to our article about [Schema Mismatch errors](../troubleshooting.md), where you can read about how to resolve the issues.
