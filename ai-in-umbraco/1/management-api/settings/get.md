---
description: >-
    Get current AI settings.
---

# Get Settings

Returns the current global AI settings.

## Request

```http
GET /umbraco/ai/management/api/v1/settings
```

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "672bf83c-97e0-4d04-9d33-23fc2e5ebe42",
    "defaultChatProfileId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "defaultEmbeddingProfileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "dateCreated": "2024-01-01T00:00:00Z",
    "dateModified": "2024-01-20T14:45:00Z",
    "createdByUserId": null,
    "modifiedByUserId": "user-guid"
}
```

{% endcode %}

{% hint style="info" %}
If no settings have been configured, default values are returned with null profile IDs.
{% endhint %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/settings" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var response = await httpClient.GetAsync("/umbraco/ai/management/api/v1/settings");
var settings = await response.Content.ReadFromJsonAsync<AISettingsModel>();
```

{% endcode %}

## Response Properties

| Property                    | Type     | Description                                                |
| --------------------------- | -------- | ---------------------------------------------------------- |
| `id`                        | guid     | Fixed settings identifier                                  |
| `defaultChatProfileId`      | guid     | Default profile for chat operations (null if not set)      |
| `defaultEmbeddingProfileId` | guid     | Default profile for embedding operations (null if not set) |
| `dateCreated`               | datetime | When settings were first created                           |
| `dateModified`              | datetime | When settings were last modified                           |
| `modifiedByUserId`          | guid     | User who last modified settings                            |
