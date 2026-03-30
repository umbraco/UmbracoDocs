---
description: >-
    Get usage breakdown by AI profile.
---

# Breakdown by Profile

Returns usage distribution across AI profiles.

## Request

```http
GET /umbraco/ai/management/api/v1/analytics/breakdown/profile
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
            "dimension": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "dimensionName": "content-assistant",
            "requestCount": 9200,
            "totalTokens": 2100000,
            "percentage": 0.55
        },
        {
            "dimension": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "dimensionName": "translator",
            "requestCount": 4800,
            "totalTokens": 890000,
            "percentage": 0.29
        },
        {
            "dimension": "e401f2ff-7d65-5c12-a1f7-e812859g1962",
            "dimensionName": "search-embeddings",
            "requestCount": 2680,
            "totalTokens": 345000,
            "percentage": 0.16
        }
    ]
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/breakdown/profile?from=2024-01-01T00:00:00Z&to=2024-01-31T23:59:59Z" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var from = DateTime.UtcNow.AddDays(-30);
var to = DateTime.UtcNow;

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/analytics/breakdown/profile?from={from:O}&to={to:O}");

var breakdown = await response.Content.ReadFromJsonAsync<AIUsageBreakdownResult>();

foreach (var item in breakdown.Items)
{
    Console.WriteLine($"{item.DimensionName}: {item.RequestCount} requests");
}
```

{% endcode %}

## Response Properties

| Property        | Type   | Description                       |
| --------------- | ------ | --------------------------------- |
| `dimension`     | string | Profile ID                        |
| `dimensionName` | string | Profile alias                     |
| `requestCount`  | int    | Number of requests                |
| `totalTokens`   | long   | Total tokens used                 |
| `percentage`    | double | Share of total requests (0.0-1.0) |

## Use Cases

- **Feature usage** - Understand which AI features are most popular
- **Profile optimization** - Identify underutilized or overused profiles
- **Budget allocation** - Attribute AI costs to specific use cases
