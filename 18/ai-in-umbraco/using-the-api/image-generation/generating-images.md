---
description: >-
    Generate images from a text prompt and validate model constraints up front.
---

# Generating Images

{% hint style="warning" %}
Image Generation is experimental and disabled by default. See [Enabling image generation](README.md#enabling-image-generation).
{% endhint %}

Use `GenerateImagesAsync` to produce images from a text prompt (Tier 1).

## Basic usage

{% code title="HeroBanner.cs" %}

```csharp
#pragma warning disable UMBRACOAI_IMAGEGEN

using Microsoft.Extensions.AI;
using Umbraco.AI.Core.ImageGeneration;

public class HeroBanner
{
    private readonly IAIImageGenerationService _imageGenerationService;

    public HeroBanner(IAIImageGenerationService imageGenerationService)
    {
        _imageGenerationService = imageGenerationService;
    }

    public async Task<IReadOnlyList<AIContent>> Generate()
    {
        var response = await _imageGenerationService.GenerateImagesAsync(
            img => img.WithAlias("hero-banner"),
            "A serene mountain landscape at dawn");

        return response.Contents;
    }
}
```

{% endcode %}

Each item in `response.Contents` is a `DataContent` (inline bytes) or `UriContent` (hosted URL), depending on the model and requested response format.

## Choosing a profile and options

{% code title="Builder example" %}

```csharp
#pragma warning disable MEAI001 // ImageGenerationOptions is experimental in M.E.AI
#pragma warning disable UMBRACOAI_IMAGEGEN

var response = await _imageGenerationService.GenerateImagesAsync(
    img => img
        .WithAlias("product-shot")
        .WithProfile("marketing-images")
        .WithImageGenerationOptions(new ImageGenerationOptions
        {
            Count = 2,
            ImageSize = new Size(1024, 1024),
        }),
    "A product photo of a ceramic coffee mug on a wooden table",
    cancellationToken);
```

{% endcode %}

Profile-level defaults (size, quality, style, output media type) come from `AIImageGenerationProfileSettings`; options passed to the builder override them per call.

## Validating models and sizes up front

Different models support different sizes. Call `GetSupportedModelsAsync` to read the resolved model and its constraints before generating, so you can fail early with a clear message rather than getting a wrong-ratio result:

{% code title="Validate.cs" %}

```csharp
#pragma warning disable UMBRACOAI_IMAGEGEN

var supported = await _imageGenerationService.GetSupportedModelsAsync(
    img => img.WithProfile("marketing-images"));

var boundModel = supported.Models.First(m => m.Model.ModelId == supported.ModelId);

// Per-model constraints are exposed via descriptor metadata
if (boundModel.Metadata.TryGetValue("image.supportedSizes", out var sizes))
{
    // e.g. "1024x1024,1024x1536,1536x1024"
    Console.WriteLine($"{supported.ModelId} supports: {sizes}");
}
```

{% endcode %}

Constraint metadata keys include `image.supportedSizes`, `image.maxEdge`, `image.supportsEdit`, and `image.supportsMask`.

## Observability

`GenerateImagesAsync` runs through the full middleware pipeline — usage tracking, audit entries, guardrails, and telemetry — and publishes `AIImageGenerationExecutingNotification` / `AIImageGenerationExecutedNotification`. Every call requires an alias (`.WithAlias(...)`) so it can be attributed in analytics and audit logs.

## Related

- [Image Generation overview](README.md) - Enablement and service surface
- [Editing Images](editing-images.md) - Maskless edit and masked outpainting
- [Usage Analytics](../../backoffice/usage-analytics.md) - Where generations are recorded
