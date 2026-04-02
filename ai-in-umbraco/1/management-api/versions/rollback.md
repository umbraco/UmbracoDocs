---
description: >-
    Rollback an entity to a previous version.
---

# Rollback Version

Restores an entity to a previous version state. This creates a new version with the restored state rather than deleting versions.

## Request

```http
POST /umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{version}/rollback
```

### Path Parameters

| Parameter    | Type   | Description                                                         |
| ------------ | ------ | ------------------------------------------------------------------- |
| `entityType` | string | Entity type (`connection`, `profile`, `context`, `prompt`, `agent`) |
| `entityId`   | guid   | Entity unique identifier                                            |
| `version`    | int    | Version number to restore                                           |

### Request Body (Optional)

{% code title="Request" %}

```json
{
    "changeDescription": "Rolled back to version 3 due to regression"
}
```

{% endcode %}

## Response

### Success

{% code title="200 OK" %}

```json
{
    "entityId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "entityType": "profile",
    "previousVersion": 5,
    "restoredFromVersion": 3,
    "newVersion": 6,
    "entity": {
        "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "alias": "content-assistant",
        "name": "Content Assistant",
        "capability": "Chat",
        "connectionId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
        "model": {
            "providerId": "openai",
            "modelId": "gpt-4o"
        },
        "settings": {
            "$type": "chat",
            "temperature": 0.7
        },
        "version": 6
    }
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
    "detail": "Version not found"
}
```

{% endcode %}

### Conflict

{% code title="409 Conflict" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.8",
    "title": "Conflict",
    "status": 409,
    "detail": "Cannot rollback: referenced connection no longer exists"
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/versions/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6/3/rollback" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "changeDescription": "Rolled back to version 3"
  }'
```

{% endcode %}

{% code title="C#" %}

```csharp
var entityType = "profile";
var entityId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6");
var targetVersion = 3;

var request = new { changeDescription = "Rolled back to version 3" };

var response = await httpClient.PostAsJsonAsync(
    $"/umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{targetVersion}/rollback",
    request);

var result = await response.Content.ReadFromJsonAsync<RollbackResultModel>();
Console.WriteLine($"Entity restored to version {result.NewVersion}");
```

{% endcode %}

## Response Properties

| Property              | Type   | Description                       |
| --------------------- | ------ | --------------------------------- |
| `entityId`            | guid   | Entity identifier                 |
| `entityType`          | string | Entity type                       |
| `previousVersion`     | int    | Version before rollback           |
| `restoredFromVersion` | int    | Version that was restored         |
| `newVersion`          | int    | New version number after rollback |
| `entity`              | object | The restored entity               |

## Notes

- Rollback creates a new version (preserving audit trail)
- The entity's `version` property increments after rollback
- Rollback may fail if the restored state references deleted entities (e.g., a deleted connection)
- Connection rollbacks do not restore sensitive data (API keys) - these must be re-entered

{% hint style="warning" %}
Rolling back a connection does not restore API keys or other sensitive credentials. You will need to update these after rollback.
{% endhint %}
