---
versionFrom: 8.0.0
---

# Webhooks

In this article you can learn more about how to use Webhooks, and how to set them up.

Webhooks from the backoffice works the same way as the webhooks from the portal. It gives you an option to hook into different actions in order to post information about the action elsewhere.

## Usage

An example of when to use webhooks would be if you have a website created with a static page builder.

By adding a webhook to a specific URL and selecting an **Event Trigger** you are able to automatically update the website by sending the data from the webhook to the static page builder.

## Setting up a webhook

From the Webhooks menu under the Settings section you can create and manage your webhooks.

![Webhooks Dashboard](images/webhooksDashboards.png)

Clicking **Create Webhook** will open the creation menu on the right side.

![Add Webhooks Menu](images/addWebhook.png)

From here you add the URL that the webhook should call and select the **Event** that should trigger the webhook. Lastly, you can choose a Content Type you wish the webhook to trigger on.

Do note that you will have to choose the type of event first and that this field is not mandatory.

Once the webhook has been created you can manage it from the list. 

![Manage Webhooks](images/manageWebhooks.png)

Should you at some point need to temporarily pause the webhook, you can disable them by selecting **Edit** and uncheck **Enabled**.

## Outgoing IPs for webhooks

Webhooks will be fired from either of the IPs below.

When you are working with an external service that is behind a firewall and that service needs to communicate with your Umbraco Heartcore project in order to receive webhook data you need to make sure that the following IPs are allowed to bypass the firewall.

```
13.69.68.63
52.136.251.35
51.144.177.200
51.144.100.70
51.144.127.200
51.144.45.23
52.232.102.225
52.136.233.87
52.136.247.194
51.145.129.179
```
