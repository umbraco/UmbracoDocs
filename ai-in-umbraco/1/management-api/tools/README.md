---
description: >-
    Manage AI tools and tool scopes via the Management API.
---

# Tool Endpoints

Tools represent functions that AI agents can call during execution. They are registered by add-ons such as Agent and are organized into scopes that define their capabilities and permissions.

You can use the tool endpoints to list all user-configurable tools and their scopes, which is useful for building custom UIs or inspecting available agent capabilities.

## Available Endpoints

| Method | Endpoint       | Description                                    |
| ------ | -------------- | ---------------------------------------------- |
| GET    | `/tools`       | List all user-configurable tools grouped by scope |
| GET    | `/tool-scopes` | List all tool scopes                           |

## Tool Model

{% code title="Tool Response" %}

```json
{
    "id": "get-content-by-id",
    "name": "Get Content By Id",
    "description": "Retrieves a content item by its unique identifier.",
    "scopeId": "content-read",
    "isDestructive": false,
    "tags": ["content", "read"]
}
```

{% endcode %}

### Properties

| Property        | Type     | Description                                      |
| --------------- | -------- | ------------------------------------------------ |
| `id`            | string   | Unique identifier for the tool                   |
| `name`          | string   | Display name                                     |
| `description`   | string   | Description of what the tool does                |
| `scopeId`       | string   | The scope this tool belongs to                   |
| `isDestructive` | boolean  | Whether the tool performs destructive operations |
| `tags`          | string[] | Tags for categorization                          |

## Tool Scope Model

{% code title="Tool Scope Response" %}

```json
{
    "id": "content-read",
    "icon": "icon-document",
    "isDestructive": false,
    "domain": "content",
    "forEntityTypes": ["document"]
}
```

{% endcode %}

### Properties

| Property         | Type     | Description                                           |
| ---------------- | -------- | ----------------------------------------------------- |
| `id`             | string   | Unique identifier for the scope                       |
| `icon`           | string   | Icon identifier for the backoffice UI                 |
| `isDestructive`  | boolean  | Whether the scope contains destructive tools          |
| `domain`         | string   | The functional domain of the scope                    |
| `forEntityTypes` | string[] | Entity types this scope applies to                    |

## In This Section

{% content-ref url="list.md" %}
[List Tools](list.md)
{% endcontent-ref %}

{% content-ref url="scopes.md" %}
[List Tool Scopes](scopes.md)
{% endcontent-ref %}
