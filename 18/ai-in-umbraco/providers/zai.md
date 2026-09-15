---
description: >-
    Configure Z.AI as an AI provider for GLM chat models.
---

# Z.AI

Z.AI provides access to GLM models, supporting the Chat capability.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.ZAI
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.ZAI
```

{% endcode %}

## Connection Settings

| Setting  | Required | Description                                                          |
| -------- | -------- | -------------------------------------------------------------------- |
| API Key  | Yes      | Your Z.AI API key from [z.ai/model-api](https://z.ai/model-api)      |
| Endpoint | No       | Custom endpoint URL (defaults to `https://api.z.ai/api/paas/v4`)     |

### Getting an API Key

1. Sign up at [z.ai/model-api](https://z.ai/model-api)
2. Navigate to **API Keys**
3. Create a new key
4. Copy the key (it won't be shown again)

{% hint style="warning" %}
Keep your API key secure. Never commit it to source control or expose it in client-side code.
{% endhint %}

{% hint style="info" %}
Z.AI's global API doesn't offer an embeddings endpoint, so this provider supports Chat only.
{% endhint %}

![Z.AI connection detail showing API Key and Endpoint fields](../.gitbook/assets/zai-create-connection.png)

## Related

- [Providers Overview](README.md)
- [Managing Connections](../backoffice/managing-connections.md)
