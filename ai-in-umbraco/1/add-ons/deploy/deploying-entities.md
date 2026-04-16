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
- Capability (Chat, Embedding, or SpeechToText)
- Model provider ID and model ID
- Capability-specific settings
- Connection reference (UDI)
- Tags

**Dependencies:**
- Automatically deploys the referenced Connection first
- For chat profiles, any referenced Guardrails are deployed first

### Contexts

When you save a Context, Deploy creates a file like:

```
data/Revision/umbraco-ai-context__brand-voice_abcd1234.uda
```

**Contains:**
- Context name and alias
- Context resources (serialized as JSON)

### Guardrails

When you save a Guardrail, Deploy creates a file like:

```
data/Revision/umbraco-ai-guardrail__safety-checks_abcd1234.uda
```

**Contains:**
- Guardrail name and alias
- Rules (serialized as JSON)

### Settings

AI Settings is a singleton entity. When saved, Deploy creates a file like:

```
data/Revision/umbraco-ai-settings__ai-settings_abcd1234.uda
```

**Contains:**
- Default chat profile reference (optional)
- Default embedding profile reference (optional)
- Classifier chat profile reference (optional)

**Dependencies:**
- Any referenced profiles are deployed first

### Prompts (Requires Umbraco.AI.Prompt.Deploy)

When you save a Prompt, Deploy creates a file like:

```
data/Revision/umbraco-ai-prompt__article-summarizer_abcd1234.uda
```

**Contains:**
- Prompt name, alias, and description
- Instructions (template content, may include `{{placeholders}}`)
- Profile reference (if specified)
- Context IDs and Guardrail IDs
- Scoping rules
- Option count, IncludeEntityContext flag, IsActive flag
- Tags

**Dependencies:**
- If linked to a Profile, deploys the Profile first
- Any referenced Guardrails are deployed first

### Agents (Requires Umbraco.AI.Agent.Deploy)

When you save an Agent, Deploy creates a file like:

```
data/Revision/umbraco-ai-agent__content-helper_abcd1234.uda
```

**Contains:**
- Agent name, alias, description, and agent type (`Standard` or `Orchestrated`)
- Type-specific configuration (serialized as JSON):
  - **Standard agents**: Instructions, allowed tool IDs, allowed tool scope IDs, context IDs, per-user-group permission overrides, optional output schema
  - **Orchestrated agents**: Workflow ID and workflow-specific settings
- Surface IDs and scoping rules
- Guardrail IDs
- Profile reference (if specified)
- IsActive flag

**Dependencies:**
- If linked to a Profile, deploys the Profile first
- Any referenced Guardrails are deployed first

{% hint style="warning" %}
For **orchestrated agents**, the workflow implementation must be registered in the target environment. Deploy transfers the workflow ID and settings, but the workflow code itself must be deployed as part of the application.
{% endhint %}

{% hint style="info" %}
Standard agent `UserGroupPermissions` are keyed by user group GUID. Referenced user groups must exist in the target environment with matching GUIDs. These are not added as explicit Deploy dependencies, so ensure user groups are deployed before agents that reference them.
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

1. **Connections, Contexts, Guardrails** (no dependencies on other AI entities)
2. **Profiles** (depend on Connections, plus any referenced Guardrails)
3. **Prompts, Agents, Settings** (optionally depend on Profiles, plus any referenced Guardrails)

If you deploy a Profile, Deploy ensures its Connection is deployed first. If you deploy an Agent or Prompt, Deploy ensures its Profile (and the Profile's Connection) are deployed first.

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

### User Group Permissions Missing on Agents

Standard agent `UserGroupPermissions` are keyed by user group GUID but are not tracked as explicit Deploy dependencies. If an agent's user group permissions appear empty or incorrect after deployment:

1. Ensure referenced user groups exist in the target environment
2. Confirm user groups have the same GUIDs across environments
3. Deploy user groups before deploying Agents that reference them

## Next Steps

- [Best Practices](best-practices.md) - Security and workflow recommendations
- [Configuration](configuration.md) - Configure sensitive data filtering
