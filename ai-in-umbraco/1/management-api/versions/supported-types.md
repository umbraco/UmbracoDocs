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

{% code title="200 OK" %}

```json
{
    "types": [
        {
            "type": "connection",
            "displayName": "Connection",
            "package": "Umbraco.AI"
        },
        {
            "type": "profile",
            "displayName": "Profile",
            "package": "Umbraco.AI"
        },
        {
            "type": "context",
            "displayName": "Context",
            "package": "Umbraco.AI"
        },
        {
            "type": "prompt",
            "displayName": "Prompt",
            "package": "Umbraco.AI.Prompt"
        },
        {
            "type": "agent",
            "displayName": "Agent",
            "package": "Umbraco.AI.Agent"
        }
    ]
}
```

{% endcode %}

{% hint style="info" %}
Available types depend on which packages are installed. Prompt and Agent types are only available if those add-on packages are installed.
{% endhint %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/versions/supported-types" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Response Properties

| Property      | Type   | Description                          |
| ------------- | ------ | ------------------------------------ |
| `type`        | string | Entity type identifier for API calls |
| `displayName` | string | Human-readable name                  |
| `package`     | string | Package providing this entity type   |
