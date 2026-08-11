---
description: >-
    Model representing an AI operation audit log entry.
---

# AIAuditLog

Represents a single AI operation audit record with timing, token usage, and outcome information.

## Namespace

```csharp
using Umbraco.AI.Core.AuditLog;
```

## Definition

{% code title="AIAuditLog" %}

```csharp
public sealed class AIAuditLog
{
    public Guid Id { get; internal set; }

    // Timing
    public DateTime StartTime { get; init; }
    public DateTime? EndTime { get; set; }
    public TimeSpan? Duration => EndTime.HasValue ? EndTime.Value - StartTime : null;

    // Status
    public AIAuditLogStatus Status { get; set; }
    public AIAuditLogErrorCategory? ErrorCategory { get; set; }
    public string? ErrorMessage { get; set; }

    // User context
    public string? UserId { get; init; }
    public string? UserName { get; init; }

    // Entity context (content being processed)
    public string? EntityId { get; init; }
    public string? EntityType { get; init; }

    // AI configuration
    public AICapability Capability { get; init; }
    public Guid ProfileId { get; init; }
    public string ProfileAlias { get; init; } = string.Empty;
    public int? ProfileVersion { get; init; }
    public string ProviderId { get; init; } = string.Empty;
    public string ModelId { get; init; } = string.Empty;

    // Feature context (prompt or agent)
    public string? FeatureType { get; init; }
    public Guid? FeatureId { get; init; }
    public int? FeatureVersion { get; init; }

    // Token usage
    public int? InputTokens { get; set; }
    public int? OutputTokens { get; set; }
    public int? TotalTokens { get; set; }

    // Content snapshots (if configured to persist)
    public string? PromptSnapshot { get; set; }
    public string? ResponseSnapshot { get; set; }

    // Tracing
    public string? TraceId { get; set; }

    // Relationships
    public Guid? ParentAuditLogId { get; internal set; }
    public IReadOnlyDictionary<string, string>? Metadata { get; init; }
}
```

{% endcode %}

## Properties

### Core Properties

| Property    | Type        | Description              |
| ----------- | ----------- | ------------------------ |
| `Id`        | `Guid`      | Unique identifier        |
| `StartTime` | `DateTime`  | When operation started   |
| `EndTime`   | `DateTime?` | When operation completed |
| `Duration`  | `TimeSpan?` | Computed duration        |

### Status Properties

| Property        | Type                       | Description          |
| --------------- | -------------------------- | -------------------- |
| `Status`        | `AIAuditLogStatus`         | Operation outcome    |
| `ErrorCategory` | `AIAuditLogErrorCategory?` | Error classification |
| `ErrorMessage`  | `string?`                  | Error details        |

### Context Properties

| Property     | Type      | Description        |
| ------------ | --------- | ------------------ |
| `UserId`     | `string?` | User who initiated |
| `UserName`   | `string?` | User display name  |
| `EntityId`   | `string?` | Content item ID    |
| `EntityType` | `string?` | Content item type  |

### AI Configuration

| Property         | Type           | Description             |
| ---------------- | -------------- | ----------------------- |
| `Capability`     | `AICapability` | Chat, Embedding, etc.   |
| `ProfileId`      | `Guid`         | Profile used            |
| `ProfileAlias`   | `string`       | Profile alias at time   |
| `ProfileVersion` | `int?`         | Profile version at time |
| `ProviderId`     | `string`       | Provider ID             |
| `ModelId`        | `string`       | Model ID                |

### Feature Context

| Property         | Type      | Description                |
| ---------------- | --------- | -------------------------- |
| `FeatureType`    | `string?` | "prompt", "agent", or null |
| `FeatureId`      | `Guid?`   | Feature ID                 |
| `FeatureVersion` | `int?`    | Feature version at time    |

### Token Usage

| Property       | Type   | Description        |
| -------------- | ------ | ------------------ |
| `InputTokens`  | `int?` | Tokens in request  |
| `OutputTokens` | `int?` | Tokens in response |
| `TotalTokens`  | `int?` | Combined tokens    |

### Content Snapshots

| Property           | Type      | Description                                 |
| ------------------ | --------- | ------------------------------------------- |
| `PromptSnapshot`   | `string?` | Request content (if configured to persist)  |
| `ResponseSnapshot` | `string?` | Response content (if configured to persist) |

---

## AIAuditLogStatus

{% code title="AIAuditLogStatus" %}

```csharp
public enum AIAuditLogStatus
{
    Running = 0,
    Succeeded = 1,
    Failed = 2,
    Cancelled = 3,
    PartialSuccess = 4,
    Blocked = 5
}
```

{% endcode %}

---

## AIAuditLogErrorCategory

{% code title="AIAuditLogErrorCategory" %}

```csharp
public enum AIAuditLogErrorCategory
{
    Authentication = 0,
    RateLimiting = 1,
    ModelNotFound = 2,
    InvalidRequest = 3,
    ServerError = 4,
    NetworkError = 5,
    ContextResolution = 6,
    ToolExecution = 7,
    GuardrailBlocked = 8,
    Unknown = 99
}
```

{% endcode %}

---

## AIAuditLogFilter

Used to filter audit log queries.

{% code title="AIAuditLogFilter" %}

```csharp
public class AIAuditLogFilter
{
    public DateTime? FromDate { get; init; }
    public DateTime? ToDate { get; init; }
    public AIAuditLogStatus? Status { get; init; }
    public AICapability? Capability { get; init; }
    public Guid? ProfileId { get; init; }
    public string? ProviderId { get; init; }
    public string? UserId { get; init; }
    public string? FeatureType { get; init; }
    public Guid? FeatureId { get; init; }
    public string? EntityId { get; init; }
    public string? EntityType { get; init; }
    public Guid? ParentAuditLogId { get; init; }
    public string? SearchText { get; init; }
}
```

{% endcode %}

## Related

- [IAIAuditLogService](../services/ai-audit-log-service.md) - Audit log service
- [Audit Logs Backoffice](../../backoffice/audit-logs.md) - Viewing logs
