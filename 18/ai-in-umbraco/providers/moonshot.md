---
description: >-
    Configure Moonshot AI as an AI provider for Kimi chat models.
---

# Moonshot AI

Moonshot AI provides access to Kimi models, supporting the Chat capability.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Moonshot
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Moonshot
```

{% endcode %}

## Connection Settings

| Setting  | Required | Description                                                                    |
| -------- | -------- | -------------------------------------------------------------------------------- |
| API Key  | Yes      | Your Moonshot API key from [platform.kimi.ai](https://platform.kimi.ai/)       |
| Endpoint | No       | Custom endpoint URL (defaults to `https://api.moonshot.ai/v1`)                 |

![Moonshot AI connection detail showing API Key and Endpoint fields](../.gitbook/assets/moonshot-create-connection.png)

### Getting an API Key

1. Sign up at [platform.kimi.ai](https://platform.kimi.ai/).
2. Navigate to **API Keys**.
3. Create a new key.
4. Copy the key (it won't be shown again).

{% hint style="warning" %}
Keep your API key secure. Never commit it to source control or expose it in client-side code.
{% endhint %}

{% hint style="info" %}
The default model is `kimi-k3`. Moonshot doesn't document an embeddings endpoint, so this provider supports Chat only.
{% endhint %}

## Related

- [Providers Overview](README.md).
- [Managing Connections](../backoffice/managing-connections.md).
