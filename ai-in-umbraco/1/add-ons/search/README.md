---
description: >-
    Semantic vector search add-on for finding content by meaning.
---

# Semantic Search

The Semantic Search add-on (`Umbraco.AI.Search`) adds AI-powered vector search to Umbraco. Content is indexed as vector embeddings, and similarity search is available through the CMS Search API and an AI agent tool.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Search
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Search
```

{% endcode %}

{% hint style="info" %}
Requires `Umbraco.AI` with an embedding-capable provider such as `Umbraco.AI.OpenAI`.
{% endhint %}

## How it works

1. When content is published, the indexer extracts text from all fields.
2. Text is split into chunks and converted to vector embeddings.
3. Embeddings are stored in the database alongside the content.
4. Searches embed the query and find content with similar vectors.

The index appears alongside other Umbraco indexes as `UmbAI_Search` and supports both content and media.

## Features

- **Semantic search** - Find content by meaning, not keywords
- **Culture-aware** - Separate embeddings per language variant
- **CMS Search integration** - Works with the standard Search API
- **Agent tool** - `semantic_search` tool for AI agent chat
- **SQL Server 2025 support** - Native `VECTOR_DISTANCE()` when available, brute-force fallback on older versions
- **SQLite support** - In-memory similarity for local development
- **Custom vector store** - Replace `IAIVectorStore` to use external providers

## Configuration

Add options under `Umbraco:AI:Search` in `appsettings.json`:

{% code title="appsettings.json" %}

```json
{
  "Umbraco": {
    "AI": {
      "Search": {
        "ChunkSize": 512,
        "ChunkOverlap": 50,
        "DefaultTopK": 100
      }
    }
  }
}
```

{% endcode %}

| Option | Default | Description |
| --- | --- | --- |
| `ChunkSize` | `512` | Maximum tokens per text chunk |
| `ChunkOverlap` | `50` | Token overlap between consecutive chunks |
| `DefaultTopK` | `100` | Maximum candidates from vector search before deduplication |

### Separate database

To store vectors in a separate database, add an `umbracoAiDbDSN` connection string:

{% code title="appsettings.json" %}

```json
{
  "ConnectionStrings": {
    "umbracoAiDbDSN": "Server=ai-db;Database=UmbracoAI;...",
    "umbracoAiDbDSN_ProviderName": "Microsoft.Data.SqlClient"
  }
}
```

{% endcode %}

If omitted, the default `umbracoDbDSN` connection is used.

## Documentation

| Section | Description |
| --- | --- |
| [Concepts](concepts.md) | How indexing and search work |
| [Custom vector store](custom-vector-store.md) | Replace the built-in store |

## Related

- [Add-ons Overview](../README.md) - All add-on packages
- [Embeddings](../../using-the-api/embeddings/README.md) - Embedding API
- [Providers](../../providers/README.md) - AI provider configuration
