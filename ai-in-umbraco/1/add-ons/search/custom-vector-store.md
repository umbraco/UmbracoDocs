---
description: >-
    Replace the built-in vector store with a custom implementation.
---

# Custom vector store

The `IAIVectorStore` interface defines vector storage and retrieval. Implement this interface to use an external vector database such as Qdrant, Pinecone, or Azure AI Search.

## Interface

{% code title="IAIVectorStore.cs" %}

```csharp
public interface IAIVectorStore
{
    Task UpsertAsync(string indexName, string documentId, string? culture,
        int chunkIndex, ReadOnlyMemory<float> vector,
        IDictionary<string, object>? metadata = null,
        CancellationToken cancellationToken = default);

    Task DeleteAsync(string indexName, string documentId, string? culture,
        CancellationToken cancellationToken = default);

    Task DeleteDocumentAsync(string indexName, string documentId,
        CancellationToken cancellationToken = default);

    Task<IReadOnlyList<AIVectorSearchResult>> SearchAsync(string indexName,
        ReadOnlyMemory<float> queryVector, string? culture = null,
        int topK = 10, CancellationToken cancellationToken = default);

    Task<IReadOnlyList<AIVectorEntry>> GetVectorsByDocumentAsync(
        string indexName, string documentId, string? culture = null,
        CancellationToken cancellationToken = default);

    Task ResetAsync(string indexName,
        CancellationToken cancellationToken = default);

    Task<long> GetDocumentCountAsync(string indexName,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Key methods

| Method | Purpose |
| --- | --- |
| `UpsertAsync` | Insert or update a single chunk vector |
| `DeleteAsync` | Remove all chunks for a document and culture |
| `DeleteDocumentAsync` | Remove all chunks for a document across all cultures |
| `SearchAsync` | Find similar vectors by cosine similarity |
| `GetVectorsByDocumentAsync` | Retrieve stored vectors for a document |
| `ResetAsync` | Clear all entries for an index |
| `GetDocumentCountAsync` | Return the number of stored entries |

## Registration

Register your implementation in a Composer to replace the built-in store:

{% code title="CustomVectorStoreComposer.cs" %}

```csharp
using Umbraco.AI.Search.Core.VectorStore;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

public class CustomVectorStoreComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddSingleton<IAIVectorStore, QdrantVectorStore>();
    }
}
```

{% endcode %}

{% hint style="info" %}
The built-in SQL Server and SQLite stores are registered as transient services. Your replacement registration takes precedence as the last-registered implementation.
{% endhint %}

## Parameters

### Culture

The `culture` parameter supports multilingual content. Pass `null` for invariant content. When searching, pass a culture to filter results to that language, or `null` to search across all cultures.

### Metadata

The indexer stores metadata with each chunk:

| Key | Type | Description |
| --- | --- | --- |
| `objectType` | `string` | Umbraco object type, for example `Document` or `Media` |
| `chunkIndex` | `int` | Zero-based position of the chunk within the document |
| `totalChunks` | `int` | Total number of chunks for the document |

## Related

- [Concepts](concepts.md) - How indexing and search work
- [Semantic Search](README.md) - Add-on overview
