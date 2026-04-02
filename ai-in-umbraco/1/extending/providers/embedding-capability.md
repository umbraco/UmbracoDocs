---
description: >-
    Implement the embedding capability for your custom provider.
---

# Embedding Capability

The embedding capability enables vector embedding generation. Implement it by extending `AIEmbeddingCapabilityBase<TSettings>`.

## Base Class

{% code title="AIEmbeddingCapabilityBase<TSettings>" %}

```csharp
public abstract class AIEmbeddingCapabilityBase<TSettings> : IAIEmbeddingCapability
    where TSettings : class
{
    // Implement this: Create an IEmbeddingGenerator
    protected abstract IEmbeddingGenerator<string, Embedding<float>> CreateGenerator(
        TSettings settings,
        string? modelId);

    // Implement this: Return available models
    protected abstract Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        TSettings settings,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Basic Implementation

{% code title="MyEmbeddingCapability.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Models;
using Umbraco.AI.Core.Providers;

public class MyEmbeddingCapability : AIEmbeddingCapabilityBase<MyProviderSettings>
{
    public MyEmbeddingCapability(IAIProvider provider) : base(provider) { }

    protected override IEmbeddingGenerator<string, Embedding<float>> CreateGenerator(
        MyProviderSettings settings,
        string? modelId)
    {
        return new MyEmbeddingGenerator(settings, modelId ?? "embedding-model");
    }

    protected override Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        MyProviderSettings settings,
        CancellationToken cancellationToken = default)
    {
        var models = new List<AIModelDescriptor>
        {
            new("embedding-small", "Embedding Small (1536 dims)"),
            new("embedding-large", "Embedding Large (3072 dims)")
        };
        return Task.FromResult<IReadOnlyList<AIModelDescriptor>>(models);
    }
}
```

{% endcode %}

## Register in Provider

Add the embedding capability in your provider constructor:

{% code title="MyProvider.cs" %}

```csharp
[AIProvider("myprovider", "My AI Provider")]
public class MyProvider : AIProviderBase<MyProviderSettings>
{
    public MyProvider(IAIProviderInfrastructure infrastructure)
        : base(infrastructure)
    {
        WithCapability<MyChatCapability>();
        WithCapability<MyEmbeddingCapability>();  // Add embedding support
    }
}
```

{% endcode %}

## Implementing IEmbeddingGenerator

The `IEmbeddingGenerator<TInput, TEmbedding>` interface:

{% code title="IEmbeddingGenerator Interface" %}

```csharp
public interface IEmbeddingGenerator<TInput, TEmbedding> : IDisposable
{
    EmbeddingGeneratorMetadata Metadata { get; }

    Task<GeneratedEmbeddings<TEmbedding>> GenerateAsync(
        IEnumerable<TInput> values,
        EmbeddingGenerationOptions? options = null,
        CancellationToken cancellationToken = default);

    object? GetService(Type serviceType, object? serviceKey = null);
}
```

{% endcode %}

## Complete IEmbeddingGenerator Example

{% code title="MyEmbeddingGenerator.cs" %}

```csharp
using System.Text.Json;
using Microsoft.Extensions.AI;

public class MyEmbeddingGenerator : IEmbeddingGenerator<string, Embedding<float>>
{
    private readonly HttpClient _httpClient;
    private readonly string _modelId;

    public MyEmbeddingGenerator(MyProviderSettings settings, string modelId)
    {
        _modelId = modelId;
        _httpClient = new HttpClient
        {
            BaseAddress = new Uri(settings.BaseUrl ?? "https://api.myprovider.com")
        };
        _httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {settings.ApiKey}");
    }

    public EmbeddingGeneratorMetadata Metadata => new(
        providerName: "MyProvider",
        providerUri: new Uri("https://myprovider.com"),
        modelId: _modelId);

    public async Task<GeneratedEmbeddings<Embedding<float>>> GenerateAsync(
        IEnumerable<string> values,
        EmbeddingGenerationOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        var inputList = values.ToList();

        var request = new
        {
            model = _modelId,
            input = inputList
        };

        var response = await _httpClient.PostAsJsonAsync(
            "/v1/embeddings",
            request,
            cancellationToken);

        response.EnsureSuccessStatusCode();

        var result = await response.Content.ReadFromJsonAsync<EmbeddingResponse>(
            cancellationToken: cancellationToken);

        var embeddings = result!.Data
            .OrderBy(d => d.Index)
            .Select(d => new Embedding<float>(d.Embedding)
            {
                ModelId = result.Model,
                CreatedAt = DateTimeOffset.UtcNow
            })
            .ToList();

        return new GeneratedEmbeddings<Embedding<float>>(embeddings)
        {
            Usage = new UsageDetails
            {
                InputTokenCount = result.Usage?.PromptTokens,
                TotalTokenCount = result.Usage?.TotalTokens
            }
        };
    }

    public object? GetService(Type serviceType, object? serviceKey = null) => null;

    public void Dispose() => _httpClient.Dispose();
}

// API response models
internal class EmbeddingResponse
{
    public string Model { get; set; } = "";
    public List<EmbeddingData> Data { get; set; } = new();
    public EmbeddingUsage? Usage { get; set; }
}

internal class EmbeddingData
{
    public int Index { get; set; }
    public float[] Embedding { get; set; } = Array.Empty<float>();
}

internal class EmbeddingUsage
{
    public int PromptTokens { get; set; }
    public int TotalTokens { get; set; }
}
```

{% endcode %}

## Using Existing M.E.AI Generators

If your service has an existing Microsoft.Extensions.AI (M.E.AI) embedding generator:

{% code title="Using Existing Generator" %}

```csharp
using Microsoft.Extensions.AI;
using OpenAI;

public class MyOpenAICompatibleEmbeddingCapability : AIEmbeddingCapabilityBase<MyProviderSettings>
{
    public MyOpenAICompatibleEmbeddingCapability(IAIProvider provider) : base(provider) { }

    protected override IEmbeddingGenerator<string, Embedding<float>> CreateGenerator(
        MyProviderSettings settings,
        string? modelId)
    {
        var client = new OpenAIClient(new ApiKeyCredential(settings.ApiKey), new OpenAIClientOptions
        {
            Endpoint = new Uri(settings.BaseUrl!)
        });

        return client.AsEmbeddingGenerator(modelId ?? "text-embedding-3-small");
    }

    protected override Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        MyProviderSettings settings,
        CancellationToken cancellationToken = default)
    {
        return Task.FromResult<IReadOnlyList<AIModelDescriptor>>(new List<AIModelDescriptor>
        {
            new("text-embedding-3-small", "Text Embedding 3 Small"),
            new("text-embedding-3-large", "Text Embedding 3 Large")
        });
    }
}
```

{% endcode %}

## Handling Batches

The `GenerateAsync` method receives multiple inputs. Handle batching appropriately:

{% code title="Batch Handling" %}

```csharp
public async Task<GeneratedEmbeddings<Embedding<float>>> GenerateAsync(
    IEnumerable<string> values,
    EmbeddingGenerationOptions? options = null,
    CancellationToken cancellationToken = default)
{
    var inputList = values.ToList();

    // Some APIs have batch limits
    const int maxBatchSize = 100;

    if (inputList.Count > maxBatchSize)
    {
        // Process in chunks
        var allEmbeddings = new List<Embedding<float>>();

        for (int i = 0; i < inputList.Count; i += maxBatchSize)
        {
            var batch = inputList.Skip(i).Take(maxBatchSize);
            var batchResult = await GenerateBatchAsync(batch, cancellationToken);
            allEmbeddings.AddRange(batchResult);
        }

        return new GeneratedEmbeddings<Embedding<float>>(allEmbeddings);
    }

    return await GenerateBatchAsync(inputList, cancellationToken);
}
```

{% endcode %}

## Dimension Information

If your API returns dimension information, include it in the model descriptors:

{% code title="With Dimensions" %}

```csharp
protected override Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
    MyProviderSettings settings,
    CancellationToken cancellationToken = default)
{
    var models = new List<AIModelDescriptor>
    {
        new("embedding-small", "Small (1536 dimensions)"),
        new("embedding-large", "Large (3072 dimensions)")
    };
    return Task.FromResult<IReadOnlyList<AIModelDescriptor>>(models);
}
```

{% endcode %}
