---
description: >-
    Get audit history for a specific entity.
---

# Get Entity Audit History

Returns audit logs related to a specific content item or entity.

## Request

```http
GET /umbraco/ai/management/api/v1/audit-log/entity/{entityType}/{entityId}
```

### Path Parameters

| Parameter    | Type   | Description                                |
| ------------ | ------ | ------------------------------------------ |
| `entityType` | string | Type of entity (e.g., `document`, `media`) |
| `entityId`   | string | Entity identifier                          |

### Query Parameters

| Parameter | Type | Default | Description                         |
| --------- | ---- | ------- | ----------------------------------- |
| `limit`   | int  | 20      | Maximum number of records to return |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "startTime": "2024-01-25T09:15:00Z",
            "status": "Succeeded",
            "capability": "Chat",
            "profileAlias": "content-assistant",
            "userName": "admin@example.com",
            "featureType": "prompt",
            "totalTokens": 570
        },
        {
            "id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "startTime": "2024-01-24T14:30:00Z",
            "status": "Succeeded",
            "capability": "Chat",
            "profileAlias": "translator",
            "userName": "editor@example.com",
            "featureType": null,
            "totalTokens": 890
        }
    ]
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-log/entity/document/content-guid?limit=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var entityType = "document";
var entityId = "content-guid";

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/audit-log/entity/{entityType}/{entityId}?limit=10");
var history = await response.Content.ReadFromJsonAsync<AIEntityAuditHistoryModel>();
```

{% endcode %}

## Use Cases

This endpoint is useful for:

- Viewing AI operations performed on a specific content item
- Auditing AI usage for compliance
- Debugging issues with specific content
- Understanding token usage per content item
