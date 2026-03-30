---
description: >-
    Get a context by ID or alias.
---

# Get Context

Returns the full details of a specific context.

## Request

```http
GET /umbraco/ai/management/api/v1/context/{idOrAlias}
```

### Path Parameters

| Parameter   | Type   | Description           |
| ----------- | ------ | --------------------- |
| `idOrAlias` | string | Context GUID or alias |

## Response

### Success

{% code title="200 OK" %}

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

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Context not found"
}
```

{% endcode %}

## Examples

### Get by ID

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/context/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Get by Alias

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/context/brand-voice" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Response Properties

| Property           | Type     | Description                        |
| ------------------ | -------- | ---------------------------------- |
| `id`               | guid     | Unique identifier                  |
| `alias`            | string   | Unique alias for code references   |
| `name`             | string   | Display name                       |
| `version`          | int      | Current version number             |
| `resources`        | array    | Collection of context resources    |
| `dateCreated`      | datetime | When the context was created       |
| `dateModified`     | datetime | When the context was last modified |
| `createdByUserId`  | guid     | User who created the context       |
| `modifiedByUserId` | guid     | User who last modified the context |
