---
description: >-
    Get usage breakdown by AI model.
---

# Breakdown by Model

Returns usage distribution across AI models.

## Request

```http
GET /umbraco/ai/management/api/v1/analytics/breakdown/model
```

### Query Parameters

| Parameter | Type     | Required | Description                 |
| --------- | -------- | -------- | --------------------------- |
| `from`    | datetime | Yes      | Start of period (inclusive) |
| `to`      | datetime | Yes      | End of period (inclusive)   |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "dimension": "openai/gpt-4o",
            "dimensionName": "GPT-4o",
            "requestCount": 8500,
            "totalTokens": 1950000,
            "percentage": 0.51
        },
        {
            "dimension": "openai/gpt-4o-mini",
            "dimensionName": "GPT-4o Mini",
            "requestCount": 4000,
            "totalTokens": 520000,
            "percentage": 0.24
        },
        {
            "dimension": "anthropic/claude-3-5-sonnet-20241022",
            "dimensionName": "Claude 3.5 Sonnet",
            "requestCount": 3200,
            "totalTokens": 890000,
            "percentage": 0.19
        },
        {
            "dimension": "openai/text-embedding-3-small",
            "dimensionName": "text-embedding-3-small",
            "requestCount": 980,
            "totalTokens": 125000,
            "percentage": 0.06
        }
    ]
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/breakdown/model?from=2024-01-01T00:00:00Z&to=2024-01-31T23:59:59Z" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var from = DateTime.UtcNow.AddDays(-30);
var to = DateTime.UtcNow;

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/analytics/breakdown/model?from={from:O}&to={to:O}");

var breakdown = await response.Content.ReadFromJsonAsync<AIUsageBreakdownResult>();

foreach (var item in breakdown.Items.OrderByDescending(x => x.TotalTokens))
{
    Console.WriteLine($"{item.DimensionName}: {item.TotalTokens:N0} tokens ({item.Percentage:P0})");
}
```

{% endcode %}

## Response Properties

| Property        | Type   | Description                            |
| --------------- | ------ | -------------------------------------- |
| `dimension`     | string | Model reference (`providerId/modelId`) |
| `dimensionName` | string | Model display name                     |
| `requestCount`  | int    | Number of requests                     |
| `totalTokens`   | long   | Total tokens used                      |
| `percentage`    | double | Share of total requests (0.0-1.0)      |

## Use Cases

- **Cost optimization** - Identify expensive models for potential replacement
- **Performance analysis** - Compare model usage patterns
- **Capacity planning** - Understand which models are most relied upon
