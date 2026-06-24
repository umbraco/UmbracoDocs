---
description: >-
    Get a specific audit log entry.
---

# Get Audit Log

Returns the full details of a specific audit log entry.

## Request

```http
GET /umbraco/ai/management/api/v1/audit-logs/{id}
```

### Path Parameters

| Parameter | Type | Description                 |
| --------- | ---- | --------------------------- |
| `id`      | guid | Audit log unique identifier |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "startTime": "2024-01-25T09:15:00Z",
    "endTime": "2024-01-25T09:15:02Z",
    "durationMs": 2345,
    "status": "Succeeded",
    "errorCategory": null,
    "errorMessage": null,
    "userId": "user-guid",
    "userName": "admin@example.com",
    "entityId": "content-guid",
    "entityType": "document",
    "capability": "Chat",
    "profileId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "profileAlias": "content-assistant",
    "profileVersion": 5,
    "providerId": "openai",
    "modelId": "gpt-4o",
    "featureType": "prompt",
    "featureId": "b2c3d4e5-f6a7-8901-bcde-f23456789012",
    "featureVersion": 2,
    "inputTokens": 150,
    "outputTokens": 420,
    "totalTokens": 570,
    "promptSnapshot": "You are a content assistant...\n\nUser: Write a summary of...",
    "responseSnapshot": "Here is a summary of the article:\n\n...",
    "parentAuditLogId": null,
    "metadata": [
        { "key": "contentTypeAlias", "value": "article" },
        { "key": "culture", "value": "en-US" }
    ]
}
```

{% endcode %}

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Audit log not found"
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-logs/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Response Properties

| Property           | Type     | Description                                        |
| ------------------ | -------- | -------------------------------------------------- |
| `id`               | guid     | Unique identifier                                  |
| `startTime`        | datetime | When the operation started                         |
| `endTime`          | datetime | When the operation completed (null if running)     |
| `durationMs`       | long     | Operation duration in milliseconds                 |
| `status`           | string   | Operation status (Running, Succeeded, Failed)      |
| `errorCategory`    | string   | Error category if failed                           |
| `errorMessage`     | string   | Error details if failed                            |
| `userId`           | string   | User who initiated the operation                   |
| `userName`         | string   | User display name                                  |
| `entityId`         | string   | ID of content/item being processed                 |
| `entityType`       | string   | Type of content/item                               |
| `capability`       | string   | AI capability used                                 |
| `profileId`        | guid     | Profile used                                       |
| `profileAlias`     | string   | Profile alias at time of operation                 |
| `profileVersion`   | int      | Profile version at time of operation               |
| `providerId`       | string   | Provider used                                      |
| `modelId`          | string   | Model used                                         |
| `featureType`      | string   | Feature type (prompt, agent) if applicable         |
| `featureId`        | guid     | Feature ID if applicable                           |
| `featureVersion`   | int      | Feature version if applicable                      |
| `inputTokens`      | int      | Tokens in the request                              |
| `outputTokens`     | int      | Tokens in the response                             |
| `totalTokens`      | int      | Total tokens used                                  |
| `promptSnapshot`   | string   | Request content (if configured to persist)         |
| `responseSnapshot` | string   | Response content (if configured to persist)        |
| `parentAuditLogId` | guid     | Parent operation ID for nested operations          |
| `metadata`         | array    | Extensible key/value pairs for feature-specific context |

{% hint style="info" %}
`promptSnapshot` and `responseSnapshot` are only populated when the profile is configured to persist prompts and responses.
{% endhint %}
