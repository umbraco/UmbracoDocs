---
description: >-
  Receive Umbraco Cloud alert notifications on your own endpoint. Learn about
  the webhook URL requirements, payload, secret header, and retries.
tags:
  - ai-generated
---

# Webhook Notifications

A webhook destination sends alert notifications from [Alerting and Notifications](README.md) to an endpoint you control. Use webhooks to connect alerts to tools such as Slack, Microsoft Teams, PagerDuty, or your own systems.

Each notification is sent as an HTTP `POST` request with a JSON body.

## URL Requirements

A webhook URL must meet the following requirements:

* The URL uses `https://`.
* The URL points to a publicly reachable host. Private network addresses, `localhost`, and raw IP addresses are not allowed.
* The URL is up to 500 characters long.
* The URL does not contain a username or password.

Redirects are not followed. Enter the final URL of your endpoint.

## Payload

The following example shows the payload for a failed deployment:

{% code title="Webhook payload" %}
```json
{
  "alertId": "3f2b8c1e-6a4d-4e0b-9a51-2c7d8e9f0a12",
  "projectAlias": "my-project",
  "projectUrl": "https://www.s1.umbraco.io/project/my-project",
  "environmentName": "Live",
  "timeFired": "2026-09-25T08:14:03Z",
  "alertName": "Deployment",
  "details": "Deployment failed for my-project: Development → Live",
  "customerMetadata": {
    "team": "platform"
  },
  "isTest": false
}
```
{% endcode %}

<!-- TODO: confirm the projectUrl base URL, and whether the payload is a versioned, stable contract -->

| Field | Description |
| --- | --- |
| `alertId` | Unique ID of the notification. Include the ID when contacting support. |
| `projectAlias` | The project's alias. |
| `projectUrl` | Link to the project in the Umbraco Cloud Portal. |
| `environmentName` | The environment the event happened on. |
| `timeFired` | When the alert fired, in UTC (ISO 8601 format). |
| `alertName` | The event type: `DDoS`, `Autoheal`, `Deployment`, or `Autoupgrade`. |
| `details` | A human-readable description of what happened. |
| `customerMetadata` | The custom metadata from your alert rule. Empty if the rule has none. |
| `isTest` | `true` when the notification was sent with [Send test](README.md#test-an-alert-rule). |

{% hint style="info" %}
Check `isTest` before triggering any action, such as paging an on-call engineer. Test notifications use your real project and environment, so the other fields look like a real alert.
{% endhint %}

## Secure Your Webhook With a Secret

You can add an optional **secret** of up to 512 characters to a webhook destination. Umbraco Cloud sends the secret in the `uc-webhook-auth` request header on every notification.

Check the header on your endpoint, and reject requests where the value doesn't match your secret.

{% hint style="warning" %}
The secret is stored encrypted and is not shown again after you save it.

To change the secret, add the webhook as a new destination with the new secret. Then remove the old destination.
{% endhint %}

## Delivery and Retries

* Your endpoint must respond with a `2xx` status code. Any other response counts as a failed delivery.
* Each attempt times out after 10 seconds. Respond quickly, and do any slow processing afterwards.
* Failed attempts caused by timeouts, connection errors, or `5xx` responses are retried. Umbraco Cloud makes up to 3 attempts in total.
* `4xx` responses are not retried. A `4xx` response usually means the request was rejected on purpose, for example because of a wrong secret.

You can see the delivery result for each destination in the [alert history](README.md#alert-history-and-activity).

## Troubleshooting Failed Deliveries

If the alert history shows **Delivery failed** for a webhook destination, check the following:

* The URL is public and uses HTTPS.
* The endpoint responds within 10 seconds.
* The endpoint returns a `2xx` status code.
* The endpoint accepts the secret you set, if any.

Use [Send test](README.md#test-an-alert-rule) to check the destination again after making changes.
