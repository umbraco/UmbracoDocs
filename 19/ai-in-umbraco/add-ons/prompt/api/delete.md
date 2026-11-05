---
description: >-
    Delete a prompt.
---

# Delete Prompt

Permanently deletes a prompt and all its version history.

## Request

```http
DELETE /umbraco/ai/management/api/v1/prompts/{idOrAlias}
```

### Path Parameters

| Parameter   | Type   | Description          |
| ----------- | ------ | -------------------- |
| `idOrAlias` | string | Prompt GUID or alias |

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
    "title": "AIPrompt not found",
    "status": 404,
    "detail": "The specified prompt could not be found."
}
```

{% endcode %}

{% hint style="warning" %}
Deleting a prompt also removes all version history. Consider deactivating (`isActive: false`) instead if you may need the prompt again.
{% endhint %}

## Examples

{% code title="cURL" %}

```bash
curl -X DELETE "https://your-site.com/umbraco/ai/management/api/v1/prompts/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}
