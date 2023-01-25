# Partial Restores

In some cases, you might not want to restore the entire content tree but only the parts that you need. **Partial restore** is a feature that allows for restoring specific parts of your content instead of restoring everything.

You can use Partial Restore on:

* [Empty environments](partial-restore.md#empty-environment) - Requires Umbraco Deploy 3.3+.
* [Environments with existing content or media](partial-restore.md#environment-with-existing-content-or-media)

## Empty Environment

{% hint style="info" %}
This feature is only available with Umbraco Deploy 3.3+
{% endhint %}

In this scenario, you've cloned down your Cloud environment to your local machine or set up a new Cloud environment. In both cases, the new environment will have an empty Content section as well as an empty Media section.

{% hint style="info" %}
This feature will also restore all dependencies of the selected content. For example, when you restore a content node that references media items as well as other content nodes, these will all be restored, including any parent nodes that these nodes depend on.
{% endhint %}

To partially restore the parts you need:

1. Go to the **Content** section of the Umbraco backoffice on your new environment (local or Cloud).
2. Right-click the **Content** tree or click the three dots and select **Do something else**.
3. Choose **Partial Restore**
4. Select the environment that you would like to restore the content from.
5. Click **Select content to restore** and a dialog with a preview of the content tree from the environment you selected opens.
6. Select the content node you would like to restore.
7. Enable **Including all items below** if you want to restore any child nodes _below_ the selected node.
8. Click **Restore**.
9. Once the restore is completed, right-click the Content tree and select **Reload**.

{% hint style="info" %}
If you select a content node deeper down the tree, all the parents above it, required for the node to exist, will be restored as well.
{% endhint %}

![Partial restore on empty environment](<../../../umbraco-deploy/deployment-workflow/restoring-content/images/partialRestore-onEmpty (1).gif>)

Partial Restores on empty environments are especially helpful when you have a large amount of content and media and do not necessarily need it all for the task you need to do. Instead of having to restore everything which could potentially take a long time, doing a partial restore can be used to shorten the waiting time by only restoring the parts you need. This will ensure that you can quickly get on your way with the task at hand.

## Environment with existing Content or Media

It is also possible to use the Partial Restore feature in environments where you already have content in the Content tree.

Imagine that you are working with your Umbraco Cloud project locally. One of your content editors updates a section in the content tree on the Live environment. You would like to see how this updated content looks with the new code you are working on. To partially restore the updated content node, do the following:

1. Go to the **Content** section of your Umbraco backoffice.
2. Right-click the content node which you know contains updates.
3. Choose **Partial Restore**
4. Select the environment that you would like to restore the content from.
5. Enable **Including all items below** if you want to restore any child nodes _below_ the selected node.
6. Click **Restore**.
7. Once the restore is completed, right-click the Content tree and select **Reload**.

![Partial restore](images/partialRestore-onEnvWithContent.png)

{% embed url="https://www.youtube.com/embed/C5SnrEf78bQ?rel=0" %}
Video example.
{% endembed %}
