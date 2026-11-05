---
description: >-
    Service for generating text embeddings.
---

# IAIEmbeddingService

Service for generating text embeddings (vector representations). Acts as a thin layer over Microsoft.Extensions.AI, adding Umbraco-specific features like profiles and middleware.

## Namespace

```csharp
using Umbraco.AI.Core.Embeddings;
using Microsoft.Extensions.AI;
```

## Interface

{% code title="IAIEmbeddingService" %}

```csharp
public interface IAIEmbeddingService
{
    Task<Embedding<float>> GenerateEmbeddingAsync(
        Action<AIEmbeddingBuilder> configure,
        string text,
        CancellationToken cancellationToken = default);

    Task<GeneratedEmbeddings<Embedding<float>>> GenerateEmbeddingsAsync(
        Action<AIEmbeddingBuilder> configure,
        IEnumerable<string> texts,
        CancellationToken cancellationToken = default);

    Task<IEmbeddingGenerator<string, Embedding<float>>> CreateEmbeddingGeneratorAsync(
        Action<AIEmbeddingBuilder> configure,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## AIEmbeddingBuilder

All methods accept an `Action<AIEmbeddingBuilder>` to configure the request. The builder provides the following fluent methods:

| Method | Description |
| --- | --- |
| `.WithAlias(string alias)` | **Required.** Sets an alias for auditing and telemetry. |
| `.WithName(string name)` | Sets a display name for telemetry purposes. |
| `.WithDescription(string? description)` | Sets a description for telemetry purposes. |
| `.WithProfile(Guid profileId)` | Selects a profile by ID. Uses default if omitted. |
| `.WithProfile(string profileAlias)` | Selects a profile by alias. |
| `.WithEmbeddingOptions(EmbeddingGenerationOptions options)` | Overrides profile defaults (model, dimensions, etc.). |
| `.WithContextItems(IEnumerable<AIRequestContextItem> contextItems)` | Attaches context items to the request. |
| `.WithGuardrails(params Guid[] guardrailIds)` | Applies guardrails by ID. |
| `.WithGuardrails(params string[] guardrailAliases)` | Applies guardrails by alias. |
| `.WithAdditionalProperties(IReadOnlyDictionary<string, object?> properties)` | Attaches additional properties to the request. |
| `.AsPassThrough()` | Marks the request as pass-through (bypasses some processing). |

{% code title="Builder example" %}

```csharp
var embedding = await _embeddingService.GenerateEmbeddingAsync(
    emb => emb
        .WithAlias("content-search")
        .WithProfile("ada-embedding"),
    "Umbraco is a content management system.",
    cancellationToken);
```

{% endcode %}

## Methods

### GenerateEmbeddingAsync

Generates an embedding for a single text value.

{% code title="Signature" %}

```csharp
Task<Embedding<float>> GenerateEmbeddingAsync(
    Action<AIEmbeddingBuilder> configure,
    string text,
    CancellationToken cancellationToken = default);
```

{% endcode %}

| Parameter           | Type                         | Description                                             |
| ------------------- | ---------------------------- | ------------------------------------------------------- |
| `configure`         | `Action<AIEmbeddingBuilder>` | Builder action to set alias, profile, options, etc.     |
| `text`              | `string`                     | The text to embed                                       |
| `cancellationToken` | `CancellationToken`          | Cancellation token                                      |

**Returns**: `Embedding<float>` containing the vector representation.

{% code title="Example" %}

```csharp
var embedding = await _embeddingService.GenerateEmbeddingAsync(
    emb => emb.WithAlias("content-search"),
    "Umbraco is a content management system.");

// Access the vector
float[] vector = embedding.Vector.ToArray();
Console.WriteLine($"Dimensions: {vector.Length}");
```

{% endcode %}

### GenerateEmbeddingsAsync

Generates embeddings for multiple text values in a batch.

{% code title="Signature" %}

```csharp
Task<GeneratedEmbeddings<Embedding<float>>> GenerateEmbeddingsAsync(
    Action<AIEmbeddingBuilder> configure,
    IEnumerable<string> texts,
    CancellationToken cancellationToken = default);
```

{% endcode %}

| Parameter           | Type                         | Description                                             |
| ------------------- | ---------------------------- | ------------------------------------------------------- |
| `configure`         | `Action<AIEmbeddingBuilder>` | Builder action to set alias, profile, options, etc.     |
| `texts`             | `IEnumerable<string>`        | The texts to embed                                      |
| `cancellationToken` | `CancellationToken`          | Cancellation token                                      |

**Returns**: `GeneratedEmbeddings<Embedding<float>>` containing embeddings for each input.

{% code title="Example" %}

```csharp
var texts = new[]
{
    "First document content",
    "Second document content",
    "Third document content"
};

var embeddings = await _embeddingService.GenerateEmbeddingsAsync(
    emb => emb.WithAlias("batch-index"),
    texts);

Console.WriteLine($"Generated {embeddings.Count} embeddings");
Console.WriteLine($"Total tokens: {embeddings.Usage?.InputTokenCount}");

// Access individual embeddings
for (int i = 0; i < embeddings.Count; i++)
{
    var vector = embeddings[i].Vector;
    Console.WriteLine($"Document {i}: {vector.Length} dimensions");
}
```

{% endcode %}

### CreateEmbeddingGeneratorAsync

Creates a configured `IEmbeddingGenerator` for advanced scenarios.

{% code title="Signature" %}

```csharp
Task<IEmbeddingGenerator<string, Embedding<float>>> CreateEmbeddingGeneratorAsync(
    Action<AIEmbeddingBuilder> configure,
    CancellationToken cancellationToken = default);
```

{% endcode %}

| Parameter           | Type                         | Description                                         |
| ------------------- | ---------------------------- | --------------------------------------------------- |
| `configure`         | `Action<AIEmbeddingBuilder>` | Builder action to set alias, profile, options, etc. |
| `cancellationToken` | `CancellationToken`          | Cancellation token                                  |

**Returns**: Configured `IEmbeddingGenerator` with middleware applied.

{% code title="Example" %}

```csharp
// Create generator for advanced usage
var generator = await _embeddingService.CreateEmbeddingGeneratorAsync(
    emb => emb.WithAlias("advanced-generator"));

// Use M.E.AI methods directly
var embeddings = await generator.GenerateAsync(
    new[] { "text1", "text2" },
    new EmbeddingGenerationOptions { ModelId = "text-embedding-3-large" });
```

{% endcode %}

## Use Cases

### Semantic Search

{% code title="Semantic Search" %}

```csharp
public async Task<List<Document>> SearchAsync(string query, IEnumerable<Document> documents)
{
    // Generate query embedding
    var queryEmbedding = await _embeddingService.GenerateEmbeddingAsync(
        emb => emb.WithAlias("semantic-search"),
        query);

    // Compare with document embeddings (pre-computed and stored)
    var results = documents
        .Select(doc => new
        {
            Document = doc,
            Similarity = CosineSimilarity(queryEmbedding.Vector, doc.Embedding)
        })
        .OrderByDescending(x => x.Similarity)
        .Take(10)
        .Select(x => x.Document)
        .ToList();

    return results;
}

private static float CosineSimilarity(ReadOnlyMemory<float> a, float[] b)
{
    var aSpan = a.Span;
    float dot = 0, normA = 0, normB = 0;

    for (int i = 0; i < aSpan.Length; i++)
    {
        dot += aSpan[i] * b[i];
        normA += aSpan[i] * aSpan[i];
        normB += b[i] * b[i];
    }

    return dot / (MathF.Sqrt(normA) * MathF.Sqrt(normB));
}
```

{% endcode %}

## Related Types

- `Embedding<T>` - Single embedding vector (M.E.AI)
- `GeneratedEmbeddings<T>` - Collection of embeddings with usage (M.E.AI)
- `EmbeddingGenerationOptions` - Generation options (M.E.AI)
