---
description: "How to restore content in Umbraco Deploy using the deployment dashboard"
---

# Transferring Content, Media, and Forms

After deploying changes to the metadata, it's time to transfer your content and media. This is done from the Umbraco Backoffice.

Content and media transfers are flexible which means you have complete control over which content nodes and/or media items you want to transfer - all in one go, a few at a time, or a single node.

Transferring content will overwrite any existing nodes on the target environment. Content transfers will transfer the items that you select in the "source" environment to the "target" environment the same as it was in the "source". This means that if you have some content on the target environment already, this will be replaced by the new content from the source environment.

**Important**: Content and Media transfers will only work if you've deployed all changes to your metadata beforehand. Please refer to our documentation on how to deploy metadata from either [Local to Cloud](local-to-cloud.md) or [Cloud to Cloud](cloud-to-cloud.md).

## Step-by-step

Let’s go through a content transfer step by step. Imagine you’ve finished working on new content for your project locally and you are ready to transfer the changes to your Cloud Development environment.

You want to transfer the whole site. You start from the `Home` node and choose to transfer everything under it:

1. Right-click **...** next to the `Home` node in the **Content** tree.
2. Select **Queue for transfer**.
3. Alternatively, if you are in the Home page editor, you can go to the **Actions** dropdown and select **Queue for transfer**.
4. Choose if you want to **include all items below** the chosen page or only transfer the chosen node. Alternatively, right-click the **Content** tree and select **Queue for transfer** to transfer all your content at once.
5. Click **Queue**.
6. Select **Open transfer queue**. The **Workspaces** dashboard opens.
    * You will be able to see which items are currently ready to be transferred - this will include both content and media that you've *queued for transfer*.
7. Click **Transfer to Development** and monitor the progress of the transfer.

Once the transfer is completed, you will see the confirmation message stating that the transfer has succeeded.

### Media Items

Media items are transferred the same way as content:

1. Right-click the items in the **Media** section and select **Queue for transfer**. Alternatively, right-click the Media tree and select **Queue for transfer** to transfer all your media at once.
2. Click **Queue**.
3. Select **Open transfer queue**. The **Workspaces** dashboard opens.
4. Click **Transfer to Development**.

### Umbraco Forms

#### Umbraco version 8 and below

For Deploy to handle Forms data as content, you'll need to add the following setting to `UmbracoDeploy.Settings.config` file:

```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
    <forms transferFormsAsContent="true" />
</settings>
```

#### Umbraco version 9 and above

For Deploy to handle Forms data as content, you'll need to ensure the `TransferFormsAsContent` setting is set to `true` in the `appsettings.json`file:

```json
"Umbraco": {
    "Deploy": {
        "Settings": {
            "TransferFormsAsContent": true,
        }
    }
  }
```

Once the setting has been added to the source and target environment, Forms can be transferred the same way as content and media:

1. Right-click the items in the Forms section and choose **Queue for transfer**. Alternatively, right-click the Forms tree and select **Queue for transfer** to transfer all your Forms at once.
2. Click **Queue**.
3. Select **Open transfer queue**. The **Workspaces** dashboard opens.
4. Click **Transfer to Development**.

{% hint style="info" %}
This does not include entries submitted via the forms.
{% endhint %}

## Schema Mismatches

Sometimes a content transfer might not be possible. For example, if you add a new property to the HomePage Document type and you don’t have that property in the other Cloud environment, you’ll get an error with a hint on how to fix this.

![clone dialog](images/schema-mismatch_v10.png)

If you are seeing this type of issue when trying to transfer content, refer to the [Schema Mismatches](../troubleshooting/deployments/schema-mismatches.md) article, where you can read about how to resolve the issues.
