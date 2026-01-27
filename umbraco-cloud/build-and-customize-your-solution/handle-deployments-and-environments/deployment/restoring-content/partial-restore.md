# Partial Restores

In some cases, you might not want to restore the entire content tree but only the parts that you need. Partial restore is a feature that allows for restoring specific parts of your content instead of restoring everything.

You can use Partial Restore on:

* [Empty environments](partial-restore.md#empty-environment) - Requires Umbraco Deploy 3.3+.
* [Environments with existing content or media](partial-restore.md#environment-with-existing-content-or-media)

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

![Partial restore on empty environment](../../../../.gitbook/assets/partialRestore-onEmpty.gif)

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

![Partial restore](../../../../.gitbook/assets/partialRestore-onEnvWithContent.png)

{% embed url="https://www.youtube.com/embed/C5SnrEf78bQ?rel=0" %}
A video showing how to use partial restores between Umbraco Cloud environments.
{% endembed %}
