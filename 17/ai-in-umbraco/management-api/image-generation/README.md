---
description: >-
    REST API endpoints for generating and editing images (experimental).
---

# Image Generation API

{% hint style="warning" %}
Image Generation is **experimental**. When the `Umbraco:AI:Experimental:ImageGeneration` feature flag is disabled, these endpoints return **404**. See [Enabling image generation](../../using-the-api/image-generation/README.md#enabling-image-generation).
{% endhint %}

The Image Generation API generates images from a text prompt, with optional maskless editing of supplied images.

## Base URL

```
/umbraco/ai/management/api/v1/image-generation
```

## Authentication

All endpoints require backoffice authentication with the `Umb.AI.Management.Api` authorization policy.

## Endpoints

| Method | Endpoint | Description |
| ------ | -------- | ----------- |
| POST   | `/umbraco/ai/management/api/v1/image-generation/generate` | [Generate images](generate-image.md) |

## In This Section

{% content-ref url="generate-image.md" %}
[Generate Images](generate-image.md)
{% endcontent-ref %}
