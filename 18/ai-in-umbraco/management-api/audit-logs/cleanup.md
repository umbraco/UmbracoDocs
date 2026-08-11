---
description: >-
    Clean up old audit log entries.
---

# Cleanup Audit Logs

Removes audit log entries older than the configured retention period.

## Request

```http
POST /umbraco/ai/management/api/v1/audit-logs/cleanup
```

This endpoint does not accept a request body. The retention period is taken from the configured `Umbraco:AI:AuditLog:RetentionDays` setting.

## Response

### Success

Returns the number of audit log records deleted as an integer.

{% code title="200 OK" %}

```json
1542
```

{% endcode %}

## Examples

### Using Default Retention

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/audit-logs/cleanup" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Configuration

Configure default retention in `appsettings.json`:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "AuditLog": {
                "Enabled": true,
                "RetentionDays": 14
            }
        }
    }
}
```

{% endcode %}

| Setting         | Default | Description                                  |
| --------------- | ------- | -------------------------------------------- |
| `Enabled`       | `true`  | Whether audit logging is enabled             |
| `RetentionDays` | `14`    | Days to retain audit logs before cleanup     |

{% hint style="info" %}
When `Enabled` is `true`, cleanup runs automatically on a background schedule. Manual cleanup via this endpoint is useful for immediate cleanup or to override the retention period. See [Audit Logs](../../backoffice/audit-logs.md) for the complete list of audit log configuration options.
{% endhint %}

