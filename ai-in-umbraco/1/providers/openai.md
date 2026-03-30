---
description: >-
    Configure OpenAI as an AI provider for chat and embedding capabilities.
---

# OpenAI

OpenAI provides access to GPT models for chat and text-embedding models for semantic search. It offers comprehensive model selection across chat and embedding capabilities.

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

## Capabilities

| Capability | Supported | Description                                             |
| ---------- | --------- | ------------------------------------------------------- |
| Chat       | Yes       | GPT-4o, GPT-4, GPT-3.5-turbo, o1 models                 |
| Embedding  | Yes       | text-embedding-3-small, text-embedding-3-large, ada-002 |

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

## Available Models

### Chat Models

| Model           | Context Window | Best For                             |
| --------------- | -------------- | ------------------------------------ |
| `gpt-4o`        | 128K           | General purpose, recommended default |
| `gpt-4o-mini`   | 128K           | Cost-effective, fast responses       |
| `gpt-4-turbo`   | 128K           | Complex reasoning tasks              |
| `gpt-4`         | 8K             | Legacy, stable behavior              |
| `gpt-3.5-turbo` | 16K            | Budget-conscious applications        |
| `o1`            | 200K           | Advanced reasoning, coding           |
| `o1-mini`       | 128K           | Efficient reasoning                  |

### Embedding Models

| Model                    | Dimensions | Best For                     |
| ------------------------ | ---------- | ---------------------------- |
| `text-embedding-3-small` | 1536       | Cost-effective, good quality |
| `text-embedding-3-large` | 3072       | Highest quality              |
| `text-embedding-ada-002` | 1536       | Legacy, widely compatible    |

## Creating a Connection

### Via Backoffice

1. Navigate to the **AI** section > **Connections**
2. Click **Create Connection**
3. Select **OpenAI** as the provider
4. Enter your API key
5. Optionally add Organization ID
6. Save the connection

### Via Code

{% code title="CreateOpenAIConnection.cs" %}

```csharp
var connection = new AIConnection
{
    Alias = "openai-production",
    Name = "OpenAI Production",
    ProviderId = "openai",
    Settings = new OpenAIProviderSettings
    {
        ApiKey = "sk-...",
        OrganizationId = "org-..."
    }
};

await _connectionService.SaveConnectionAsync(connection);
```

{% endcode %}

## Creating a Profile

### Chat Profile

{% code title="OpenAIChatProfile.cs" %}

```csharp
var profile = new AIProfile
{
    Alias = "content-writer",
    Name = "Content Writer",
    Capability = AICapability.Chat,
    ConnectionId = connectionId,
    Model = new AIModelRef("openai", "gpt-4o"),
    Settings = new AIChatProfileSettings
    {
        Temperature = 0.7f,
        MaxTokens = 2000,
        SystemPromptTemplate = "You are a helpful content writer."
    }
};

await _profileService.SaveProfileAsync(profile);
```

{% endcode %}

### Embedding Profile

{% code title="OpenAIEmbeddingProfile.cs" %}

```csharp
var profile = new AIProfile
{
    Alias = "search-embeddings",
    Name = "Search Embeddings",
    Capability = AICapability.Embedding,
    ConnectionId = connectionId,
    Model = new AIModelRef("openai", "text-embedding-3-small")
};

await _profileService.SaveProfileAsync(profile);
```

{% endcode %}

## Azure OpenAI

OpenAI models are also available through Azure OpenAI Service. To use Azure:

1. Set the **Endpoint** to your Azure OpenAI resource URL:
   `https://{resource-name}.openai.azure.com/`

2. Use your Azure API key instead of an OpenAI key

3. Model names may differ (deployment names vs model names)

{% hint style="info" %}
Azure OpenAI provides data residency, enterprise compliance, and integration with Azure security features.
{% endhint %}

## Pricing Considerations

OpenAI uses pay-per-token pricing:

| Model Tier    | Input (1M tokens) | Output (1M tokens) |
| ------------- | ----------------- | ------------------ |
| GPT-4o        | ~$2.50            | ~$10.00            |
| GPT-4o-mini   | ~$0.15            | ~$0.60             |
| GPT-3.5-turbo | ~$0.50            | ~$1.50             |

{% hint style="info" %}
Prices are approximate and subject to change. Check [OpenAI pricing](https://openai.com/pricing) for current rates.
{% endhint %}

## Troubleshooting

### Invalid API Key

{% code title="Error" %}
```
Error: Invalid API key provided
```
{% endcode %}

Verify your API key is correct and hasn't been revoked.

### Rate Limits

{% code title="Error" %}
```
Error: Rate limit exceeded
```
{% endcode %}

OpenAI has rate limits based on your account tier. Consider:

- Implementing retry logic with exponential backoff
- Upgrading your OpenAI account tier
- Using a smaller/faster model

### Model Not Found

{% code title="Error" %}
```
Error: The model 'gpt-5' does not exist
```
{% endcode %}

Check the model name matches exactly. Available models depend on your OpenAI account access.

## Related

- [Providers Overview](README.md) - Compare all providers
- [Connections](../concepts/connections.md) - Managing credentials
- [Profiles](../concepts/profiles.md) - Configuring models
