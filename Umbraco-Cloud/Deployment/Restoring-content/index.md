---
versionFrom: 7.0.0
meta.RedirectLink: "/umbraco-cloud/deployments/deployment"
---

# Restoring Content

When you have content on your Cloud environment and you clone down your Umbraco Cloud project to your local machine, you will need to do an extra step, to see your content locally. You will also need to use the restore option when setting up new Umbraco Cloud environments.

The restore option comes in handy when you have content editors creating content on the Live or Staging environments. You will be able to restore and work with that content in your Development and local environments.

## Step-by-step

You can restore the content in the following ways:

- [Restoring Content](#restoring-content)
  - [Step-by-step](#step-by-step)
    - [Restore when starting up the project locally](#restore-when-starting-up-the-project-locally)
    - [Workspace Restore](#workspace-restore)
    - [Tree Restore](#tree-restore)
    - [Partial Restore](#partial-restore)

### Restore when starting up the project locally

The first time you run your project locally you will have the option to restore your content and media before going to the Umbraco Backoffice.

:::note
This will restore **all** the content nodes and any media dependencies.
:::

1. When your site is done spinning up, click the green **Restore** button to restore all the content nodes and media files.
2. Wait till the process completes. This might take a while depending on the amount of content and media you have on your project.
3. When it's completed, select **Open Umbraco** to go to the Backoffice.
4. You will now see all your content and media in the Umbraco Backoffice.

![Restore from start-up](images/Normal-Restore.gif)

### Workspace Restore

Use this option when setting up new Cloud environments. The Workspace restore option restores all the entities (content, media, forms, datasources, and prevalue sources from Umbraco Forms) of a workspace via the Backoffice.

1. Log in to the Umbraco Backoffice in the environment you want to restore the content and media.
2. Click **...** and select **Do something else** or Right-click the **Content** Tree in the Content section.
3. Choose **Workspace Restore**.
4. Select the environment from the **Restore this workspace from** dropdown.
5. To ensure the restore succeeds, make sure that your environments have the [same metadata and structure files](../Cloud-to-Cloud).
6. Click **Restore from <environment_name>** and wait till the process completes. This might take a while depending on the amount of content and media you have on your project.
7. Once the content restore is completed, you will get a notification with a timestamp. Click **Okay** to complete the process.
8. Right-click the **Content** tree and choose **Reload** to see your content in the tree.

:::note
If any of your content nodes depends on media items, these will also be restored in the process.

To see the media, go to the **Media** section and **reload** the tree.
:::

![Workspace Restore](images/Workspace_Restore.gif)

<iframe width="800" height="450" title="Restoring Content: Workspace Restore" src="https://www.youtube.com/embed/0jIhKZOSeLc?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### Tree Restore

The Tree restore option restores all the entities available for the selected tree in that section. It's available in the **Content**, **Media**, **Forms** (root node of Forms, Datasources, and Prevalue sources), or **Translation** (Dictionary menu if configured) sections. Using Tree Restore, you can, for example, restore all your content only. This will restore any media that’s referenced in that content, but it won’t attempt to restore the full media library.

1. Log in to the Umbraco Backoffice in the environment you want to restore the tree.
2. Click **...** and select **Do something else** or Right-click the **Content** Tree in the Content section.
3. Choose **Tree Restore**.
4. Select the environment from the **Restore this tree from** dropdown.
5. To ensure the restore succeeds, make sure that your environments have the [same metadata and structure files](../Cloud-to-Cloud).
6. Click **Restore from <environment_name>** and wait till the process completes. This might take a while depending on the amount of content and media you have on your project.
7. Once the content restore is completed, you will get a notification with a timestamp. Click **Okay** to complete the process.
8. Right-click the **Content** tree and choose **Reload** to see your content in the tree.

![Tree Restore](images/Tree-Restore.gif)

<iframe width="800" height="450" title="Restoring Content: Tree Restore" src="https://www.youtube.com/embed/X7m3FzhRHp0?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### [Partial Restore](Partial-Restore)

Using the Partial Restore option, you can restore only a single node from a tree (optionally with descendants) that you need to work with.
