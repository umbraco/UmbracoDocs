---
description: A description of the proper workflow when working with Umbraco Deploy
---

# Deployment

Umbraco Deploy uses a deployment model that relies on Git and Umbraco Deploy core technology to move your changes from one environment to another. Umbraco Deploy uses a classic "left to right" deployment model, meaning that changes are first made in the Development or local environment and then deployed to the production environment.

{% hint style="info" %}
If your project contains a Staging environment, deployments will be made from Development to Staging and then from Staging to Live.
{% endhint %}

![Left to right model](images/left-to-right.png)

## Deployment Approach

Umbraco Deploy uses a two-part deployment approach where we keep meta data (Document types, templates, etc) and content (Content nodes and Media) as separate parts of a deployment. In order to be able to distinguish between the two types of deployments we use the term _transfer_ for content and media deployments and the term _deploy_ for meta data deployments.

In summary:

1. Meta data such as Document Types, Templates, Forms, Views and config files are stored in a repository and are **deployed** between environments. This can be achieved using a CI/CD deployment pipeline with something like GitHub Actions or Azure DevOps.
2. Content and Media items are **not** stored in the repository. These need to be **transferred** directly from the Umbraco backoffice using the _"Queue for Transfer"_ option. Once a content editor has all the items needed for a transfer they will use the Deployment Dashboard in the Content section to transfer the items in the queue.

### Deploying meta data

In order to be able to transfer content and media, the source environment and the target environment needs to have the same setup - meaning they need to be completely in sync and have the same file structure. To achieve this you need to deploy your meta data changes to the target environment.

* [Deploying from your local machine to your environments](deploying-changes.md)

### Transfer Content and Media

Moving your content and media between your environments is done through the Umbraco backoffice. You can transfer content from one environment to another, e.g. from local to your development environment. You also have the option to restore content and media to your local or development environment from your production or staging environment.

* [Transfer Content and Media](content-transfer.md)
* [Restore Content and/or Media](restoring-content/)

{% hint style="info" %}
Transferring and restoring content and media is the same whether you are working locally and transferring between two environments.
{% endhint %}

{% embed url="https://www.youtube.com/embed/poRzuBB11pc?rel=0" %}
Umbraco Deploy - Content transfer and deploy
{% endembed %}

### Import and Export

Another approach for transferring content and schema between environments is to use import and export. In one environment, you can export selected content, a tree, or the whole workspace to a .zip file. There are options to include related media files, schema and code files such as templates and stylesheets.

That .zip file can then be uploaded into a new environment, where it will be validated and then processed to update Umbraco.

As part of the import process, we provide hooks to allow for migrations of the imported artifacts (like data types) and property data. This should allow you to migrate your Umbraco data from one Umbraco major version to a newer one.

We recommend using the content and media backoffice transfer options for day-to-day editorial activities. Import and export is intended more for larger transfer options, project upgrades, or one-off tasks when setting up new environments.

Read more about the [import and export](import-export.md) feature.

## Deploy Dashboard

In Umbraco Deploy we have included a Deploy Dashboard in the Settings section of the Umbraco backoffice to make it easier to run operations like schema deployment from data files and extract schema to data files.

When running the `extract schema to data files` operation, Umbraco Deploy will run an `echo > deploy-export` in the data folder of your project which is used to generate UDA files based on the schema in your database.

Running the `schema deployment from data files` operation will initiate an extraction on the environment

The extraction will end in one of two possible outcomes:

1. `deploy-complete`: The extraction succeeded and your environment is in good shape!
2. `deploy-failed`: The extraction failed - open the deploy-failed file, to see the error message.

It is also possible to see which version of Umbraco Deploy you are running, when the last operation was started and the status of the deployment operation.

<figure><img src="../.gitbook/assets/image (15).png" alt="Deploy Dashboard"><figcaption><p>Deploy Dashboard</p></figcaption></figure>

{% embed url="https://www.youtube.com/embed/l5qdTsIddKM?rel=0" %}
Umbraco Deploy - Content transfer and deploy
{% endembed %}
