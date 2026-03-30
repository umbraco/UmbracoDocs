---
description: >-
    Get version history for an entity.
---

# Get Version History

Returns a paginated list of versions for a specific entity.

## Request

```http
GET /umbraco/ai/management/api/v1/versions/{entityType}/{entityId}
```

### Path Parameters

| Parameter    | Type   | Description                                                         |
| ------------ | ------ | ------------------------------------------------------------------- |
| `entityType` | string | Entity type (`connection`, `profile`, `context`, `prompt`, `agent`) |
| `entityId`   | guid   | Entity unique identifier                                            |

### Query Parameters

| Parameter | Type | Default | Description                  |
| --------- | ---- | ------- | ---------------------------- |
| `skip`    | int  | 0       | Number of versions to skip   |
| `take`    | int  | 20      | Number of versions to return |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
            "entityId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "entityType": "profile",
            "version": 5,
            "dateCreated": "2024-01-25T09:15:00Z",
            "createdByUserId": "user-guid",
            "changeDescription": "Updated system prompt"
        },
        {
            "id": "b2c3d4e5-f6a7-8901-bcde-f23456789012",
            "entityId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "entityType": "profile",
            "version": 4,
            "dateCreated": "2024-01-22T16:30:00Z",
            "createdByUserId": "user-guid",
            "changeDescription": "Changed temperature to 0.8"
        },
        {
            "id": "c3d4e5f6-a7b8-9012-cdef-345678901234",
            "entityId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "entityType": "profile",
            "version": 3,
            "dateCreated": "2024-01-20T14:45:00Z",
            "createdByUserId": "user-guid",
            "changeDescription": null
        }
    ],
    "total": 5
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
    "detail": "Entity not found"
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/versions/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6?skip=0&take=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var entityType = "profile";
var entityId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6");

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/versions/{entityType}/{entityId}?skip=0&take=10");
var history = await response.Content.ReadFromJsonAsync<PagedResult<AIEntityVersionModel>>();
```

{% endcode %}

## Notes

- Versions are returned in descending order (newest first)
- The `changeDescription` may be null if no description was provided when the version was created
- History does not include the snapshot data - use the [Get Version](get-version.md) endpoint to retrieve full snapshots
