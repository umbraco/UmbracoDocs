---
description: Install the Umbraco AI Deploy add-on packages for environment-based deployment.
---

# Installation

This guide walks you through installing Umbraco.AI Deploy support.

## Prerequisites

Before installing Deploy support, ensure you have:

- Umbraco CMS 17.0 or later
- .NET 10.0 or later
- Umbraco.AI installed and configured
- Umbraco Deploy installed and configured

The Deploy packages pull in their matching Umbraco.AI packages as dependencies. `Umbraco.AI.Prompt.Deploy` requires `Umbraco.AI.Prompt`, and `Umbraco.AI.Agent.Deploy` requires `Umbraco.AI.Agent` — both are installed automatically when you add the Deploy package.

## Step 1: Install NuGet Packages

Install the Deploy packages you need:

{% code title="Terminal" %}

```bash
# Core Deploy support (required)
dotnet add package Umbraco.AI.Deploy

# Optional: Prompt deployment
dotnet add package Umbraco.AI.Prompt.Deploy

# Optional: Agent deployment
dotnet add package Umbraco.AI.Agent.Deploy
```

{% endcode %}

## Step 2: Build and Run

Build your project and run it:

{% code title="Terminal" %}

```bash
dotnet build
dotnet run
```

{% endcode %}

Deploy support is automatically registered and starts working immediately. No additional configuration is required unless you need to customize sensitive data filtering.

## Step 3: Verify Installation

To verify Deploy support is working:

1. Open the Umbraco backoffice
2. Navigate to **Settings → AI → Connections**
3. Create or edit a Connection
4. Save the Connection
5. Check your repository for a new file in `data/Revision/` (e.g., `umbraco-ai-connection__openai-production_abcd1234.uda`)

If you see the deployment file, Deploy support is working correctly.

## What Gets Installed

When you install the Deploy packages, you get:

- Automatic deployment file generation when saving AI entities
- Automatic deployment when pushing to other environments
- Dependency resolution (e.g., Profiles depend on Connections)
- Sensitive data filtering (API keys and secrets excluded by default)

## Troubleshooting

### No Deployment Files Generated

If deployment files aren't created when you save entities:

1. Verify Umbraco Deploy is installed and configured
2. Check that the Deploy packages are installed (check your `.csproj` file)
3. Rebuild and restart your application
4. Check the Umbraco logs for any Deploy-related errors

### Deployment Files Include Sensitive Data

If deployment files contain API keys or other sensitive data:

1. Use configuration references instead of hardcoded values (e.g., `$OpenAI:ApiKey`)
2. Configure sensitive data filtering in `appsettings.json` (see [Configuration](configuration.md))

## Next Steps

- [Configuration](configuration.md) - Configure sensitive data filtering
- [Deploying Entities](deploying-entities.md) - Deploy AI configuration between environments
- [Best Practices](best-practices.md) - Security and workflow recommendations
