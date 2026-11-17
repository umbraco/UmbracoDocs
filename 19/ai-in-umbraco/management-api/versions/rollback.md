---
description: >-
    Rollback an entity to a previous version.
---

# Rollback Version

Restores an entity to a previous version state. This creates a new version with the restored state rather than deleting versions.

## Request

```http
POST /umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{entityVersion}/rollback
```

### Path Parameters

| Parameter       | Type   | Description                                                         |
| --------------- | ------ | ------------------------------------------------------------------- |
| `entityType`    | string | Entity type (`connection`, `profile`, `context`, `prompt`, `agent`) |
| `entityId`      | guid   | Entity unique identifier                                            |
| `entityVersion` | int    | Version number to restore                                           |

This endpoint does not accept a request body.

## Response

### Success

{% code title="204 No Content" %}

```
(empty response body)
```

{% endcode %}

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Rollback failed",
    "status": 404,
    "detail": "Version not found for this entity."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/versions/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6/3/rollback" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var entityType = "profile";
var entityId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6");
var targetVersion = 3;

var response = await httpClient.PostAsync(
    $"/umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{targetVersion}/rollback",
    null);

if (response.IsSuccessStatusCode)
{
    Console.WriteLine($"Entity rolled back to version {targetVersion}");
}
```

{% endcode %}

## Notes

- Rollback creates a new version (preserving audit trail)
- The entity's `version` property increments after rollback
- Rollback may fail if the restored state references deleted entities (e.g., a deleted connection)
- Connection rollbacks do not restore sensitive data (API keys) - these must be re-entered

{% hint style="warning" %}
Rolling back a connection does not restore API keys or other sensitive credentials. You will need to update these after rollback.
{% endhint %}
