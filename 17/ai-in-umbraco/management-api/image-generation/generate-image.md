---
description: >-
    Generate one or more images from a text prompt, with optional maskless edit.
---

# Generate Images

{% hint style="warning" %}
Returns **404** when the `Umbraco:AI:Experimental:ImageGeneration` feature flag is disabled.
{% endhint %}

```http
POST /umbraco/ai/management/api/v1/image-generation/generate
```

## Request Body

{% code title="application/json" %}

```json
{
  "prompt": "A serene mountain landscape at dawn",
  "profileIdOrAlias": "marketing-images",
  "count": 1,
  "size": "1024x1024",
  "responseFormat": "data",
  "originalImages": [
    { "data": "<base64>", "mediaType": "image/png" }
  ]
}
```

{% endcode %}

| Property | Type | Required | Description |
| --- | --- | --- | --- |
| `prompt` | string | Yes | The text prompt describing the desired image(s). |
| `profileIdOrAlias` | string | No | Profile ID or alias. Uses the default image-generation profile if omitted. |
| `count` | int | No | Number of images to generate. |
| `size` | string | No | Image size as `"{width}x{height}"` (for example, `"1024x1024"`). |
| `responseFormat` | string | No | How images are returned: `"url"` (a URI to the image), `"data"` (inline base64 data), or `"hosted"` (a hosted resource identifier to retrieve the image later). |
| `originalImages` | array | No | Base64 images to edit (maskless edit). Each: `{ "data", "mediaType" }`. Masked outpainting is not exposed over REST. |

## Response

{% code title="200 OK" %}

```json
{
  "images": [
    { "data": "<base64>", "url": null, "mediaType": "image/png" }
  ],
  "usage": {
    "inputTokens": 0,
    "outputTokens": 0,
    "totalTokens": 0
  }
}
```

{% endcode %}

| Property | Type | Description |
| --- | --- | --- |
| `images` | array | Generated images. Each has `data` (base64) and/or `url`, plus `mediaType`. |
| `usage` | object | Optional token usage (`inputTokens`, `outputTokens`, `totalTokens`), when reported. |

## Status Codes

| Code | Meaning |
| --- | --- |
| 200 | Images generated. |
| 400 | Invalid prompt, invalid base64 image data, or generation failed. |
| 404 | Feature flag disabled, or the profile was not found. |

## Example

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/image-generation/generate" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "prompt": "A serene mountain landscape at dawn", "size": "1024x1024" }'
```

{% endcode %}

## Related

- [Image Generation API overview](README.md)
- [Using the Image Generation API](../../using-the-api/image-generation/README.md)
