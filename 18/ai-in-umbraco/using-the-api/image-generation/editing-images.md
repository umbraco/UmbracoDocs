---
description: >-
    Edit existing images with a prompt (maskless), and reach the provider-native client for masked outpainting.
---

# Editing Images

{% hint style="warning" %}
Image Generation is experimental and disabled by default. See [Enabling image generation](README.md#enabling-image-generation).
{% endhint %}

## Maskless edit (Tier 2)

Supply one or more original images alongside the prompt. The model transforms the supplied image(s) rather than generating from scratch. Use the `GenerateImagesAsync` overload that takes `originalImages`:

{% code title="EditImage.cs" %}

```csharp
#pragma warning disable UMBRACOAI_IMAGEGEN

using Microsoft.Extensions.AI;
using Umbraco.AI.Core.ImageGeneration;

public async Task<IReadOnlyList<AIContent>> AddSnow(byte[] originalPng)
{
    var original = new DataContent(originalPng, "image/png");

    var response = await _imageGenerationService.GenerateImagesAsync(
        img => img.WithAlias("seasonal-edit").WithProfile("marketing-images"),
        "Add a light dusting of snow to the scene",
        new AIContent[] { original });

    return response.Contents;
}
```

{% endcode %}

{% hint style="info" %}
Not every model supports editing. Check the `image.supportsEdit` constraint from [`GetSupportedModelsAsync`](generating-images.md#validating-models-and-sizes-up-front) before offering an edit workflow.
{% endhint %}

## Masked outpainting (Tier 3)

Masked editing (supplying a mask to control which region changes) is not expressible through the Microsoft.Extensions.AI abstraction. For it, reach the provider-native client through the scoped generator's `GetService`.

`CreateImageGeneratorAsync` returns an `IImageGenerator` that forwards `GetService` through the full pipeline. For OpenAI, resolve the un-bound `OpenAIClient` and pick your model and size at call time:

{% code title="MaskedEdit.cs" %}

```csharp
#pragma warning disable UMBRACOAI_IMAGEGEN

using OpenAI;

var generator = await _imageGenerationService.CreateImageGeneratorAsync(
    img => img.WithAlias("masked-outpaint").WithProfile("marketing-images"));

var openAiClient = (OpenAIClient?)generator.GetService(typeof(OpenAIClient));
var imageClient = openAiClient!.GetImageClient("gpt-image-1");

// Use imageClient's native mask/edit APIs here.
```

{% endcode %}

{% hint style="warning" %}
`GetService` is OpenAI/Azure-OpenAI specific — other providers will not return an `OpenAIClient`. Raw calls made this way **bypass the usage and audit middleware**. To keep them visible in analytics and audit, wrap them in `InvokeWithTrackingAsync` (below).
{% endhint %}

## Keeping raw calls tracked

`InvokeWithTrackingAsync` opens a scope, builds the scoped generator, runs your operation, and records usage + audit around it. Return an `AITrackedImageResult<TResult>` reporting what the raw call produced:

{% code title="TrackedRawCall.cs" %}

```csharp
#pragma warning disable UMBRACOAI_IMAGEGEN

using Microsoft.Extensions.AI;
using OpenAI;
using Umbraco.AI.Core.ImageGeneration;

var tracked = await _imageGenerationService.InvokeWithTrackingAsync(
    img => img.WithAlias("masked-outpaint").WithProfile("marketing-images"),
    async (generator, ct) =>
    {
        var client = (OpenAIClient)generator.GetService(typeof(OpenAIClient))!;
        var imageClient = client.GetImageClient("gpt-image-1");

        // ... perform the provider-native masked edit, obtain bytes ...
        byte[] resultBytes = await DoMaskedEditAsync(imageClient, ct);

        return new AITrackedImageResult<byte[]>
        {
            Result = resultBytes,
            ImageCount = 1,
        };
    });

byte[] edited = tracked.Result;
```

{% endcode %}

## Related

- [Generating Images](generating-images.md) - Text-to-image and model validation
- [Image Generation overview](README.md) - Enablement and service surface
- [OpenAI Provider](../../providers/openai.md) - The provider that supports the escape hatch
