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
public class AIAuditLog
{
    public Guid Id { get; set; }

    // Timing
    public DateTime StartTime { get; set; }
    public DateTime? EndTime { get; set; }
    public TimeSpan? Duration => EndTime.HasValue ? EndTime.Value - StartTime : null;

    // Status
    public AIAuditLogStatus Status { get; set; }
    public AIAuditLogErrorCategory? ErrorCategory { get; set; }
    public string? ErrorMessage { get; set; }

    // User context
    public string? UserId { get; set; }
    public string? UserName { get; set; }

    // Entity context (content being processed)
    public string? EntityId { get; set; }
    public string? EntityType { get; set; }

    // AI configuration
    public AICapability Capability { get; set; }
    public Guid ProfileId { get; set; }
    public string ProfileAlias { get; set; } = string.Empty;
    public int? ProfileVersion { get; set; }
    public string ProviderId { get; set; } = string.Empty;
    public string ModelId { get; set; } = string.Empty;

    // Feature context (prompt or agent)
    public string? FeatureType { get; set; }
    public Guid? FeatureId { get; set; }
    public int? FeatureVersion { get; set; }

    // Token usage
    public int? InputTokens { get; set; }
    public int? OutputTokens { get; set; }
    public int? TotalTokens { get; set; }

    // Content snapshots (if configured to persist)
    public string? PromptSnapshot { get; set; }
    public string? ResponseSnapshot { get; set; }

    // Relationships
    public Guid? ParentAuditLogId { get; set; }
    public IReadOnlyDictionary<string, string>? Metadata { get; set; }
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

# AIAuditLogStatus

{% code title="AIAuditLogStatus" %}

```csharp
public enum AIAuditLogStatus
{
    Running = 0,
    Succeeded = 1,
    Failed = 2,
    Cancelled = 3,
    PartialSuccess = 4
}
```

{% endcode %}

---

# AIAuditLogErrorCategory

{% code title="AIAuditLogErrorCategory" %}

```csharp
public enum AIAuditLogErrorCategory
{
    Unknown = 0,
    Authentication = 1,
    RateLimit = 2,
    Timeout = 3,
    InvalidRequest = 4,
    ModelError = 5,
    NetworkError = 6
}
```

{% endcode %}

---

# AIAuditLogFilter

Used to filter audit log queries.

{% code title="AIAuditLogFilter" %}

```csharp
public class AIAuditLogFilter
{
    public DateTime? From { get; set; }
    public DateTime? To { get; set; }
    public AIAuditLogStatus? Status { get; set; }
    public AICapability? Capability { get; set; }
    public Guid? ProfileId { get; set; }
    public string? ProviderId { get; set; }
    public Guid? UserId { get; set; }
    public string? FeatureType { get; set; }
}
```

{% endcode %}

## Related

- [IAIAuditLogService](../services/ai-audit-log-service.md) - Audit log service
- [Audit Logs Backoffice](../../backoffice/audit-logs.md) - Viewing logs
