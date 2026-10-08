---
description: >-
    Get a specific version snapshot.
---

# Get Version

Returns the version record for a specific version of an entity.

## Request

```http
GET /umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{entityVersion}
```

### Path Parameters

| Parameter       | Type   | Description                                                         |
| --------------- | ------ | ------------------------------------------------------------------- |
| `entityType`    | string | Entity type (`connection`, `profile`, `context`, `prompt`, `agent`) |
| `entityId`      | guid   | Entity unique identifier                                            |
| `entityVersion` | int    | Version number to retrieve                                          |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "entityId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "version": 3,
    "dateCreated": "2024-01-20T14:45:00Z",
    "createdByUserId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "createdByUserName": "admin@example.com",
    "changeDescription": "Updated temperature setting"
}
```

{% endcode %}

### Response Properties

| Property            | Type     | Description                                          |
| ------------------- | -------- | ---------------------------------------------------- |
| `id`                | guid     | Unique identifier of the version record              |
| `entityId`          | guid     | ID of the entity this version belongs to             |
| `version`           | int      | The version number                                   |
| `dateCreated`       | datetime | When this version was created                        |
| `createdByUserId`   | guid     | User key of the user who created this version        |
| `createdByUserName` | string   | Display name of the user who created this version    |
| `changeDescription` | string   | Optional description of what changed in this version |

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Version not found"
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/versions/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6/3" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var entityType = "profile";
var entityId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6");
var version = 3;

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/versions/{entityType}/{entityId}/{version}");
var versionData = await response.Content.ReadFromJsonAsync<EntityVersionResponseModel>();
```

{% endcode %}
