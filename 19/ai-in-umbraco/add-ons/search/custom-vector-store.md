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
using Umbraco.AI.Search.Startup;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

[ComposeAfter(typeof(UmbracoAISearchComposer))]
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
The built-in SQL Server and SQLite stores are registered as singleton services by `UmbracoAISearchComposer`. Using `[ComposeAfter(typeof(UmbracoAISearchComposer))]` on your composer guarantees your registration runs last so it becomes the resolved implementation of `IAIVectorStore`.
{% endhint %}

### In-memory store for testing

An `InMemoryAIVectorStore` is available in `Umbraco.AI.Search.Core.VectorStore`. It is intended for development and automated testing and is not suitable for production use.

## Parameters

### Culture

The `culture` parameter supports multilingual content. Pass `null` when indexing invariant content.

Search-time culture filtering follows the CMS Search conventions used by the built-in stores:

- When `culture` is a specific value, return entries for that culture **plus** invariant (`null`) entries.
- When `culture` is `null`, return **only** invariant (`null`) entries.

A `null` culture does not mean "all cultures". Custom implementations should mirror this behaviour so results remain consistent across vector stores.

### Metadata

The indexer stores metadata with each chunk:

| Key | Type | Description |
| --- | --- | --- |
| `objectType` | `string` | Umbraco object type, for example `Document` or `Media` |
| `chunkIndex` | `int` | Zero-based position of the chunk within the document |
| `totalChunks` | `int` | Total number of chunks for the document |
| `accessIds` | `string` | Comma-separated access IDs for protected content. Only present when the document has `ContentProtection.AccessIds`. Used by the searcher to filter results for public members and group membership. |

{% hint style="warning" %}
Custom stores must persist and return the `accessIds` metadata value unchanged. The searcher uses it to enforce member access control: public content (no `accessIds`) is always returned; protected content is only returned when the caller's principal or group IDs match.
{% endhint %}

## Related

- [Concepts](concepts.md) - How indexing and search work
- [Semantic Search](README.md) - Add-on overview
