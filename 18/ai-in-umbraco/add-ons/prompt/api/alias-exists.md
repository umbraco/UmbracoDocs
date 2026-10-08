---
description: >-
    Check whether a prompt alias is in use.
---

# Check Alias Exists

Returns whether a prompt with the given alias already exists. Useful for validating user input before creating or renaming a prompt.

## Request

```http
GET /umbraco/ai/management/api/v1/prompts/{alias}/exists
```

### Path Parameters

| Parameter | Type   | Description                |
| --------- | ------ | -------------------------- |
| `alias`   | string | The alias to check         |

### Query Parameters

| Parameter   | Type | Required | Description                                                  |
| ----------- | ---- | -------- | ------------------------------------------------------------ |
| `excludeId` | guid | No       | Optional prompt ID to exclude from the check (useful during updates to allow the prompt to keep its own alias). |

## Response

### Success

{% code title="200 OK" %}

```
true
```

{% endcode %}

The response body is a JSON boolean: `true` if a prompt with the alias exists, `false` otherwise.

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/prompts/meta-description/exists" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}
