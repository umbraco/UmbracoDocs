---
description: >-
    List entity types that support version history.
---

# List Supported Types

Returns a list of entity types that support version history.

## Request

```http
GET /umbraco/ai/management/api/v1/versions/supported-types
```

## Response

### Success

Returns an array of entity type identifiers.

{% code title="200 OK" %}

```json
[
    "connection",
    "profile",
    "context",
    "prompt",
    "agent"
]
```

{% endcode %}

{% hint style="info" %}
Available types depend on which packages are installed. `prompt` and `agent` types are only available if those add-on packages are installed.
{% endhint %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/versions/supported-types" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}
