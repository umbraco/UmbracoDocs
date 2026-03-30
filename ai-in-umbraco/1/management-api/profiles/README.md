---
description: >-
    API endpoints for managing AI profiles.
---

# Profiles

Profiles combine a connection with model-specific settings for use cases. They define which AI model to use and how it should behave.

## Base URL

```
/umbraco/ai/management/api/v1/profile
```

## Endpoints

| Method | Endpoint               | Description                   |
| ------ | ---------------------- | ----------------------------- |
| GET    | `/profile`             | [List all profiles](list.md)  |
| GET    | `/profile/{idOrAlias}` | [Get a profile](get.md)       |
| POST   | `/profile`             | [Create a profile](create.md) |
| PUT    | `/profile/{idOrAlias}` | [Update a profile](update.md) |
| DELETE | `/profile/{idOrAlias}` | [Delete a profile](delete.md) |

## Profile Object

{% code title="Profile Response" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "content-assistant",
    "name": "Content Assistant",
    "capability": "Chat",
    "model": {
        "providerId": "openai",
        "modelId": "gpt-4o"
    },
    "connectionId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "settings": {
        "$type": "chat",
        "temperature": 0.7,
        "maxTokens": 4096,
        "systemPromptTemplate": "You are a helpful content assistant."
    },
    "tags": ["content", "assistant"]
}
```

{% endcode %}

## Profile Properties

| Property       | Type   | Description                                     |
| -------------- | ------ | ----------------------------------------------- |
| `id`           | guid   | Unique identifier                               |
| `alias`        | string | Unique alias for code references                |
| `name`         | string | Display name                                    |
| `capability`   | string | Capability type (`Chat`, `Embedding`)           |
| `model`        | object | Model reference with `providerId` and `modelId` |
| `connectionId` | guid   | ID of the connection to use                     |
| `settings`     | object | Capability-specific settings (polymorphic)      |
| `tags`         | array  | Optional tags for categorization                |

## Settings Types

Settings are polymorphic based on the `$type` discriminator.

### Chat Settings

{% code title="Chat Settings" %}

```json
{
    "$type": "chat",
    "temperature": 0.7,
    "maxTokens": 4096,
    "systemPromptTemplate": "You are a helpful assistant."
}
```

{% endcode %}

| Property               | Type   | Description             |
| ---------------------- | ------ | ----------------------- |
| `temperature`          | float  | Randomness (0.0-1.0)    |
| `maxTokens`            | int    | Maximum response tokens |
| `systemPromptTemplate` | string | Default system prompt   |

### Embedding Settings

{% code title="Embedding Settings" %}

```json
{
    "$type": "embedding"
}
```

{% endcode %}

Embedding profiles currently have no additional settings.

## ID or Alias

Most endpoints accept either a GUID or alias to identify profiles:

```bash
# By ID
GET /umbraco/ai/management/api/v1/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6

# By alias
GET /umbraco/ai/management/api/v1/profile/content-assistant
```

This flexibility allows referencing profiles by memorable aliases in configuration while using GUIDs internally.

## In This Section

{% content-ref url="list.md" %}
[List Profiles](list.md)
{% endcontent-ref %}

{% content-ref url="get.md" %}
[Get Profile](get.md)
{% endcontent-ref %}

{% content-ref url="create.md" %}
[Create Profile](create.md)
{% endcontent-ref %}

{% content-ref url="update.md" %}
[Update Profile](update.md)
{% endcontent-ref %}

{% content-ref url="delete.md" %}
[Delete Profile](delete.md)
{% endcontent-ref %}
