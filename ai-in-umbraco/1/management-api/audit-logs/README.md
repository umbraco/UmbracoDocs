---
description: >-
    API endpoints for accessing AI operation audit logs.
---

# Audit Logs API

The Audit Logs API provides access to operational audit records for AI operations. Every chat and embedding request is logged with details about the request, response, tokens used, and outcome.

## Endpoints

| Method | Endpoint                                                         | Description                     |
| ------ | ---------------------------------------------------------------- | ------------------------------- |
| GET    | [`/audit-log`](list.md)                                          | List audit logs with filtering  |
| GET    | [`/audit-log/{id}`](get.md)                                      | Get a specific audit log entry  |
| GET    | [`/audit-log/entity/{entityType}/{entityId}`](entity-history.md) | Get audit history for an entity |
| DELETE | [`/audit-log/{id}`](delete.md)                                   | Delete a specific audit log     |
| POST   | [`/audit-log/cleanup`](cleanup.md)                               | Clean up old audit logs         |

## Base URL

```
/umbraco/ai/management/api/v1
```

## Audit Log Object

{% code title="Audit Log" %}

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
    "detailLevel": "Standard",
    "parentAuditLogId": null
}
```

{% endcode %}

## Status Values

| Status           | Description                      |
| ---------------- | -------------------------------- |
| `Running`        | Operation is in progress         |
| `Succeeded`      | Operation completed successfully |
| `Failed`         | Operation failed with an error   |
| `Cancelled`      | Operation was cancelled          |
| `PartialSuccess` | Operation partially completed    |

## Error Categories

| Category         | Description                  |
| ---------------- | ---------------------------- |
| `Authentication` | API key or credential issues |
| `RateLimit`      | Provider rate limit exceeded |
| `Timeout`        | Request timed out            |
| `InvalidRequest` | Malformed request            |
| `ModelError`     | Model processing error       |
| `NetworkError`   | Connection issues            |
| `Unknown`        | Unclassified error           |

## Detail Levels

Audit logs can be stored with different levels of detail:

| Level      | Includes                          |
| ---------- | --------------------------------- |
| `Minimal`  | Timing, status, tokens only       |
| `Standard` | Above + profile, model, user info |
| `Full`     | Above + prompt/response snapshots |

{% hint style="info" %}
Detail level is configured in application settings. Higher detail levels use more storage.
{% endhint %}

## Related

- [Audit Logs Backoffice](../../backoffice/audit-logs.md)
- [Usage Analytics](../analytics/README.md)
