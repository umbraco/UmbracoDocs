---
description: >-
    Generate vector embeddings for semantic search, similarity matching, and RAG applications.
---

# Embeddings

The embeddings API generates vector representations of text. Use embeddings for semantic search, document similarity, clustering, and Retrieval-Augmented Generation (RAG).

## What Are Embeddings

Embeddings convert text into numerical vectors that capture semantic meaning. Similar texts produce similar vectors, enabling:

- **Semantic search** - Find content by meaning, beyond keyword matching
- **Document similarity** - Compare how related two pieces of content are
- **Clustering** - Group similar content together
- **RAG** - Retrieve relevant context for AI responses

## IAIEmbeddingService

The primary interface for embedding operations:

{% code title="IAIEmbeddingService.cs" %}

```csharp
public interface IAIEmbeddingService
{
    // Single embedding
    Task<Embedding<float>> GenerateEmbeddingAsync(
        string value,
        EmbeddingGenerationOptions? options = null,
        CancellationToken cancellationToken = default);

    Task<Embedding<float>> GenerateEmbeddingAsync(
        Guid profileId,
        string value,
        EmbeddingGenerationOptions? options = null,
        CancellationToken cancellationToken = default);

    // Multiple embeddings
    Task<GeneratedEmbeddings<Embedding<float>>> GenerateEmbeddingsAsync(
        IEnumerable<string> values,
        EmbeddingGenerationOptions? options = null,
        CancellationToken cancellationToken = default);

    Task<GeneratedEmbeddings<Embedding<float>>> GenerateEmbeddingsAsync(
        Guid profileId,
        IEnumerable<string> values,
        EmbeddingGenerationOptions? options = null,
        CancellationToken cancellationToken = default);

    // Advanced: Get the underlying generator
    Task<IEmbeddingGenerator<string, Embedding<float>>> GetEmbeddingGeneratorAsync(
        Guid? profileId = null,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Basic Usage

{% code title="SearchService.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Embeddings;

public class SearchService
{
    private readonly IAIEmbeddingService _embeddingService;

    public SearchService(IAIEmbeddingService embeddingService)
    {
        _embeddingService = embeddingService;
    }

    public async Task<float[]> GetEmbedding(string text)
    {
        var embedding = await _embeddingService.GenerateEmbeddingAsync(text);
        return embedding.Vector.ToArray();
    }
}
```

{% endcode %}

## Choosing a Profile

### Default Profile

Once you have [configured a default embedding profile](../../backoffice/managing-settings.md) in the backoffice, you can call without specifying a profile:

```csharp
var embedding = await _embeddingService.GenerateEmbeddingAsync(text);
```

### Specific Profile

Pass the profile ID:

```csharp
var embedding = await _embeddingService.GenerateEmbeddingAsync(profileId, text);
```

## Common Use Cases

### Semantic Search

1. Generate embeddings for all searchable content
2. Store embeddings in a vector database
3. When searching, embed the query and find nearest neighbors

### Content Similarity

Compare two pieces of content:

```csharp
var embedding1 = await _embeddingService.GenerateEmbeddingAsync(content1);
var embedding2 = await _embeddingService.GenerateEmbeddingAsync(content2);

var similarity = CosineSimilarity(embedding1.Vector, embedding2.Vector);
```

### RAG (Retrieval-Augmented Generation)

1. Embed user question
2. Find relevant content via vector search
3. Include retrieved content in chat prompt

## In This Section

{% content-ref url="generating-embeddings.md" %}
[Generating Embeddings](generating-embeddings.md)
{% endcontent-ref %}

{% content-ref url="batch-embeddings.md" %}
[Batch Embeddings](batch-embeddings.md)
{% endcontent-ref %}
