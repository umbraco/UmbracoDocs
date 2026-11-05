---
description: >-
  Configure how Umbraco AI Deploy handles sensitive connection settings such as API keys.
---

# Configuration

Deploy support provides configuration options to control which connection settings are written to deployment files.

## How Sensitive Settings Are Handled

Providers mark fields that hold secrets, such as API keys and client secrets, as sensitive (`[AIField(IsSensitive = true)]`). Deploy keeps the literal values of these fields out of deployment files:

- **Sensitive literal values are never deployed.** A key typed directly into a sensitive field stays on the environment where you entered it.
- **Configuration references are deployed.** A value such as `$Umbraco:AI:Secrets:OpenAIApiKey` only names a setting. Each environment resolves it from its own configuration.
- **Encrypted values are never deployed.** Values starting with `ENC:` can't be read on another environment, because each environment has its own encryption keys.

The same rules apply when Deploy reads a deployment file. A literal secret found in a deployment file is not imported, including from files written by earlier versions.

{% hint style="warning" %}

Deployment files written by earlier versions of Umbraco AI Deploy may contain literal API keys. Those keys remain in your source control history.

Revoke any key that was stored as a literal value with its provider. Then create a new key and enter it on each environment, ideally as a configuration reference.

{% endhint %}

### When a Deployed Connection Has No Value for a Secret

The target environment keeps its own value for any sensitive field the deployment file doesn't carry. Deploying never clears a key that is already set on the target.

When a connection arrives without a value for a required secret, and the target has no value either, Deploy still imports it. The connection is imported as inactive. It stays inactive on later deployments until you set the value.

To use the connection, enter the secret on that environment and activate the connection.

Sensitive fields in profile capability settings, guardrail rules, and context resources follow the same rules. The settings below apply to connections only.

## Configuration Settings

Add these settings to your `appsettings.json`:

{% code title="appsettings.json" %}

```json
{
  "Umbraco": {
    "AI": {
      "Deploy": {
        "Connections": {
          "IgnoreSettings": [],
          "IncludeSensitiveSettings": []
        }
      }
    }
  }
}
```

{% endcode %}

### IgnoreSettings

**Default:** `[]` (empty array)

Specify connection setting names that are never deployed, whatever their value. Configuration references are excluded too. Names are matched case-insensitively.

```json
"IgnoreSettings": ["endpoint"]
```

`IgnoreSettings` takes precedence over `IncludeSensitiveSettings`.

### IncludeSensitiveSettings

**Default:** `[]` (empty array)

Specify sensitive connection setting names whose literal values may be deployed. Names are matched case-insensitively.

```json
"IncludeSensitiveSettings": ["apiKey"]
```

{% hint style="danger" %}

Literal values of the fields listed here are written in plain text to the deployment file, and so to source control. Use a configuration reference instead wherever possible.

{% endhint %}

### Obsolete Settings

`IgnoreEncrypted` and `IgnoreSensitive` are obsolete and have no effect. Encrypted values and sensitive literal values are never deployed. Use `IncludeSensitiveSettings` to opt specific sensitive fields in.

## Filtering Order

When Deploy evaluates whether to include a connection setting value, it checks in this order:

1. **IgnoreSettings** - If the field name is listed, exclude the value.
2. **Encrypted values** - If the value starts with `ENC:`, exclude the value.
3. **Sensitive fields** - If the field is sensitive, include the value only when it's a configuration reference or the field is listed in `IncludeSensitiveSettings`.
4. **Other fields** - Include the value.

A value starting with `$$` is a literal that begins with `$`, not a configuration reference.

## Using Configuration References

To safely deploy API keys and secrets, use configuration references:

### 1. Store Secrets in appsettings.json

{% code title="appsettings.Development.json" %}

```json
{
  "Umbraco": {
    "AI": {
      "Secrets": {
        "OpenAIApiKey": "sk-dev-abc123..."
      }
    }
  }
}
```

{% endcode %}

{% code title="appsettings.Production.json" %}

```json
{
  "Umbraco": {
    "AI": {
      "Secrets": {
        "OpenAIApiKey": "sk-prod-xyz789..."
      }
    }
  }
}
```

{% endcode %}

### 2. Reference in Connection Settings

When creating a Connection in the backoffice, use `$` syntax:

- **API Key field:** `$Umbraco:AI:Secrets:OpenAIApiKey`

Deploy saves the reference in the deployment file. Each environment resolves the value from its own configuration.

### 3. Verify

Check the deployment file (`.uda`) to ensure it contains the reference, not the actual key:

```json
{
  "Settings": {
    "apiKey": "$Umbraco:AI:Secrets:OpenAIApiKey"
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

Sensitive literal values are not written to deployment files. If you see an API key in a `.uda` file:

1. Check whether the field is listed in `IncludeSensitiveSettings`.
2. Check whether the file was written by an earlier version. Saving the connection rewrites the file.
3. Check that the provider marks the field as sensitive.

### Connection Is Inactive After Deployment

A connection is imported as inactive when the target environment has no value for one of its required secrets. Enter the secret on that environment, then activate the connection.

### Configuration References Not Working

If `$` references aren't resolving in target environments:

1. Verify the configuration key exists in `appsettings.json`
2. Check the configuration key path matches exactly (case-sensitive)
3. Restart the application after changing `appsettings.json`

## Next Steps

- [Deploying Entities](deploying-entities.md) - Deploy AI configuration between environments
- [Best Practices](best-practices.md) - Security and workflow recommendations
