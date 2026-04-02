---
description: >-
    Generate vector embeddings from text values.
---

# Generate Embeddings

Generates vector embeddings for one or more text values.

## Request

```http
POST /umbraco/ai/management/api/v1/embedding/generate
```

### Headers

| Header          | Value                  |
| --------------- | ---------------------- |
| `Authorization` | Bearer token or cookie |
| `Content-Type`  | `application/json`     |

### Request Body

{% code title="Request" %}

```json
{
    "profileIdOrAlias": "document-embeddings",
    "values": ["Umbraco is an open-source CMS", "Content management made easy"]
}
```

{% endcode %}

### Request Properties

| Property           | Type        | Required | Description                                   |
| ------------------ | ----------- | -------- | --------------------------------------------- |
| `profileIdOrAlias` | string/guid | No       | Profile ID or alias (uses default if omitted) |
| `values`           | string[]    | Yes      | Text values to embed (min 1)                  |

## Response

### Success (200 OK)

Returns embeddings for each input value.

{% code title="Response" %}

```json
{
  "embeddings": [
    {
      "index": 0,
      "vector": [0.0023, -0.0092, 0.0156, 0.0089, ...]
    },
    {
      "index": 1,
      "vector": [0.0089, -0.0034, 0.0201, 0.0145, ...]
    }
  ]
}
```

{% endcode %}

### Response Properties

| Property              | Type    | Description                        |
| --------------------- | ------- | ---------------------------------- |
| `embeddings`          | array   | List of embedding results          |
| `embeddings[].index`  | int     | Index of corresponding input value |
| `embeddings[].vector` | float[] | Embedding vector                   |

### Bad Request (400)

Returned when the request is invalid or embedding generation fails.

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Embedding generation failed",
    "detail": "No default embedding profile configured",
    "status": 400
}
```

{% endcode %}

### Not Found (404)

Returned when the specified profile doesn't exist.

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404
}
```

{% endcode %}

## Example

### cURL

```bash
curl -X POST "https://localhost:44331/umbraco/ai/management/api/v1/embedding/generate" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{
    "profileIdOrAlias": "document-embeddings",
    "values": ["Umbraco CMS", "Content management"]
  }'
```

### C# HttpClient

{% code title="Example" %}

```csharp
using var client = new HttpClient();
client.DefaultRequestHeaders.Authorization =
    new AuthenticationHeaderValue("Bearer", token);

var request = new
{
    profileIdOrAlias = "document-embeddings",
    values = new[] { "Umbraco CMS", "Content management" }
};

var response = await client.PostAsJsonAsync(
    "https://localhost:44331/umbraco/ai/management/api/v1/embedding/generate",
    request);

var result = await response.Content.ReadFromJsonAsync<EmbeddingResponseModel>();

foreach (var embedding in result.Embeddings)
{
    Console.WriteLine($"Input {embedding.Index}: {embedding.Vector.Length} dimensions");
}
```

{% endcode %}

### JavaScript

{% code title="Example" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/embedding/generate", {
    method: "POST",
    headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
    },
    body: JSON.stringify({
        profileIdOrAlias: "document-embeddings",
        values: ["Umbraco CMS", "Content management"],
    }),
});

const result = await response.json();
result.embeddings.forEach((e) => {
    console.log(`Input ${e.index}: ${e.vector.length} dimensions`);
});
```

{% endcode %}

## Use Cases

### Semantic Search Index

Generate embeddings for content to enable semantic search:

{% code title="Example" %}

```csharp
public async Task IndexContentAsync(IContent content)
{
    var text = $"{content.Name} {content.GetValue<string>("bodyText")}";

    var response = await _httpClient.PostAsJsonAsync(
        "/umbraco/ai/management/api/v1/embedding/generate",
        new { values = new[] { text } });

    var result = await response.Content.ReadFromJsonAsync<EmbeddingResponseModel>();
    var embedding = result.Embeddings[0].Vector;

    // Store in vector database
    await _vectorStore.UpsertAsync(content.Key, embedding, new
    {
        contentId = content.Id,
        name = content.Name,
        url = content.GetUrl()
    });
}
```

{% endcode %}

### Content Similarity

Find similar content by comparing embeddings:

{% code title="Example" %}

```csharp
public async Task<IEnumerable<IContent>> FindSimilarContentAsync(
    string text,
    int count = 5)
{
    // Generate embedding for search text
    var response = await _httpClient.PostAsJsonAsync(
        "/umbraco/ai/management/api/v1/embedding/generate",
        new { values = new[] { text } });

    var result = await response.Content.ReadFromJsonAsync<EmbeddingResponseModel>();
    var queryVector = result.Embeddings[0].Vector;

    // Query vector database for similar content
    var similar = await _vectorStore.SearchAsync(queryVector, count);

    // Load Umbraco content
    return similar
        .Select(s => _contentService.GetById(s.ContentId))
        .Where(c => c != null);
}
```

{% endcode %}

### Batch Processing

Process content in batches for efficiency:

{% code title="Example" %}

```csharp
public async Task IndexAllContentAsync(IEnumerable<IContent> contents)
{
    const int batchSize = 100;

    foreach (var batch in contents.Chunk(batchSize))
    {
        var texts = batch.Select(c =>
            $"{c.Name} {c.GetValue<string>("bodyText")}").ToList();

        var response = await _httpClient.PostAsJsonAsync(
            "/umbraco/ai/management/api/v1/embedding/generate",
            new { values = texts });

        var result = await response.Content.ReadFromJsonAsync<EmbeddingResponseModel>();

        for (int i = 0; i < result.Embeddings.Count; i++)
        {
            var content = batch.ElementAt(i);
            var vector = result.Embeddings[i].Vector;
            await _vectorStore.UpsertAsync(content.Key, vector);
        }
    }
}
```

{% endcode %}

## Notes

- Embedding order matches input order (use `index` to correlate)
- Vector dimensions depend on the model configured in the profile
- Processing multiple values in one request is more efficient than individual calls
- Store embeddings in a vector database for production semantic search
