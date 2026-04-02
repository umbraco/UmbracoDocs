---
description: >-
    Get a specific version snapshot.
---

# Get Version

Returns a specific version including the complete entity snapshot.

## Request

```http
GET /umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{version}
```

### Path Parameters

| Parameter    | Type   | Description                                                         |
| ------------ | ------ | ------------------------------------------------------------------- |
| `entityType` | string | Entity type (`connection`, `profile`, `context`, `prompt`, `agent`) |
| `entityId`   | guid   | Entity unique identifier                                            |
| `version`    | int    | Version number to retrieve                                          |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "entityId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "entityType": "profile",
    "version": 3,
    "dateCreated": "2024-01-20T14:45:00Z",
    "createdByUserId": "user-guid",
    "changeDescription": "Updated temperature setting",
    "snapshot": {
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
            "temperature": 0.7,
            "maxTokens": 4096,
            "systemPromptTemplate": "You are a helpful content assistant."
        },
        "tags": ["content"],
        "version": 3
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

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/versions/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6/3" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var entityType = "profile";
var entityId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6");
var version = 3;

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{version}");
var versionData = await response.Content.ReadFromJsonAsync<AIEntityVersionWithSnapshotModel>();
```

{% endcode %}

## Snapshot Structure

The snapshot structure matches the entity type:

### Profile Snapshot

```json
{
  "snapshot": {
    "id": "guid",
    "alias": "string",
    "name": "string",
    "capability": "Chat|Embedding",
    "connectionId": "guid",
    "model": { "providerId": "string", "modelId": "string" },
    "settings": { ... },
    "tags": ["string"]
  }
}
```

### Context Snapshot

```json
{
  "snapshot": {
    "id": "guid",
    "alias": "string",
    "name": "string",
    "resources": [{ ... }]
  }
}
```

### Connection Snapshot

{% hint style="warning" %}
Connection snapshots exclude sensitive data (API keys) for security.
{% endhint %}

```json
{
    "snapshot": {
        "id": "guid",
        "alias": "string",
        "name": "string",
        "providerId": "string",
        "settings": {
            /* non-sensitive settings only */
        }
    }
}
```
