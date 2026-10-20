---
description: >-
    API endpoints for managing global AI settings.
---

# Settings API

The Settings API allows you to configure system-wide defaults for Umbraco.AI.

## Endpoints

| Method | Endpoint                                                  | Description          |
| ------ | --------------------------------------------------------- | -------------------- |
| GET    | [`/umbraco/ai/management/api/v1/settings`](get.md)        | Get current settings |
| PUT    | [`/umbraco/ai/management/api/v1/settings`](update.md)     | Update settings      |
| GET    | [`/umbraco/ai/management/api/v1/settings/disclosure`](disclosure.md) | Get the AI disclosure notice setting |

## Base URL

```
/umbraco/ai/management/api/v1
```

## Settings Object

{% code title="Settings" %}

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

## Properties

| Property                    | Type     | Description                              |
| --------------------------- | -------- | ---------------------------------------- |
| `defaultChatProfileId`      | GUID     | Default profile for chat operations      |
| `defaultEmbeddingProfileId` | GUID     | Default profile for embedding operations |
| `classifierChatProfileId`   | GUID     | Optional profile for classification tasks |
| `defaultSpeechToTextProfileId` | GUID  | Default profile for speech-to-text operations |
| `defaultDecisionProfileId`  | GUID     | Default profile for decisions (experimental) |
| `disclosureNoticeMode`      | string   | How the AI-generated notice is shown: `Always`, `Dismissible`, or `Off` |

{% hint style="info" %}
There is always exactly one settings record.
{% endhint %}

## Related

- [Settings Concept](../../concepts/settings.md)
- [Managing Settings](../../backoffice/managing-settings.md)
