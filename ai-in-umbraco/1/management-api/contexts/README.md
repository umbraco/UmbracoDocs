---
description: >-
    API endpoints for managing AI contexts.
---

# Contexts API

Contexts define collections of resources (brand voice, guidelines, content) that get injected into AI operations.

## Endpoints

| Method | Endpoint                         | Description                  |
| ------ | -------------------------------- | ---------------------------- |
| GET    | [`/context`](list.md)            | List all contexts            |
| GET    | [`/context/{idOrAlias}`](get.md) | Get a context by ID or alias |
| POST   | [`/context`](create.md)          | Create a new context         |
| PUT    | [`/context/{id}`](update.md)     | Update an existing context   |
| DELETE | [`/context/{id}`](delete.md)     | Delete a context             |

## Base URL

```
/umbraco/ai/management/api/v1
```

## Context Object

{% code title="Context" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "brand-voice",
    "name": "Brand Voice",
    "version": 3,
    "resources": [
        {
            "id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "resourceTypeId": "text",
            "name": "Tone of Voice",
            "description": "Writing style guidelines",
            "sortOrder": 0,
            "data": "Always use a friendly, professional tone...",
            "injectionMode": "Always"
        }
    ],
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-20T14:45:00Z",
    "createdByUserId": "user-guid",
    "modifiedByUserId": "user-guid"
}
```

{% endcode %}

## Resource Properties

| Property         | Type   | Description                                 |
| ---------------- | ------ | ------------------------------------------- |
| `id`             | guid   | Unique identifier                           |
| `resourceTypeId` | string | Type of resource (e.g., "text", "document") |
| `name`           | string | Display name                                |
| `description`    | string | Optional description                        |
| `sortOrder`      | int    | Controls injection order                    |
| `data`           | object | Type-specific resource data                 |
| `injectionMode`  | string | When to inject: `Always` or `OnDemand`      |

## Related

- [Contexts Concept](../../concepts/contexts.md)
- [Managing Contexts](../../backoffice/managing-contexts.md)
