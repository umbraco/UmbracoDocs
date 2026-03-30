---
description: >-
    Manage AI provider connections via the Management API.
---

# Connection Endpoints

The connection endpoints allow you to manage AI provider connections programmatically.

## Available Endpoints

| Method | Endpoint                                 | Description                   |
| ------ | ---------------------------------------- | ----------------------------- |
| GET    | `/connections`                           | List all connections          |
| GET    | `/connections/{idOrAlias}`               | Get a specific connection     |
| POST   | `/connections`                           | Create a connection           |
| PUT    | `/connections/{id}`                      | Update a connection           |
| DELETE | `/connections/{id}`                      | Delete a connection           |
| POST   | `/connections/{idOrAlias}/test`          | Test a connection             |
| GET    | `/connections/capabilities`              | List available capabilities   |
| GET    | `/connections/capabilities/{capability}` | Get connections by capability |
| GET    | `/connections/{idOrAlias}/models`        | Get available models          |

## Connection Model

{% code title="Connection Response" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "openai-prod",
    "name": "OpenAI Production",
    "providerId": "openai",
    "isActive": true,
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-15T10:30:00Z",
    "settings": {
        "apiKey": "sk-***",
        "organization": null
    }
}
```

{% endcode %}

### Properties

| Property       | Type     | Description                   |
| -------------- | -------- | ----------------------------- |
| `id`           | guid     | Unique identifier             |
| `alias`        | string   | Unique alias for lookups      |
| `name`         | string   | Display name                  |
| `providerId`   | string   | ID of the provider            |
| `isActive`     | boolean  | Whether connection is enabled |
| `dateCreated`  | datetime | Creation timestamp            |
| `dateModified` | datetime | Last modification timestamp   |
| `settings`     | object   | Provider-specific settings    |

{% hint style="info" %}
Settings are returned with sensitive values masked (for example, API keys show as `sk-***`).
{% endhint %}

## In This Section

{% content-ref url="list.md" %}
[List Connections](list.md)
{% endcontent-ref %}

{% content-ref url="get.md" %}
[Get Connection](get.md)
{% endcontent-ref %}

{% content-ref url="create.md" %}
[Create Connection](create.md)
{% endcontent-ref %}

{% content-ref url="update.md" %}
[Update Connection](update.md)
{% endcontent-ref %}

{% content-ref url="delete.md" %}
[Delete Connection](delete.md)
{% endcontent-ref %}

{% content-ref url="test.md" %}
[Test Connection](test.md)
{% endcontent-ref %}

{% content-ref url="capabilities.md" %}
[List Capabilities](capabilities.md)
{% endcontent-ref %}

{% content-ref url="models.md" %}
[Get Models](models.md)
{% endcontent-ref %}
