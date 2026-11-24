---
description: >-
    Compare two versions of an entity.
---

# Compare Versions

Returns a comparison between two versions, showing what changed.

## Request

{% code title="Endpoint" %}

```http
GET /umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{fromEntityVersion}/compare/{toEntityVersion}
```

{% endcode %}

### Path Parameters

| Parameter           | Type   | Description                                                         |
| ------------------- | ------ | ------------------------------------------------------------------- |
| `entityType`        | string | Entity type (`connection`, `profile`, `context`, `prompt`, `agent`) |
| `entityId`          | guid   | Entity unique identifier                                            |
| `fromEntityVersion` | int    | Source version number                                               |
| `toEntityVersion`   | int    | Target version number                                               |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "fromVersion": 2,
    "toVersion": 5,
    "changes": [
        {
            "path": "settings.temperature",
            "oldValue": "0.5",
            "newValue": "0.8"
        },
        {
            "path": "settings.systemPromptTemplate",
            "oldValue": "You are an assistant.",
            "newValue": "You are a helpful content assistant for a website."
        },
        {
            "path": "tags[1]",
            "oldValue": null,
            "newValue": "content"
        }
    ]
}
```

{% endcode %}

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Version not found",
    "status": 404,
    "detail": "One or both versions were not found for this entity."
}
```

{% endcode %}

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
var comparison = await response.Content.ReadFromJsonAsync<EntityVersionComparisonResponseModel>();

foreach (var change in comparison.Changes)
{
    Console.WriteLine($"{change.Path}");
    Console.WriteLine($"  Old: {change.OldValue}");
    Console.WriteLine($"  New: {change.NewValue}");
}
```

{% endcode %}

## Response Properties

| Property      | Type  | Description                    |
| ------------- | ----- | ------------------------------ |
| `fromVersion` | int   | Source version number          |
| `toVersion`   | int   | Target version number          |
| `changes`     | array | List of detected value changes |

### Value Change Properties

| Property   | Type   | Description                                |
| ---------- | ------ | ------------------------------------------ |
| `path`     | string | The path of the value that changed         |
| `oldValue` | string | The old value (from the source version)    |
| `newValue` | string | The new value (from the target version)    |
