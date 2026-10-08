---
description: >-
  Learn how to create, save, and publish content pages in the Umbraco
  backoffice, including scheduling and unpublishing options.
---

# Creating, Saving and Publishing Content Options

In this article, you get an overview of how to create and save pages. You will also learn more about how to publish and unpublish your content.

If you are a Cloud user, you will also learn how to compare and transfer content between environments. In Umbraco Cloud, an environment is a separate workspace such as Development, Staging, or Live/Production. It lets you preview and test changes before moving them to your live site. For more information about environments, see the [Environments](https://docs.umbraco.com/umbraco-cloud/begin-your-cloud-journey/project-features/environments) article in the Umbraco Cloud documentation.

## Creating a New Page

Select the parent page to create your new page. The parent page can be the home page or any of the sub-pages of the site.

If the parent page allows sub-pages underneath it, follow these steps:

1. Hover over the name of the parent page in the **Content** section and click **•••** to view the types of pages you can create.
2. Select the page type you wish to create. The new page is loaded in the editor on the right-hand side.
3. Enter a **Name** for the page and click **Save**.

![New Page](../../.gitbook/assets/creating-new-page-18.png)

## Saving and Publishing Pages

There are three different options for saving and publishing pages. The options vary depending on whether you’re still in the process of editing the page or you’re ready to publish your changes.

![Save and Publish](../../.gitbook/assets/save-and-publish-18.png)

### Option 1: Save and Preview

The **Save and preview** button allows you to save your changes and preview it before publishing the changes to the live site. The **Preview** feature shows you how the page will look once it is published. This **Save and preview** feature only saves your page and does not publish your contents to the live site.

### Option 2: Save

The **Save** button is used for saving the page without publishing the changes to the live site. The Save feature prevents data loss during long-term projects. Use it frequently to protect your ongoing changes.

### Option 3: Save and Publish

The **Save and publish** button is used to publish a previously saved page to the live website or to publish a page without previewing it. The **Save and publish** feature will save and publish the page to your live website.

The **Save and publish** button has three options:

![Schedule](../../.gitbook/assets/publish-options-18.png)

#### 1: Schedule

The **Schedule** button allows you to set a time and a date for when your page should be published. The Schedule option lets you keep editing your page. The site will automatically publish at your scheduled date and time.

To set up scheduled publishing, follow these steps:

1. Navigate to the page you want to publish.
2. Select the arrow next to the **Save and Publish** button.
3. Select **Schedule publish**.
4. In the **Scheduled Publishing** window, set the date and time in the **Publish at** field.

![Scheduled publishing](../../.gitbook/assets/scheduled-publishing-18.png)

5. Select **Schedule**.

#### 2: Publish with descendants

The **Publish with descendants** button allows you to publish the current page and all the content linked to this page to the live site. Using this option, you can publish the current parent page and its child nodes, previously published, and unpublished content items.

To publish the node with descendants, follow these steps:

1. Navigate to the page you want to publish.
2. Select the arrow next to the **Save and Publish** button.
3. Select **Publish with descendants**.
4. Toggle the option to **Include unpublished content items** if you wish to. This option includes all unpublished content items for the selected page and the descendant pages.

#### 3: Unpublish

The **Unpublish** button allows you to unpublish a page if you do not want a page to be publicly visible.

To unpublish a page, follow these steps:

1. Navigate to the page you want to unpublish.
2. Select the arrow next to the **Save and Publish** button.
3. Select **Unpublish**.

![Unpublish](../../.gitbook/assets/unpublish-18.png)

Take note of any listed items with dependencies on the content your are unpublishing. This will typically be child items published under the content you have selected.

You can also unpublish your page by setting the date and time using the **Schedule** feature.

To set up scheduled unpublishing, follow these steps:

1. Navigate to the page you want to unpublish.
2. Select the arrow next to the **Save and Publish** button.
3. Select **Schedule**.
4. In the **Scheduled Publishing** window, set the date and time in the **Unpublish at** field.

![Schedule Unpublishing](../../.gitbook/assets/scheduled-publishing-18.png)

5. Select **Schedule**.
