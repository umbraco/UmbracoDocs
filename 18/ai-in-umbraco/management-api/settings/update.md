---
description: >-
    Update global AI settings.
---

# Update Settings

Updates the global AI settings.

## Request

```http
PUT /umbraco/ai/management/api/v1/settings
```

### Request Body

{% code title="Request" %}

```json
{
    "defaultChatProfileId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "defaultEmbeddingProfileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "defaultSpeechToTextProfileId": null,
    "classifierChatProfileId": null,
    "defaultDecisionProfileId": null,
    "disclosureNoticeMode": "Always"
}
```

{% endcode %}

### Request Properties

| Property                         | Type | Required | Description                                   |
| -------------------------------- | ---- | -------- | --------------------------------------------- |
| `defaultChatProfileId`           | guid | No       | Default profile for chat operations           |
| `defaultEmbeddingProfileId`      | guid | No       | Default profile for embedding operations      |
| `defaultSpeechToTextProfileId`   | guid | No       | Default profile for speech-to-text operations |
| `classifierChatProfileId`        | guid | No       | Optional profile for classification tasks     |
| `defaultDecisionProfileId`       | GUID | No       | Default profile for decisions (experimental)  |
| `disclosureNoticeMode`           | string | No     | How the AI-generated notice is shown: `Always`, `Dismissible`, or `Off` |

{% hint style="info" %}
Set a property to `null` to clear the default.
{% endhint %}

{% hint style="warning" %}
The request replaces all settings. If `disclosureNoticeMode` is missing or not a known value, it is saved as `Always`. Include the current value when you only want to change a profile.
{% endhint %}

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "672bf83c-97e0-4d04-9d33-23fc2e5ebe42",
    "defaultChatProfileId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "defaultEmbeddingProfileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "defaultSpeechToTextProfileId": null,
    "classifierChatProfileId": null,
    "defaultDecisionProfileId": null,
    "disclosureNoticeMode": "Always",
    "dateCreated": "2024-01-01T00:00:00Z",
    "dateModified": "2024-01-25T09:15:00Z",
    "modifiedByUserId": "user-guid"
}
```

{% endcode %}

### Validation Error

Each profile property that is not `null` is checked. The profile must exist and have the capability that matches the property. The first property that fails returns `400 Bad Request`, and nothing is saved.

{% code title="400 Bad Request" %}

```json
{
    "type": "Error",
    "title": "Invalid settings",
    "status": 400,
    "detail": "DefaultDecisionProfileId must reference a profile with the Decision capability, but the specified profile has the Chat capability.",
    "operationStatus": "InvalidSettings"
}
```

{% endcode %}

If the profile does not exist, `detail` reads `<PropertyName> references a profile that does not exist.`

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

- Each specified profile must exist and have the capability its property expects. `classifierChatProfileId` expects a Chat profile, and `defaultDecisionProfileId` expects a Decision profile
- Settings changes take effect immediately for new requests
- `defaultDecisionProfileId` is stored whether or not the experimental Decision flag is enabled. The backoffice hides its picker while the flag is off, but keeps the saved value
