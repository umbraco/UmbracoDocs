---
description: >-
    Compare two versions of an entity.
---

# Compare Versions

Returns a comparison between two versions, showing what changed.

## Request

{% code title="Endpoint" %}

```http
GET /umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{from}/compare/{to}
```

{% endcode %}

### Path Parameters

| Parameter    | Type   | Description                                                         |
| ------------ | ------ | ------------------------------------------------------------------- |
| `entityType` | string | Entity type (`connection`, `profile`, `context`, `prompt`, `agent`) |
| `entityId`   | guid   | Entity unique identifier                                            |
| `from`       | int    | Source version number                                               |
| `to`         | int    | Target version number                                               |

## Response

### Success

{% code title="200 OK" %}

```json
{
  "entityId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "entityType": "profile",
  "fromVersion": 2,
  "toVersion": 5,
  "fromDate": "2024-01-18T10:00:00Z",
  "toDate": "2024-01-25T09:15:00Z",
  "changes": [
    {
      "path": "settings.temperature",
      "changeType": "Modified",
      "fromValue": "0.5",
      "toValue": "0.8"
    },
    {
      "path": "settings.systemPromptTemplate",
      "changeType": "Modified",
      "fromValue": "You are an assistant.",
      "toValue": "You are a helpful content assistant for a website."
    },
    {
      "path": "tags[1]",
      "changeType": "Added",
      "fromValue": null,
      "toValue": "content"
    }
  ],
  "fromSnapshot": { ... },
  "toSnapshot": { ... }
}
```

{% endcode %}

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "One or both versions not found"
}
```

{% endcode %}

## Change Types

| Type       | Description                                |
| ---------- | ------------------------------------------ |
| `Added`    | Property was added in the target version   |
| `Removed`  | Property was removed in the target version |
| `Modified` | Property value changed between versions    |

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/versions/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6/2/compare/5" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var entityType = "profile";
var entityId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6");
var fromVersion = 2;
var toVersion = 5;

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{fromVersion}/compare/{toVersion}");
var comparison = await response.Content.ReadFromJsonAsync<AIVersionComparisonModel>();

foreach (var change in comparison.Changes)
{
    Console.WriteLine($"{change.Path}: {change.ChangeType}");
    Console.WriteLine($"  From: {change.FromValue}");
    Console.WriteLine($"  To: {change.ToValue}");
}
```

{% endcode %}

## Response Properties

| Property       | Type     | Description                         |
| -------------- | -------- | ----------------------------------- |
| `entityId`     | guid     | Entity identifier                   |
| `entityType`   | string   | Entity type                         |
| `fromVersion`  | int      | Source version number               |
| `toVersion`    | int      | Target version number               |
| `fromDate`     | datetime | When the source version was created |
| `toDate`       | datetime | When the target version was created |
| `changes`      | array    | List of detected changes            |
| `fromSnapshot` | object   | Complete source version snapshot    |
| `toSnapshot`   | object   | Complete target version snapshot    |

## Notes

- Version order doesn't matter - you can compare from higher to lower version
- Large snapshots may result in large response payloads
- Sensitive data (like API keys) is excluded from comparison snapshots
