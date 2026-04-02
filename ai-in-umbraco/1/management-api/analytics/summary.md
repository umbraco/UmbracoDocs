---
description: >-
    Get aggregated usage summary for a time period.
---

# Get Usage Summary

Returns aggregated usage statistics for the specified time period.

## Request

{% code title="Endpoint" %}

```http
GET /umbraco/ai/management/api/v1/analytics/summary
```

{% endcode %}

### Query Parameters

| Parameter    | Type     | Required | Description                                |
| ------------ | -------- | -------- | ------------------------------------------ |
| `from`       | datetime | Yes      | Start of period (inclusive)                |
| `to`         | datetime | Yes      | End of period (inclusive)                  |
| `profileId`  | guid     | No       | Filter by specific profile                 |
| `providerId` | string   | No       | Filter by specific provider                |
| `capability` | string   | No       | Filter by capability (`Chat`, `Embedding`) |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "totalRequests": 15420,
    "inputTokens": 2450000,
    "outputTokens": 890000,
    "totalTokens": 3340000,
    "successCount": 15210,
    "failureCount": 210,
    "successRate": 0.9864,
    "averageDurationMs": 1245
}
```

{% endcode %}

## Examples

### Last 30 Days Summary

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/summary?from=2024-01-01T00:00:00Z&to=2024-01-31T23:59:59Z" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filtered by Provider

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/summary?from=2024-01-01T00:00:00Z&to=2024-01-31T23:59:59Z&providerId=openai" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var from = DateTime.UtcNow.AddDays(-30);
var to = DateTime.UtcNow;

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/analytics/summary?from={from:O}&to={to:O}");

var summary = await response.Content.ReadFromJsonAsync<AIUsageSummary>();

Console.WriteLine($"Total Requests: {summary.TotalRequests}");
Console.WriteLine($"Total Tokens: {summary.TotalTokens:N0}");
Console.WriteLine($"Success Rate: {summary.SuccessRate:P1}");
```

{% endcode %}

## Response Properties

| Property            | Type   | Description                            |
| ------------------- | ------ | -------------------------------------- |
| `totalRequests`     | int    | Number of AI operations in the period  |
| `inputTokens`       | long   | Total tokens sent in requests          |
| `outputTokens`      | long   | Total tokens received in responses     |
| `totalTokens`       | long   | Combined input and output tokens       |
| `successCount`      | int    | Number of successful operations        |
| `failureCount`      | int    | Number of failed operations            |
| `successRate`       | double | Success rate (0.0 to 1.0)              |
| `averageDurationMs` | int    | Average operation time in milliseconds |

## Notes

- Token counts are based on values reported by the AI provider
- If no data exists for the period, all values will be 0
- Large date ranges may take longer to compute
