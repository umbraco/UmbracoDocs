---
description: >-
    Get usage breakdown by user.
---

# Breakdown by User

Returns usage distribution across users.

## Request

```http
GET /umbraco/ai/management/api/v1/analytics/breakdown/user
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
            "dimension": "user-guid-1",
            "dimensionName": "admin@example.com",
            "requestCount": 5200,
            "totalTokens": 1150000,
            "percentage": 0.31
        },
        {
            "dimension": "user-guid-2",
            "dimensionName": "editor@example.com",
            "requestCount": 4100,
            "totalTokens": 920000,
            "percentage": 0.25
        },
        {
            "dimension": "user-guid-3",
            "dimensionName": "writer@example.com",
            "requestCount": 3800,
            "totalTokens": 780000,
            "percentage": 0.23
        },
        {
            "dimension": null,
            "dimensionName": "System/API",
            "requestCount": 3580,
            "totalTokens": 485000,
            "percentage": 0.21
        }
    ]
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/breakdown/user?from=2024-01-01T00:00:00Z&to=2024-01-31T23:59:59Z" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var from = DateTime.UtcNow.AddDays(-30);
var to = DateTime.UtcNow;

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/analytics/breakdown/user?from={from:O}&to={to:O}");

var breakdown = await response.Content.ReadFromJsonAsync<AIUsageBreakdownResult>();

foreach (var item in breakdown.Items.OrderByDescending(x => x.RequestCount))
{
    Console.WriteLine($"{item.DimensionName}: {item.RequestCount} requests ({item.Percentage:P0})");
}
```

{% endcode %}

## Response Properties

| Property        | Type   | Description                         |
| --------------- | ------ | ----------------------------------- |
| `dimension`     | string | User ID (null for system/API calls) |
| `dimensionName` | string | User email or "System/API"          |
| `requestCount`  | int    | Number of requests                  |
| `totalTokens`   | long   | Total tokens used                   |
| `percentage`    | double | Share of total requests (0.0-1.0)   |

## Notes

- A null `dimension` indicates system or API-initiated requests without a user context
- User information is based on the authenticated user at request time
- Anonymous requests are grouped under "System/API"

## Use Cases

- **User activity tracking** - Monitor AI usage by team members
- **Training needs** - Identify power users who could train others
- **Quota management** - Implement per-user usage limits
- **Compliance** - Audit who is using AI features
