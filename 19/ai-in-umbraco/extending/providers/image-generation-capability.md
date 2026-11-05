---
description: >-
    Implement the experimental image-generation capability for your custom provider.
---

# Image Generation Capability

{% hint style="warning" %}
Image Generation is **experimental**. When the `Umbraco:AI:Experimental:ImageGeneration` feature flag is off, the capability is hidden from discovery and not selectable in the profile editor — even if a provider implements it.
{% endhint %}

The image-generation capability produces images from prompts. Implement it by extending `AIImageGeneratorCapabilityBase<TSettings>`.

## Base Class

{% code title="AIImageGeneratorCapabilityBase<TSettings>" %}

```csharp
public abstract class AIImageGeneratorCapabilityBase<TSettings>(IAIProvider provider)
    : AICapabilityBase<TSettings>(provider), IAICapability<TSettings>, IAIImageGeneratorCapability
    where TSettings : class
{
    public override AICapability Kind => AICapability.ImageGeneration;

    // Override this (or CreateGeneratorAsync) to create an IImageGenerator
    protected virtual IImageGenerator CreateGenerator(TSettings settings, string? modelId) { /* ... */ }

    // Override this for an async variant
    protected virtual Task<IImageGenerator> CreateGeneratorAsync(
        TSettings settings, string? modelId, CancellationToken cancellationToken = default) { /* ... */ }

    // Implement this: return available models (with constraint metadata)
    protected abstract Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        TSettings settings,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

{% hint style="info" %}
`IImageGenerator` is marked `[Experimental("MEAI001")]` in Microsoft.Extensions.AI, and the Umbraco capability surface carries the `UMBRACOAI_IMAGEGEN` diagnostic. Add both `#pragma warning disable MEAI001` and `#pragma warning disable UMBRACOAI_IMAGEGEN` to your implementation files.
{% endhint %}

## Basic Implementation

{% code title="MyImageGenerationCapability.cs" %}

```csharp
#pragma warning disable MEAI001
#pragma warning disable UMBRACOAI_IMAGEGEN

using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Models;
using Umbraco.AI.Core.Providers;

public class MyImageGenerationCapability : AIImageGeneratorCapabilityBase<MyProviderSettings>
{
    public MyImageGenerationCapability(IAIProvider provider) : base(provider) { }

    protected override IImageGenerator CreateGenerator(MyProviderSettings settings, string? modelId)
    {
        return new MyImageGenerator(settings, modelId ?? "default-image-model");
    }

    protected override Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        MyProviderSettings settings,
        CancellationToken cancellationToken = default)
    {
        var models = new List<AIModelDescriptor>
        {
            new(
                new AIModelRef(Provider.Id, "image-standard"),
                "Standard Image Model",
                new Dictionary<string, string>
                {
                    ["image.supportedSizes"] = "1024x1024",
                    ["image.maxEdge"] = "1024",
                    ["image.supportsEdit"] = "false",
                    ["image.supportsMask"] = "false",
                })
        };
        return Task.FromResult<IReadOnlyList<AIModelDescriptor>>(models);
    }
}
```

{% endcode %}

{% hint style="info" %}
Surface per-model constraints via `AIModelDescriptor` metadata (`image.supportedSizes`, `image.maxEdge`, `image.supportsEdit`, `image.supportsMask`). Consumers read these through `GetSupportedModelsAsync` to validate requests before calling.
{% endhint %}

## Register in Provider

Add the image-generation capability in your provider constructor:

{% code title="MyProvider.cs" %}

```csharp
[AIProvider("myprovider", "My AI Provider")]
public class MyProvider : AIProviderBase<MyProviderSettings>
{
    public MyProvider(IAIProviderInfrastructure infrastructure)
        : base(infrastructure)
    {
        WithCapability<MyChatCapability>();
        WithCapability<MyImageGenerationCapability>();  // Add image-generation support
    }
}
```

{% endcode %}

## Exposing a provider-native client (optional)

To let consumers reach your provider's native client for masked outpainting (Tier 3), return an `IImageGenerator` that overrides `GetService` to resolve that client. The OpenAI provider does this with `OpenAIClient`: wrap the `Microsoft.Extensions.AI` adapter in a `DelegatingImageGenerator` and return your native client for its type in `GetService`.

## Related

- [Creating a Provider](creating-a-provider.md) - Provider setup
- [Chat Capability](chat-capability.md) - Chat capability implementation
- [Speech-to-Text Capability](speech-to-text-capability.md) - Speech-to-text capability implementation
- [Image Generation API](../../using-the-api/image-generation/README.md) - Using the Image Generation API
