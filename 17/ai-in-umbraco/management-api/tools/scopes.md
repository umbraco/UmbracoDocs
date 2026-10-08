---
description: >-
    List all AI tool scopes that define tool categories and permissions.
---

# List Tool Scopes

Retrieve a list of all tool scopes. Scopes define categories of tools and determine their permissions and capabilities.

## Endpoint

{% code title="Endpoint" %}

```
GET /umbraco/ai/management/api/v1/tools/scopes
```

{% endcode %}

## Response

### Success (200 OK)

{% code title="Response" %}

```json
[
    {
        "id": "content-read",
        "icon": "icon-document",
        "isDestructive": false,
        "domain": "content"
    },
    {
        "id": "content-write",
        "icon": "icon-edit",
        "isDestructive": true,
        "domain": "content"
    },
    {
        "id": "media-read",
        "icon": "icon-picture",
        "isDestructive": false,
        "domain": "media"
    },
    {
        "id": "media-write",
        "icon": "icon-picture",
        "isDestructive": true,
        "domain": "media"
    },
    {
        "id": "search",
        "icon": "icon-search",
        "isDestructive": false,
        "domain": "search"
    }
]
```

{% endcode %}

### Item Properties

| Property        | Type    | Description                                  |
| --------------- | ------- | -------------------------------------------- |
| `id`            | string  | Unique identifier for the scope              |
| `icon`          | string  | Icon identifier for the backoffice UI        |
| `isDestructive` | boolean | Whether the scope contains destructive tools |
| `domain`        | string  | The functional domain of the scope           |

{% hint style="info" %}
Scope name and description are localized on the frontend using the keys `uaiToolScope_{scopeId}Label` and `uaiToolScope_{scopeId}Description`.
{% endhint %}

## Built-in Scopes

The following scopes are available by default when the Agent add-on is installed:

| Scope            | Domain       | Destructive | Description                          |
| ---------------- | ------------ | ----------- | ------------------------------------ |
| `content-read`   | content      | No          | Read content items                   |
| `content-write`  | content      | Yes         | Create, update, and delete content   |
| `media-read`     | media        | No          | Read media items                     |
| `media-write`    | media        | Yes         | Create, update, and delete media     |
| `search`         | search       | No          | Search across content and media      |
| `navigation`     | navigation   | No          | Navigate content tree structures     |
| `translation`    | translation  | No          | Translate content between languages  |
| `web`            | web          | No          | Fetch web content and URLs           |
| `entity-read`    | entity       | No          | Read generic entities                |
| `entity-write`   | entity       | Yes         | Create, update, and delete entities  |

{% hint style="info" %}
Destructive scopes (`content-write`, `media-write`, `entity-write`) are flagged to allow administrators to review and approve tools that can modify data.
{% endhint %}

## Examples

### List All Scopes

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/tools/scopes"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/tools/scopes", {
    credentials: "include",
});

const scopes = await response.json();

// Find destructive scopes
const destructiveScopes = scopes.filter((scope) => scope.isDestructive);
console.log(`${destructiveScopes.length} destructive scopes found`);
```

{% endcode %}
