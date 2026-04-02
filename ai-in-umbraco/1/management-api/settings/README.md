---
description: >-
    API endpoints for managing global AI settings.
---

# Settings API

The Settings API allows you to configure system-wide defaults for Umbraco.AI.

## Endpoints

| Method | Endpoint                 | Description          |
| ------ | ------------------------ | -------------------- |
| GET    | [`/settings`](get.md)    | Get current settings |
| PUT    | [`/settings`](update.md) | Update settings      |

## Base URL

```
/umbraco/ai/management/api/v1
```

## Settings Object

{% code title="Settings" %}

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

## Properties

| Property                    | Type     | Description                              |
| --------------------------- | -------- | ---------------------------------------- |
| `id`                        | guid     | Fixed settings identifier                |
| `defaultChatProfileId`      | guid     | Default profile for chat operations      |
| `defaultEmbeddingProfileId` | guid     | Default profile for embedding operations |
| `dateCreated`               | datetime | When settings were first created         |
| `dateModified`              | datetime | When settings were last modified         |
| `modifiedByUserId`          | guid     | User who last modified settings          |

{% hint style="info" %}
Settings use a fixed ID. There is always exactly one settings record.
{% endhint %}

## Related

- [Settings Concept](../../concepts/settings.md)
- [Managing Settings](../../backoffice/managing-settings.md)
