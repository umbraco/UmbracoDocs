---
description: >-
    Service for AI operation audit logging.
---

# IAIAuditLogService

Service for recording and querying AI operation audit logs. Audit logs track every chat and embedding request with timing, token usage, and outcome information.

## Namespace

```csharp
using Umbraco.AI.Core.AuditLog;
```

## Interface

{% code title="IAIAuditLogService" %}

```csharp
public interface IAIAuditLogService
{
    // Recording methods (used internally by AI services)
    Task<AIAuditLog> StartAuditLogAsync(AIAuditLog auditLog, CancellationToken cancellationToken = default);
    Task CompleteAuditLogAsync(AIAuditLog audit, object? response, CancellationToken cancellationToken = default);
    Task RecordAuditLogFailureAsync(AIAuditLog audit, Exception exception, CancellationToken cancellationToken = default);

    // Fire-and-forget variants (non-blocking)
    void QueueStartAuditLogAsync(AIAuditLog auditLog, CancellationToken cancellationToken = default);
    void QueueCompleteAuditLogAsync(AIAuditLog audit, object? response, CancellationToken cancellationToken = default);
    void QueueRecordAuditLogFailureAsync(AIAuditLog audit, Exception exception, CancellationToken cancellationToken = default);

    // Query methods
    Task<AIAuditLog?> GetAuditLogAsync(Guid id, CancellationToken cancellationToken = default);

    Task<(IEnumerable<AIAuditLog> Items, int Total)> GetAuditLogsPagedAsync(
        AIAuditLogFilter? filter = null,
        int skip = 0,
        int take = 50,
        CancellationToken cancellationToken = default);

    Task<IEnumerable<AIAuditLog>> GetEntityHistoryAsync(
        string entityId,
        string entityType,
        int limit = 20,
        CancellationToken cancellationToken = default);

    // Management methods
    Task<bool> DeleteAuditLogAsync(Guid id, CancellationToken cancellationToken = default);
    Task<int> CleanupOldAuditLogsAsync(CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Query Methods

### GetAuditLogAsync

Gets a specific audit log entry by ID.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The audit log ID   |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The audit log if found, otherwise `null`.

{% code title="Example" %}

```csharp
var log = await _auditLogService.GetAuditLogAsync(auditLogId);
if (log != null)
{
    Console.WriteLine($"Status: {log.Status}");
    Console.WriteLine($"Tokens: {log.TotalTokens}");
    Console.WriteLine($"Duration: {log.Duration}");
}
```

{% endcode %}

### GetAuditLogsPagedAsync

Gets audit logs with filtering and pagination.

| Parameter           | Type                | Description               |
| ------------------- | ------------------- | ------------------------- |
| `filter`            | `AIAuditLogFilter?` | Filter criteria           |
| `skip`              | `int`               | Records to skip           |
| `take`              | `int`               | Records to take (max 100) |
| `cancellationToken` | `CancellationToken` | Cancellation token        |

**Returns**: Tuple of (logs, total count).

{% code title="Example" %}

```csharp
var filter = new AIAuditLogFilter
{
    From = DateTime.UtcNow.AddDays(-7),
    To = DateTime.UtcNow,
    Status = AIAuditLogStatus.Failed,
    Capability = AICapability.Chat
};

var (logs, total) = await _auditLogService.GetAuditLogsPagedAsync(
    filter,
    skip: 0,
    take: 50);

Console.WriteLine($"Found {total} failed chat operations");
```

{% endcode %}

### GetEntityHistoryAsync

Gets audit history for a specific content entity.

| Parameter           | Type                | Description                        |
| ------------------- | ------------------- | ---------------------------------- |
| `entityId`          | `string`            | The entity ID                      |
| `entityType`        | `string`            | The entity type (e.g., "document") |
| `limit`             | `int`               | Maximum records to return          |
| `cancellationToken` | `CancellationToken` | Cancellation token                 |

**Returns**: Audit logs for the entity.

{% code title="Example" %}

```csharp
var history = await _auditLogService.GetEntityHistoryAsync(
    contentId.ToString(),
    "document",
    limit: 10);

foreach (var log in history)
{
    Console.WriteLine($"{log.StartTime}: {log.ProfileAlias} - {log.Status}");
}
```

{% endcode %}

## Management Methods

### DeleteAuditLogAsync

Deletes a specific audit log entry.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The audit log ID   |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: `true` if deleted, `false` if not found.

### CleanupOldAuditLogsAsync

Removes audit logs older than the configured retention period.

**Returns**: Number of deleted records.

{% code title="Example" %}

```csharp
var deletedCount = await _auditLogService.CleanupOldAuditLogsAsync();
Console.WriteLine($"Cleaned up {deletedCount} old audit logs");
```

{% endcode %}

## Filter Properties

The `AIAuditLogFilter` class supports:

| Property      | Type                | Description            |
| ------------- | ------------------- | ---------------------- |
| `From`        | `DateTime?`         | Start of date range    |
| `To`          | `DateTime?`         | End of date range      |
| `Status`      | `AIAuditLogStatus?` | Filter by status       |
| `Capability`  | `AICapability?`     | Filter by capability   |
| `ProfileId`   | `Guid?`             | Filter by profile      |
| `ProviderId`  | `string?`           | Filter by provider     |
| `UserId`      | `Guid?`             | Filter by user         |
| `FeatureType` | `string?`           | Filter by feature type |

## Notes

- The recording methods (`StartAuditLogAsync`, `CompleteAuditLogAsync`, etc.) are used internally by AI services
- Use the `Queue*` variants for non-blocking audit logging
- Audit logs include token counts reported by the AI provider
- Prompt and response snapshots are only included when detail level is set to `Full`

## Related

- [AIAuditLog](../models/ai-audit-log.md) - The audit log model
- [Audit Logs Backoffice](../../backoffice/audit-logs.md) - Viewing audit logs
