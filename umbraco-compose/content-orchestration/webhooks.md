---
description: >-
  Webhooks can be used to notify your external service when content changes in
  Umbraco Compose.
---

# Webhooks

Umbraco Compose can be configured to notify external services whenever certain events happen in the platform.

Instead of continuously polling, you can get real-time updates related to content changes. For example, you may wish to set up a webhook that runs a static site build process whenever content in Umbraco Compose is updated.

Webhooks work by sending an HTTP POST request to a configured endpoint, with information about the event in the request body.

## Configuration

Webhooks can be configured through the [Management API](../apis/management/). The following configuration options are available:

| Option              | Description                                                                                                                                             |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Webhook alias       | Alias to uniquely identify the webhook.                                                                                                                 |
| Description         | Description of the webhook.                                                                                                                             |
| Url                 | The URL to which Compose will send a POST request when conditions are met.                                                                              |
| Event types         | Action(s) that will cause the webhook to be fired. Must be one of `content.ingested` or `content.deleted`.                                              |
| Collection Aliases  | Collection(s) that content should be ingested into for the webhook to be fired.                                                                         |
| Type Schema Aliases | Type Schema(s) that content entries should be a type of for the webhook to be fired.                                                                    |
| Custom headers      | Dictionary of custom HTTP headers to be sent with the request. May be useful for identifying the source of a request or for authorization, for example. |

## Delivery

Whenever the conditions in a webhook are met, the webhook is triggered, and an HTTP request is sent to the configured URL.

### Headers

Compose includes a number of standard HTTP headers with webhook requests, such as `Content-Type` and `Content-Length`. Additionally, Compose also includes the following custom headers, prefixed with `umb-`:

| Header                  | Description                                                                                                                                                                                                                                            |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `umb-event`             | Type of event that caused this webhook to fire.                                                                                                                                                                                                        |
| `umb-project-alias`     | Project from which the webhook firing originated.                                                                                                                                                                                                      |
| `umb-environment-alias` | Environment from which the webhook firing originated.                                                                                                                                                                                                  |
| `umb-collection-alias`  | Collection in which the triggering content resided.                                                                                                                                                                                                    |
| `umb-variant`           | Content variant which triggered the webhook.                                                                                                                                                                                                           |
| `umb-id`                | Id of the content item that triggered the webhook.                                                                                                                                                                                                     |
| `umb-delivery-attempt`  | The number of times delivery of this webhook trigger has been attempted, including the current attempt.                                                                                                                                                |
| `umb-delivery-id`       | Unique identifier and idempotency key for this webhook delivery. This identifier is unique to and remains the same for all retry attempts of a webhook trigger. Applications can use these optionally as a key to prevent double-handling of messages. |

Lastly, Compose also includes any custom headers that were specified in the webhook configuration.

### Body

When Compose delivers a webhook, the HTTP request body contains the following properties:

* `id`
* `projectAlias`
* `environmentAlias`
* `collectionAlias`
* `typeSchemaAlias`
* `variant`
* `data`

Notes:

`id` is the identifier of the ingested content entry.\
`data` contains the content entry that has triggered the webhook to be fired.

An example of a webhook triggered by `content.ingested` event, containing one custom user-added header `header-1`:

```http
POST / HTTP/1.1
Host: yourwebhookdestination.com
Content-Type: application/json
User-Agent: Umbraco Compose Webhook/1.0
umb-event: content.ingested,
umb-delivery-id: 422d6800-7b78-42ad-a167-0f66aa724b87,
umb-project-alias: considerate-cute-otter,
umb-environment-alias: development,
umb-collection-alias: content,
umb-id: 176fa4c5-5ae9-457c-adf8-5826824cad63
umb-variant: en-GB,
umb-delivery-attempt: 1,
header-1: custom-value

{
  "id": "176fa4c5-5ae9-457c-adf8-5826824cad63",
  "projectAlias": "considerate-cute-otter",
  "environmentAlias": "development",
  "collectionAlias": "content",
  "typeSchemaAlias": "software",
  "variant": "en-GB",
  "data": {
    "name": "Umbraco Deploy"
  }
}
```

### Redelivery

The HTTP status code returned by a configured endpoint is used by Compose to determine if a webhook was successfully delivered.

When an endpoint returns an HTTP status code in the range 200-299, Compose considers it a successful delivery. No further delivery attempts will be made.

For all other status codes, Compose considers webhook delivery a failure. It will retry the request at a later time. If a `Retry-After` response header was returned from the endpoint during a failed delivery, then Compose will attempt redelivery no earlier than the time specified.

Otherwise, Compose uses an exponential backoff policy for redeliveries. The first redelivery occurs approximately 90 seconds after the initial delivery attempt, and the last around 12 hours later. Precise delivery times can vary due to jitter in the algorithm. In total, delivery will be attempted up to 10 times.

### Outbound IP Addresses

See [Outbound Traffic](outbound-traffic.md) for a list of IP addresses from which webhooks will originate.
