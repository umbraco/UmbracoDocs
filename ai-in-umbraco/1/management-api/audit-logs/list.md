---
description: >-
    List audit logs with filtering and pagination.
---

# List Audit Logs

Returns a paginated list of audit logs with optional filtering.

## Request

```http
GET /umbraco/ai/management/api/v1/audit-log
```

### Query Parameters

| Parameter     | Type     | Default | Description                                |
| ------------- | -------- | ------- | ------------------------------------------ |
| `skip`        | int      | 0       | Number of records to skip                  |
| `take`        | int      | 50      | Number of records to return (max 100)      |
| `from`        | datetime | null    | Filter by start time (inclusive)           |
| `to`          | datetime | null    | Filter by end time (inclusive)             |
| `status`      | string   | null    | Filter by status                           |
| `capability`  | string   | null    | Filter by capability (`Chat`, `Embedding`) |
| `profileId`   | guid     | null    | Filter by profile                          |
| `providerId`  | string   | null    | Filter by provider                         |
| `userId`      | guid     | null    | Filter by user                             |
| `featureType` | string   | null    | Filter by feature type (`prompt`, `agent`) |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "startTime": "2024-01-25T09:15:00Z",
            "endTime": "2024-01-25T09:15:02Z",
            "duration": "00:00:02.345",
            "status": "Succeeded",
            "capability": "Chat",
            "profileAlias": "content-assistant",
            "providerId": "openai",
            "modelId": "gpt-4o",
            "userName": "admin@example.com",
            "inputTokens": 150,
            "outputTokens": 420,
            "totalTokens": 570
        }
    ],
    "total": 1250
}
```

{% endcode %}

## Examples

### Basic List

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-log?skip=0&take=20" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filtered by Date Range

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-log?from=2024-01-01T00:00:00Z&to=2024-01-31T23:59:59Z" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filtered by Status

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-log?status=Failed" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Multiple Filters

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-log?capability=Chat&providerId=openai&status=Succeeded" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var queryParams = new Dictionary<string, string>
{
    ["skip"] = "0",
    ["take"] = "50",
    ["capability"] = "Chat",
    ["providerId"] = "openai"
};

var query = string.Join("&", queryParams.Select(kv => $"{kv.Key}={kv.Value}"));
var response = await httpClient.GetAsync($"/umbraco/ai/management/api/v1/audit-log?{query}");
var result = await response.Content.ReadFromJsonAsync<PagedResult<AIAuditLogModel>>();
```

{% endcode %}

## Notes

- Results are sorted by `startTime` descending (newest first)
- The list response includes a subset of fields for performance
- Use the [Get Audit Log](get.md) endpoint for full details including snapshots
