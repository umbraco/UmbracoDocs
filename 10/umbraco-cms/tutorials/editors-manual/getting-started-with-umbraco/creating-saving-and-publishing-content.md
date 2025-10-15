# Creating, Saving and Publishing Content Options

In this section, you will get an overview of how to create and save pages. You will also learn more about how to publish and unpublish your content, as well as how you can compare content between multiple environments. Finally, you will also get an introduction to how you can transfer your created content to another environment.

## Creating a New Page

Select the parent page to create your new page. The parent page can be the home page or any of the sub-pages of the site.

If the parent page allows sub-pages underneath it, follow these steps:

1. Hover over the name of the parent page in the **Content** section and click **•••** to view the types of pages you can create.
2. Select the page type you wish to create. The new page is loaded in the editor on the right-hand side.
3.  Enter a **Name** for the page and click **Save**.

    ![New Page](images/Enter-name-v9.png)

## Saving and Publishing Pages

There are three different options for saving and publishing pages. The options vary depending on whether you’re still in the process of editing the page or have completed your edits and wish to publish your changes.

### Option 1: Save and Preview

The **Save and preview** button allows you to save your changes and preview it before publishing the changes to the live site. The **Preview** feature shows you how the page will look once it is published. This **Save and preview** feature only saves your page and does not publish your contents to the live site.

![Save and preview](images/Save-and-preview-v9.png)

### Option 2: Save

The **Save** button is used for saving the page without publishing the changes to the live site. The **Save** feature is especially useful if you are working on changes over a period of time as you can save your changes frequently to prevent losing any data.

![Save](images/Save-v9.png)

### Option 3: Save and Publish

The **Save and publish** button is used to publish a previously saved page to the live website or to publish a page without previewing it. The **Save and publish** feature will save and publish the page to your live website.

![Save and Publish](images/Save-and-publish-v9.png)

The **Save and publish** button has three options:

#### 1: Schedule

The **Schedule** button allows you to set a time and a date for when your page should be published. With this option, you can continue working on your edits and the site will automatically be published at the time and date it was scheduled to.

![Schedule](images/Schedule-v9.png)

To set up scheduled publishing, follow these steps:

1. Navigate to the page you want to publish.
2. Select the arrow next to the **Save and Publish** button.
3. Select **Schedule**.
4.  In the **Scheduled Publishing** window, set the date and time in the **Publish at** field.

    ![Scheduled publishing.](images/Schedule\_publishing\_v9.png)
5. Select **Schedule**.

#### 2: Publish with descendants

The **Publish with descendants** button allows you to publish the current page and all the content linked to this page to the live site. Using this option, you can publish the current parent page and it's child nodes, previously published, and unpublished content items.

To publish the node with descendants, follow these steps:

1. Navigate to the page you want to publish.
2. Select the arrow next to the **Save and Publish** button.
3.  Select **Publish with descendants**.

    ![Publish with descendants](images/Publish-with-descendants-v9.png)
4.  Toggle the option to **Include unpublished content items** if you wish to. This option includes all unpublished content items for the selected page and the available linked pages.

    ![Publish with descendants](images/Publish-with-descendants2-v9.png)

#### 3: Unpublish

The **Unpublish** button allows you to unpublish a page if you do not want a page to be publicly visible and do not want to delete it.

To unpublish a page, follow these steps:

1. Navigate to the page you want to unpublish.
2. Select the arrow next to the **Save and Publish** button.
3. Select **Unpublish**.

![Unpublish](images/Manually-unpublishing-v9.png)

You can also unpublish your page by setting the date and time using the **Schedule** feature.

To set up scheduled unpublishing, follow these steps:

1. Navigate to the page you want to unpublish.
2. Select the arrow next to the **Save and Publish** button.
3. Select **Schedule**.
4.  In the **Scheduled Publishing** window, set the date and time in the **Unpublish at** field.

    ![Scheduled unpublishing.](images/Schedule\_Unpublishing\_v9.png)
5. Select **Schedule**.

## Comparing Content between environments

{% hint style="info" %}
**Compare** content is available in all Umbraco Cloud projects running the latest version of Umbraco Deploy for Umbraco versions 8 and 9.
{% endhint %}

Compare Content allows previewing content changes before transferring them to another environment. This is helpful to ensure that the correct updates are transferred when working with content in multiple environments.

You can see the **Summary Information** and **Field Comparison** values to understand what will change if you proceed to transfer the content to a higher environment or try restoring content to the current environment.

To compare content between environments, follow these steps:

1. Navigate to the page you want to compare.
2. Select the arrow next to the **Save and Publish** button. Alternatively, you can right-click the content node or click the **Actions** drop-down.
3.  Select **Compare** to open the **Compare** window.

    ![Compare option](images/Compare\_option.png)
4. **Choose the workspace** from the drop-down field.
5. View the **Summary information**.
6. In the **Field Comparison** table, view the differences between the versions in the two workspaces at the node level of each field.
7. Proceed to transfer the content using the **Queue for transfer** or **Transfer now** options.
8. Restore the content from the higher environment using the **Partial restore** option.
9.  Click **Close** to continue editing the content node.

    ![Comparing Content](images/Comparing\_Content.png)

## Transferring content

{% hint style="info" %}
**Transfer now** is available in all Umbraco Cloud projects running the latest version of Umbraco Deploy for Umbraco versions 8 and 9.
{% endhint %}

You can transfer a specific content node directly to the higher environment without adding it to the **Queue for transfer**.

To transfer content between environments, follow these steps:

1. Navigate to the page you want to transfer.
2. Select the arrow next to the **Save and Publish** button.
3.  Select **Transfer now**.

    ![Transfer option](images/Transfernow\_option.png)
4. In the **Transfer now** window, a message is displayed that you are about to transfer the content node directly to the higher environment, without adding it to the queue. ![Transfer Content](images/Transfer\_Content.png)
5. Click **Transfer now**.
