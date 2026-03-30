---
description: >-
    REST API endpoints for generating text embeddings.
---

# Embeddings API

The Embeddings API provides endpoints for generating vector embeddings from text, useful for semantic search, content similarity, and recommendation systems.

## Overview

Embeddings convert text into numerical vectors that capture semantic meaning. Similar texts produce similar vectors, enabling:

- **Semantic search**: Find content by meaning, beyond keyword matching
- **Content similarity**: Identify related articles or documents
- **Recommendations**: Suggest similar content to users
- **Clustering**: Group similar content together

## Base URL

```
/umbraco/ai/management/api/v1/embedding
```

## Authentication

All endpoints require backoffice authentication with the `Umb.AI.Management.Api` authorization policy.

## Endpoints

| Method | Endpoint              | Description                        |
| ------ | --------------------- | ---------------------------------- |
| POST   | `/embedding/generate` | [Generate embeddings](generate.md) |

## Response Model

### EmbeddingResponseModel

```json
{
  "embeddings": [
    {
      "index": 0,
      "vector": [0.0023, -0.0092, 0.0156, ...]
    },
    {
      "index": 1,
      "vector": [0.0089, -0.0034, 0.0201, ...]
    }
  ]
}
```

| Property              | Type    | Description                        |
| --------------------- | ------- | ---------------------------------- |
| `embeddings`          | array   | List of embedding results          |
| `embeddings[].index`  | int     | Index of the input value (0-based) |
| `embeddings[].vector` | float[] | The embedding vector               |

## Vector Dimensions

The vector size depends on the embedding model configured in your profile:

| Model                  | Dimensions |
| ---------------------- | ---------- |
| text-embedding-3-small | 1536       |
| text-embedding-3-large | 3072       |
| text-embedding-ada-002 | 1536       |

## Working with Embeddings

### Calculating Similarity

Use cosine similarity to compare embedding vectors:

{% code title="Example" %}

```csharp
public static double CosineSimilarity(float[] a, float[] b)
{
    double dotProduct = 0;
    double normA = 0;
    double normB = 0;

    for (int i = 0; i < a.Length; i++)
    {
        dotProduct += a[i] * b[i];
        normA += a[i] * a[i];
        normB += b[i] * b[i];
    }

    return dotProduct / (Math.Sqrt(normA) * Math.Sqrt(normB));
}

// Similarity ranges from -1 to 1 (higher = more similar)
var similarity = CosineSimilarity(embedding1.Vector, embedding2.Vector);
```

{% endcode %}

### Storing Embeddings

For production use, store embeddings in a vector database:

- **pgvector** (PostgreSQL extension)
- **Azure AI Search**
- **Pinecone**
- **Qdrant**

## In This Section

{% content-ref url="generate.md" %}
[Generate Embeddings](generate.md)
{% endcontent-ref %}
