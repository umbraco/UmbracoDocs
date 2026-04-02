---
description: >-
    Delete a specific audit log entry.
---

# Delete Audit Log

Permanently deletes a specific audit log entry.

## Request

```http
DELETE /umbraco/ai/management/api/v1/audit-log/{id}
```

### Path Parameters

| Parameter | Type | Description                 |
| --------- | ---- | --------------------------- |
| `id`      | guid | Audit log unique identifier |

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
    "detail": "Audit log not found"
}
```

{% endcode %}

{% hint style="warning" %}
Deleting audit logs is permanent and cannot be undone. This action may affect compliance reporting and usage analytics.
{% endhint %}

## Examples

{% code title="cURL" %}

```bash
curl -X DELETE "https://your-site.com/umbraco/ai/management/api/v1/audit-log/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var response = await httpClient.DeleteAsync(
    "/umbraco/ai/management/api/v1/audit-log/3fa85f64-5717-4562-b3fc-2c963f66afa6");

if (response.StatusCode == HttpStatusCode.NoContent)
{
    // Successfully deleted
}
```

{% endcode %}
