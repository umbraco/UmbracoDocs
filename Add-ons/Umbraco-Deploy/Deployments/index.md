---
versionFrom: 8.0.0
---

# Deployment

Umbraco Deploy uses a deployment model that relies on Git and Umbraco Deploy core technology to move your changes from one environment to another. Umbraco Deploy uses a classic "left to right" deployment model, meaning that changes are first made in the Development or local environment and then deployed to the production environment.

__Note:__ If your project contains a Staging environment, deployments will be made from Development to Staging and then from Staging to Live.

![Left to right model](images/left-to-right.png)

## Deployment Approach

Umbraco Deploy uses a two-part deployment approach where we keep meta data (Document types, templates, etc) and content (Content nodes and Media) as separate parts of a deployment. In order to be able to distinguish between the two types of deployments we use the term *transfer* for content and media deployments and the term *deploy* for meta data deployments.
In summary:

1. Meta data such as Document Types, Templates, Forms, Views and config files are stored in a repository and are **deployed** between environments.
this can be achieved using a CI/CD deployment pipeline with something like Github actions or Azure DevOps.

2. Content and Media items are **not** stored in the repository. These need to be **transferred** directly from the Umbraco backoffice using the *"Queue for Transfer"* option. Once a content editor has all the items needed for a transfer they will use the Deployment Dashboard in the Content section to transfer the items in the queue.

<!-- need new video or need to be removed 
### Video tutorial

Learn more about the deployment approach in this video, which will also show you how to deploy meta data as well as how to transfer content and media. Below you'll find links to articles containing step-by-step guides for each approach.

<iframe width="800" height="450" src="https://www.youtube.com/embed/sjId_hN1ba0?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>-->

### Deploying meta data

In order to be able to transfer content and media, the source environment and the target environment needs to have the same setup - meaning they need to be completely in sync and have the same file structure. To achieve this you need to deploy your meta data changes to the target environment.

 - [Deploying from your local machine to your environments](Deploying-Changes)

### Transfer Content and Media

Moving your content and media between your environments is done through the Umbraco backoffice. You can transfer content from one environment to another, e.g. from Local to your Development environment. You also have the option to restore content and media to your Local or Development environment from your production or Staging environment.

  - [Transfer Content and Media](Content-Transfer)
  - [Restore Content and / or Media](Restoring-content)

**Note:** Transferring and restoring content and media is the same whether you are working Locally and transfering between two environments.

## Deploy Dashboard
