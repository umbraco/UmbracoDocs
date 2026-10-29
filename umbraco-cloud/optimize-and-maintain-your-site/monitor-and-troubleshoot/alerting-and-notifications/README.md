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

You can find **Alerting & Notifications** in the Umbraco Cloud Portal:

* **Project**: Go to **Insights** → **Alerting & Notifications**.
* **Organization**: Go to **Overview** → **Alerting & Notifications**.

{% hint style="info" %}
Notifications are **opt-in**. If no enabled alert rule matches an event, no notification is sent.
{% endhint %}

<!-- TODO: screenshot of the Alerting & Notifications overview. Proposed file: .gitbook/assets/alerting-overview.png. Take after the history UI shows the new statuses -->

## Key Concepts

| Concept | Description |
| --- | --- |
| **Alert rule** | A subscription to one type of event. The rule defines what to listen for, where to send the notification, and how often at most. |
| **Event type** | The kind of event the rule reacts to, such as **Deployment** or **DDoS**. You can't change the event type after the rule is created. |
| **Condition** | Narrows a rule to specific outcomes. For example, a Deployment rule can be limited to failed deployments. |
| **Destination** | Where the notification goes: an email address or a webhook URL. A rule can have up to 15 destinations. |
| **Cooldown** | The minimum time after a sent notification before the same rule sends another. A cooldown keeps you from being flooded during an ongoing incident. |
| **Alert history** | A log of every alert: what fired, when, and whether each destination received the notification. |

## Available Alerts

| Alert | Sent when | Conditions |
| --- | --- | --- |
| [DDoS](#ddos) | A Distributed Denial of Service (DDoS) attack against one of your hostnames is detected and mitigated. | None |
| [Autoheal](#autoheal) | Umbraco Cloud restarts an environment automatically to recover it. | None |
| [Deployment](#deployment) | A deployment to one of your environments starts, completes, or fails. | Required: one or more of **Started**, **Completed**, **Failed** |
| [Autoupgrade](#autoupgrade) | An upgrade of one of your environments starts, completes, fails, or times out. | Required: one or more of **Started**, **Completed**, **Failed**, **Timed out** |

{% hint style="info" %}
More alert types are planned for a later release. These include end-of-support warnings for your Umbraco version, hosting recommendations, and custom hostname monitoring failures.
{% endhint %}

### DDoS

A DDoS alert is sent when Cloudflare's edge network detects and mitigates a DDoS attack. The alert covers application-layer (HTTP) attacks against a hostname on your project.

The notification includes the affected hostname. Where available, it also includes the attack type, the request rate, and the action taken. For example:

`Hostname: www.example.com. Attack: HTTP DDoS. RPS: 12000. Action: block`

<!-- TODO: confirm the attack and action values customers will see. Values come from Cloudflare, application-layer attacks only -->

For more information about how Umbraco Cloud protects your site, see the [Web Application Firewall](../../../build-and-customize-your-solution/set-up-your-project/security/web-application-firewall.md) article.

### Autoheal

An Autoheal alert is sent when Azure detects that an environment is unhealthy and restarts it automatically.

<!-- TODO: product-approved explanation of what triggers Autoheal -->

The notification text is always the same:

`The site was automatically recycled to recover from an unhealthy state. No action is required.`

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

Deployment alerts also cover deployments through the [Umbraco CI/CD Flow](../../../build-and-customize-your-solution/handle-deployments-and-environments/umbraco-cicd/README.md). A CI/CD deployment has no source environment, so the notification shows only the target environment. For example:

`CI/CD deployment failed for my-project (Live)`

A CI/CD deployment that times out is reported as **Failed**, with "(timed out)" in the notification text.

For Deployment rules, the [environment type](#alert-rule-settings) refers to the **target** environment of the deployment.

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
   * Project: **Insights** → **Alerting & Notifications**.
   * Organization: **Overview** → **Alerting & Notifications**.
3. Select **New rule**.
4. Fill in the rule settings described in the [Alert Rule Settings](#alert-rule-settings) section.
5. Select **Create alert rule**.
6. [Send a test notification](#test-an-alert-rule) to check that it arrives.

<!-- TODO: screenshot of the create rule form. Proposed file: .gitbook/assets/alerting-create-rule.png. Take after the history UI shows the new statuses -->

{% hint style="info" %}
Saving a rule is processed in the background. It can take a moment before the rule appears in the list.
{% endhint %}

### Alert Rule Settings

* **Event type**: The alert the rule reacts to. You can't change the event type later.
* **Conditions**: For Deployment and Autoupgrade rules, the outcomes you want to be notified about. At least one is required.
* **Destinations**: Up to 15 email addresses or webhook URLs. See the [Destinations](#destinations) section.
* **Priority**: **Critical**, **High**, **Medium**, or **Low**. The default is **High**. The priority is included in the notification.
* **Cooldown**: The minimum time between notifications from the rule, in minutes, hours, or days. The default is 5 minutes. `0` means no cooldown. The maximum is 43,200 minutes (30 days). See the [Cooldown](#cooldown) section.
* **Enabled**: Use the **Enable this alert** toggle in the form, or the **On/Off** switch in the rule list. Turn a rule off to stop notifications without deleting the rule.
* **Projects** (organization rules only): All projects, or a selection. See the [Project and Organization Rules](#project-and-organization-rules) section.
* **Environment type**: **All environments**, **Production**, or **Non-production**.
  * **Production** is the last environment in your deployment chain, the one your visitors reach.
  * **Non-production** covers every environment before Production.
  * You can't select a single non-production environment.

### Edit or Delete a Rule

Select **Save changes** to save your edits to a rule.

You can't change the event type of a rule. To react to a different event type, delete the rule and create a new one.

You can add and remove destinations, but you can't edit an email or webhook destination. To change an email address or a webhook URL, remove the destination and add a new one. Removing a destination keeps its past results in the alert history.

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

Organization rules also have an environment type. For example, an organization rule for **Production** only sends notifications about the production environment of each covered project.

## Destinations

### Email

Email notifications are sent to the address you enter. The address can belong to anyone, such as a shared team inbox. The recipient does not need to be an Umbraco Cloud user.

The subject line uses the following format:

`[Umbraco Cloud] Deployment failed alert on my-project (Live)`

For Deployment and Autoupgrade alerts, the subject includes the outcome, such as "failed". Subjects of test emails start with `[Umbraco Cloud] [TEST]`.

The email contains:

* The project name and a link to the project in the Cloud Portal.
* The environment.
* The alert type and time.
* The scope: whether a project rule or an organization rule sent the notification.
* Details about what happened.
* The rule's priority, under **Additional information**.
* An Alert ID to use when contacting support.

### Webhook

Webhook notifications are sent as an HTTP `POST` request with a JSON body to the URL you enter. Use webhooks to connect alerts to tools such as Slack, Microsoft Teams, PagerDuty, or your own systems.

Webhook URLs must use HTTPS and point to a publicly reachable host. You can add an optional secret to verify that requests come from Umbraco Cloud.

{% content-ref url="webhooks.md" %}
[Webhook Notifications](webhooks.md)
{% endcontent-ref %}

<!-- TODO: screenshot of a webhook or email notification. Proposed file: .gitbook/assets/alerting-webhook-example.png. Take after the history UI shows the new statuses -->

## Test an Alert Rule

Select **Send test** on a rule to send a sample notification to all of the rule's destinations. The sample uses your real project name and environment. You can see what a real notification from the rule looks like.

**Send test** is available when you edit a saved rule:

* The test uses the saved rule. **Send test** is unavailable while the form has unsaved changes.
* A test is sent even if the rule is turned off.
* For DDoS rules, the details text is a sample, such as `DDoS mitigation triggered for <hostname>`. A real DDoS notification uses the format shown in the [DDoS](#ddos) section.

Test notifications are marked in two ways:

* The `details` text starts with `[TEST]`.
* The webhook payload has `"isTest": true`, so your receiving system can ignore the request instead of paging someone.

Test notifications appear in the [alert history](#alert-history-and-activity) with their delivery results. You can see which destinations accepted them. Test notifications don't start the rule's cooldown and aren't counted in the rule's activity.

## Cooldown

The cooldown starts when a rule sends a notification. The cooldown is measured from the time the alert fired. Until the cooldown ends, events don't send a notification. The events are still recorded in the alert history as **Cooldown suppressed**, so you can see that they happened.

A cooldown only starts if the notification could reach at least one destination:

* If every destination failed, no cooldown starts. The next event sends a new notification.
* An email that is still waiting for delivery confirmation holds the cooldown.
* If a later bounce means no destination received the notification, the cooldown ends. The next event sends a new notification.

For what counts as a failed destination, see the [Delivery Results per Destination](#delivery-results-per-destination) section.

Test notifications never start a cooldown.

Each rule has its own cooldown. A cooldown on one rule never suppresses notifications from another rule.

## Alert History and Activity

The alert history lists every alert for a project or organization, newest first. You can filter by:

* Event type
* Environment
* Priority
* Result
* Period: the last 7, 14, or 30 days, or all time
* Project (organization only)

Test notifications are shown by default. Use the **Test** result filter to see only test notifications.

<!-- TODO: align filter labels with the Cloud Portal once the history UI shows the new statuses -->

Each entry shows the event type, when the alert fired, the details, the overall outcome, and the result for each destination.

| Outcome | Description |
| --- | --- |
| **Waiting for confirmation** | The notification was sent, and at least one email is not confirmed yet. |
| **Delivered** | Every destination received the notification. |
| **Partially delivered** | Some destinations received the notification, but not all. |
| **Delivery failed** | No destination received the notification. |
| **Cooldown suppressed** | The event happened during the rule's cooldown, so no notification was sent. |

<!-- TODO: align outcome labels with the Cloud Portal once the history UI shows the new statuses -->

<!-- TODO: confirm how long alert history is kept -->

### Delivery Results per Destination

A webhook destination is **Delivered** when your endpoint returns a `2xx` status code. Otherwise, the destination is **Failed**. The result is known as soon as the notification is sent.

An email destination has one of the following results:

* **In progress**: The email provider has queued, accepted, or deferred the message.
* **Delivered**: The recipient's mail server accepted the message.
* **Bounced**: The recipient's mail server rejected the message.
* **Dropped**: The email provider did not attempt delivery.
* **Blocked**: The recipient's mail server refused the message.
* **Failed**: The message never reached the email provider.
* **Unconfirmed**: No delivery confirmation arrived in time.

An email with no result after 30 minutes becomes **Unconfirmed**. If the email provider deferred the message, the limit is 6 hours. Unconfirmed counts as not delivered. The alert history can take up to 5 minutes more to show the change.

A **Delivered** email can later become **Bounced** if the recipient's mail server bounces the message afterwards. The bounce is the final result.

For failed destinations, the alert history shows one of the following messages:

| Result | Message |
| --- | --- |
| **Bounced** | The recipient's mail server rejected the message. The address may no longer exist. |
| **Dropped** | The email provider did not attempt delivery, usually because earlier messages to this address failed and it has been suppressed. Contact support to have it reinstated. |
| **Blocked** | The recipient's mail server refused the message. This is usually a filtering or policy decision on their side rather than a problem with the address. |
| **Unconfirmed** | No delivery confirmation was received in time, so whether this message arrived is unknown. |
| **Failed** | The notification could not be sent to this destination. |

### Activity

The rule list shows how many alerts each rule raised in the last 7 days, and when the rule last fired. Cooldown-suppressed events are counted. Test notifications are not counted.

## Troubleshooting

### No Notification Received

* Check that the rule is **enabled**.
* For Deployment and Autoupgrade rules, check that the outcome is selected in the rule's conditions.
* Check that the rule's environment type covers the environment. For example, a **Production** rule doesn't send notifications for deployments to a non-production environment.
* Check the [alert history](#alert-history-and-activity):
  * No entry: No enabled rule matched the event.
  * **Cooldown suppressed**: The event happened during the cooldown. Lower the cooldown if you want more notifications.
  * **Delivery failed**: No destination received the notification. Check the [result for each destination](#delivery-results-per-destination). For webhooks, see the [Webhook Notifications](webhooks.md#troubleshooting-failed-deliveries) article.
  * **Bounced** or **Blocked**: Check the email address with the recipient's mail administrator.
  * **Dropped**: Contact support to have the email address reinstated.
  * **Unconfirmed**: The email may or may not have arrived. Use **Send test** to check the destination.
* An email shown as **Delivered** was accepted by the recipient's mail server. If the email isn't in the inbox, check the spam folder.
* Use [Send test](#test-an-alert-rule) to confirm that a destination works.

### Duplicate Notifications for One Event

A project rule and an organization rule can both match the event. Each rule sends its own notification. Remove one of the rules, or narrow the organization rule to specific projects.

### Autoupgrade Alert for an Upgrade You Started

Autoupgrade alerts cover all upgrades, including upgrades you start from the Cloud Portal. The alert is expected.
