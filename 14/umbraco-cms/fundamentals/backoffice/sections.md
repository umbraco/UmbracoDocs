---
description: >-
  In this article you can learn more about the various sections you can find
  within the Umbraco Backoffice.
---

# Sections

A section in Umbraco is where you perform specific tasks related to a particular area of Umbraco. For example Content, Settings, and Users are all sections. You can navigate between the different sections by clicking the corresponding icon in the section menu which is positioned at the top of the Backoffice.

_The **Section menu** is the horizontal menu located at the top of the Umbraco Backoffice._

![Section](images/highlight-sections-v14.png)

Umbraco comes with the following default sections:

## Content

The Content section contains the content of the website. Content is displayed as nodes in the content tree.

Nodes in Umbraco can display the following content states:

* **Save and Preview**: The content changes are saved and can be previewed to see how it will look when published.
* **Save**: The content is being worked on and has not been published.
* **Save and Publish**: The content is saved and ready to be published.
* **Schedule**: The content is set to be published at a specific future date and time.
* **Unpublish**: The content is saved but is removed from the website.
* **Pending Approval**: The content is awaiting review or approval before it can be published.

In order to create content, you must define it using Document Types.

For more information, see the [Defining Content](../../fundamentals/data/defining-content/README.md) article.

## Media

The Media section contains the media for the website. By default, you can create folders and upload media files, such as images and PDFs. Additionally, you can customize the existing media types or define your own from the Settings section.

For more information, see the [Creating Media](../../fundamentals/data/creating-media/README.md) article.

## Settings

The Settings section allows you to manage website layout files, languages, media, content types, and access the Log Viewer for reviewing log files.

The Settings section consists of:

**Structure**

* Document Types
* Media Types
* Member Types
* Data Types
* Languages
* Document Blueprints

**Templating**

* Templates (`.cshtml` files)
* Partial views (`.cshtml` files)
* Stylesheets (`.css` files)
* Scripts (`.js` files)

**Advanced**

* Relations
* Log Viewer
* Extension Insights
* Webhooks

The **Settings** section in the Umbraco backoffice has its own set of default dashboards.

For more information, see the [Settings Dashboards](settings-dashboards.md) article.

## Packages

In this section, you can browse the different packages available for your Umbraco solution. You can also get an overview of all the packages you have installed or created.

For more information, see the [Packages](../../extending/packages/README.md) article.

## Users

The Users section allows administrators to manage user accounts, assign permissions, set user roles, and monitor user activity within the backoffice. It provides control over who can access and modify content, media, and settings in the CMS.

For more information, see the [Users](../../fundamentals/data/users.md) article.

## Members

The Members section allows to create and manage member profiles, set up member groups, and control Member's access to restricted content on the website.

For more information, see the [Members](../../fundamentals/data/members.md) article.

## Translation

The Translation section is where you create and manage Dictionary Items. By managing these dictionary items, you can ensure consistent and efficient content translation and maintenance across different languages.

For more information, see the [Dictionary Items](../../fundamentals/data/dictionary-items.md) article.

## Add-On Sections

You can enhance Umbraco's functionality with plugins and extensions tailored to specific needs, expanding capabilities beyond core features. Currently, Umbraco supports add-ons like Forms, Deploy, Workflow, Commerce, and UI Builder. You can find the different packages at [Umbraco Marketplace](https://marketplace.umbraco.com/).

For more information, see the [Umbraco DXP](https://docs.umbraco.com/umbraco-dxp) documentation.

## Help Section

The Help section in Umbraco provides documentation and resources to assist in understanding and effectively using the Umbraco CMS. It typically includes the following in the _Getting Started_ Dashboard:

* **Documentation**: Comprehensive guides, tutorials, and references covering different aspects of Umbraco.
* **Community Forums**: Access to forums where you can ask questions, share knowledge, and seek assistance from other Umbraco community members.
* **Resources**: Stay updated with the latest news, access documentation, watch free video tutorials, and register for live demos.
* **Training**: Learn how to effectively use Umbraco through structured courses, webinars, and hands-on tutorials designed to enhance your proficiency with the CMS.

The Help section serves as a valuable resource hub in navigating and leveraging the capabilities of the Umbraco CMS effectively.

## Custom Sections

Along with the default sections that come with Umbraco, you can create your own [Custom Sections](../../extending/section-trees/).

## Access based on User Group

A User can access a particular section based on the User Group permissions.

Learn more about how to configure the permissions in the article about [backoffice users](../data/users.md).
