---
description: >-
    Get a specific audit log entry.
---

# Get Audit Log

Returns the full details of a specific audit log entry.

## Request

```http
GET /umbraco/ai/management/api/v1/audit-log/{id}
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
    "duration": "00:00:02.345",
    "status": "Succeeded",
    "errorCategory": null,
    "errorMessage": null,
    "userId": "user-guid",
    "userName": "admin@example.com",
    "entityId": "content-guid",
    "entityType": "document",
    "capability": "Chat",
    "profileId": "profile-guid",
    "profileAlias": "content-assistant",
    "profileVersion": 5,
    "providerId": "openai",
    "modelId": "gpt-4o",
    "featureType": "prompt",
    "featureId": "prompt-guid",
    "featureVersion": 2,
    "inputTokens": 150,
    "outputTokens": 420,
    "totalTokens": 570,
    "promptSnapshot": "You are a content assistant...\n\nUser: Write a summary of...",
    "responseSnapshot": "Here is a summary of the article:\n\n...",
    "detailLevel": "Full",
    "parentAuditLogId": null,
    "metadata": {
        "contentTypeAlias": "article",
        "culture": "en-US"
    }
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
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-log/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Response Properties

| Property           | Type     | Description                                    |
| ------------------ | -------- | ---------------------------------------------- |
| `id`               | guid     | Unique identifier                              |
| `startTime`        | datetime | When the operation started                     |
| `endTime`          | datetime | When the operation completed (null if running) |
| `duration`         | timespan | Operation duration                             |
| `status`           | string   | Operation status                               |
| `errorCategory`    | string   | Error category if failed                       |
| `errorMessage`     | string   | Error details if failed                        |
| `userId`           | guid     | User who initiated the operation               |
| `userName`         | string   | User display name                              |
| `entityId`         | string   | ID of content/item being processed             |
| `entityType`       | string   | Type of content/item                           |
| `capability`       | string   | AI capability used                             |
| `profileId`        | guid     | Profile used                                   |
| `profileAlias`     | string   | Profile alias at time of operation             |
| `profileVersion`   | int      | Profile version at time of operation           |
| `providerId`       | string   | Provider used                                  |
| `modelId`          | string   | Model used                                     |
| `featureType`      | string   | Feature type (prompt, agent) if applicable     |
| `featureId`        | guid     | Feature ID if applicable                       |
| `featureVersion`   | int      | Feature version if applicable                  |
| `inputTokens`      | int      | Tokens in the request                          |
| `outputTokens`     | int      | Tokens in the response                         |
| `totalTokens`      | int      | Total tokens used                              |
| `promptSnapshot`   | string   | Request content (if detail level allows)       |
| `responseSnapshot` | string   | Response content (if detail level allows)      |
| `detailLevel`      | string   | What level of detail was captured              |
| `parentAuditLogId` | guid     | Parent operation ID for nested operations      |
| `metadata`         | object   | Additional context-specific data               |

{% hint style="info" %}
`promptSnapshot` and `responseSnapshot` are only included when the audit log was created with `Full` detail level.
{% endhint %}
