---
versionFrom: 7.0.0
---

# Restoring content

When you have content on your Cloud environment and you clone down your Umbraco Cloud project to your local machine, you will need to do an extra step, in order to see your content locally. You will also need to use the restore option when setting up new Umbraco Cloud environments. 

The restore option also comes in really handy when you have content editors creating content on the Live or Staging environments. You will be able to restore and work with that content on your Development and local environments.

## Step-by-step

There is a total of three ways to restore content.

1. [Restore when starting up the project locally](#restore-when-starting-up-the-project-locally)
2. [Restore everything through the Umbraco backoffice](#restore-everything-through-the-umbraco-backoffice)
3. [Partial Restores](Partial-Restore)

### Restore when starting up the project locally

The first time you run your project locally you will have the option to restore your content and media before going to the Umbraco backoffice.

:::note
This will restore **all** content nodes, and any media dependencies.
:::

1. When your site is done spinning up, click the green *Restore* button - this will restore all content and media!
2. Wait till the process completes - this might take a while, depending on the amount of content and media you have on your project
3. When it's complete select *Open Umbraco* to go to the backoffice
4. You will now see all your content and media in the Umbraco backoffice

![Restore from start-up](images/Normal-Restore.gif)

### Restore everything through the Umbraco backoffice

The second option for restoring your content and media is found in the Umbraco backoffice - use this option when setting up new Cloud environments.

1. Go to the Umbraco backoffice on the environment you want to restore content and media to
2. Click the three dots an select *Do something else*, or *Right-click* the Content Tree
3. Choose *Restore* from the menu
4. You will now have the option to restore content from any Cloud environment that's *to the right of* the current environment in the deployment workflow
5. To ensure the restore will succeed, [make sure that your environments have the same meta data and structure files](../Cloud-to-Cloud)
6. Click *Restore from ..* and wait till the process completes - this might take a while, depending on the amount of content and media you have on your project
7. When it's done, *right-click* the Content tree again and choose *Reload* to see your content in the tree

:::note
If any of your content nodes depends on media items, these will also be restored in the process.

To see the media, go to the Media section and *reload* the tree.
:::

<iframe width="800" height="450" src="https://www.youtube.com/embed/WGTU8DF8PEk?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### [Partial Restore](Partial-Restore)

By using the Partial Restore option, you can make sure that you only restore the part of the content that you need to work with.
