---
description: >-
    Delete an AI guardrail.
---

# Delete Guardrail

Permanently deletes a guardrail and all its rules.

## Request

```http
DELETE /umbraco/ai/management/api/v1/guardrails/{id}
```

### Path Parameters

| Parameter | Type | Description                 |
| --------- | ---- | --------------------------- |
| `id`      | guid | Guardrail unique identifier |

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
    "title": "Guardrail not found",
    "status": 404,
    "detail": "The specified guardrail could not be found."
}
```

{% endcode %}

{% hint style="warning" %}
Deleting a guardrail also removes all version history. This action cannot be undone. Ensure the guardrail is not referenced by profiles, prompts, or agents before deletion.
{% endhint %}

## Examples

{% code title="cURL" %}

```bash
curl -X DELETE "https://your-site.com/umbraco/ai/management/api/v1/guardrails/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var response = await httpClient.DeleteAsync("/umbraco/ai/management/api/v1/guardrails/3fa85f64-5717-4562-b3fc-2c963f66afa6");
if (response.StatusCode == HttpStatusCode.NoContent)
{
    // Successfully deleted
}
```

{% endcode %}
