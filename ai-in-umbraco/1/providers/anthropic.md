---
description: >-
    Configure Anthropic as an AI provider for Claude models.
---

# Anthropic

Anthropic provides access to Claude models, known for their large context windows and strong reasoning capabilities.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Anthropic
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Anthropic
```

{% endcode %}

## Capabilities

| Capability | Supported | Description                       |
| ---------- | --------- | --------------------------------- |
| Chat       | Yes       | Claude 3.5, Claude 3 model family |
| Embedding  | No        | Not currently supported           |

## Connection Settings

| Setting  | Required | Description                                                                        |
| -------- | -------- | ---------------------------------------------------------------------------------- |
| API Key  | Yes      | Your Anthropic API key from [console.anthropic.com](https://console.anthropic.com) |
| Endpoint | No       | Custom endpoint URL (defaults to `https://api.anthropic.com`)                      |

### Getting an API Key

1. Sign up at [console.anthropic.com](https://console.anthropic.com)
2. Navigate to **API Keys**
3. Click **Create Key**
4. Copy the key (it won't be shown again)

{% hint style="warning" %}
Keep your API key secure. Never commit it to source control or expose it in client-side code.
{% endhint %}

## Available Models

| Model                        | Context Window | Best For                               |
| ---------------------------- | -------------- | -------------------------------------- |
| `claude-sonnet-4-20250514`   | 200K           | Best balance of speed and intelligence |
| `claude-opus-4-20250514`     | 200K           | Most capable, complex tasks            |
| `claude-3-5-sonnet-20241022` | 200K           | Previous generation, stable            |
| `claude-3-opus-20240229`     | 200K           | Previous generation, complex reasoning |
| `claude-3-sonnet-20240229`   | 200K           | Previous generation, general purpose   |
| `claude-3-haiku-20240307`    | 200K           | Fastest, most cost-effective           |

{% hint style="info" %}
Claude's 200K token context window is ideal for processing long documents, extensive conversation history, or large codebases.
{% endhint %}

## Creating a Connection

### Via Backoffice

1. Navigate to the **AI** section > **Connections**
2. Click **Create Connection**
3. Select **Anthropic** as the provider
4. Enter your API key
5. Save the connection

### Via Code

{% code title="CreateAnthropicConnection.cs" %}

```csharp
var connection = new AIConnection
{
    Alias = "anthropic-production",
    Name = "Anthropic Production",
    ProviderId = "anthropic",
    Settings = new AnthropicProviderSettings
    {
        ApiKey = "sk-ant-..."
    }
};

await _connectionService.SaveConnectionAsync(connection);
```

{% endcode %}

## Creating a Profile

{% code title="AnthropicChatProfile.cs" %}

```csharp
var profile = new AIProfile
{
    Alias = "claude-assistant",
    Name = "Claude Assistant",
    Capability = AICapability.Chat,
    ConnectionId = connectionId,
    Model = new AIModelRef("anthropic", "claude-sonnet-4-20250514"),
    Settings = new AIChatProfileSettings
    {
        Temperature = 0.7f,
        MaxTokens = 4096,
        SystemPromptTemplate = "You are a helpful assistant."
    }
};

await _profileService.SaveProfileAsync(profile);
```

{% endcode %}

## Claude-Specific Features

### Long Context Processing

Claude handles processing long documents. The 200K context window allows:

- Analyzing complete documents (books, reports, legal documents)
- Maintaining extensive conversation history
- Processing large codebases for code review

{% code title="LongContextChat.cs" %}

```csharp
// Claude can handle very long inputs
var messages = new List<ChatMessage>
{
    new ChatMessage(ChatRole.User, fullDocumentContent) // Up to ~150K tokens
};

var response = await _chatService.GetChatResponseAsync(profileId, messages);
```

{% endcode %}

### System Prompts

Claude responds well to detailed system prompts:

{% code title="SystemPromptProfile.cs" %}

```csharp
var profile = new AIProfile
{
    // ...
    Settings = new AIChatProfileSettings
    {
        SystemPromptTemplate = @"You are a technical documentation writer.

Guidelines:
- Use clear, concise language
- Include code examples where appropriate
- Structure content with headings
- Avoid jargon unless necessary"
    }
};
```

{% endcode %}

## Pricing Considerations

Anthropic uses pay-per-token pricing:

| Model             | Input (1M tokens) | Output (1M tokens) |
| ----------------- | ----------------- | ------------------ |
| Claude Sonnet 4   | ~$3.00            | ~$15.00            |
| Claude Opus 4     | ~$15.00           | ~$75.00            |
| Claude 3.5 Sonnet | ~$3.00            | ~$15.00            |
| Claude 3 Haiku    | ~$0.25            | ~$1.25             |

{% hint style="info" %}
Prices are approximate and subject to change. Check [Anthropic pricing](https://www.anthropic.com/pricing) for current rates.
{% endhint %}

## Troubleshooting

### Invalid API Key

{% code title="Error" %}
```
Error: Invalid API key
```
{% endcode %}

Verify your API key starts with `sk-ant-` and hasn't been revoked.

### Rate Limits

{% code title="Error" %}
```
Error: Rate limit exceeded
```
{% endcode %}

Anthropic has rate limits based on your account tier. Consider:

- Implementing retry logic with exponential backoff
- Requesting a rate limit increase
- Using Claude 3 Haiku for high-volume tasks

### Context Length Exceeded

{% code title="Error" %}
```
Error: Request too large
```
{% endcode %}

Even with 200K context, very large requests can exceed limits. Consider:

- Summarizing or chunking long documents
- Using RAG to retrieve only relevant portions

## Related

- [Providers Overview](README.md) - Compare all providers
- [Connections](../concepts/connections.md) - Managing credentials
- [Profiles](../concepts/profiles.md) - Configuring models
