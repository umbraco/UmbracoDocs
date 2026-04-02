---
description: >-
  Deploy Umbraco AI entities like connections, profiles, and prompts between environments.
---

# Deploy Support

Deploy support enables you to version control and deploy your Umbraco.AI configuration across environments (development, staging, production).

## What Gets Deployed

With Deploy support installed, these AI entities are automatically deployed:

- **Connections** - API keys and provider settings
- **Profiles** - Model configurations and chat settings
- **Prompts** - Template content and scoping rules (requires Umbraco.AI.Prompt.Deploy)
- **Agents** - Instructions, tools, and permissions (requires Umbraco.AI.Agent.Deploy)

## How It Works

When you save an AI entity in the Umbraco backoffice, Deploy automatically:

1. Creates a deployment file in your repository (e.g., `data/Revision/umbraco-ai-connection__*.uda`)
2. Commits the file to version control alongside your code
3. Deploys the configuration when you push to other environments

Your AI configuration follows the same deployment workflow as your content types and other Umbraco configuration.

## Packages

| Package | Purpose |
|---------|---------|
| **Umbraco.AI.Deploy** | Core Deploy support for Connections and Profiles |
| **Umbraco.AI.Prompt.Deploy** | Deploy support for Prompt templates |
| **Umbraco.AI.Agent.Deploy** | Deploy support for AI Agents |

## Installation

Install the packages you need via NuGet:

{% code title="Terminal" %}

```bash
# Core (required)
dotnet add package Umbraco.AI.Deploy

# Optional add-ons
dotnet add package Umbraco.AI.Prompt.Deploy
dotnet add package Umbraco.AI.Agent.Deploy
```

{% endcode %}

See [Installation](installation.md) for detailed setup instructions.

## Key Features

### Sensitive Data Protection

Deploy automatically filters sensitive data like API keys to prevent secrets from being committed to version control.

Use configuration references (e.g., `$OpenAI:ApiKey`) instead of hardcoded values to keep secrets safe. See [Configuration](configuration.md) for details.

### Dependency Resolution

Deploy automatically resolves dependencies between entities:

- Profiles depend on Connections
- Prompts can optionally depend on Profiles
- Agents can optionally depend on Profiles

If you deploy a Profile, Deploy ensures its Connection is deployed first.

### Multi-Environment Support

Deploy the same AI configuration to multiple environments:

- **Development** - Use test API keys from configuration
- **Staging** - Use staging API keys from configuration
- **Production** - Use production API keys from configuration

Each environment resolves configuration references from its own `appsettings.json`.

## Next Steps

- [Installation](installation.md) - Install Deploy packages
- [Configuration](configuration.md) - Configure sensitive data filtering
- [Deploying Entities](deploying-entities.md) - Deploy AI configuration between environments
- [Best Practices](best-practices.md) - Security and workflow recommendations
