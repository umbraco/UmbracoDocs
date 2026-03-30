---
description: >-
    Get available AI models for a connection.
---

# Get Models

Retrieve the list of AI models available through a specific connection. This is useful for populating model selection dropdowns in the UI.

## Endpoint

```
GET /connections/{idOrAlias}/models
```

## Path Parameters

| Parameter   | Type   | Description              |
| ----------- | ------ | ------------------------ |
| `idOrAlias` | string | Connection GUID or alias |

## Response

### Success (200 OK)

{% code title="Response" %}

```json
{
    "items": [
        {
            "id": "gpt-4o",
            "name": "GPT-4o",
            "capabilities": ["Chat"]
        },
        {
            "id": "gpt-4o-mini",
            "name": "GPT-4o Mini",
            "capabilities": ["Chat"]
        },
        {
            "id": "text-embedding-3-small",
            "name": "Text Embedding 3 Small",
            "capabilities": ["Embedding"]
        },
        {
            "id": "text-embedding-3-large",
            "name": "Text Embedding 3 Large",
            "capabilities": ["Embedding"]
        }
    ]
}
```

{% endcode %}

### Model Properties

| Property       | Type     | Description                          |
| -------------- | -------- | ------------------------------------ |
| `id`           | string   | Model identifier to use in API calls |
| `name`         | string   | Display name                         |
| `capabilities` | string[] | Capabilities this model supports     |

### 404 Not Found

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Connection not found"
}
```

## Examples

### cURL

{% code title="cURL" %}

```bash
curl -X GET "https://localhost:44331/umbraco/ai/management/api/v1/connections/openai-prod/models"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
async function getModels(connectionIdOrAlias) {
    const response = await fetch(`/umbraco/ai/management/api/v1/connections/${connectionIdOrAlias}/models`, {
        credentials: "include",
    });

    if (!response.ok) {
        throw new Error("Failed to fetch models");
    }

    const { items } = await response.json();
    return items;
}

// Usage
const models = await getModels("openai-prod");
console.log(models);
```

{% endcode %}

### Filter by Capability

{% code title="JavaScript" %}

```javascript
async function getChatModels(connectionIdOrAlias) {
    const models = await getModels(connectionIdOrAlias);
    return models.filter((m) => m.capabilities.includes("Chat"));
}

async function getEmbeddingModels(connectionIdOrAlias) {
    const models = await getModels(connectionIdOrAlias);
    return models.filter((m) => m.capabilities.includes("Embedding"));
}
```

{% endcode %}

### Populate Model Dropdown

{% code title="JavaScript" %}

```javascript
async function populateModelSelect(selectElement, connectionId, capability) {
    const models = await getModels(connectionId);
    const filtered = models.filter((m) => m.capabilities.includes(capability));

    selectElement.innerHTML = "";

    for (const model of filtered) {
        const option = document.createElement("option");
        option.value = model.id;
        option.textContent = model.name;
        selectElement.appendChild(option);
    }
}
```

{% endcode %}

## Notes

{% hint style="info" %}
The list of models is fetched from the AI provider in real-time. Results may vary based on your API key's permissions and the provider's available models.
{% endhint %}

{% hint style="warning" %}
This endpoint makes a call to the AI provider's API. Consider caching the results if you need to call it frequently.
{% endhint %}
