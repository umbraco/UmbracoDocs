---
description: A description of the proper workflow when working with Umbraco Deploy
---

# Deployment

Umbraco Deploy uses a deployment model that relies on Git and Umbraco Deploy core technology to move your changes from one environment to another. Umbraco Deploy uses a classic "left to right" deployment model, meaning that changes are first made in the Development or local environment and then deployed to the production or Live environment.

{% hint style="info" %}
If your project contains a Staging environment, deployments will be made from Development to Staging and then from Staging to Live.
{% endhint %}

![Left to right model](../.gitbook/assets/left-to-right.png)

## Deployment Approach

Umbraco Deploy uses a two-part deployment approach where we keep metadata (Document types, templates, etc) and content (Content and Media) as separate parts of a deployment. In order to be able to distinguish between the two types of deployments, we use the term _transfer_ for content and media deployments and the term _deploy_ for metadata deployments.

In summary:

1. Metadata such as Document Types, Templates, Forms, Views, and config files are stored in a repository and are **deployed** between environments. This can be achieved using a CI/CD deployment pipeline with something like GitHub Actions or Azure DevOps.
2. Content and Media items are **not** stored in the repository. These need to be **transferred** directly from the Umbraco backoffice using the _"Queue for Transfer"_ option. Once a content editor has all the items needed for a transfer, they will use the Deployment Dashboard in the Content section to transfer the items in the queue.

### Deploying Metadata

To transfer content and media, the source and target environments need to have the same setup. They need to be in sync and have the same file structure. To achieve this, you need to deploy your metadata changes to the target environment.

* [Deploying from your local machine to your environments](deploying-changes.md)

### Transfer Content and Media

Moving your content and media between your environments is done through the Umbraco backoffice. You can transfer content from one environment to another, for example, from local to your development environment. You also have the option to restore content and media to your local or development environment from your production/Live or staging environment.

* [Transfer Items](content-transfer.md)
* [Restore Items](restoring-content.md)

{% hint style="info" %}
Transferring and restoring content and media works the same way whether you work locally or between two environments.
{% endhint %}

### Import and Export

Another approach for transferring content and schema between environments is to use import and export. In one environment, you can export selected content, a tree, or the whole workspace to a .zip file. There are options to include related media files, schema, and code files, such as templates and stylesheets.

Read more about the [import and export](import-export.md) feature.

## Deploy Settings

In Umbraco Deploy, we have included a collection of Deploy-specific pages in the Settings section. These enable you to run operations such as schema deployment from data files and schema extraction to data files.

Learn more about the different options in the [Deploy Settings article](deploy-dashboard.md).
