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
    "defaultChatProfileId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "defaultEmbeddingProfileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "classifierChatProfileId": null,
    "defaultSpeechToTextProfileId": null,
    "defaultDecisionProfileId": null,
    "disclosureNoticeMode": "Always"
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
var settings = await response.Content.ReadFromJsonAsync<SettingsResponseModel>();
```

{% endcode %}

## Response Properties

| Property                    | Type     | Description                                                |
| --------------------------- | -------- | ---------------------------------------------------------- |
| `defaultChatProfileId`      | GUID     | Default profile for chat operations (null if not set)      |
| `defaultEmbeddingProfileId`      | GUID     | Default profile for embedding operations (null if not set)      |
| `classifierChatProfileId`        | GUID     | Optional profile for classification tasks (null if not set)     |
| `defaultSpeechToTextProfileId`   | GUID     | Default profile for speech-to-text operations (null if not set) |
| `defaultDecisionProfileId`       | GUID     | Default profile for decisions (experimental, null if not set)   |
| `disclosureNoticeMode`           | string   | How the AI-generated notice is shown: `Always`, `Dismissible`, or `Off` |
