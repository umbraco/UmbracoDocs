---
description: >-
  Set up alert rules on Umbraco Cloud to get email or webhook notifications
  about DDoS attacks, automatic restarts, deployments, and upgrades.
tags:
  - ai-generated
---

# Alerting and Notifications

Alerting and Notifications lets you choose which events on your Umbraco Cloud projects you want to hear about, and where. You set up **alert rules** that send a notification by **email** or to a **webhook** when an event happens. For example, you can be notified when a deployment fails or when a DDoS attack on your site is mitigated.

You can create alert rules for a single project, or for your whole organization. Organization rules can cover every project, including projects you create later.

You can find **Alerting & Notifications** on your project and on your organization in the Umbraco Cloud Portal.

<!-- TODO: confirm the exact menu path for project and organization, for example Insights > Alerting & Notifications -->

{% hint style="info" %}
Notifications are **opt-in**. If no enabled alert rule matches an event, no notification is sent.
{% endhint %}

<!-- TODO: screenshot of the Alerting & Notifications overview. Proposed file: .gitbook/assets/alerting-overview.png -->

## Key Concepts

| Concept | Description |
| --- | --- |
| **Alert rule** | A subscription to one type of event. The rule defines what to listen for, where to send the notification, and how often at most. |
| **Event type** | The kind of event the rule reacts to, such as **Deployment** or **DDoS**. You can't change the event type after the rule is created. |
| **Condition** | Narrows a rule to specific outcomes. For example, a Deployment rule can be limited to failed deployments. |
| **Destination** | Where the notification goes: an email address or a webhook URL. A rule can have up to 15 destinations. |
| **Cooldown** | The minimum time between two notifications from the same rule. A cooldown keeps you from being flooded during an ongoing incident. |
| **Alert history** | A log of every alert: what fired, when, and whether the notification reached each destination. |

## Available Alerts

| Alert | Sent when | Conditions |
| --- | --- | --- |
| [DDoS](#ddos) | A DDoS attack against one of your hostnames is detected and mitigated. | None |
| [Autoheal](#autoheal) | Umbraco Cloud restarts an environment automatically to recover it. | None |
| [Deployment](#deployment) | A deployment to one of your environments starts, completes, or fails. | Required: one or more of **Started**, **Completed**, **Failed** |
| [Autoupgrade](#autoupgrade) | An upgrade of one of your environments starts, completes, fails, or times out. | Required: one or more of **Started**, **Completed**, **Failed**, **Timed out** |

{% hint style="info" %}
More alert types are planned for a later release. These include end-of-support warnings for your Umbraco version, hosting recommendations, and custom hostname monitoring failures.
{% endhint %}

### DDoS

A DDoS alert is sent when Cloudflare's edge network detects and mitigates a Distributed Denial of Service (DDoS) attack. The alert covers application-layer (HTTP) attacks against a hostname on your project.

The notification includes the affected hostname. Where available, it also includes the attack type, the request rate, and the action taken. For example:

`Hostname: www.example.com. Attack: HTTP DDoS. RPS: 12000. Action: block`

<!-- TODO: confirm the exact attack and action values customers will see -->

For more information about how Umbraco Cloud protects your site, see the [Web Application Firewall](../../../build-and-customize-your-solution/set-up-your-project/security/web-application-firewall.md) article.

### Autoheal

An Autoheal alert is sent when Azure detects that an environment is unhealthy and restarts it automatically.

<!-- TODO: product-approved customer-facing explanation of Autoheal, and what the details text contains -->

An Autoheal alert usually means your site stopped responding for a period. If you receive Autoheal alerts often, check the [log files](../resolve-issues-quickly-and-efficiently/log-files.md) for the cause. Common causes are high memory usage and long-running requests.

For more information about automatic restarts, see the [Platform Configuration](../../../build-and-customize-your-solution/set-up-your-project/project-settings/platform-configuration.md) article.

<!-- TODO: confirm that Autoheal alerts are triggered by Proactive Auto-Heal restarts -->

### Deployment

A Deployment alert is sent when a deployment to one of your environments changes state. When you create the rule, select the outcomes you want to be notified about:

* **Started**: A deployment has begun.
* **Completed**: A deployment finished successfully.
* **Failed**: A deployment did not complete.

The notification shows the outcome and the source and target environments. For example:

`Deployment failed for my-project: Development → Live`

{% hint style="info" %}
To be notified about failures only, create a Deployment rule with only **Failed** selected.

You can create more than one Deployment rule with different outcomes and destinations. For example, send failures to your on-call webhook and completions to a team inbox.
{% endhint %}

Deployment alerts are separate from the [Deployment Webhook](../../../build-and-customize-your-solution/handle-deployments-and-environments/deployment/deployment-webhook.md). The Deployment Webhook is configured per environment, is sent only for successful deployments, and uses a different payload.

### Autoupgrade

An Autoupgrade alert is sent when an environment is upgraded. Select the outcomes you want to be notified about:

* **Started**: An upgrade has begun.
* **Completed**: The upgrade finished successfully.
* **Failed**: The upgrade did not complete.
* **Timed out**: The upgrade did not finish in time.

The notification shows the outcome, the environment, and the upgraded components. For example:

`Autoupgrade completed for my-project (Live): Umbraco.Cms, Umbraco.Forms`

{% hint style="warning" %}
Autoupgrade alerts are sent for **every** upgrade of your environment. This includes [automatic upgrades](../../manage-product-upgrades/product-upgrades/minor-upgrades.md) and upgrades you start yourself from the [Cloud Portal](../../manage-product-upgrades/product-upgrades/minor-upgrades.md#upgrade-from-the-cloud-portal). Both run the same upgrade process.
{% endhint %}


## Create an Alert Rule

1. Go to your project or organization in the [Umbraco Cloud Portal](https://www.s1.umbraco.io).
2. Navigate to **Alerting & Notifications**.
   <!-- TODO: confirm the menu path -->
3. Select **Create alert rule**.
   <!-- TODO: confirm the button label -->
4. Fill in the rule settings described in the [Alert Rule Settings](#alert-rule-settings) section.
5. Select **Save**.
6. [Send a test notification](#test-an-alert-rule) to check that it arrives.

<!-- TODO: screenshot of the create rule form. Proposed file: .gitbook/assets/alerting-create-rule.png -->

{% hint style="info" %}
Saving a rule is processed in the background. It can take a moment before the rule appears in the list.
{% endhint %}

### Alert Rule Settings

* **Event type**: The alert the rule reacts to. You can't change the event type later.
* **Conditions**: For Deployment and Autoupgrade rules, the outcomes you want to be notified about. At least one is required.
* **Destinations**: Up to 15 email addresses or webhook URLs. See the [Destinations](#destinations) section.
* **Cooldown**: The minimum number of minutes between notifications from the rule. `0` means no cooldown. The maximum is 43,200 minutes (30 days). See the [Cooldown](#cooldown) section.
* **Enabled**: Turn the rule off to stop notifications without deleting the rule.
* **Projects** (organization rules only): All projects, or a selection. See the [Project and Organization Rules](#project-and-organization-rules) section.
* **Environment Type**: You can select all environment types, or scope it down to only production or feature environments. 

### Edit or Delete a Rule

You can add and remove destinations, but you can't edit one. To change an email address or a webhook URL, remove the destination and add a new one.

The same applies to a [webhook secret](webhooks.md#secure-your-webhook-with-a-secret). Add the webhook again as a new destination with the new secret, then remove the old destination.

## Who Can Manage Alert Rules

| | View rules, history, and activity | Create, edit, delete, and send tests |
| --- | --- | --- |
| **Project rules** | Any project team member, or an organization **Admin** | Project team members with **Admin** permission, or an organization **Admin** |
| **Organization rules** | Organization members with the **Read**, **Write**, or **Admin** role | Organization members with the **Admin** role |

Sending a test notification requires the same permission as editing the rule. A test sends real messages to the rule's destinations.

For more information about permissions, see the [Manage Team Members and Permissions](../../../begin-your-cloud-journey/project-features/team-members/README.md) and [Organizations](../../../begin-your-cloud-journey/the-cloud-portal/organizations/README.md) articles.

## Project and Organization Rules

| | Project rule | Organization rule |
| --- | --- | --- |
| **Covers** | One project | All projects in the organization, or a selection |
| **New projects** | Not applicable | Covered automatically when the rule applies to all projects |
| **Typical use** | Project-specific destinations, such as a client's inbox | Company-wide policies, such as sending all failed deployments to an on-call tool |

When you select specific projects for an organization rule, you can only pick projects that belong to the organization.

Rules are independent of each other. If a project rule and an organization rule both match the same event, **both** send a notification. Each rule follows its own cooldown.

From the organization, you can also see the project rules of every project in the organization. To change a project rule, go to the project.

<!-- Should we add environment type information here -->

## Destinations

### Email

Email notifications are sent to the address you enter. The address can belong to anyone, such as a shared team inbox. The recipient does not need to be an Umbraco Cloud user.

The subject line uses the following format:

`[Umbraco Cloud] Deployment failed alert on my-project (Live)`

The email contains:

* The project name and a link to the project in the Cloud Portal.
* The environment.
* The alert type and time.
* Details about what happened.
* Your custom metadata, if the rule has any.
* An Alert ID to use when contacting support.



### Webhook

Webhook notifications are sent as an HTTP `POST` request with a JSON body to the URL you enter. Use webhooks to connect alerts to tools such as Slack, Microsoft Teams, PagerDuty, or your own systems.

Webhook URLs must use HTTPS and point to a publicly reachable host. You can add an optional secret to verify that requests come from Umbraco Cloud.

{% content-ref url="webhooks.md" %}
[Webhook Notifications](webhooks.md)
{% endcontent-ref %}

<!-- TODO: screenshot of wehbook or email Proposed file: .gitbook/assets/alerting-webhook-example.png -->

## Test an Alert Rule

Select **Send test** on a rule to send a sample notification to all of the rule's destinations. The sample uses your real project name and environment. You can see what a real notification from the rule looks like.

<!-- TODO: confirm the button label -->

Test notifications are marked in two ways:

* The `details` text starts with `[TEST]`.
* The webhook payload has `"isTest": true`, so your receiving system can ignore the request instead of paging someone.

Test notifications appear in the [alert history](#alert-history-and-activity) with their delivery results. You can see which destinations accepted them. Test notifications don't start the rule's cooldown and aren't counted in the rule's activity.

## Cooldown

The cooldown is the minimum number of minutes between two delivered notifications from the same rule. Events during the cooldown don't send a notification. The events are still recorded in the alert history as **Cooldown suppressed**, so you can see that they happened.

Each rule has its own cooldown. A cooldown on one rule never suppresses notifications from another rule.

## Alert History and Activity

The alert history lists every alert for a project or organization, newest first. You can filter by event type and by date range, and include or exclude test notifications.

Each entry shows the event type, when the alert fired, the details, and the delivery result for each destination.

| Status | Description |
| --- | --- |
| **Delivered** | The notification reached all destinations. |
| **Partially delivered** | The notification reached some destinations, but not all. |
| **Delivery failed** | The notification did not reach any destination. |
| **Cooldown suppressed** | The event happened during the rule's cooldown, so no notification was sent. |

<!-- TODO: confirm which statuses are shown in the UI, and how long alert history is kept -->

The **activity** view shows how many times each rule fired and when it last fired. The view covers the last 30 days by default and up to 90 days. Test notifications are not counted.

## Troubleshooting

### No Notification Received

* Check that the rule is **enabled**.
* For Deployment and Autoupgrade rules, check that the outcome is selected in the rule's conditions.
* Check the [alert history](#alert-history-and-activity):
  * No entry: No enabled rule matched the event.
  * **Cooldown suppressed**: The event happened during the cooldown. Lower the cooldown if you want more notifications.
  * **Delivery failed**: The destination didn't accept the notification. For webhooks, see the [Webhook Notifications](webhooks.md#troubleshooting-failed-deliveries) article.
* For email, check your spam folder.
* Use [Send test](#test-an-alert-rule) to confirm that a destination works.

### Duplicate Notifications for One Event

A project rule and an organization rule can both match the event. Each rule sends its own notification. Remove one of the rules, or narrow the organization rule to specific projects.

### Autoupgrade Alert for an Upgrade You Started

Autoupgrade alerts cover all upgrades, including upgrades you start from the Cloud Portal. The alert is expected.
