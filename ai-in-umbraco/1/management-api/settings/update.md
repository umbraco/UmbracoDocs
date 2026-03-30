---
description: >-
    Update global AI settings.
---

# Update Settings

Updates the global AI settings. Changes are tracked in the audit log.

## Request

```http
PUT /umbraco/ai/management/api/v1/settings
```

### Request Body

{% code title="Request" %}

```json
{
    "defaultChatProfileId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "defaultEmbeddingProfileId": "d290f1ee-6c54-4b01-90e6-d701748f0851"
}
```

{% endcode %}

### Request Properties

| Property                    | Type | Required | Description                              |
| --------------------------- | ---- | -------- | ---------------------------------------- |
| `defaultChatProfileId`      | guid | No       | Default profile for chat operations      |
| `defaultEmbeddingProfileId` | guid | No       | Default profile for embedding operations |

{% hint style="info" %}
Set a property to `null` to clear the default.
{% endhint %}

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "672bf83c-97e0-4d04-9d33-23fc2e5ebe42",
    "defaultChatProfileId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "defaultEmbeddingProfileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "dateCreated": "2024-01-01T00:00:00Z",
    "dateModified": "2024-01-25T09:15:00Z",
    "modifiedByUserId": "user-guid"
}
```

{% endcode %}

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "errors": {
        "defaultChatProfileId": ["Profile not found or does not support Chat capability"]
    }
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/settings" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "defaultChatProfileId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "defaultEmbeddingProfileId": null
  }'
```

{% endcode %}

{% code title="C#" %}

```csharp
var settings = new
{
    defaultChatProfileId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
    defaultEmbeddingProfileId = (Guid?)null
};

var response = await httpClient.PutAsJsonAsync("/umbraco/ai/management/api/v1/settings", settings);
```

{% endcode %}

## Notes

- The specified profiles must exist and have the correct capability (Chat or Embedding)
- Changes to settings are recorded in the audit log
- Settings changes take effect immediately for new requests
