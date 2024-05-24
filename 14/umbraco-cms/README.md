---
description: This is the documentation for the next major of Umbraco, version 14.
---

# Umbraco 14 (RC) CMS Documentation

{% hint style="danger" %}
This documentation is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.

The new Backoffice for Umbraco CMS is scheduled for release along with Umbraco 14 in May 2024.
{% endhint %}

### Getting started with the Umbraco 14

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th><th data-hidden data-card-cover data-type="files"></th></tr></thead><tbody><tr><td></td><td><a href="fundamentals/setup/"><strong>Getting Started</strong></a></td><td>Are you excited to discover the new Backoffice for Umbraco CMS? Head over to the Setup section to learn how to install and configure v14 Umbraco installation.</td><td><a href="fundamentals/setup/">setup</a></td><td><a href=".gitbook/assets/Documentations Icons_Umbraco_CMS_Install (1).png">Documentations Icons_Umbraco_CMS_Install (1).png</a></td></tr><tr><td></td><td><a href="extending/customize-backoffice/README.md"><strong>Customizing the Backoffice</strong></a></td><td>Want to learn how to set up a package and implement the Backoffice extensions? Let's get started!</td><td><a href="extending/customize-backoffice/README.md">customize-backoffice.md</a></td><td><a href=".gitbook/assets/Documentations Icons_Umbraco_CMS_Fundamentals_Backoffice (1) (2).png">Documentations Icons_Umbraco_CMS_Fundamentals_Backoffice (1) (2).png</a></td></tr><tr><td></td><td><a href="broken-reference/"><strong>Tutorials</strong></a></td><td>Our step-by-step guides will take you through creating a basic website, creating a custom dashboard todeep diving into the world of Property Editors. Don't wait, start exploring now.</td><td><a href="broken-reference/">broken-reference</a></td><td><a href=".gitbook/assets/Documentations Icons_Umbraco_CMS_Tutorials_the_Starter_Kit (1).png">Documentations Icons_Umbraco_CMS_Tutorials_the_Starter_Kit (1).png</a></td></tr></tbody></table>

### Recommended starting points

1. [Install v14](fundamentals/setup/install/)-RC

{% hint style="warning" %}
If you have previously installed the Nightly or pre-release feeds versions you must clear the cache to use the new versions. This can be done by running the following command:

`dotnet nuget locals all --clear`

Then restore your package with `dotnet restore` and run the solution again with `dotnet run`.
{% endhint %}

2. [Setup your development Environment](extending/customize-backoffice/development-flow/README.md) followed by [Vite package setup](extending/customize-backoffice/development-flow/vite-package-setup.md)
3. [Creating your first extension](tutorials/creating-a-basic-website/creating-your-first-template-and-content-node.md)
4. [Creating a custom dashboard](tutorials/creating-a-custom-dashboard/)
5. [Creating a property editor](tutorials/creating-a-property-editor/)
6. [Terminology](extending/customize-backoffice/README.md#terminology)
7. [UI Documentation](extending/ui-documentation.md)
8. [Creating your own api](fundamentals/backoffice/create-your-own-api.md)

{% hint style="info" %}
You can also find a list of other resources related to the new backoffice of Umbraco in the [Umbraco v14 "Bellissima" Resources](https://github.com/umbraco/Umbraco.Packages/tree/main/bellissima) article.
{% endhint %}

### Breaking Changes

Some breaking changes have been introduced in the Umbraco 14. You can find the list of breaking changes or other changes from v14 in the [Version Specific Upgrades](fundamentals/setup/upgrading/version-specific/) article. In the same article, you can find the breaking changes between each v14 version.

You can also find a sneak peak of what is upcoming on v14 of the CMS in the [Umbraco Product Update Blog](https://umbraco.com/blog/umbraco-product-update-february-2024/#CMS).

### New and Updated articles

Below you will find a list of new and updated articles for Umbraco 14.

The list will be updated as more articles have been created and updated.

* **FUNDAMENTALS**:
  * **SETUP**
    * [Installation](fundamentals/setup/install/)
    * Upgrade your project
      * [Version specific upgrades](fundamentals/setup/upgrading/version-specific/)
  * **BACKOFFICE**:
    * [Document Blueprints](fundamentals/backoffice/document-blueprints.md) (previously known as Content Templates)
    * [Create a custom API](fundamentals/backoffice/create-your-own-api.md)
* **EXTENDING**
  * More or less all articles are new.
* **REFERENCE**:
  * [Two-factor Authentication](reference/security/two-factor-authentication.md)
  * [Management API](reference/management-api/) (new article)
    * [Setup OAuth using Postman](reference/management-api/postman-setup-swagger.md) (new article)
  * [Custom Swagger API](reference/custom-swagger-api.md) (new article)
* **TUTORIALS**:
  * [Create your first extension](tutorials/creating-your-first-extension.md) (new article)
  * [Creating a Custom Dashboard](tutorials/creating-a-custom-dashboard/)
  * [Creating a Property Editor](tutorials/creating-a-property-editor/)
  * [Implementing Custom Error Pages](tutorials/custom-error-page.md)
