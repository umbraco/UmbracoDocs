---
description: >-
  A deployment model that relies on Git, Kudu, and Umbraco Deploy core
  technology to move your changes from one environment to another.
---

# Deployment

Umbraco Cloud uses a deployment model that relies on Git, Kudu, and Umbraco Deploy core technology to move your changes from one environment to another. Umbraco Cloud uses a classic "left to right" deployment model - changes are first made in the Development or local environment and then deployed to the Live environment.

{% hint style="info" %}
If your project contains a Staging environment, deployments will be made from Development to Staging and then from Staging to Live.
{% endhint %}

![Left to right model](images/left-to-right.png)

## Deployment Approach

Umbraco Cloud uses a two-part deployment approach where we keep metadata (Document types, templates, etc) and content (Content nodes and Media) as separate parts of deployment. To be able to distinguish between the two types of deployments, we use the term _transfer_ for content and media deployments and the term _deploy_ for metadata deployments. In summary:

1. Metadata such as Document Types, Templates, Forms, Views, and config files are stored in a Git repository and are **deployed** between environments using either a Git client or the Umbraco Cloud Portal.
2. Content and Media items are **not** stored in the Git repository. These need to be **transferred** directly from the Umbraco backoffice using the **Queue for Transfer** option. Once a content editor has all the items needed for a transfer, they will use the **Deployment** Dashboard in the **Content** section to transfer the items in the queue.

With this arrangement, you don't need to grant Umbraco Cloud portal access to your content editors. Instead, allow them access only to the required backoffice sections of your sites. This also allows developers to focus on deploying metadata that is stored in the site's Git repository and content editors to focus on transferring content that is stored as Umbraco data.

### Video Tutorial

Learn more about the deployment approach in this video, which will also show you how to deploy metadata as well as how to transfer content and media. Below you'll find links to articles containing step-by-step guides for each approach.

{% embed url="https://www.youtube.com/embed/sjId_hN1ba0?rel=0" %}
Video example.
{% endembed %}

### Deploying Metadata

To transfer content and media, the source environment and the target environment needs to have the same setup. They need to be in sync and have the same file structure. To achieve this you need to deploy your metadata changes to the target environment.

* [Deploy changes from Local to Cloud](local-to-cloud.md)
* [Deploy changes from one Cloud environment to another](cloud-to-cloud.md)
* [How Forms are handled on Cloud](umbraco-forms-on-cloud.md)

### Transfer Content and Media

Moving your content and media between your environments is done through the Umbraco Backoffice. You can transfer content from one environment to another, e.g. from Local to your Development environment. You also have the option to restore content and media to your Local or Development environment from your Live or Staging environment.

* [Transfer Content and Media](content-transfer.md)
* [Restore Content and / or Media](restoring-content/)

{% hint style="info" %}
Transferring and restoring content and media is the same whether you are working between Local and Cloud or you are working between two Cloud environments.
{% endhint %}

## [Deploy Settings](https://docs.umbraco.com/umbraco-deploy/deploy-settings)

All configuration for Umbraco Deploy is held in the `appSettings.json` file found at the root of your Umbraco website.

## Environment Restart

Some deployments can cause an Umbraco Cloud environment to restart. See the table below to learn which actions initiate an application restart.

| Action:                           | Application Restart? |
| --------------------------------- | -------------------- |
| Config file change                | Yes                  |
| Metadata deployment               | No                   |
| File change - Example: _css-file_ | No                   |
| Content and/or Media transfer     | No                   |

### Manual Restart

From the Umbraco Cloud Portal, you can manually restart your environments.

<figure><img src="../.gitbook/assets/image (38).png" alt="Restart an environment"><figcaption><p>Restart an environment</p></figcaption></figure>

## Umbraco-cloud.json

You might notice a file in your cloud project called `umbraco-cloud.json`. This file tells the deployment engine where to deploy to, it knows which environment you’re currently on (for example, local or staging) and chooses the next environment in the list to deploy to.

![clone dialog](images/Umbraco-cloud-json.png)

{% hint style="info" %}
You are free to update the `name` attribute in the `umbraco-cloud.json` file to make it clear in the **Workspaces** dashboard where you’re deploying to. So if you want to name the _Development_ environment to “Everything goes here” then you can do that and the name will be displayed on the dashboard when deploying to that environment.
{% endhint %}

![clone dialog](images/change-env-name-v8.png)

***

## Umbraco Training

Umbraco HQ offers a full-day training course covering best practices for developing with Umbraco Cloud. The course targets frontend and backend developers who currently work or plan to work with Umbraco Cloud.

[Explore the Umbraco Cloud Developer Training Course](https://umbraco.com/training/course-details/cloud-developer/) to learn more about the topics covered and how it can enhance your Umbraco development skills.
