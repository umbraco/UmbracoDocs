# Restoring Content

When you have content on your Cloud environment and clone down your project to your local machine, you need to restore the content. You will also need to use the restore option when setting up new Cloud environments.

The restore option can be used to always ensure you work with the latest content when delevoping new features.

## How to Restore Content

You can restore the content in the following ways:

1. [Restore when starting up the project locally](restoring-content.md#restore-when-starting-up-the-project-locally)
2. [Workspace Restore](restoring-content.md#workspace-restore)
3. [Tree Restore](restoring-content.md#tree-restore)
4. [Partial Restore](restoring-content.md#partial-restore)

### Restore when starting up the project locally

The first time you run your project locally you will have the option to restore your content and media before going to the Umbraco Backoffice.

{% hint style="info" %}
This will restore **all** the content nodes and any media dependencies.
{% endhint %}

1. Run the website locally.
2. Click the green **Restore** button to restore all the content nodes and media files.
3. Wait till the process completes. This might take a while depending on the amount of content and media you have on your project.
4. Select **Open Umbraco** to go to the Backoffice.

All your content and media is now available in the Umbraco Backoffice.

![Restore from start-up](../../../deployment/restoring-content/images/Normal-Restore.gif)

### Workspace Restore

Use this option when setting up new Cloud environments. The Workspace restore option restores all the entities (content, media, forms, datasources, and prevalue sources from Umbraco Forms) of a workspace via the Backoffice.

1. Log in to the Umbraco Backoffice on the environment you want to restore the content and media.
2. Click **...** and select **Do something else** or Right-click the **Content** Tree in the Content section.
3. Choose **Workspace Restore**.
4. Select the environment from the **Restore this workspace from** dropdown.
5. Make sure that your environments have the [same schema](broken-reference).
6. Click **Restore from \<environment\_name>** and wait till the process completes. This might take a while depending on the amount of content and media you have on your project.
7. Click **Okay** to complete the process once the restore is done.
8. Right-click the **Content** tree and choose **Reload** to see your content in the tree.

![Workspace Restore](../../../deployment/restoring-content/images/Workspace_Restore.gif)

{% embed url="https://www.youtube.com/embed/0jIhKZOSeLc?rel=0" %}
Workspace restore
{% endembed %}

### Tree Restore

The Tree restore option restores all the entities available for the selected tree in that section. It's available in the **Content**, **Media**, **Members**, **Forms** (root node of Forms, Datasources, and Prevalue sources), or **Translation** (Dictionary menu if configured) sections. Using Tree Restore, you can choose to restore only content. This will restore any media that’s referenced in that content, but it won’t attempt to restore the full media library.

1. Log in to the Umbraco Backoffice in the environment you want to restore the tree.
2. Click **...** and select **Do something else** or Right-click the **Content** Tree in the Content section.
3. Choose **Tree Restore**.
4. Select the environment from the **Restore this tree from** dropdown.
5. Make sure that your environments have the [same schema](broken-reference).
6. Click **Restore from \<environment\_name>** and wait till the process completes. This might take a while depending on the amount of content and media you have on your project.
7. Click **Okay** to complete the process when the restore is done.
8. Right-click the **Content** tree and choose **Reload** to see your content in the tree.

![Tree Restore](../../../deployment/restoring-content/images/Tree-Restore.gif)

{% embed url="https://www.youtube.com/embed/X7m3FzhRHp0?rel=0" %}
Video example.
{% endembed %}

### [Partial Restore](broken-reference)

Using the Partial Restore option, you can restore single nodes from a tree (optionally with descendants) that you need to work with.

In some cases, you might not want to restore the entire content tree but only the parts that you need. Partial restore is a feature that allows for restoring specific parts of your content instead of restoring everything.

You can use Partial Restore on:

* [Empty environments](restoring-content.md#empty-environment) - Requires Umbraco Deploy 3.3+.
* [Environments with existing content or media](restoring-content.md#environment-with-existing-content-or-media)

## Empty Environment

{% hint style="info" %}
This feature is only available with Umbraco Deploy 3.3+
{% endhint %}

In this scenario, the Cloud environment is cloned to your local machine or a new Cloud environment has been created. In both cases, the new environment will have an empty Content section as well as an empty Media section.

{% hint style="info" %}
This feature will also restore all dependencies of the selected content. When you restore a content node that references media items and other content nodes, these will all be restored. This includes any parent nodes that these nodes depend on.
{% endhint %}

To partially restore the parts you need:

1. Go to the **Content** section of the Umbraco backoffice on your new environment (local or Cloud).
2. Right-click the **Content** tree or click the three dots and select **Do something else**.
3. Choose **Partial Restore**.
4. Select the environment that you would like to restore the content from.
5. **Select content to restore** to open a dialog with a preview of the content tree.
6. Select the content node you would like to restore.
7. Enable **Including all items below** if you want to restore any child nodes below the selected node.
8. Click **Restore**.
9. Right-click the Content tree and select **Reload** once the restore is complete.

![Partial restore on empty environment](../../../deployment/restoring-content/images/partialRestore-onEmpty.gif)

Partial Restores on empty environments are helpful when not all content or media is necessary for the tasks to be performed on the new environment. Instead of having to restore everything, doing a partial restore can be used to only restore the parts you need. This will ensure that you can quickly get on your way with the task at hand.

## Environment with existing Content or Media

It is possible to use the Partial Restore feature in environments where you already have content in the Content tree.

1. Go to the **Content** section of your Umbraco backoffice.
2. Right-click the content node which you know contains updates.
3. Choose **Partial Restore**.
4. Select the environment that you would like to restore the content from.
5. Enable **Including all items below** if you want to restore any child nodes _below_ the selected node.
6. Click **Restore**.
7. Right-click the Content tree and select **Reload** once the restore is complete.

![Partial restore](../../../deployment/restoring-content/images/partialRestore-onEnvWithContent.png)

{% embed url="https://www.youtube.com/embed/C5SnrEf78bQ?rel=0" %}
A video showing how to use partial restores between Umbraco Cloud environments.
{% endembed %}
