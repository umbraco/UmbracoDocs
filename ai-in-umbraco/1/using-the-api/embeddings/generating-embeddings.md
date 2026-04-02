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

## Next Steps

{% content-ref url="batch-embeddings.md" %}
[Batch Embeddings](batch-embeddings.md)
{% endcontent-ref %}
