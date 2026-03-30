---
description: >-
    Generate vector embeddings for individual text values.
---

# Generating Embeddings

Generate a single embedding vector for a piece of text. This is the most common operation for search indexing and similarity comparisons.

## Basic Example

{% code title="BasicEmbedding.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Embeddings;

public class EmbeddingExample
{
    private readonly IAIEmbeddingService _embeddingService;

    public EmbeddingExample(IAIEmbeddingService embeddingService)
    {
        _embeddingService = embeddingService;
    }

    public async Task<float[]> GenerateEmbedding(string text)
    {
        var embedding = await _embeddingService.GenerateEmbeddingAsync(text);

        // The vector is a ReadOnlyMemory<float>
        return embedding.Vector.ToArray();
    }
}
```

{% endcode %}

## Understanding the Response

The `Embedding<float>` type contains:

| Property    | Type                    | Description                            |
| ----------- | ----------------------- | -------------------------------------- |
| `Vector`    | `ReadOnlyMemory<float>` | The embedding vector                   |
| `ModelId`   | `string?`               | The model that generated the embedding |
| `CreatedAt` | `DateTimeOffset?`       | When the embedding was generated       |

{% code title="EmbeddingDetails.cs" %}

```csharp
var embedding = await _embeddingService.GenerateEmbeddingAsync(text);

// Access the vector
ReadOnlyMemory<float> vector = embedding.Vector;
int dimensions = vector.Length; // e.g., 1536 for text-embedding-3-small

// Convert to array if needed
float[] array = vector.ToArray();

// Check which model was used
string? model = embedding.ModelId;
```

{% endcode %}

## Using a Specific Profile

{% code title="WithProfile.cs" %}

```csharp
public class ProfiledEmbeddingService
{
    private readonly IAIEmbeddingService _embeddingService;
    private readonly IAIProfileService _profileService;

    public ProfiledEmbeddingService(
        IAIEmbeddingService embeddingService,
        IAIProfileService profileService)
    {
        _embeddingService = embeddingService;
        _profileService = profileService;
    }

    public async Task<float[]> GenerateWithProfile(string text, string profileAlias)
    {
        var profile = await _profileService.GetProfileByAliasAsync(profileAlias);
        if (profile is null)
        {
            throw new InvalidOperationException($"Profile '{profileAlias}' not found");
        }

        var embedding = await _embeddingService.GenerateEmbeddingAsync(profile.Id, text);
        return embedding.Vector.ToArray();
    }
}
```

{% endcode %}

## Indexing Content

A common pattern for search indexing:

{% code title="ContentIndexer.cs" %}

```csharp
public class ContentIndexer
{
    private readonly IAIEmbeddingService _embeddingService;
    private readonly IVectorStore _vectorStore;

    public ContentIndexer(
        IAIEmbeddingService embeddingService,
        IVectorStore vectorStore)
    {
        _embeddingService = embeddingService;
        _vectorStore = vectorStore;
    }

    public async Task IndexContent(IContent content)
    {
        // Combine relevant text fields
        var textToEmbed = $"{content.Name} {content.GetValue<string>("bodyText")}";

        // Generate embedding
        var embedding = await _embeddingService.GenerateEmbeddingAsync(textToEmbed);

        // Store in vector database
        await _vectorStore.UpsertAsync(new VectorDocument
        {
            Id = content.Key.ToString(),
            Vector = embedding.Vector.ToArray(),
            Metadata = new Dictionary<string, object>
            {
                ["contentType"] = content.ContentType.Alias,
                ["name"] = content.Name
            }
        });
    }
}
```

{% endcode %}

## Computing Similarity

Compare two embeddings using cosine similarity:

{% code title="Similarity.cs" %}

```csharp
public class SimilarityService
{
    private readonly IAIEmbeddingService _embeddingService;

    public SimilarityService(IAIEmbeddingService embeddingService)
    {
        _embeddingService = embeddingService;
    }

    public async Task<double> ComputeSimilarity(string text1, string text2)
    {
        var embedding1 = await _embeddingService.GenerateEmbeddingAsync(text1);
        var embedding2 = await _embeddingService.GenerateEmbeddingAsync(text2);

        return CosineSimilarity(embedding1.Vector.Span, embedding2.Vector.Span);
    }

    private static double CosineSimilarity(ReadOnlySpan<float> a, ReadOnlySpan<float> b)
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
}
```

{% endcode %}

{% hint style="info" %}
Cosine similarity returns a value between -1 and 1, where 1 means identical, 0 means unrelated, and -1 means opposite.
{% endhint %}

## Error Handling

{% code title="ErrorHandling.cs" %}

```csharp
public async Task<float[]?> SafeGenerateEmbedding(string text)
{
    try
    {
        var embedding = await _embeddingService.GenerateEmbeddingAsync(text);
        return embedding.Vector.ToArray();
    }
    catch (InvalidOperationException ex) when (ex.Message.Contains("profile"))
    {
        _logger.LogError(ex, "Embedding profile not configured");
        return null;
    }
    catch (HttpRequestException ex)
    {
        _logger.LogError(ex, "Failed to reach embedding service");
        return null;
    }
}
```

{% endcode %}

## Best Practices

1. **Normalize input text** - Remove excessive whitespace, consider lowercasing
2. **Chunk long content** - Most models have token limits; split long documents
3. **Cache embeddings** - Store generated embeddings to avoid regenerating
4. **Use consistent profiles** - Query embeddings should use the same model as indexed embeddings

## Next Steps

{% content-ref url="batch-embeddings.md" %}
[Batch Embeddings](batch-embeddings.md)
{% endcontent-ref %}
