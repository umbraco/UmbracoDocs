---
description: >-
    Create middleware to intercept and modify embedding operations.
---

# Embedding Middleware

Embedding middleware wraps `IEmbeddingGenerator<string, Embedding<float>>` instances to add behavior to embedding generation. Implement `IAIEmbeddingMiddleware` to create custom middleware.

## Interface

{% code title="IAIEmbeddingMiddleware" %}

```csharp
public interface IAIEmbeddingMiddleware
{
    IEmbeddingGenerator<string, Embedding<float>> Apply(
        IEmbeddingGenerator<string, Embedding<float>> generator);
}
```

{% endcode %}

The `Apply` method receives the current generator and returns a wrapped generator.

## Basic Implementation

{% code title="SimpleEmbeddingMiddleware.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Embeddings;

public class SimpleEmbeddingMiddleware : IAIEmbeddingMiddleware
{
    public IEmbeddingGenerator<string, Embedding<float>> Apply(
        IEmbeddingGenerator<string, Embedding<float>> generator)
    {
        return new SimpleEmbeddingWrapper(generator);
    }
}
```

{% endcode %}

## Creating a Custom Wrapper

{% code title="MetricsEmbeddingMiddleware.cs" %}

```csharp
using System.Diagnostics;
using Microsoft.Extensions.AI;
using Microsoft.Extensions.Logging;

public class MetricsEmbeddingMiddleware : IAIEmbeddingMiddleware
{
    private readonly ILogger<MetricsEmbeddingMiddleware> _logger;

    public MetricsEmbeddingMiddleware(ILogger<MetricsEmbeddingMiddleware> logger)
    {
        _logger = logger;
    }

    public IEmbeddingGenerator<string, Embedding<float>> Apply(
        IEmbeddingGenerator<string, Embedding<float>> generator)
    {
        return new MetricsEmbeddingGenerator(generator, _logger);
    }
}

internal class MetricsEmbeddingGenerator : IEmbeddingGenerator<string, Embedding<float>>
{
    private readonly IEmbeddingGenerator<string, Embedding<float>> _inner;
    private readonly ILogger _logger;

    public MetricsEmbeddingGenerator(
        IEmbeddingGenerator<string, Embedding<float>> inner,
        ILogger logger)
    {
        _inner = inner;
        _logger = logger;
    }

    public EmbeddingGeneratorMetadata Metadata => _inner.Metadata;

    public async Task<GeneratedEmbeddings<Embedding<float>>> GenerateAsync(
        IEnumerable<string> values,
        EmbeddingGenerationOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        var inputList = values.ToList();
        var stopwatch = Stopwatch.StartNew();

        try
        {
            var result = await _inner.GenerateAsync(inputList, options, cancellationToken);
            stopwatch.Stop();

            _logger.LogInformation(
                "Generated {Count} embeddings in {ElapsedMs}ms. Tokens: {Tokens}",
                result.Count,
                stopwatch.ElapsedMilliseconds,
                result.Usage?.InputTokenCount);

            return result;
        }
        catch (Exception ex)
        {
            stopwatch.Stop();
            _logger.LogError(ex,
                "Embedding generation failed after {ElapsedMs}ms for {Count} inputs",
                stopwatch.ElapsedMilliseconds,
                inputList.Count);
            throw;
        }
    }

    public object? GetService(Type serviceType, object? serviceKey = null)
        => _inner.GetService(serviceType, serviceKey);

    public void Dispose() => _inner.Dispose();
}
```

{% endcode %}

## Using M.E.AI Built-in Middleware

Microsoft.Extensions.AI (M.E.AI) provides built-in middleware for embedding generators:

{% code title="Using Built-in Middleware" %}

```csharp
using Microsoft.Extensions.AI;
using Microsoft.Extensions.Logging;

public class LoggingEmbeddingMiddleware : IAIEmbeddingMiddleware
{
    private readonly ILoggerFactory _loggerFactory;

    public LoggingEmbeddingMiddleware(ILoggerFactory loggerFactory)
    {
        _loggerFactory = loggerFactory;
    }

    public IEmbeddingGenerator<string, Embedding<float>> Apply(
        IEmbeddingGenerator<string, Embedding<float>> generator)
    {
        return generator.AsBuilder()
            .UseLogging(_loggerFactory)
            .Build();
    }
}
```

{% endcode %}

## Registering Embedding Middleware

Register middleware in a Composer:

{% code title="MyComposer.cs" %}

```csharp
using Umbraco.AI.Extensions;
using Umbraco.Cms.Core.Composing;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIEmbeddingMiddleware()
            .Append<MetricsEmbeddingMiddleware>();
    }
}
```

{% endcode %}

## Example: Caching Middleware

Cache embeddings to avoid regenerating for the same input:

{% code title="CachingEmbeddingMiddleware.cs" %}

```csharp
using System.Security.Cryptography;
using System.Text;
using Microsoft.Extensions.AI;
using Microsoft.Extensions.Caching.Memory;

public class CachingEmbeddingMiddleware : IAIEmbeddingMiddleware
{
    private readonly IMemoryCache _cache;

    public CachingEmbeddingMiddleware(IMemoryCache cache)
    {
        _cache = cache;
    }

    public IEmbeddingGenerator<string, Embedding<float>> Apply(
        IEmbeddingGenerator<string, Embedding<float>> generator)
    {
        return new CachingEmbeddingGenerator(generator, _cache);
    }
}

internal class CachingEmbeddingGenerator : IEmbeddingGenerator<string, Embedding<float>>
{
    private readonly IEmbeddingGenerator<string, Embedding<float>> _inner;
    private readonly IMemoryCache _cache;

    public CachingEmbeddingGenerator(
        IEmbeddingGenerator<string, Embedding<float>> inner,
        IMemoryCache cache)
    {
        _inner = inner;
        _cache = cache;
    }

    public EmbeddingGeneratorMetadata Metadata => _inner.Metadata;

    public async Task<GeneratedEmbeddings<Embedding<float>>> GenerateAsync(
        IEnumerable<string> values,
        EmbeddingGenerationOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        var inputList = values.ToList();
        var results = new List<Embedding<float>>();
        var uncachedInputs = new List<(int Index, string Value)>();

        // Check cache for each input
        for (int i = 0; i < inputList.Count; i++)
        {
            var cacheKey = GetCacheKey(inputList[i]);
            if (_cache.TryGetValue<Embedding<float>>(cacheKey, out var cached))
            {
                results.Add(cached!);
            }
            else
            {
                uncachedInputs.Add((i, inputList[i]));
                results.Add(null!); // Placeholder
            }
        }

        // Generate uncached embeddings
        if (uncachedInputs.Count > 0)
        {
            var generated = await _inner.GenerateAsync(
                uncachedInputs.Select(x => x.Value),
                options,
                cancellationToken);

            for (int i = 0; i < uncachedInputs.Count; i++)
            {
                var embedding = generated[i];
                var cacheKey = GetCacheKey(uncachedInputs[i].Value);

                _cache.Set(cacheKey, embedding, TimeSpan.FromHours(24));
                results[uncachedInputs[i].Index] = embedding;
            }
        }

        return new GeneratedEmbeddings<Embedding<float>>(results);
    }

    private static string GetCacheKey(string input)
    {
        var hash = SHA256.HashData(Encoding.UTF8.GetBytes(input));
        return $"embedding:{Convert.ToBase64String(hash)}";
    }

    public object? GetService(Type serviceType, object? serviceKey = null)
        => _inner.GetService(serviceType, serviceKey);

    public void Dispose() => _inner.Dispose();
}
```

{% endcode %}

## Example: Normalization Middleware

Normalize embedding vectors to unit length:

{% code title="NormalizationMiddleware.cs" %}

```csharp
using Microsoft.Extensions.AI;

public class NormalizationEmbeddingMiddleware : IAIEmbeddingMiddleware
{
    public IEmbeddingGenerator<string, Embedding<float>> Apply(
        IEmbeddingGenerator<string, Embedding<float>> generator)
    {
        return new NormalizingEmbeddingGenerator(generator);
    }
}

internal class NormalizingEmbeddingGenerator : IEmbeddingGenerator<string, Embedding<float>>
{
    private readonly IEmbeddingGenerator<string, Embedding<float>> _inner;

    public NormalizingEmbeddingGenerator(IEmbeddingGenerator<string, Embedding<float>> inner)
    {
        _inner = inner;
    }

    public EmbeddingGeneratorMetadata Metadata => _inner.Metadata;

    public async Task<GeneratedEmbeddings<Embedding<float>>> GenerateAsync(
        IEnumerable<string> values,
        EmbeddingGenerationOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        var result = await _inner.GenerateAsync(values, options, cancellationToken);

        var normalized = result.Select(e => new Embedding<float>(Normalize(e.Vector.ToArray()))
        {
            ModelId = e.ModelId,
            CreatedAt = e.CreatedAt
        }).ToList();

        return new GeneratedEmbeddings<Embedding<float>>(normalized)
        {
            Usage = result.Usage
        };
    }

    private static float[] Normalize(float[] vector)
    {
        var magnitude = MathF.Sqrt(vector.Sum(x => x * x));
        if (magnitude == 0) return vector;

        return vector.Select(x => x / magnitude).ToArray();
    }

    public object? GetService(Type serviceType, object? serviceKey = null)
        => _inner.GetService(serviceType, serviceKey);

    public void Dispose() => _inner.Dispose();
}
```

{% endcode %}
