# Partial Restores

If your project has a lot of content nodes and/or media items you might not want to restore everything every time a minor change has been made to the content.

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