---
versionFrom: 8.0.0
---

# Working with content

Whether you're building your website around the sample content or you're setting everything up from scratch, content is the most important part of your website. Every landing page, section and article are created and maintained from the **Content** section of the Umbraco Backoffice.

In Umbraco Uno there are a hand-full of options for creating content along with a long list of customizable elements. This article aims to give you the basics of working with content be it updating, creating or even deleting.

## Overview

* [Creating content](#creating-content)
* [Updating content](#updating-content)
* [Deleting content](#deleting-content)
* [Publishing content](#publishing-content)
* [Unpublishing content](#unpublishing-content)
* [Other options](#other-options)

## Creating content

Whether you're creating a new landing page, a new section or a feed area, the process of creating a new piece of content follows the same flow:

1. In the Content tree, hover over the piece of content that you want to create a new piece of content under - this could be the Start node or another landing page
2. Selecting the three little dots will open a "Create" dialog
3. From the "Create" dialog, choose which type of content you want to create - choose between **Page** and **Feed**
4. Select the chosen type and a workspace area will now display a blank piece of content
5. Give the content item a name
6. Setup the page
7. Finalize the creation of the page by **Saving** it

While working on a piece of content you can use the *Preview* feature to preview how the page looks. Once the page is done you can choose to either publish it right away, or schedule when the page should be published.

When you have a website that uses multiple languages, you can create a new *variant* of the content item for each language you're using. 

## Updating content

To update and make changes to already existing content, follow these steps:

1. Select the content item that needs updating from the Content tree in the Content section
2. Use the workspace area to make the needed updates to the content item
3. Use the *Preview* feature to preview the new changes
4. Save and/or publish the item

## Deleting content

In some cases you might need to delete page or entire sections of your website. That can be done by following these steps:

1. In the Content tree, locate the content item or section that you need to delete
2. Right-click the content item - when deleting an entire section, right-click the parent item
3. From the dialog, choose "Delete..."
4. Select "OK" to confirm the deletion

Once a piece of content or a section has been deleted, it will be moved to the **Recycle Bin** which is accessible from the Content tree. It is possible to **restore** deleted content by either moving the item back under the start node or by right-clicking it in the Content tree and choosing "Restore".

## Publishing content

When you're done editing a piece of content you can choose to either publish the page right away or you can schedule it for a later point on time.

To **publish the content right away** select the green "Save and publish" button in the bottom-right corner.

To schedule to content for another point in time select the "Schedule..." option, which canbe found by clicking the arrow next to the green "Save and publish" button in the bottom-right corner.

## Unpublishing content

Once a page is published on your website you can at any time choose to unpublish it. The option to do this is available from the publish menu which is accessible through the arrow next to the green "Save and publish" button in the bottom-right corner.

## Other options

When you right click a piece of content in the Content tree, you will be presented with a list of different options. Some of the options are described further up in this article, the rest will be shortly explained below.

### Create Content Template

This feature allows you to use the selected piece of content to create a Content Template which can be used to create additional content.

### Move

Move the content item to another section in the Content tree.

### Copy

Create a copy of the selected content item, and choose where the new copy should be located in the tree.

### Sort

This feature allows you to change the order of the content items and sections in the Content tree.

This will also affect how the main navigation is ordered, if you haven't enabled the custom navigation.

### Culture and Hostnames

Choose a specific hostname for the content item or section, and decide which culture (language) should be associated with it.

### Permissions

This options lets you specify permissions on the selected piece of content for each user group. Note that this will overwrite the overall permissions which are configured on the User Group.

Learn more about User Groups and permissions in the [Manage Users](../../Manage-users) section.

### Public access

This feature lets you control who should have access to view a specific page on the frontend of your website.

When you're creating a website that allows users to sign up for a membership, you can create pages and sections that only (some) members can see once they're logged in.

Learn more about this feature in the [Manage users](../../Manage-users) section.

### Notifications

You can setup notifications to be notified whenever a specific action is performed on the selected piece of content. The actions include, but are not limited to: copy, delete, rollback and update.

### Reload

This option will reload the sub pages for the selected piece of content.

:::tip
Use this option on the start node to reload the entire Content tree.
:::
