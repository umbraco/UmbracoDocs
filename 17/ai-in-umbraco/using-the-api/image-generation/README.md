---
description: >-
    Generate and edit images from text prompts using the experimental Image Generation API.
---

# Image Generation

{% hint style="warning" %}
Image Generation is **experimental**. The API surface may change between releases. It is disabled by default — see [Enabling image generation](#enabling-image-generation) below.
{% endhint %}

The Image Generation API produces images from text prompts and edits existing images. It is a thin layer over [Microsoft.Extensions.AI](https://learn.microsoft.com/dotnet/ai/)'s `IImageGenerator`, adding Umbraco profiles, connections, guardrails, and observability (auditing, telemetry, usage tracking).

## Enabling image generation

Image Generation is gated behind a feature flag. Until it is enabled:

- The capability is hidden from discovery and is **not selectable** in the profile editor,
- Profiles using it cannot be created, and
- The Management API endpoint returns **404**.

Enable it in `appsettings.json`:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "Experimental": {
                "ImageGeneration": true
            }
        }
    }
}
```

{% endcode %}

The C# API surface is annotated with the `UMBRACOAI_IMAGEGEN` diagnostic. Because it is experimental, suppress the diagnostic in files that call it:

{% code title="C#" %}

```csharp
#pragma warning disable UMBRACOAI_IMAGEGEN
```

{% endcode %}

Once enabled, restart the site. A **Default Image Generation Profile** setting appears under **Settings > AI > Settings**, and Image Generation becomes selectable when creating a profile.

## What you can do

Image Generation supports three tiers of use:

| Tier | Scenario | How |
| --- | --- | --- |
| 1. Text-to-image | Generate images from a prompt | [`GenerateImagesAsync`](generating-images.md) |
| 2. Maskless edit | Transform supplied images with a prompt | [`GenerateImagesAsync` with original images](editing-images.md) |
| 3. Masked outpainting | Provider-native masked edits | [`GetService` escape hatch](editing-images.md#masked-outpainting-tier-3) |

## IAIImageGenerationService

The primary interface for image-generation operations. It follows the same builder pattern as the other capability services.

{% code title="IAIImageGenerationService.cs" %}

```csharp
public interface IAIImageGenerationService
{
    Task<ImageGenerationResponse> GenerateImagesAsync(
        Action<AIImageGenerationBuilder> configure,
        string prompt,
        CancellationToken cancellationToken = default);

    Task<ImageGenerationResponse> GenerateImagesAsync(
        Action<AIImageGenerationBuilder> configure,
        string prompt,
        IEnumerable<AIContent>? originalImages,
        CancellationToken cancellationToken = default);

    Task<IImageGenerator> CreateImageGeneratorAsync(
        Action<AIImageGenerationBuilder> configure,
        CancellationToken cancellationToken = default);

    Task<AITrackedImageResult<TResult>> InvokeWithTrackingAsync<TResult>(
        Action<AIImageGenerationBuilder> configure,
        Func<IImageGenerator, CancellationToken, Task<AITrackedImageResult<TResult>>> operation,
        CancellationToken cancellationToken = default);

    Task<AISupportedImageModels> GetSupportedModelsAsync(
        Action<AIImageGenerationBuilder> configure,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## AIImageGenerationBuilder

All methods accept an `Action<AIImageGenerationBuilder>` to configure the request:

| Method | Description |
| --- | --- |
| `.WithAlias(string alias)` | Sets an alias for auditing and telemetry. Required for generation calls; optional for `GetSupportedModelsAsync` (a read-only metadata lookup that uses only the profile). |
| `.WithProfile(Guid profileId)` | Selects a profile by ID. Uses the default image-generation profile if omitted. |
| `.WithProfile(string profileAlias)` | Selects a profile by alias. |
| `.WithImageGenerationOptions(ImageGenerationOptions options)` | Overrides profile defaults (size, count, response format). |
| `.WithOriginalImages(IEnumerable<AIContent> images)` | Supplies images to edit (maskless edit — Tier 2). |
| `.WithGuardrails(params string[] aliases)` | Adds guardrails on top of the profile's (additive). |
| `.SetGuardrails(params string[] aliases)` | Replaces the profile's guardrails. |
| `.WithContextItems(IEnumerable<AIRequestContextItem> items)` | Attaches context items to the request. |

## Setting up image generation

### 1. Enable the feature flag

See [Enabling image generation](#enabling-image-generation) above.

### 2. Install a provider with Image Generation support

Currently, OpenAI is the only provider with Image Generation support:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.OpenAI
```

{% endcode %}

### 3. Create a connection and profile

Create an OpenAI connection in the backoffice, then create a profile with the **Image Generation** capability. Supported models include:

| Model | Notes |
| --- | --- |
| `gpt-image-1` | Default. Sizes 1024x1024, 1024x1536, 1536x1024; supports editing and masks. |
| `dall-e-3` | Sizes 1024x1024, 1792x1024, 1024x1792; no editing. |
| `dall-e-2` | Sizes 256x256, 512x512, 1024x1024; supports editing and masks. |

## In this section

{% content-ref url="generating-images.md" %}
[Generating Images](generating-images.md)
{% endcontent-ref %}

{% content-ref url="editing-images.md" %}
[Editing Images](editing-images.md)
{% endcontent-ref %}

## Related

- [Capabilities](../../concepts/capabilities.md) - Available capability types
- [OpenAI Provider](../../providers/openai.md) - Provider with Image Generation support
- [Image Generation Controller](../../frontend/image-generation-controller.md) - Frontend API
- [Image Generation Management API](../../management-api/image-generation/README.md) - REST endpoints
