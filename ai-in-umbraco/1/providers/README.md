---
description: >-
    Detailed configuration guides for each AI provider supported by Umbraco.AI.
---

# Providers

Umbraco.AI supports multiple AI providers through installable NuGet packages. Each provider connects to a different AI service and may support different capabilities.

## Available Providers

| Provider                                     | Package                       | Capabilities    | Best For                         |
| -------------------------------------------- | ----------------------------- | --------------- | -------------------------------- |
| [OpenAI](openai.md)                          | `Umbraco.AI.OpenAI`           | Chat, Embedding | General purpose, most models     |
| [Anthropic](anthropic.md)                    | `Umbraco.AI.Anthropic`        | Chat            | Claude models, long context      |
| [Google Gemini](google.md)                   | `Umbraco.AI.Google`           | Chat            | Gemini models, multimodal        |
| [Amazon Bedrock](amazon.md)                  | `Umbraco.AI.Amazon`           | Chat, Embedding | AWS integration, multiple models |
| [Microsoft AI Foundry](microsoft-foundry.md) | `Umbraco.AI.MicrosoftFoundry` | Chat, Embedding | Azure, enterprise compliance     |

## Choosing a Provider

Consider these factors when selecting a provider:

### Capabilities Needed

| Capability | OpenAI | Anthropic | Google | Amazon | MS Foundry |
| ---------- | ------ | --------- | ------ | ------ | ---------- |
| Chat       | Yes    | Yes       | Yes    | Yes    | Yes        |
| Embedding  | Yes    | No        | No     | Yes    | Yes        |

### Use Case Fit

| Use Case                   | Recommended Provider     |
| -------------------------- | ------------------------ |
| General content generation | OpenAI, Anthropic        |
| Code assistance            | OpenAI, Anthropic        |
| Long document processing   | Anthropic (200K context) |
| Semantic search/RAG        | OpenAI, Amazon Bedrock   |
| AWS infrastructure         | Amazon Bedrock           |
| Azure/Microsoft stack      | Microsoft AI Foundry     |
| Cost optimization          | Google (Gemini Flash)    |

### Enterprise Considerations

| Factor                 | OpenAI  | Anthropic | Google  | Amazon | MS Foundry |
| ---------------------- | ------- | --------- | ------- | ------ | ---------- |
| Data residency options | Limited | No        | Yes     | Yes    | Yes        |
| SOC 2 compliance       | Yes     | Yes       | Yes     | Yes    | Yes        |
| HIPAA eligible         | Yes     | Contact   | Contact | Yes    | Yes        |
| Self-hosted option     | No      | No        | No      | No     | No         |

## Installing Multiple Providers

You can install multiple providers simultaneously. Each provider registers independently and becomes available in the connection dropdown.

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.OpenAI
Install-Package Umbraco.AI.Anthropic
Install-Package Umbraco.AI.Google
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.OpenAI
dotnet add package Umbraco.AI.Anthropic
dotnet add package Umbraco.AI.Google
```

{% endcode %}

## Provider Configuration Pattern

All providers follow the same pattern:

1. **Install the package** - NuGet package for the provider
2. **Create a connection** - Provide API credentials
3. **Create a profile** - Select model and configure settings
4. **Use the profile** - Reference in code or prompts

```
┌──────────────┐      ┌──────────────┐     ┌──────────────┐
│   Provider   │────▶│  Connection  │────▶│   Profile    │
│   (NuGet)    │      │  (API Key)   │     │   (Model)    │
└──────────────┘      └──────────────┘     └──────────────┘
```

## Custom Providers

If your AI service isn't supported, you can create a custom provider. See [Creating Custom Providers](../extending/providers/README.md).

## Related

- [Connections](../concepts/connections.md) - Store provider credentials
- [Profiles](../concepts/profiles.md) - Configure models for use
- [Capabilities](../concepts/capabilities.md) - What operations providers support
