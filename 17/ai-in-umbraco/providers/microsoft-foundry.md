---
description: >-
    Configure Microsoft AI Foundry as an AI provider for chat and embedding capabilities.
---

# Microsoft AI Foundry

Microsoft AI Foundry (formerly Azure AI Studio) provides a unified endpoint for accessing multiple AI models within the Azure ecosystem, supporting both Chat and Embedding capabilities.

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

### Advanced Settings

| Setting            | Required | Description                                                                                                          |
| ------------------ | -------- | -------------------------------------------------------------------------------------------------------------------- |
| Use Responses API  | No       | When enabled, uses the OpenAI Responses API instead of Chat Completions. Only available in certain Azure regions.    |

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

![Microsoft AI Foundry connection detail showing endpoint and authentication fields](../.gitbook/assets/microsoft-foundry-create-connection.png)

## Related

- [Providers Overview](README.md)
- [Managing Connections](../backoffice/managing-connections.md)
