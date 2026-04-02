---
description: >-
    Clean up old audit log entries.
---

# Cleanup Audit Logs

Removes audit log entries older than the configured retention period.

## Request

```http
POST /umbraco/ai/management/api/v1/audit-log/cleanup
```

### Request Body (Optional)

{% code title="Request" %}

```json
{
    "olderThanDays": 90
}
```

{% endcode %}

| Property        | Type | Default          | Description                   |
| --------------- | ---- | ---------------- | ----------------------------- |
| `olderThanDays` | int  | configured value | Override the retention period |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "deletedCount": 1542,
    "oldestRetained": "2024-10-25T00:00:00Z",
    "retentionDays": 90
}
```

{% endcode %}

## Examples

### Using Default Retention

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/audit-log/cleanup" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Custom Retention Period

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/audit-log/cleanup" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "olderThanDays": 30 }'
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
                "RetentionDays": 90,
                "AutoCleanupEnabled": true,
                "AutoCleanupIntervalHours": 24
            }
        }
    }
}
```

{% endcode %}

| Setting                    | Default | Description                |
| -------------------------- | ------- | -------------------------- |
| `RetentionDays`            | 90      | Days to retain audit logs  |
| `AutoCleanupEnabled`       | true    | Enable automatic cleanup   |
| `AutoCleanupIntervalHours` | 24      | Hours between cleanup runs |

{% hint style="info" %}
When `AutoCleanupEnabled` is true, cleanup runs automatically on a background schedule. Manual cleanup is useful for immediate cleanup or using a different retention period.
{% endhint %}

## Response Properties

| Property         | Type     | Description                          |
| ---------------- | -------- | ------------------------------------ |
| `deletedCount`   | int      | Number of records deleted            |
| `oldestRetained` | datetime | Timestamp of oldest remaining record |
| `retentionDays`  | int      | Retention period used for cleanup    |
