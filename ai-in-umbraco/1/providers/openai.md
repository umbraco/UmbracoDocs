---
description: >-
    Configure OpenAI as an AI provider for chat and embedding capabilities.
---

# OpenAI

OpenAI provides access to GPT and text-embedding models, supporting both Chat and Embedding capabilities.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.OpenAI
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.OpenAI
```

{% endcode %}

## Connection Settings

| Setting         | Required | Description                                                                 |
| --------------- | -------- | --------------------------------------------------------------------------- |
| API Key         | Yes      | Your OpenAI API key from [platform.openai.com](https://platform.openai.com) |
| Organization ID | No       | Optional organization identifier for usage tracking                         |
| Endpoint        | No       | Custom endpoint URL (defaults to `https://api.openai.com/v1`)               |

### Getting an API Key

1. Sign up at [platform.openai.com](https://platform.openai.com)
2. Navigate to **API keys** in the sidebar
3. Click **Create new secret key**
4. Copy the key (it won't be shown again)

{% hint style="warning" %}
Keep your API key secure. Never commit it to source control or expose it in client-side code.
{% endhint %}

### Azure OpenAI

OpenAI models are also available through Azure OpenAI Service. To use Azure:

1. Set the **Endpoint** to your Azure OpenAI resource URL:
   `https://{resource-name}.openai.azure.com/`

2. Use your Azure API key instead of an OpenAI key

3. Model names may differ (deployment names vs model names)

{% hint style="info" %}
Azure OpenAI provides data residency, enterprise compliance, and integration with Azure security features.
{% endhint %}

![OpenAI connection detail showing API Key and Organization fields](../.gitbook/assets/openai-create-connection.png)

## Related

- [Providers Overview](README.md)
- [Managing Connections](../backoffice/managing-connections.md)
