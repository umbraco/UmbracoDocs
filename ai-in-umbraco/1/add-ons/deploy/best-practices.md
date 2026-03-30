---
description: >-
  Security, workflow, and configuration best practices for deploying AI entities across environments.
---

# Best Practices

Follow these best practices to safely and effectively deploy AI configuration across environments.

## Security Best Practices

### 1. Always Use Configuration References

**Never hardcode API keys or secrets in the backoffice.**

❌ **Bad:**
```
API Key: sk-prod-abc123def456...
```

✅ **Good:**
```
API Key: $OpenAI:ApiKey
```

Configuration references ensure secrets stay in configuration files, not in version control.

### 2. Separate Configuration by Environment

Use environment-specific configuration files:

```
appsettings.json                  # Shared settings
appsettings.Development.json      # Dev secrets
appsettings.Staging.json          # Staging secrets
appsettings.Production.json       # Production secrets (not in git)
```

**Never commit production secrets to version control.**

### 3. Use Secret Management for Production

For production environments, use a secret management solution:

- **Azure Key Vault** - For Azure deployments
- **AWS Secrets Manager** - For AWS deployments
- **Environment Variables** - For container deployments
- **Kubernetes Secrets** - For Kubernetes deployments

Example with Azure Key Vault:

```json
{
  "OpenAI": {
    "ApiKey": "$KeyVault:OpenAI:ApiKey"
  }
}
```

### 4. Review Deployment Files Before Committing

Before committing `.uda` files, review them to ensure:

- No API keys or secrets are present
- Configuration references use `$` syntax
- Sensitive fields are filtered

```bash
# Review changes before committing
git diff data/Revision/

# Check for accidental API keys
grep -r "sk-" data/Revision/
grep -r "API" data/Revision/
```

### 5. Use .gitignore for Local Overrides

If you need local configuration overrides, use `.gitignore`:

```gitignore
# Local settings (not committed)
appsettings.Local.json
appsettings.*.Local.json
```

## Workflow Best Practices

### 1. Test in Development First

Always test AI configuration in development before deploying:

1. Create/edit entities in development
2. Test the configuration works
3. Commit deployment files
4. Deploy to staging
5. Test in staging
6. Deploy to production

### 2. Use Descriptive Names and Aliases

Use clear, descriptive names for entities:

❌ **Bad:**
- Name: "Conn1"
- Alias: "c1"

✅ **Good:**
- Name: "OpenAI Production"
- Alias: "openai-production"

Descriptive names make deployment files easier to understand and troubleshoot.

### 3. Version Control Everything

Commit all deployment files to version control:

```bash
# Commit all AI deployment files
git add data/Revision/umbraco-ai-*
git commit -m "feat(ai): Add chat assistant configuration"
```

Version-controlled deployment files keep all environments in sync.

### 4. Deploy Dependencies First

When deploying related entities, deploy in this order:

1. Connections
2. Profiles
3. Prompts/Agents

While Deploy handles dependencies automatically, deploying in this order makes troubleshooting easier.

### 5. Use Feature Branches

Use feature branches for AI configuration changes:

```bash
# Create feature branch
git checkout -b feature/add-chat-assistant

# Make changes in backoffice
# Commit deployment files
git add data/Revision/
git commit -m "feat(ai): Add chat assistant profile"

# Push and create PR
git push origin feature/add-chat-assistant
```

Feature branches allow peer review before deploying to production.

## Configuration Best Practices

### 1. Group Related Settings

Organize configuration by provider and environment:

```json
{
  "OpenAI": {
    "ApiKey": "sk-dev-abc123...",
    "Organization": "org-123"
  },
  "Anthropic": {
    "ApiKey": "sk-ant-dev-xyz789..."
  }
}
```

### 2. Use Consistent Key Paths

Use consistent configuration key paths across providers:

✅ **Good:**
```json
{
  "OpenAI": { "ApiKey": "..." },
  "Anthropic": { "ApiKey": "..." },
  "Google": { "ApiKey": "..." }
}
```

❌ **Bad:**
```json
{
  "OpenAI": { "Key": "..." },
  "Anthropic": { "ApiKey": "..." },
  "Google": { "API_KEY": "..." }
}
```

### 3. Document Configuration Keys

Add comments to configuration files (where supported):

```jsonc
{
  // OpenAI configuration
  // Get API key from: https://platform.openai.com/api-keys
  "OpenAI": {
    "ApiKey": "$KeyVault:OpenAI:ApiKey"
  }
}
```

### 4. Validate Configuration References

After deployment, verify configuration references resolve correctly:

1. Open the entity in the target environment
2. Check that settings display correctly
3. Test the functionality (e.g., send a test message)

## Team Collaboration Best Practices

### 1. Coordinate AI Configuration Changes

When multiple team members work on AI configuration:

- Communicate changes in team chat/standup
- Use pull requests for review
- Avoid simultaneous edits to the same entities

### 2. Document AI Configuration

Maintain documentation of your AI configuration:

```markdown
# AI Configuration

## Connections

### OpenAI Production
- **Purpose:** Production chat and embeddings
- **Model:** gpt-4o
- **Configuration:** `$OpenAI:ApiKey`

## Profiles

### Chat Assistant
- **Purpose:** General-purpose chat assistant
- **Connection:** OpenAI Production
- **Model:** gpt-4o
- **Temperature:** 0.7
```

### 3. Review Deployment Files in Pull Requests

When reviewing PRs that include `.uda` files:

- Verify no secrets are present
- Check configuration references are correct
- Ensure entity names/aliases are descriptive
- Validate dependencies are included

### 4. Test After Deployment

After deploying to an environment:

1. Verify entities appear in backoffice
2. Test functionality works as expected
3. Check logs for any errors

## Monitoring Best Practices

### 1. Monitor Deployment Logs

Check Umbraco logs after deployment:

```bash
# Check for deployment errors
tail -f App_Data/Logs/umbraco-*.txt | grep -i "deploy"
```

### 2. Monitor API Usage

Monitor AI provider API usage to detect issues:

- Unexpected API calls
- Failed authentication
- Rate limit errors

### 3. Set Up Alerts

Configure alerts for:

- Deployment failures
- AI API errors
- High API usage/costs
- Rate limit warnings

## Troubleshooting Best Practices

### 1. Check Deployment Files First

When troubleshooting deployment issues:

1. Check the `.uda` file exists
2. Verify the file content is correct
3. Ensure configuration references are valid

### 2. Compare Across Environments

Compare configuration between working and non-working environments:

```bash
# Compare deployment files
diff data/Revision/umbraco-ai-connection__*.uda
```

### 3. Check Logs

Always check logs when troubleshooting:

- Umbraco logs (`App_Data/Logs/`)
- Deploy logs (if available)
- Application logs

### 4. Test Configuration References

Test that configuration references resolve:

{% code title="Terminal" %}

```bash
# .NET console test
dotnet run --project ConfigTest
```

{% endcode %}

{% code title="ConfigTest/Program.cs" %}

```csharp
var builder = WebApplication.CreateBuilder(args);
var apiKey = builder.Configuration["OpenAI:ApiKey"];
Console.WriteLine($"OpenAI API Key: {apiKey}");
```

{% endcode %}

## Summary Checklist

Before deploying AI configuration to production:

- [ ] All API keys use configuration references (`$...`)
- [ ] Configuration files are correct in target environment
- [ ] Deployment files reviewed (no secrets present)
- [ ] Dependencies are included (Connections before Profiles)
- [ ] Tested in development and staging
- [ ] Pull request reviewed by team
- [ ] Documentation updated
- [ ] Monitoring/alerts configured

Following these best practices ensures safe, reliable deployment of AI configuration across all environments.
