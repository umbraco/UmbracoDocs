---
description: >-
    List all registered AI providers.
---

# List Providers

Returns all AI providers registered in the system.

## Request

```http
GET /umbraco/ai/management/api/v1/provider
```

### Headers

| Header          | Value                  |
| --------------- | ---------------------- |
| `Authorization` | Bearer token or cookie |

### Query Parameters

None.

## Response

### Success (200 OK)

Returns an array of provider items.

{% code title="Response" %}

```json
[
    {
        "id": "openai",
        "name": "OpenAI",
        "capabilities": ["Chat", "Embedding"]
    },
    {
        "id": "azure-openai",
        "name": "Azure OpenAI",
        "capabilities": ["Chat", "Embedding"]
    }
]
```

{% endcode %}

### Response Properties

| Property       | Type     | Description                |
| -------------- | -------- | -------------------------- |
| `id`           | string   | Unique provider identifier |
| `name`         | string   | Display name               |
| `capabilities` | string[] | Supported capabilities     |

## Capabilities

Possible capability values:

| Value        | Description                          |
| ------------ | ------------------------------------ |
| `Chat`       | Conversational AI / chat completions |
| `Embedding`  | Text to vector embeddings            |
| `Media`      | Image/media generation (planned)     |
| `Moderation` | Content safety (planned)             |

## Example

### cURL

```bash
curl -X GET "https://localhost:44331/umbraco/ai/management/api/v1/provider" \
  -H "Authorization: Bearer {token}"
```

### C# HttpClient

{% code title="Example" %}

```csharp
using var client = new HttpClient();
client.DefaultRequestHeaders.Authorization =
    new AuthenticationHeaderValue("Bearer", token);

var response = await client.GetAsync(
    "https://localhost:44331/umbraco/ai/management/api/v1/provider");

var providers = await response.Content
    .ReadFromJsonAsync<ProviderItemResponseModel[]>();

foreach (var provider in providers)
{
    Console.WriteLine($"{provider.Name}: {string.Join(", ", provider.Capabilities)}");
}
```

{% endcode %}

### JavaScript

{% code title="Example" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/provider", {
    headers: {
        Authorization: `Bearer ${token}`,
    },
});

const providers = await response.json();
providers.forEach((p) => {
    console.log(`${p.name}: ${p.capabilities.join(", ")}`);
});
```

{% endcode %}

## Notes

- Providers are discovered automatically from installed NuGet packages
- The list is read-only - providers cannot be added via API
- Only active (properly configured) providers are returned
