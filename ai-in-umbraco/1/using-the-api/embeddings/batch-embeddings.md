---
description: >-
    Generate embeddings for multiple texts in a single request for efficiency.
---

# Batch Embeddings

When embedding multiple texts, use batch operations for better performance. A single batch request is more efficient than multiple individual requests.

## Basic Batch Example

{% code title="BatchEmbedding.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Embeddings;

public class BatchEmbeddingExample
{
    private readonly IAIEmbeddingService _embeddingService;

    public BatchEmbeddingExample(IAIEmbeddingService embeddingService)
    {
        _embeddingService = embeddingService;
    }

    public async Task<IList<float[]>> GenerateEmbeddings(IEnumerable<string> texts)
    {
        var embeddings = await _embeddingService.GenerateEmbeddingsAsync(texts);

        return embeddings.Select(e => e.Vector.ToArray()).ToList();
    }
}
```

{% endcode %}

## Understanding the Response

`GenerateEmbeddingsAsync` returns `GeneratedEmbeddings<Embedding<float>>`:

| Property     | Type                      | Description                       |
| ------------ | ------------------------- | --------------------------------- |
| (collection) | `IList<Embedding<float>>` | The generated embeddings in order |
| `Usage`      | `UsageDetails?`           | Token usage for the batch         |

{% code title="BatchDetails.cs" %}

```csharp
var texts = new[] { "First document", "Second document", "Third document" };

var embeddings = await _embeddingService.GenerateEmbeddingsAsync(texts);

// Embeddings are in the same order as input
for (int i = 0; i < texts.Length; i++)
{
    var text = texts[i];
    var embedding = embeddings[i];

    Console.WriteLine($"Text: {text}");
    Console.WriteLine($"Dimensions: {embedding.Vector.Length}");
}

// Check usage
if (embeddings.Usage is { } usage)
{
    Console.WriteLine($"Total tokens: {usage.TotalTokenCount}");
}
```

{% endcode %}

## Batch Indexing

Index multiple content items efficiently:

{% code title="BatchIndexer.cs" %}

```csharp
public class BatchContentIndexer
{
    private readonly IAIEmbeddingService _embeddingService;
    private readonly IVectorStore _vectorStore;

    public BatchContentIndexer(
        IAIEmbeddingService embeddingService,
        IVectorStore vectorStore)
    {
        _embeddingService = embeddingService;
        _vectorStore = vectorStore;
    }

    public async Task IndexContentBatch(IEnumerable<IContent> contents)
    {
        var contentList = contents.ToList();

        // Prepare texts for embedding
        var texts = contentList.Select(c =>
            $"{c.Name} {c.GetValue<string>("bodyText")}").ToList();

        // Generate all embeddings in one request
        var embeddings = await _embeddingService.GenerateEmbeddingsAsync(texts);

        // Store each embedding with its content
        var documents = contentList.Zip(embeddings, (content, embedding) =>
            new VectorDocument
            {
                Id = content.Key.ToString(),
                Vector = embedding.Vector.ToArray(),
                Metadata = new Dictionary<string, object>
                {
                    ["contentType"] = content.ContentType.Alias,
                    ["name"] = content.Name
                }
            });

        await _vectorStore.UpsertBatchAsync(documents);
    }
}
```

{% endcode %}

## Chunking Large Batches

Most providers have limits on batch size. Process large sets in chunks:

{% code title="ChunkedBatch.cs" %}

```csharp
public class ChunkedEmbeddingService
{
    private readonly IAIEmbeddingService _embeddingService;
    private const int BatchSize = 100;

    public ChunkedEmbeddingService(IAIEmbeddingService embeddingService)
    {
        _embeddingService = embeddingService;
    }

    public async Task<IList<Embedding<float>>> GenerateEmbeddingsChunked(
        IEnumerable<string> texts,
        CancellationToken cancellationToken = default)
    {
        var textList = texts.ToList();
        var allEmbeddings = new List<Embedding<float>>();

        // Process in chunks
        for (int i = 0; i < textList.Count; i += BatchSize)
        {
            var chunk = textList.Skip(i).Take(BatchSize);

            var embeddings = await _embeddingService.GenerateEmbeddingsAsync(
                chunk,
                cancellationToken: cancellationToken);

            allEmbeddings.AddRange(embeddings);
        }

        return allEmbeddings;
    }
}
```

{% endcode %}

## Using a Specific Profile

{% code title="BatchWithProfile.cs" %}

```csharp
public async Task<IList<float[]>> GenerateBatchWithProfile(
    IEnumerable<string> texts,
    Guid profileId)
{
    var embeddings = await _embeddingService.GenerateEmbeddingsAsync(
        profileId,
        texts);

    return embeddings.Select(e => e.Vector.ToArray()).ToList();
}
```

{% endcode %}

## Related

- [Generating Embeddings](generating-embeddings.md) - Single embedding generation
- [Embeddings Concept](../../concepts/capabilities.md) - Understanding capabilities
