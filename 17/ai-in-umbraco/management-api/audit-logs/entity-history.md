---
description: >-
    Get audit history for a specific entity.
---

# Get Entity Audit History

Returns audit logs related to a specific content item or entity by filtering the audit logs list on `entityId`.

## Request

```http
GET /umbraco/ai/management/api/v1/audit-logs?entityId={entityId}
```

### Query Parameters

| Parameter    | Type   | Default | Description                                    |
| ------------ | ------ | ------- | ---------------------------------------------- |
| `entityId`   | string | -       | Entity identifier to filter audit logs by      |
| `skip`       | int    | 0       | Number of records to skip                      |
| `take`       | int    | 100     | Number of records to return                     |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "startTime": "2024-01-25T09:15:00Z",
            "durationMs": 2345,
            "status": "Succeeded",
            "userId": "admin-user-guid",
            "userName": "admin@example.com",
            "entityId": "content-guid",
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
            "outputTokens": 420
        }
    ],
    "total": 2
}
```

{% endcode %}

See [List Audit Logs](list.md) for the full list of item properties.

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-logs?entityId=content-guid&take=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var entityId = "content-guid";

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/audit-logs?entityId={entityId}&take=10");
var history = await response.Content.ReadFromJsonAsync<PagedResult<AIAuditLogModel>>();
```

{% endcode %}

## Use Cases

This endpoint is useful for:

- Viewing AI operations performed on a specific content item
- Auditing AI usage for compliance
- Debugging issues with specific content
- Understanding token usage per content item
