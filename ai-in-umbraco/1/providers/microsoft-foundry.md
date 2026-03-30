---
description: >-
    Configure Microsoft AI Foundry as an AI provider for chat and embedding capabilities.
---

# Microsoft AI Foundry

Microsoft AI Foundry (formerly Azure AI Studio) provides a unified endpoint for accessing multiple AI models within the Azure ecosystem. It includes enterprise compliance and security features.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.MicrosoftFoundry
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.MicrosoftFoundry
```

{% endcode %}

## Capabilities

| Capability | Supported | Description                     |
| ---------- | --------- | ------------------------------- |
| Chat       | Yes       | GPT, Phi, Llama, Mistral models |
| Embedding  | Yes       | Azure OpenAI embeddings         |

## Connection Settings

The provider supports two authentication methods: **Entra ID** (recommended) and **API Key** (legacy).

### Entra ID Authentication (Recommended)

| Setting        | Required | Description                                              |
| -------------- | -------- | -------------------------------------------------------- |
| Endpoint       | Yes      | Your AI Foundry endpoint URL                             |
| Project Name   | No       | AI Foundry project name (enables deployed model listing) |
| Tenant ID      | No       | Microsoft Entra ID tenant ID                             |
| Client ID      | No       | Service principal application (client) ID                |
| Client Secret  | No       | Service principal secret                                 |

Entra ID supports two modes:

- **Service Principal** - Provide Tenant ID, Client ID, and Client Secret for explicit credentials
- **Managed Identity** - Provide only Tenant ID (or leave all Microsoft Entra ID fields empty) to use `DefaultAzureCredential`. This supports managed identities, Azure CLI, and other automatic credential sources

{% hint style="info" %}
When using Microsoft Entra ID with a Project Name, the model picker shows only models deployed in your project. It does not display the full catalog.
{% endhint %}

### API Key Authentication (Legacy)

| Setting  | Required | Description                  |
| -------- | -------- | ---------------------------- |
| Endpoint | Yes      | Your AI Foundry endpoint URL |
| API Key  | Yes      | Your AI Foundry API key      |

### Getting Your Credentials

#### For Entra ID

1. Sign in to [Azure AI Studio](https://ai.azure.com)
2. Open your AI project
3. Copy the **Project Name** and **Endpoint** from the project overview
4. Create a service principal in **Microsoft Entra ID** > **App registrations**
5. Grant the **Azure AI Developer** role to the service principal on your AI Hub resource

#### For API Key

1. Sign in to [Azure AI Studio](https://ai.azure.com)
2. Open your AI project
3. Navigate to **Deployments**
4. Select your deployment
5. Copy the **Target URI** (endpoint) and **Key**

{% hint style="warning" %}
Keep credentials secure. Never commit API keys or client secrets to source control.
{% endhint %}

## Available Models

Microsoft AI Foundry provides access to models from multiple providers. All models are available through a single endpoint:

### Chat Models

| Model Family  | Example Models                | Notes                             |
| ------------- | ----------------------------- | --------------------------------- |
| Azure OpenAI  | GPT-4o, GPT-4, GPT-3.5-turbo  | Microsoft-hosted OpenAI           |
| Microsoft Phi | Phi-3-medium, Phi-3-mini      | Microsoft's small language models |
| Meta Llama    | Llama-3.1-405B, Llama-3.1-70B | Open source, hosted on Azure      |
| Mistral       | Mistral Large, Mistral Small  | Open source, Azure-hosted         |

### Embedding Models

| Model                  | Dimensions | Notes                   |
| ---------------------- | ---------- | ----------------------- |
| text-embedding-ada-002 | 1536       | Azure OpenAI embeddings |
| text-embedding-3-small | 1536       | Latest Azure OpenAI     |
| text-embedding-3-large | 3072       | Highest quality         |

{% hint style="info" %}
Available models depend on your Azure subscription, region, and deployed models in AI Foundry.
{% endhint %}

## Creating a Connection

### Via Backoffice

1. Navigate to the **AI** section > **Connections**
2. Click **Create Connection**
3. Select **Microsoft AI Foundry** as the provider
4. Enter your endpoint URL and API key
5. Save the connection

![Microsoft AI Foundry connection detail showing endpoint and authentication fields](../.gitbook/assets/microsoft-foundry-create-connection.png)

### Via Code (Entra ID)

{% code title="CreateFoundryConnectionEntraID.cs" %}

```csharp
var connection = new AIConnection
{
    Alias = "ai-foundry-production",
    Name = "AI Foundry Production",
    ProviderId = "microsoft-foundry",
    Settings = new MicrosoftFoundryProviderSettings
    {
        Endpoint = "https://your-project.region.inference.ml.azure.com",
        ProjectName = "my-ai-project",
        TenantId = "your-tenant-id",
        ClientId = "your-client-id",
        ClientSecret = "your-client-secret"
    }
};

await _connectionService.SaveConnectionAsync(connection);
```

{% endcode %}

### Via Code (API Key)

{% code title="CreateFoundryConnectionApiKey.cs" %}

```csharp
var connection = new AIConnection
{
    Alias = "ai-foundry-legacy",
    Name = "AI Foundry (API Key)",
    ProviderId = "microsoft-foundry",
    Settings = new MicrosoftFoundryProviderSettings
    {
        Endpoint = "https://your-project.region.inference.ml.azure.com",
        ApiKey = "..."
    }
};

await _connectionService.SaveConnectionAsync(connection);
```

{% endcode %}

## Creating Profiles

### Chat Profile

{% code title="FoundryChatProfile.cs" %}

```csharp
var profile = new AIProfile
{
    Alias = "foundry-assistant",
    Name = "AI Foundry Assistant",
    Capability = AICapability.Chat,
    ConnectionId = connectionId,
    Model = new AIModelRef("microsoft-foundry", "gpt-4o"),
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

### Embedding Profile

{% code title="FoundryEmbeddingProfile.cs" %}

```csharp
var profile = new AIProfile
{
    Alias = "foundry-embeddings",
    Name = "AI Foundry Embeddings",
    Capability = AICapability.Embedding,
    ConnectionId = connectionId,
    Model = new AIModelRef("microsoft-foundry", "text-embedding-ada-002")
};

await _profileService.SaveProfileAsync(profile);
```

{% endcode %}

## Advanced Settings

### Responses API

The provider supports an opt-in **Responses API** mode. It is available in select Azure regions (East US, East US 2, West US, West US 3, UK South, Sweden Central).

To enable, set `UseResponsesApi = true` in the connection settings. This uses the newer OpenAI Responses API instead of the default Chat Completions API.

{% hint style="info" %}
The Responses API is experimental and only applies to chat capabilities. Embedding requests always use the standard API.
{% endhint %}

## Enterprise Features

### Data Residency

Microsoft AI Foundry provides regional deployments for data residency requirements:

- Deploy models in specific Azure regions
- Data stays within your Azure tenant
- Compliant with regional data protection regulations

### Network Security

{% code title="PrivateEndpointConnection.cs" %}

```csharp
// Use private endpoints for enhanced security
var connection = new AIConnection
{
    // ...
    Settings = new MicrosoftFoundryProviderSettings
    {
        Endpoint = "https://your-private-endpoint.azure.com",
        ApiKey = "..."
    }
};
```

{% endcode %}

### Azure Integration

AI Foundry integrates with Azure services:

- **Microsoft Entra ID** - Service principal and managed identity authentication
- **Azure Key Vault** - Secure key storage
- **Azure Monitor** - Logging and diagnostics
- **Azure Policy** - Governance controls

## Setting Up in Azure

### 1. Create an AI Hub

1. Go to [Azure AI Studio](https://ai.azure.com)
2. Click **+ New hub**
3. Configure region and networking
4. Create the hub

### 2. Create a Project

1. Within your hub, click **+ New project**
2. Name your project
3. Configure settings

### 3. Deploy a Model

1. Go to **Model catalog**
2. Select a model
3. Click **Deploy**
4. Configure deployment settings
5. Copy the endpoint and key

## Pricing Considerations

Pricing depends on the model deployed:

| Model Type    | Pricing Model               |
| ------------- | --------------------------- |
| Azure OpenAI  | Pay-per-token               |
| Phi models    | Pay-per-token (lower cost)  |
| Llama/Mistral | Pay-per-token or throughput |

{% hint style="info" %}
Check [Azure AI pricing](https://azure.microsoft.com/pricing/details/machine-learning/) for current rates.
{% endhint %}

## Troubleshooting

### Authentication Failed

{% code title="Error" %}
```
Error: 401 Unauthorized
```
{% endcode %}

For API Key:

- Verify the API key is correct
- Check the key has not expired or been rotated
- Ensure the endpoint URL matches your deployment

For Microsoft Entra ID:

- Verify Tenant ID, Client ID, and Client Secret are correct
- Ensure the service principal has the **Azure AI Developer** role on the AI Hub resource
- Check that the service principal has not expired

### Model Not Found

{% code title="Error" %}
```
Error: Model deployment not found
```
{% endcode %}

Ensure:

- The model name matches your deployment name
- The deployment is active
- You're connecting to the correct project

### Network Errors

{% code title="Error" %}
```
Error: Connection refused
```
{% endcode %}

Check:

- Endpoint URL is correct
- Network allows outbound connections
- Private endpoint configuration (if applicable)

## Related

- [Providers Overview](README.md) - Compare all providers
- [Connections](../concepts/connections.md) - Managing credentials
- [Profiles](../concepts/profiles.md) - Configuring models
