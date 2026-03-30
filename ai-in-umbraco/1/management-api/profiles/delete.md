---
description: >-
    Delete an AI profile.
---

# Delete Profile

Permanently deletes a profile.

## Request

```http
DELETE /umbraco/ai/management/api/v1/profile/{idOrAlias}
```

### Path Parameters

| Parameter   | Type   | Description           |
| ----------- | ------ | --------------------- |
| `idOrAlias` | string | Profile GUID or alias |

## Response

### Success

{% code title="200 OK" %}

```
(empty body)
```

{% endcode %}

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Profile not found"
}
```

{% endcode %}

## Examples

### Delete by ID

{% code title="cURL" %}

```bash
curl -X DELETE "https://your-site.com/umbraco/ai/management/api/v1/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Delete by Alias

{% code title="cURL" %}

```bash
curl -X DELETE "https://your-site.com/umbraco/ai/management/api/v1/profile/content-assistant" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% hint style="warning" %}
Deleting a profile is permanent and cannot be undone. Any code referencing the deleted profile's alias will fail.
{% endhint %}

## Considerations

### Before Deleting

1. **Check usage** - Ensure no application code references the profile by alias
2. **Update configurations** - Remove profile references from any configurations
3. **Consider deactivation** - If unsure, consider creating a replacement profile first

### After Deleting

- The profile ID and alias become available for reuse
- Any AI requests using the deleted profile will fail
- Historical data referencing the profile may show the ID but no details
