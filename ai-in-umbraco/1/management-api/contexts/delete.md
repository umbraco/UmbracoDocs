---
description: >-
    Delete an AI context.
---

# Delete Context

Permanently deletes a context and all its resources.

## Request

```http
DELETE /umbraco/ai/management/api/v1/context/{id}
```

### Path Parameters

| Parameter | Type | Description               |
| --------- | ---- | ------------------------- |
| `id`      | guid | Context unique identifier |

## Response

### Success

{% code title="204 No Content" %}

```
(empty response body)
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

{% hint style="warning" %}
Deleting a context also removes all version history. This action cannot be undone. Ensure the context is not referenced by prompts or agents before deletion.
{% endhint %}

## Examples

{% code title="cURL" %}

```bash
curl -X DELETE "https://your-site.com/umbraco/ai/management/api/v1/context/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var response = await httpClient.DeleteAsync("/umbraco/ai/management/api/v1/context/3fa85f64-5717-4562-b3fc-2c963f66afa6");
if (response.StatusCode == HttpStatusCode.NoContent)
{
    // Successfully deleted
}
```

{% endcode %}
