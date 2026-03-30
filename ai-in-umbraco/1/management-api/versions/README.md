---
description: >-
    Unified API for accessing version history across all AI entities.
---

# Versions API

The Versions API provides centralized access to version history for all versioned AI entities. Rather than per-entity version endpoints, this unified API handles versioning for connections, profiles, contexts, prompts, and agents.

## Endpoints

| Method | Endpoint                                                              | Description                               |
| ------ | --------------------------------------------------------------------- | ----------------------------------------- |
| GET    | [`/versions/supported-types`](supported-types.md)                     | List entity types that support versioning |
| GET    | [`/versions/{entityType}/{entityId}`](history.md)                     | Get version history for an entity         |
| GET    | [`/versions/{entityType}/{entityId}/{version}`](get-version.md)       | Get a specific version snapshot           |
| GET    | [`/versions/{entityType}/{entityId}/{from}/compare/{to}`](compare.md) | Compare two versions                      |
| POST   | [`/versions/{entityType}/{entityId}/{version}/rollback`](rollback.md) | Rollback to a previous version            |

## Base URL

```
/umbraco/ai/management/api/v1
```

## Supported Entity Types

| Entity Type  | Package           | Description                     |
| ------------ | ----------------- | ------------------------------- |
| `connection` | Umbraco.AI        | API connections and credentials |
| `profile`    | Umbraco.AI        | AI profile configurations       |
| `context`    | Umbraco.AI        | Context resources and content   |
| `prompt`     | Umbraco.AI.Prompt | Prompt templates                |
| `agent`      | Umbraco.AI.Agent  | Agent definitions               |

## Version Object

{% code title="Version" %}

```json
{
    "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "entityId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "entityType": "profile",
    "version": 3,
    "dateCreated": "2024-01-20T14:45:00Z",
    "createdByUserId": "user-guid",
    "changeDescription": "Updated temperature setting"
}
```

{% endcode %}

## Properties

| Property            | Type     | Description                     |
| ------------------- | -------- | ------------------------------- |
| `id`                | guid     | Version record identifier       |
| `entityId`          | guid     | ID of the versioned entity      |
| `entityType`        | string   | Type discriminator              |
| `version`           | int      | Sequential version number       |
| `dateCreated`       | datetime | When this version was created   |
| `createdByUserId`   | guid     | User who created this version   |
| `changeDescription` | string   | Optional description of changes |

## Version Snapshots

When you request a specific version, the response includes a `snapshot` field containing the complete entity state at that version:

{% code title="Version with Snapshot" %}

```json
{
    "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "entityId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "entityType": "profile",
    "version": 3,
    "dateCreated": "2024-01-20T14:45:00Z",
    "snapshot": {
        "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "alias": "content-assistant",
        "name": "Content Assistant",
        "capability": "Chat",
        "model": {
            "providerId": "openai",
            "modelId": "gpt-4o"
        },
        "settings": {
            "$type": "chat",
            "temperature": 0.7
        }
    }
}
```

{% endcode %}

## Related

- [Version History Concept](../../concepts/versioning.md)
- [Version History Backoffice](../../backoffice/version-history.md)
