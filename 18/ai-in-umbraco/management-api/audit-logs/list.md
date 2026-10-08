---
description: >-
    List audit logs with filtering and pagination.
---

# List Audit Logs

Returns a paginated list of audit logs with optional filtering.

## Request

```http
GET /umbraco/ai/management/api/v1/audit-logs
```

### Query Parameters

| Parameter    | Type     | Default | Description                                 |
| ------------ | -------- | ------- | ------------------------------------------- |
| `status`     | string   | null    | Filter by status (Running, Succeeded, Failed) |
| `userId`     | string   | null    | Filter by user ID                           |
| `profileId`  | guid     | null    | Filter by profile                           |
| `providerId` | string   | null    | Filter by provider                          |
| `entityId`   | string   | null    | Filter by entity ID                         |
| `fromDate`   | datetime | null    | Filter by start date (inclusive)            |
| `toDate`     | datetime | null    | Filter by end date (inclusive)              |
| `searchText` | string   | null    | Search text across multiple fields          |
| `skip`       | int      | 0       | Number of records to skip                   |
| `take`       | int      | 100     | Number of records to return                 |

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
            "userId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
            "userName": "admin@example.com",
            "entityId": "content-guid",
            "capability": "Chat",
            "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
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
    "total": 1250
}
```

{% endcode %}

### Item Properties

| Property           | Type     | Description                                 |
| ------------------ | -------- | ------------------------------------------- |
| `id`               | guid     | Unique identifier                           |
| `startTime`        | datetime | When the operation started                  |
| `durationMs`       | long     | Operation duration in milliseconds          |
| `status`           | string   | Operation status                            |
| `userId`           | string   | User who initiated the operation            |
| `userName`         | string   | User display name                           |
| `entityId`         | string   | ID of content/item being processed          |
| `capability`       | string   | AI capability used                          |
| `profileId`        | string   | Profile used                                |
| `profileAlias`     | string   | Profile alias at time of operation          |
| `profileVersion`   | int      | Profile version at time of operation        |
| `providerId`       | string   | Provider used                               |
| `modelId`          | string   | Model used                                  |
| `featureType`      | string   | Feature type (prompt, agent) if applicable  |
| `featureId`        | guid     | Feature ID if applicable                    |
| `featureVersion`   | int      | Feature version if applicable               |
| `parentAuditLogId` | guid     | Parent operation ID for nested operations   |
| `inputTokens`      | int      | Tokens in the request                       |
| `outputTokens`     | int      | Tokens in the response                      |
| `errorMessage`     | string   | Error details if failed                     |

## Examples

### Basic List

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-logs?skip=0&take=20" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filtered by Date Range

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-logs?fromDate=2024-01-01T00:00:00Z&toDate=2024-01-31T23:59:59Z" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filtered by Status

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-logs?status=Failed" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Multiple Filters

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/audit-logs?providerId=openai&status=Succeeded" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var queryParams = new Dictionary<string, string>
{
    ["skip"] = "0",
    ["take"] = "50",
    ["providerId"] = "openai",
    ["status"] = "Succeeded"
};

var query = string.Join("&", queryParams.Select(kv => $"{kv.Key}={kv.Value}"));
var response = await httpClient.GetAsync($"/umbraco/ai/management/api/v1/audit-logs?{query}");
var result = await response.Content.ReadFromJsonAsync<PagedResult<AuditLogItemResponseModel>>();
```

{% endcode %}

## Notes

- Results are sorted by `startTime` descending (newest first)
- The list response includes a subset of fields for performance
- Use the [Get Audit Log](get.md) endpoint for full details including snapshots
