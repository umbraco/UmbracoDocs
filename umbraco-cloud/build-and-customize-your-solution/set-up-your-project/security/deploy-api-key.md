---
description: >-
  Learn how to reroll the Deploy API key for an Umbraco Cloud project and what
  happens to your environments during a reroll.
---

# Deploy API Key

Umbraco Deploy uses the Deploy API key of your project when content and schema are transferred between environments. All environments in a project share the same key.

Reroll the Deploy API key if you suspect the key has been shared or leaked. A reroll generates one new key and applies the new key to every environment. The old key stops working once the reroll completes.

## What happens during a reroll

* All environments are restarted. Each website is unavailable for a short while during the restart.
* The key in the `umbraco-cloud.json` file is updated in the repository of every environment.
* Transfers and deployments that use the old key are rejected.

Learn more about the `umbraco-cloud.json` file in the [Deployment](../../handle-deployments-and-environments/deployment/README.md) article.

## How to reroll the Deploy API key

{% hint style="info" %}
Only project admins can reroll the Deploy API key. Other team members can open the page and follow a reroll in progress.
{% endhint %}

1. Go to **Deploy** under the **Security** tab.
2. Click **Reroll Deploy API key**.
3. Read the consequences listed in the dialog and click **Reroll key**.

The page lists every environment and its status while the reroll runs. A confirmation is shown when every environment uses the new key.

After the reroll has completed:

* Pull the latest changes into any local clone before the next transfer.
* Update any local development setup that uses the old key.

If a reroll fails, the page shows which environment failed. Run the reroll again to bring every environment back onto one key.

## Baseline projects

A baseline project shares the Deploy API key with all child projects. Learn more about baseline projects in the [Baselines](../../../begin-your-cloud-journey/creating-a-cloud-project/baselines.md) article.

* Rerolling the key on a baseline project also applies the new key to every child project. The environments of the child projects are restarted too.
* The key cannot be rerolled from a child project. Reroll the key from the baseline project instead.
