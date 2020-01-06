# Partial Restores

In some cases you might not want to download the entire content tree, but only the parts that you need. **Partial restores** is a feature that allows for restoring specific parts of the content section instead of restoring everything.

You can use partial restores on empty environments as well as on environments that already have content in the Content tree.

## Empty environment

In this scenario you've cloned down your Cloud environment to your local machine or setup a new Cloud environment. In both cases the new environment will have an empty Content section as well as an empty Media section. 



You only need a specific part of the content. Follow these steps to restore only the parts that you need:

1. Go to the Content section of the Umbraco backoffice on your new environments (local or Cloud)
2. *Right-click* the Content Tree
3. Choose *Partial Restore*
4. Select the environment that you would like to restore content from
5. *Select content to restore* - this will open a dialog which will show you the content tree from the environment you selected
6. Select the content node you would like to restore
7. Decide whether you want to also restore any child nodes under the selected node
8. Start the restore by clicking *Restore*
9. To see the restored content, *reload* the content tree - *right-click* the Content tree to find this option

Partial Restores on empty environments is especially helpful when you have a large amount of content and media.

Instead of having to restore everything which could potentially take a long time, the partial restores can be used to shorten the waiting time, and ensure that you can quickly get on your way with the task at hand.

## Environment with cotnent and media

Imagine that you are working with your Umbraco Cloud project locally. One of your content editors updates a section in the content tree on the Live environment. You would like to see how this updated content looks with the new code you are working on. Follow these steps to do a partial restore of the updated content node:

1. Go to the Content section of your local Umbraco backoffice
2. *Right-click* the content node which you know has been updated on the Live environment
3. Choose **Partial restore**
4. From the *dropdown* you will be able to choose which environment you want to restore the content node
5. After choosing environment, click **Restore from ..**
6. When the restore is done, reload the content tree to see the changes

![Partial restore](images/partial-restore.gif)

:::note
Partial restores are only available when you have content on your environment. This means that you cannot do partial restores on a fresh Local clone or a newly created Cloud environment where to content tree is empty.
:::