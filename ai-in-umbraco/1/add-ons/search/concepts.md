---
description: >-
    How semantic vector search indexes and retrieves content.
---

# Concepts

## Vector Embeddings

A vector embedding is a list of numbers that represents the meaning of a piece of text. Texts about similar topics produce similar vectors. By comparing vectors, you can find content that is related by meaning rather than matching keywords.

Umbraco.AI.Search uses the configured embedding profile to generate vectors. Any provider that supports the embedding capability works, including OpenAI, Google, and Amazon Bedrock.

## Indexing Pipeline

The search add-on registers an index called `UmbAI_Search` with the CMS Search framework. The index receives the same content change notifications as other indexes such as Examine.

When content is published:

1. **Text extraction** - The CMS Search property value handlers extract text from all fields, including nested block content.
2. **HTML stripping** - Tags and entities are removed, whitespace is normalized.
3. **Chunking** - Long text is split into smaller chunks that fit within the embedding model's token limit.
4. **Embedding** - Each chunk is sent to the embedding provider to generate a vector.
5. **Storage** - Vectors are stored in the database with the document ID, culture, and chunk index.

### Culture-Aware Indexing

For multilingual content, the indexer generates separate embeddings per culture. Each language variant has its own set of chunks and vectors. Searches can filter by culture to return results in a specific language.

### Text Chunking

The recursive text chunker splits content by trying paragraph boundaries first, then sentences, then words. This preserves semantic coherence within each chunk.

Overlap between chunks ensures that concepts spanning a boundary are captured in both chunks. Configure chunk size and overlap in `appsettings.json` under `Umbraco:AI:Search`.

## Search

Searches work by embedding the query text and finding stored vectors with the highest cosine similarity. Multiple chunks from the same document are deduplicated, keeping the best score.

### CMS Search API

The index is available through the standard CMS Search API. Send a POST request to the search endpoint with the `UmbAI_Search` index alias:

{% code title="Search API request" %}

```json
{
  "indexAlias": "UmbAI_Search",
  "query": "sustainability initiatives",
  "culture": "en-US"
}
```

{% endcode %}

### Agent Tool

When the Agent add-on is installed, the `semantic_search` tool is available in chat. It supports two modes:

- **Text query** - Find content about a topic.
- **Document ID** - Find content similar to an existing page.

The document mode retrieves stored embeddings directly, so there is no extra embedding call.

## Access Control

### CMS Search API

Protected content (pages with member login restrictions) is filtered based on the `AccessContext` passed in the search request. Public content is always returned. Protected content is only returned when the caller's principal or group IDs match the allowed access IDs stored during indexing.

### Agent Tool

The agent tool runs in the backoffice and respects the current user's start node restrictions. Users with restricted content or media start nodes only see results under their allowed tree branches. If content cannot be resolved to verify the path, the result is excluded when restrictions are in place.

## Database Providers

### SQL Server

On SQL Server 2025 and Azure SQL, the store uses `VECTOR_DISTANCE()` for server-side similarity search. On older versions, vectors are loaded into memory and compared using cosine similarity in .NET.

The column type is `varbinary(max)` for compatibility across all SQL Server versions. SQL Server 2025 casts to the native `vector` type at query time.

### SQLite

SQLite uses in-memory cosine similarity. This is suitable for local development and testing but not recommended for production workloads.

## Custom Vector Store

You can replace the built-in store by implementing `IAIVectorStore` and registering it in a Composer. See [Custom vector store](custom-vector-store.md) for details.
