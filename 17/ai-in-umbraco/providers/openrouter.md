---
description: >-
    Configure OpenRouter as an AI provider for chat models from dozens of vendors through one API key.
---

# OpenRouter

OpenRouter provides access to hundreds of chat models from dozens of vendors through a single API key, supporting the Chat capability.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.OpenRouter
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.OpenRouter
```

{% endcode %}

## Connection Settings

| Setting  | Required | Description                                                            |
| -------- | -------- | -------------------------------------------------------------------------- |
| API Key  | Yes      | Your OpenRouter API key from [openrouter.ai/keys](https://openrouter.ai/keys) |
| Endpoint | No       | Custom endpoint URL (defaults to `https://openrouter.ai/api/v1`)       |

### Getting an API Key

1. Sign up at [openrouter.ai](https://openrouter.ai/)
2. Navigate to **Keys**
3. Create a new key
4. Copy the key (it won't be shown again)

{% hint style="warning" %}
Keep your API key secure. Never commit it to source control or expose it in client-side code.
{% endhint %}

### Choosing a Model

OpenRouter model IDs include the originating vendor, for example `openai/gpt-4o` or `anthropic/claude-3.5-sonnet`. Umbraco.AI lists the available models directly from the OpenRouter catalog.

{% hint style="info" %}
This provider supports Chat only. OpenRouter's provider routing and fallback options, reasoning-effort settings, and embeddings aren't available yet.
{% endhint %}

![OpenRouter connection detail showing API Key and Endpoint fields](../.gitbook/assets/openrouter-create-connection.png)

## Related

- [Providers Overview](README.md)
- [Managing Connections](../backoffice/managing-connections.md)
