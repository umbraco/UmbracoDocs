---
description: >-
  A deployment model that relies on Git, Kudu, and Umbraco Deploy core
  technology to move your changes from one environment to another.
---

# Deployment

Umbraco Cloud uses a deployment model based on Git, Kudu, and Umbraco Deploy core technology to move changes between environments. This follows a "left to right" model. Changes start in the local or left-most environment and are deployed to the production environment.

![Left to right model](images/left-to-right.png)

## Deployment Approach

Umbraco Cloud separates metadata and content during deployment. Metadata includes Document Types, Templates, Forms, Views, and config files. Content includes content items and media.

**Key Terms:**

* **Deploy:** Moves metadata between environments using a Git client or the Umbraco Cloud Portal.
* **Transfer:** Moves content and media directly via the Umbraco backoffice.

**Deployment Types:**

* **Metadata Deployment:** Metadata, including Document Types, Templates, Forms, Views, and config files, is stored in a Git repository. These are **deployed** between environments using a Git client or the Umbraco Cloud Portal.
* **Content and Media Transfer:** Content and Media items are **not** stored in the Git repository. Instead, they must be **transferred** directly from the Umbraco backoffice using the **Queue for Transfer** option. Once all required items are queued, the **Deployment** Dashboard in the **Content** section is used to complete the transfer.

Content editors do not need Umbraco Cloud Portal access. They can manage content through the backoffice, while developers handle metadata deployments via Git.

### Deploying Metadata

The source and target environments must be in sync before transferring content and media. Deploy metadata first to ensure consistency.

* [Deploy changes from Local to Cloud](local-to-cloud.md)
* [Deploy changes between Cloud environments](cloud-to-cloud.md)
* [Umbraco Forms on Cloud](umbraco-forms-on-cloud.md)

### Transfer Content and Media

Content and media move between environments through the Umbraco backoffice. Content can be transferred from Local to Development and restored from Live or Staging.

* [Transfer Content and Media](content-transfer.md)
* [Restore Content and Media](restoring-content/)

{% hint style="info" %}
The transfer and restore process is the same for Local to Cloud and between Cloud environments.
{% endhint %}

## [Deploy Settings](https://docs.umbraco.com/umbraco-deploy/deploy-settings)

All configuration for Umbraco Deploy is stored in the `appSettings.json` file found at the root of your Umbraco website.

## Environment Restart

Some deployments can trigger an Umbraco Cloud environment to restart. The table below outlines which actions initiate a restart.

| Action:                             | Application Restart? |
| ----------------------------------- | -------------------- |
| Config file change                  | Yes                  |
| Metadata deployment                 | No                   |
| File change (for example, CSS file) | No                   |
| Content or Media transfer           | No                   |

### Manual Restart

From the Umbraco Cloud Portal, you can manually restart your environments.

<figure><img src="../.gitbook/assets/image (38).png" alt="Restart an environment"><figcaption><p>Restart an environment</p></figcaption></figure>

## Umbraco-cloud.json

The `umbraco-cloud.json` file defines deployment settings, identifies the current environment, and determines the next deployment target.

![Clone dialog](images/Umbraco-cloud-json.png)

{% hint style="info" %}
The `name` attribute in the `umbraco-cloud.json` can be updated to clarify deployment destinations in the Workspaces dashboard.
{% endhint %}

![clone dialog](images/change-env-name-v8.png)

***



{% include "../.gitbook/includes/umbraco-training-cloud.md" %}
