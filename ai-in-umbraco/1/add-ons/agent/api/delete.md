---
description: >-
    Delete an agent.
---

# Delete Agent

Permanently deletes an agent and all its version history.

## Request

```http
DELETE /umbraco/ai/management/api/v1/agent/{id}
```

### Path Parameters

| Parameter | Type | Description             |
| --------- | ---- | ----------------------- |
| `id`      | guid | Agent unique identifier |

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
    "detail": "Agent not found"
}
```

{% endcode %}

{% hint style="warning" %}
Deleting an agent also removes all version history. Consider deactivating (`isActive: false`) instead if you may need the agent again.
{% endhint %}

## Examples

{% code title="cURL" %}

```bash
curl -X DELETE "https://your-site.com/umbraco/ai/management/api/v1/agent/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}
