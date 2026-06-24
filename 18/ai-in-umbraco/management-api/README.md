---
description: >-
    REST API for managing AI connections, profiles, and performing AI operations.
---

# Management API

The Umbraco.AI Management API provides REST endpoints for managing connections and profiles, as well as performing chat completions and embedding generation.

## Base URL

All endpoints are prefixed with:

{% code title="Base URL" %}

```
/umbraco/ai/management/api/v1
```

{% endcode %}

## API Versioning

The API uses URL-based versioning. The current version is `v1`.

## Available Endpoints

### Chat Operations

| Method | Endpoint                                                                  | Description                              |
| ------ | ------------------------------------------------------------------------- | ---------------------------------------- |
| POST   | `/umbraco/ai/management/api/v1/chat/complete`                             | Get a chat completion (default profile)  |
| POST   | `/umbraco/ai/management/api/v1/chat/{profileIdOrAlias}/complete`          | Get a chat completion (specific profile) |

### Connection Management

| Method | Endpoint                                                                             | Description                   |
| ------ | ------------------------------------------------------------------------------------ | ----------------------------- |
| GET    | `/umbraco/ai/management/api/v1/connections`                                          | List all connections          |
| GET    | `/umbraco/ai/management/api/v1/connections/{connectionIdOrAlias}`                    | Get a specific connection     |
| POST   | `/umbraco/ai/management/api/v1/connections`                                          | Create a connection           |
| PUT    | `/umbraco/ai/management/api/v1/connections/{connectionIdOrAlias}`                    | Update a connection           |
| DELETE | `/umbraco/ai/management/api/v1/connections/{connectionIdOrAlias}`                    | Delete a connection           |
| POST   | `/umbraco/ai/management/api/v1/connections/{connectionIdOrAlias}/test`               | Test a connection             |
| GET    | `/umbraco/ai/management/api/v1/connections/capabilities`                             | List available capabilities   |
| GET    | `/umbraco/ai/management/api/v1/connections/capabilities/{capability}`                | Get connections by capability |
| GET    | `/umbraco/ai/management/api/v1/connections/{connectionIdOrAlias}/models`             | Get available models          |

### Profile Management

| Method | Endpoint                                                              | Description            |
| ------ | --------------------------------------------------------------------- | ---------------------- |
| GET    | `/umbraco/ai/management/api/v1/profiles`                              | List all profiles      |
| GET    | `/umbraco/ai/management/api/v1/profiles/{profileIdOrAlias}`           | Get a specific profile |
| POST   | `/umbraco/ai/management/api/v1/profiles`                              | Create a profile       |
| PUT    | `/umbraco/ai/management/api/v1/profiles/{profileIdOrAlias}`           | Update a profile       |
| DELETE | `/umbraco/ai/management/api/v1/profiles/{profileIdOrAlias}`           | Delete a profile       |

### Context Management

| Method | Endpoint                                                              | Description            |
| ------ | --------------------------------------------------------------------- | ---------------------- |
| GET    | `/umbraco/ai/management/api/v1/contexts`                              | List all contexts      |
| GET    | `/umbraco/ai/management/api/v1/contexts/{contextIdOrAlias}`           | Get a specific context |
| POST   | `/umbraco/ai/management/api/v1/contexts`                              | Create a context       |
| PUT    | `/umbraco/ai/management/api/v1/contexts/{contextIdOrAlias}`           | Update a context       |
| DELETE | `/umbraco/ai/management/api/v1/contexts/{contextIdOrAlias}`           | Delete a context       |

### Guardrails

| Method | Endpoint                                                              | Description               |
| ------ | --------------------------------------------------------------------- | ------------------------- |
| GET    | `/umbraco/ai/management/api/v1/guardrails`                            | List all guardrails       |
| GET    | `/umbraco/ai/management/api/v1/guardrails/{guardrailIdOrAlias}`       | Get a specific guardrail  |
| POST   | `/umbraco/ai/management/api/v1/guardrails`                            | Create a guardrail        |
| PUT    | `/umbraco/ai/management/api/v1/guardrails/{guardrailIdOrAlias}`       | Update a guardrail        |
| DELETE | `/umbraco/ai/management/api/v1/guardrails/{guardrailIdOrAlias}`       | Delete a guardrail        |
| GET    | `/umbraco/ai/management/api/v1/guardrail-evaluators`                  | List available evaluators |

### Settings

| Method | Endpoint                                  | Description          |
| ------ | ----------------------------------------- | -------------------- |
| GET    | `/umbraco/ai/management/api/v1/settings`  | Get current settings |
| PUT    | `/umbraco/ai/management/api/v1/settings`  | Update settings      |

### Version History

| Method | Endpoint                                                                                         | Description                               |
| ------ | ------------------------------------------------------------------------------------------------ | ----------------------------------------- |
| GET    | `/umbraco/ai/management/api/v1/versions/supported-types`                                         | List entity types that support versioning |
| GET    | `/umbraco/ai/management/api/v1/versions/{entityType}/{entityId}`                                 | Get version history                       |
| GET    | `/umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{version}`                       | Get specific version                      |
| GET    | `/umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{from}/compare/{to}`             | Compare versions                          |
| POST   | `/umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{version}/rollback`              | Rollback to version                       |

### Audit Logs

| Method | Endpoint                                                          | Description            |
| ------ | ----------------------------------------------------------------- | ---------------------- |
| GET    | `/umbraco/ai/management/api/v1/audit-logs`                        | List audit logs        |
| GET    | `/umbraco/ai/management/api/v1/audit-logs/{id}`                   | Get specific audit log |
| GET    | `/umbraco/ai/management/api/v1/audit-logs?entityId={entityId}`    | Get entity history     |
| DELETE | `/umbraco/ai/management/api/v1/audit-logs/{id}`                   | Delete audit log       |
| POST   | `/umbraco/ai/management/api/v1/audit-logs/cleanup`                | Cleanup old logs       |

### Usage Analytics

| Method | Endpoint                                                          | Description           |
| ------ | ----------------------------------------------------------------- | --------------------- |
| GET    | `/umbraco/ai/management/api/v1/analytics/usage-summary`           | Get usage summary     |
| GET    | `/umbraco/ai/management/api/v1/analytics/usage-time-series`       | Get time series data  |
| GET    | `/umbraco/ai/management/api/v1/analytics/usage-by-provider`       | Breakdown by provider |
| GET    | `/umbraco/ai/management/api/v1/analytics/usage-by-model`          | Breakdown by model    |
| GET    | `/umbraco/ai/management/api/v1/analytics/usage-by-profile`        | Breakdown by profile  |
| GET    | `/umbraco/ai/management/api/v1/analytics/usage-by-user`           | Breakdown by user     |

### Tools

| Method | Endpoint                                           | Description                                       |
| ------ | -------------------------------------------------- | ------------------------------------------------- |
| GET    | `/umbraco/ai/management/api/v1/tools`              | List all user-configurable tools grouped by scope |
| GET    | `/umbraco/ai/management/api/v1/tools/scopes`       | List all tool scopes                              |

### Context Resource Types

| Method | Endpoint                                                              | Description                                  |
| ------ | --------------------------------------------------------------------- | -------------------------------------------- |
| GET    | `/umbraco/ai/management/api/v1/context-resource-types`                | List all resource types                      |
| GET    | `/umbraco/ai/management/api/v1/context-resource-types/{id}`           | Get a resource type with its settings schema |

### Provider Information

| Method | Endpoint                                              | Description             |
| ------ | ----------------------------------------------------- | ----------------------- |
| GET    | `/umbraco/ai/management/api/v1/providers`             | List all providers      |
| GET    | `/umbraco/ai/management/api/v1/providers/{id}`        | Get a specific provider |

### Embedding Operations

| Method | Endpoint                                                                      | Description         |
| ------ | ----------------------------------------------------------------------------- | ------------------- |
| POST   | `/umbraco/ai/management/api/v1/embeddings/generate`                           | Generate embeddings |

## IdOrAlias Pattern

Many endpoints accept an `IdOrAlias` parameter, which can be either:

- A GUID (for example, `3fa85f64-5717-4562-b3fc-2c963f66afa6`)
- A string alias (for example, `my-chat-profile`)

Using either format provides flexibility in how you reference resources.

## Response Format

All responses use standard HTTP status codes and return JSON:

### Success Response

{% code title="Response" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "my-profile",
    "name": "My Profile"
}
```

{% endcode %}

### Error Response

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Connection not found"
}
```

{% endcode %}

## Pagination

List endpoints support pagination:

| Parameter | Type   | Default | Description               |
| --------- | ------ | ------- | ------------------------- |
| `skip`    | int    | 0       | Number of items to skip   |
| `take`    | int    | 100     | Number of items to return |
| `filter`  | string | null    | Filter by name (contains) |

Response includes total count:

{% code title="Response" %}

```json
{
  "items": [...],
  "total": 42
}
```

{% endcode %}

## In This Section

{% content-ref url="authentication.md" %}
[Authentication](authentication.md)
{% endcontent-ref %}

{% content-ref url="chat/README.md" %}
[Chat](chat/README.md)
{% endcontent-ref %}

{% content-ref url="connections/README.md" %}
[Connections](connections/README.md)
{% endcontent-ref %}

{% content-ref url="profiles/README.md" %}
[Profiles](profiles/README.md)
{% endcontent-ref %}

{% content-ref url="providers/README.md" %}
[Providers](providers/README.md)
{% endcontent-ref %}

{% content-ref url="tools/README.md" %}
[Tools](tools/README.md)
{% endcontent-ref %}

{% content-ref url="context-resource-types/README.md" %}
[Context Resource Types](context-resource-types/README.md)
{% endcontent-ref %}

{% content-ref url="embeddings/README.md" %}
[Embeddings](embeddings/README.md)
{% endcontent-ref %}
