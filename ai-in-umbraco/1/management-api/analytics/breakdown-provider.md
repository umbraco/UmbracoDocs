---
description: >-
    Get usage breakdown by AI provider.
---

# Breakdown by Provider

Returns usage distribution across AI providers.

## Request

```http
GET /umbraco/ai/management/api/v1/analytics/breakdown/provider
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
            "dimension": "openai",
            "dimensionName": "OpenAI",
            "requestCount": 12500,
            "totalTokens": 2850000,
            "percentage": 0.75
        },
        {
            "dimension": "anthropic",
            "dimensionName": "Anthropic",
            "requestCount": 3200,
            "totalTokens": 890000,
            "percentage": 0.19
        },
        {
            "dimension": "google",
            "dimensionName": "Google",
            "requestCount": 980,
            "totalTokens": 245000,
            "percentage": 0.06
        }
    ]
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/breakdown/provider?from=2024-01-01T00:00:00Z&to=2024-01-31T23:59:59Z" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var from = DateTime.UtcNow.AddDays(-30);
var to = DateTime.UtcNow;

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/analytics/breakdown/provider?from={from:O}&to={to:O}");

var breakdown = await response.Content.ReadFromJsonAsync<AIUsageBreakdownResult>();

foreach (var item in breakdown.Items)
{
    Console.WriteLine($"{item.DimensionName}: {item.Percentage:P0} ({item.TotalTokens:N0} tokens)");
}
```

{% endcode %}

## Response Properties

| Property        | Type   | Description                       |
| --------------- | ------ | --------------------------------- |
| `dimension`     | string | Provider ID                       |
| `dimensionName` | string | Provider display name             |
| `requestCount`  | int    | Number of requests                |
| `totalTokens`   | long   | Total tokens used                 |
| `percentage`    | double | Share of total requests (0.0-1.0) |

## Use Cases

- **Cost allocation** - Understand which providers drive costs
- **Provider comparison** - Compare performance across providers
- **Migration planning** - Identify usage before switching providers
