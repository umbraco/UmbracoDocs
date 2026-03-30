---
description: >-
  Deploy AI connections, profiles, prompts, and agents between environments using Umbraco Deploy.
---

# Deploying Entities

This guide walks you through deploying AI configuration between environments.

## Deployment Workflow

AI entities follow the same deployment workflow as Umbraco content types and other configuration:

1. **Create/Edit** - Make changes in the Umbraco backoffice
2. **Save** - Deploy automatically creates deployment files
3. **Commit** - Commit deployment files to version control
4. **Deploy** - Push to other environments (Umbraco Deploy handles the rest)

## What Gets Deployed

### Connections

When you save a Connection, Deploy creates a file like:

```
data/Revision/umbraco-ai-connection__openai-production_abcd1234.uda
```

**Contains:**
- Connection name and alias
- Provider ID
- Connection settings (with sensitive data filtered)
- Active status

**Environment resolution:**
- API keys resolve from each environment's `appsettings.json`
- Provider must be installed in target environment

### Profiles

When you save a Profile, Deploy creates a file like:

```
data/Revision/umbraco-ai-profile__chat-assistant_abcd1234.uda
```

**Contains:**
- Profile name and alias
- Model selection
- Chat/embedding settings
- Connection reference
- Tags

**Dependencies:**
- Automatically deploys the referenced Connection first

### Prompts (Requires Umbraco.AI.Prompt.Deploy)

When you save a Prompt, Deploy creates a file like:

```
data/Revision/umbraco-ai-prompt__article-summarizer_abcd1234.uda
```

**Contains:**
- Prompt name and alias
- Template content
- Scoping rules
- Profile reference (if specified)
- Tags

**Dependencies:**
- If linked to a Profile, deploys the Profile first

### Agents (Requires Umbraco.AI.Agent.Deploy)

When you save an Agent, Deploy creates a file like:

```
data/Revision/umbraco-ai-agent__content-helper_abcd1234.uda
```

**Contains:**
- Agent name, alias, and agent type (`Standard` or `Orchestrated`)
- Type-specific configuration:
  - **Standard agents**: Instructions, tool permissions, user group permissions, context IDs
  - **Orchestrated agents**: Workflow ID and workflow-specific settings
- Surface IDs and scoping rules
- Profile reference (if specified)

**Dependencies:**
- If linked to a Profile, deploys the Profile first

{% hint style="warning" %}
For **orchestrated agents**, the workflow implementation must be registered in the target environment. Deploy transfers the workflow ID and settings, but the workflow code itself must be deployed as part of the application.
{% endhint %}

## Step-by-Step: Deploying a Connection

### 1. Create Connection in Development

1. Open the Umbraco backoffice
2. Navigate to **Settings → AI → Connections**
3. Click **Create Connection**
4. Select provider (e.g., OpenAI)
5. Enter details:
   - **Name:** "OpenAI Production"
   - **Alias:** "openai-production"
   - **API Key:** `$OpenAI:ApiKey` (configuration reference)
   - **Organization ID:** (optional)
6. Click **Save**

### 2. Verify Deployment File

Check that the deployment file was created:

```bash
# File location (example)
data/Revision/umbraco-ai-connection__openai-production_abc123.uda
```

Open the file and verify it contains the configuration reference, not the actual API key:

```json
{
  "Settings": {
    "ApiKey": "$OpenAI:ApiKey"
  }
}
```

### 3. Commit to Version Control

```bash
git add data/Revision/umbraco-ai-connection__openai-production_*.uda
git commit -m "feat(ai): Add OpenAI production connection"
git push
```

### 4. Configure Target Environment

Before deploying, ensure the target environment has the configuration:

**appsettings.Production.json:**
```json
{
  "OpenAI": {
    "ApiKey": "sk-prod-xyz789..."
  }
}
```

### 5. Deploy to Target Environment

When you deploy to the target environment (via Umbraco Cloud, Azure DevOps, or other CI/CD):

1. Umbraco Deploy detects the new deployment file
2. Creates the Connection in the target environment
3. Resolves `$OpenAI:ApiKey` from the target's `appsettings.json`
4. Activates the Connection

## Step-by-Step: Deploying a Profile

### 1. Create Profile in Development

1. Navigate to **Settings → AI → Profiles**
2. Click **Create Profile**
3. Enter details:
   - **Name:** "Chat Assistant"
   - **Alias:** "chat-assistant"
   - **Connection:** Select "OpenAI Production"
   - **Model:** "gpt-4o"
   - **Temperature:** 0.7
4. Click **Save**

### 2. Verify Deployment Files

Check that both files exist:

```bash
# Profile deployment file
data/Revision/umbraco-ai-profile__chat-assistant_abc123.uda

# Connection deployment file (if not already committed)
data/Revision/umbraco-ai-connection__openai-production_def456.uda
```

### 3. Commit and Deploy

```bash
git add data/Revision/umbraco-ai-profile__chat-assistant_*.uda
git commit -m "feat(ai): Add chat assistant profile"
git push
```

When deployed, Umbraco Deploy:
1. Deploys the Connection first (if not already deployed)
2. Deploys the Profile
3. Links the Profile to the Connection

## Multi-Environment Example

Here's how the same configuration deploys to different environments:

### Development Environment

**appsettings.Development.json:**
```json
{
  "OpenAI": {
    "ApiKey": "sk-dev-abc123..."
  }
}
```

### Staging Environment

**appsettings.Staging.json:**
```json
{
  "OpenAI": {
    "ApiKey": "sk-staging-def456..."
  }
}
```

### Production Environment

**appsettings.Production.json:**
```json
{
  "OpenAI": {
    "ApiKey": "sk-prod-xyz789..."
  }
}
```

### Deployment File (Same for All Environments)

**umbraco-ai-connection__openai-production_abc123.uda:**
```json
{
  "Name": "OpenAI Production",
  "Alias": "openai-production",
  "ProviderId": "openai",
  "Settings": {
    "ApiKey": "$OpenAI:ApiKey"
  }
}
```

Each environment resolves `$OpenAI:ApiKey` from its own configuration, so the same deployment file works everywhere.

## Deployment Order

Deploy handles dependencies automatically, but it's helpful to understand the order:

1. **Connections** (no dependencies)
2. **Profiles** (depend on Connections)
3. **Prompts** (optionally depend on Profiles)
4. **Agents** (optionally depend on Profiles)

If you deploy a Profile, Deploy ensures its Connection is deployed first. If you deploy an Agent, Deploy ensures its Profile (and its Profile's Connection) are deployed first.

## Troubleshooting

### Deployment Fails: "Connection not found"

If deployment fails because a Connection doesn't exist:

1. Check that the Connection deployment file exists in `data/Revision/`
2. Verify the Connection file was committed to version control
3. Deploy the Connection before deploying Profiles/Prompts/Agents

### Deployment Fails: "Provider not found"

If deployment fails because a provider isn't found:

1. Ensure the provider package is installed in the target environment (e.g., `Umbraco.AI.OpenAI`)
2. Rebuild and restart the target environment

### API Keys Not Resolving

If the target environment doesn't resolve `$` references:

1. Verify the configuration key exists in `appsettings.json`
2. Check the configuration path matches exactly (case-sensitive)
3. Restart the application

### User Group Not Found (Agents)

If Agent deployment fails because a user group doesn't exist:

1. Ensure referenced user groups exist in the target environment
2. User groups must have the same GUIDs across environments
3. Deploy user groups before deploying Agents

## Next Steps

- [Best Practices](best-practices.md) - Security and workflow recommendations
- [Configuration](configuration.md) - Configure sensitive data filtering
