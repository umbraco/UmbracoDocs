---
description: >-
  Configure sensitive data filtering and deployment settings for Umbraco AI Deploy.
---

# Configuration

Deploy support provides configuration options to control how sensitive data is handled during deployment.

## Default Behavior

By default, Deploy:

- **Excludes encrypted values** - Values starting with `ENC:` are not deployed
- **Allows configuration references** - Values starting with `$` (e.g., `$OpenAI:ApiKey`) are deployed
- **Allows sensitive fields** - Fields marked as sensitive can be deployed if they use configuration references

Encrypted values stay safe while configuration references for sensitive fields are still deployed.

## Configuration Settings

Add these settings to your `appsettings.json`:

{% code title="appsettings.json" %}

```json
{
  "Umbraco": {
    "AI": {
      "Deploy": {
        "Connections": {
          "IgnoreEncrypted": true,
          "IgnoreSensitive": false,
          "IgnoreSettings": []
        }
      }
    }
  }
}
```

{% endcode %}

### IgnoreEncrypted

**Default:** `true`

When `true`, blocks encrypted values (starting with `ENC:`) from being deployed, but allows configuration references (starting with `$`).

```json
"IgnoreEncrypted": true
```

**Example behavior:**

| Value in Database | Deployed? |
|-------------------|-----------|
| `$OpenAI:ApiKey` | ✅ Yes (configuration reference) |
| `ENC:abc123...` | ❌ No (encrypted value) |
| `https://api.openai.com` | ✅ Yes (plain value) |

**When to set to `false`:** Only if you need to deploy encrypted values. This is rarely needed and not recommended.

### IgnoreSensitive

**Default:** `false`

When `true`, blocks all values from fields marked as sensitive by providers, even configuration references.

```json
"IgnoreSensitive": false
```

**Example behavior (when `false`):**

For a field marked as sensitive (e.g., `ApiKey`):

| Value in Database | Deployed? |
|-------------------|-----------|
| `$OpenAI:ApiKey` | ✅ Yes (configuration reference allowed) |
| `ENC:abc123...` | ❌ No (blocked by IgnoreEncrypted) |
| `sk-abc123...` | ✅ Yes (plain value allowed - not recommended) |

**When to set to `true`:** Only if you want to completely block sensitive fields from deployment, even configuration references. This is the most restrictive option.

### IgnoreSettings

**Default:** `[]` (empty array)

Specify individual setting field names to always block, regardless of other settings.

```json
"IgnoreSettings": ["ApiKey", "ClientSecret"]
```

The `IgnoreSettings` array provides fine-grained control over specific fields. Use it when you want to block specific fields but allow others.

## Filtering Priority

When Deploy evaluates whether to include a setting value, it checks in this order:

1. **IgnoreSettings** - If the field name is in this array, block it (highest priority)
2. **IgnoreSensitive** - If `true` and field is marked sensitive, block it
3. **IgnoreEncrypted** - If `true` and value starts with `ENC:`, block it
4. **Allow** - Otherwise, include the value in deployment

## Recommended Configurations

### Balanced Security (Default)

Blocks encrypted values but allows configuration references for sensitive fields:

{% code title="appsettings.json" %}

```json
{
  "Connections": {
    "IgnoreEncrypted": true,
    "IgnoreSensitive": false,
    "IgnoreSettings": []
  }
}
```

{% endcode %}

**Use when:** You use configuration references for secrets and need to deploy them.

### Maximum Security

Blocks all sensitive fields entirely, even configuration references:

{% code title="appsettings.json" %}

```json
{
  "Connections": {
    "IgnoreEncrypted": true,
    "IgnoreSensitive": true,
    "IgnoreSettings": []
  }
}
```

{% endcode %}

**Use when:** You want absolute protection and manage sensitive fields outside of Deploy.

### Block Specific Fields Only

Block specific fields but allow everything else:

{% code title="appsettings.json" %}

```json
{
  "Connections": {
    "IgnoreEncrypted": true,
    "IgnoreSensitive": false,
    "IgnoreSettings": ["ApiKey", "ClientSecret", "PrivateKey"]
  }
}
```

{% endcode %}

**Use when:** You have specific fields that should never be deployed, but other fields are safe.

## Using Configuration References

To safely deploy API keys and secrets, use configuration references:

### 1. Store Secrets in appsettings.json

{% code title="appsettings.Development.json" %}

```json
{
  "OpenAI": {
    "ApiKey": "sk-dev-abc123..."
  }
}
```

{% endcode %}

{% code title="appsettings.Production.json" %}

```json
{
  "OpenAI": {
    "ApiKey": "sk-prod-xyz789..."
  }
}
```

{% endcode %}

### 2. Reference in Connection Settings

When creating a Connection in the backoffice, use `$` syntax:

- **API Key field:** `$OpenAI:ApiKey`

Deploy saves the reference in the deployment file. Each environment resolves the value from its own configuration.

### 3. Verify

Check the deployment file (`.uda`) to ensure it contains the reference, not the actual key:

```json
{
  "Settings": {
    "ApiKey": "$OpenAI:ApiKey"
  }
}
```

## Environment-Specific Secrets

Use environment-specific configuration files to manage secrets:

```
appsettings.json                  # Default/shared settings
appsettings.Development.json      # Dev API keys
appsettings.Staging.json          # Staging API keys
appsettings.Production.json       # Production API keys (not in version control)
```

**Important:** Never commit `appsettings.Production.json` to version control. Use Azure Key Vault, environment variables, or other secret management solutions for production secrets.

## Troubleshooting

### API Keys Appearing in Deployment Files

If you see actual API keys in `.uda` files:

1. Verify you're using `$` references, not hardcoded keys
2. Check that `IgnoreEncrypted` is `true` (default)
3. Ensure the field is marked as sensitive by the provider

### Configuration References Not Working

If `$` references aren't resolving in target environments:

1. Verify the configuration key exists in `appsettings.json`
2. Check the configuration key path matches exactly (case-sensitive)
3. Restart the application after changing `appsettings.json`

## Next Steps

- [Deploying Entities](deploying-entities.md) - Deploy AI configuration between environments
- [Best Practices](best-practices.md) - Security and workflow recommendations
