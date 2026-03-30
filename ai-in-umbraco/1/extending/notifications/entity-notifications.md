---
description: >-
    Complete reference for all entity lifecycle notifications in Umbraco.AI.
---

# Entity Lifecycle Notifications

Umbraco.AI publishes notifications for all entity lifecycle operations. Subscribe to these events to add custom validation, audit logging, and automation.

## Notification Categories

| Entity | Save/Delete | Rollback | Execution |
|--------|-------------|----------|-----------|
| **AIProfile** | ✅ | ✅ | - |
| **AIConnection** | ✅ | ✅ | - |
| **AIContext** | ✅ | ✅ | - |
| **AIPrompt** | ✅ | - | ✅ |
| **AIAgent** | ✅ | - | ✅ |

## AIProfile Notifications

### AIProfileSavingNotification

**Namespace:** `Umbraco.AI.Core.Profiles`

Published **before** a profile is saved (create or update).

**Properties:**
- `Entity` (AIProfile) - The profile being saved
- `Messages` (EventMessages) - Add messages for cancellation reasons
- `Cancel` (bool) - Set to true to prevent the save

**Use Cases:**
- Validate profile configuration before saving
- Enforce naming conventions on aliases
- Check for duplicate aliases (beyond built-in checks)
- Apply business rules (e.g., limit profiles per connection)

**Example:**

{% code title="ProfileSavingHandler.cs" %}

```csharp
public class ProfileSavingHandler : INotificationAsyncHandler<AIProfileSavingNotification>
{
    public Task HandleAsync(AIProfileSavingNotification notification, CancellationToken ct)
    {
        var profile = notification.Entity;

        // Enforce alias naming convention
        if (!Regex.IsMatch(profile.Alias, "^[a-z][a-z0-9-]*$"))
        {
            notification.Cancel = true;
            notification.Messages.Add(new EventMessage(
                "Validation",
                "Profile alias must start with lowercase letter and contain only lowercase letters, numbers, and hyphens",
                EventMessageType.Error));
        }

        // Validate temperature range for specific providers
        if (profile.Temperature.HasValue &&
            (profile.Temperature < 0 || profile.Temperature > 2))
        {
            notification.Cancel = true;
            notification.Messages.Add(new EventMessage(
                "Validation",
                "Temperature must be between 0 and 2",
                EventMessageType.Error));
        }

        return Task.CompletedTask;
    }
}
```

{% endcode %}

### AIProfileSavedNotification

**Namespace:** `Umbraco.AI.Core.Profiles`

Published **after** a profile is saved (not cancelable).

**Properties:**
- `Entity` (AIProfile) - The saved profile
- `Messages` (EventMessages) - Event messages from the operation

**Use Cases:**
- Audit logging (who changed what, when)
- Invalidate related caches
- Send webhooks to external systems
- Update dependent entities
- Track configuration changes for compliance

**Example:**

{% code title="ProfileSavedHandler.cs" %}

```csharp
public class ProfileSavedHandler : INotificationAsyncHandler<AIProfileSavedNotification>
{
    private readonly IAuditService _auditService;
    private readonly IMemoryCache _cache;

    public async Task HandleAsync(AIProfileSavedNotification notification, CancellationToken ct)
    {
        var profile = notification.Entity;

        // Log the change
        await _auditService.LogAsync(new AuditEntry
        {
            EntityType = "AIProfile",
            EntityId = profile.Id,
            EntityAlias = profile.Alias,
            Action = "Saved",
            Timestamp = DateTime.UtcNow
        });

        // Invalidate cache
        _cache.Remove($"profile:{profile.Id}");
        _cache.Remove($"profile:{profile.Alias}");

        // If this is a default profile, clear default profile cache
        if (profile.IsDefault)
        {
            _cache.Remove($"default-profile:{profile.Capability}");
        }
    }
}
```

{% endcode %}

### AIProfileDeletingNotification

**Namespace:** `Umbraco.AI.Core.Profiles`

Published **before** a profile is deleted.

**Properties:**
- `EntityId` (Guid) - The ID of the profile being deleted
- `Messages` (EventMessages) - Add messages for cancellation reasons
- `Cancel` (bool) - Set to true to prevent the delete

**Use Cases:**
- Check for dependencies before allowing deletion
- Require confirmation for critical profiles
- Enforce deletion policies

**Example:**

{% code title="ProfileDeletingHandler.cs" %}

```csharp
public class ProfileDeletingHandler : INotificationAsyncHandler<AIProfileDeletingNotification>
{
    private readonly IAIPromptService _promptService;

    public async Task HandleAsync(AIProfileDeletingNotification notification, CancellationToken ct)
    {
        // Check if any prompts reference this profile
        var dependentPrompts = await _promptService.GetPromptsByProfileAsync(
            notification.EntityId, ct);

        if (dependentPrompts.Any())
        {
            notification.Cancel = true;
            notification.Messages.Add(new EventMessage(
                "Dependency",
                $"Cannot delete profile: {dependentPrompts.Count()} prompt(s) depend on it",
                EventMessageType.Error));
        }
    }
}
```

{% endcode %}

### AIProfileDeletedNotification

**Namespace:** `Umbraco.AI.Core.Profiles`

Published **after** a profile is deleted (not cancelable).

**Properties:**
- `EntityId` (Guid) - The ID of the deleted profile
- `Messages` (EventMessages) - Event messages from the operation

**Use Cases:**
- Audit logging for compliance
- Cleanup related data (cache, temporary files)
- Cascade delete related entities (if not handled by FK)

**Example:**

{% code title="ProfileDeletedHandler.cs" %}

```csharp
public class ProfileDeletedHandler : INotificationAsyncHandler<AIProfileDeletedNotification>
{
    public Task HandleAsync(AIProfileDeletedNotification notification, CancellationToken ct)
    {
        // Log deletion for audit trail
        _logger.LogInformation(
            "Profile {ProfileId} was deleted at {Timestamp}",
            notification.EntityId,
            DateTime.UtcNow);

        // Clear all related cache entries
        _cache.RemoveByPrefix($"profile:{notification.EntityId}");

        return Task.CompletedTask;
    }
}
```

{% endcode %}

### AIProfileRollingBackNotification

**Namespace:** `Umbraco.AI.Core.Profiles`

Published **before** a profile is rolled back to a previous version.

**Properties:**
- `ProfileId` (Guid) - The ID of the profile being rolled back
- `TargetVersion` (int) - The version number to roll back to
- `Messages` (EventMessages) - Add messages for cancellation reasons
- `Cancel` (bool) - Set to true to prevent the rollback

**Use Cases:**
- Require approval for rollback operations
- Validate target version exists
- Check permissions for version management

**Example:**

{% code title="ProfileRollingBackHandler.cs" %}

```csharp
public class ProfileRollingBackHandler : INotificationAsyncHandler<AIProfileRollingBackNotification>
{
    public Task HandleAsync(AIProfileRollingBackNotification notification, CancellationToken ct)
    {
        // Only allow rollback to versions within last 30 days
        if (notification.TargetVersion < GetMinimumAllowedVersion())
        {
            notification.Cancel = true;
            notification.Messages.Add(new EventMessage(
                "Policy",
                "Cannot roll back to versions older than 30 days",
                EventMessageType.Error));
        }

        return Task.CompletedTask;
    }
}
```

{% endcode %}

### AIProfileRolledBackNotification

**Namespace:** `Umbraco.AI.Core.Profiles`

Published **after** a profile is rolled back (not cancelable).

**Properties:**
- `Profile` (AIProfile) - The rolled back profile
- `TargetVersion` (int) - The version number that was rolled back to
- `Messages` (EventMessages) - Event messages from the operation

**Use Cases:**
- Audit logging for compliance
- Notify administrators of rollback events
- Track version history

**Example:**

{% code title="ProfileRolledBackHandler.cs" %}

```csharp
public class ProfileRolledBackHandler : INotificationAsyncHandler<AIProfileRolledBackNotification>
{
    public async Task HandleAsync(AIProfileRolledBackNotification notification, CancellationToken ct)
    {
        await _auditService.LogAsync(new AuditEntry
        {
            EntityType = "AIProfile",
            EntityId = notification.Profile.Id,
            Action = $"Rolled back to version {notification.TargetVersion}",
            Timestamp = DateTime.UtcNow
        });

        // Send notification to admins
        await _notificationService.NotifyAsync(
            "Profile Rollback",
            $"Profile '{notification.Profile.Name}' was rolled back to version {notification.TargetVersion}");
    }
}
```

{% endcode %}

## AIConnection Notifications

AIConnection follows the same pattern as AIProfile:

- `AIConnectionSavingNotification` - Before connection save
- `AIConnectionSavedNotification` - After connection save
- `AIConnectionDeletingNotification` - Before connection delete
- `AIConnectionDeletedNotification` - After connection delete
- `AIConnectionRollingBackNotification` - Before connection rollback
- `AIConnectionRolledBackNotification` - After connection rollback

**Namespace:** `Umbraco.AI.Core.Connections`

**Common use cases:**
- Validate API keys before saving connections
- Test connectivity before allowing save
- Check for dependent profiles before deletion
- Audit credential changes for security compliance

## AIContext Notifications

AIContext follows the same pattern as AIProfile:

- `AIContextSavingNotification` - Before context save
- `AIContextSavedNotification` - After context save
- `AIContextDeletingNotification` - Before context delete
- `AIContextDeletedNotification` - After context delete
- `AIContextRollingBackNotification` - Before context rollback
- `AIContextRolledBackNotification` - After context rollback

**Namespace:** `Umbraco.AI.Core.Contexts`

**Common use cases:**
- Validate context resolver configuration
- Enforce context naming conventions
- Check for dependent profiles before deletion
- Track context usage patterns

## AIPrompt Notifications

### AIPromptSavingNotification / AIPromptSavedNotification

Same pattern as AIProfile Save notifications.

**Namespace:** `Umbraco.AI.Prompt.Core.Prompts`

### AIPromptDeletingNotification / AIPromptDeletedNotification

Same pattern as AIProfile Delete notifications.

**Namespace:** `Umbraco.AI.Prompt.Core.Prompts`

### AIPromptExecutingNotification

Published **before** a prompt is executed (cancelable).

**Properties:**
- `Prompt` (AIPrompt) - The prompt being executed
- `Request` (AIPromptExecutionRequest) - The execution request context
- `Messages` (EventMessages) - Add messages for cancellation reasons
- `Cancel` (bool) - Set to true to prevent execution

**Use Cases:**
- Rate limiting per user/profile
- Custom authorization beyond profile permissions
- Resource availability checks
- Execution quotas

**Example:**

{% code title="PromptExecutingHandler.cs" %}

```csharp
public class PromptExecutingHandler : INotificationAsyncHandler<AIPromptExecutingNotification>
{
    private readonly IRateLimiter _rateLimiter;

    public async Task HandleAsync(AIPromptExecutingNotification notification, CancellationToken ct)
    {
        var userId = GetCurrentUserId();

        // Check rate limit
        if (!await _rateLimiter.AllowAsync(userId, "prompt-execution"))
        {
            notification.Cancel = true;
            notification.Messages.Add(new EventMessage(
                "RateLimit",
                "Rate limit exceeded. Please try again later.",
                EventMessageType.Error));
        }

        // Log execution attempt
        _logger.LogInformation(
            "User {UserId} executing prompt {PromptAlias}",
            userId,
            notification.Prompt.Alias);
    }
}
```

{% endcode %}

### AIPromptExecutedNotification

Published **after** a prompt execution completes (not cancelable).

**Properties:**
- `Prompt` (AIPrompt) - The prompt that was executed
- `Request` (AIPromptExecutionRequest) - The execution request context
- `Result` (AIPromptExecutionResult) - The execution result with response and usage data
- `Messages` (EventMessages) - Event messages from the operation

**Use Cases:**
- Usage tracking and billing
- Performance monitoring
- Result caching
- Audit logging

**Example:**

{% code title="PromptExecutedHandler.cs" %}

```csharp
public class PromptExecutedHandler : INotificationAsyncHandler<AIPromptExecutedNotification>
{
    public async Task HandleAsync(AIPromptExecutedNotification notification, CancellationToken ct)
    {
        var result = notification.Result;

        // Track usage for billing
        await _usageService.RecordAsync(new UsageRecord
        {
            PromptId = notification.Prompt.Id,
            ProfileId = notification.Prompt.ProfileId,
            InputTokens = result.Usage?.InputTokens ?? 0,
            OutputTokens = result.Usage?.OutputTokens ?? 0,
            ExecutionTime = result.Duration,
            Timestamp = DateTime.UtcNow
        });

        // Monitor performance
        if (result.Duration > TimeSpan.FromSeconds(10))
        {
            _logger.LogWarning(
                "Slow prompt execution: {PromptAlias} took {Duration}s",
                notification.Prompt.Alias,
                result.Duration.TotalSeconds);
        }
    }
}
```

{% endcode %}

## AIAgent Notifications

### AIAgentSavingNotification / AIAgentSavedNotification

Same pattern as AIProfile Save notifications.

**Namespace:** `Umbraco.AI.Agent.Core.Agents`

### AIAgentDeletingNotification / AIAgentDeletedNotification

Same pattern as AIProfile Delete notifications.

**Namespace:** `Umbraco.AI.Agent.Core.Agents`

### AIAgentExecutingNotification

Published **before** an agent execution starts (cancelable).

**Properties:**
- `Agent` (AIAgent) - The agent being executed
- `Request` (AGUIRunRequest) - The execution run request
- `FrontendTools` (IEnumerable\<AIFrontendTool\>?) - The frontend tools provided
- `Messages` (EventMessages) - Add messages for cancellation reasons
- `Cancel` (bool) - Set to true to prevent execution

**Use Cases:**
- Rate limiting and quotas
- Custom authorization checks
- Resource availability validation
- Execution scheduling

**Example:**

{% code title="AgentExecutingHandler.cs" %}

```csharp
public class AgentExecutingHandler : INotificationAsyncHandler<AIAgentExecutingNotification>
{
    private readonly IResourceManager _resources;

    public async Task HandleAsync(AIAgentExecutingNotification notification, CancellationToken ct)
    {
        // Check if system has capacity
        if (!await _resources.HasCapacityAsync())
        {
            notification.Cancel = true;
            notification.Messages.Add(new EventMessage(
                "Capacity",
                "System is at capacity. Please try again later.",
                EventMessageType.Error));
            return;
        }

        // Validate frontend tools if provided
        if (notification.FrontendTools?.Any() == true)
        {
            var invalidTools = notification.FrontendTools
                .Where(t => !IsToolValid(t))
                .ToList();

            if (invalidTools.Any())
            {
                notification.Cancel = true;
                notification.Messages.Add(new EventMessage(
                    "Validation",
                    $"Invalid frontend tools: {string.Join(", ", invalidTools.Select(t => t.Tool.Name))}",
                    EventMessageType.Error));
            }
        }
    }
}
```

{% endcode %}

### AIAgentExecutedNotification

Published **after** an agent execution completes (not cancelable).

**Properties:**
- `Agent` (AIAgent) - The agent that was executed
- `Request` (AGUIRunRequest) - The execution run request
- `FrontendTools` (IEnumerable\<AIFrontendTool\>?) - The frontend tools provided
- `Duration` (TimeSpan) - The execution duration (measured with high-resolution Stopwatch)
- `IsSuccess` (bool) - Whether the execution completed successfully
- `Messages` (EventMessages) - Event messages from the operation

**Use Cases:**
- Usage tracking and billing
- Performance monitoring and alerting
- Execution history for analytics
- Cost attribution

**Example:**

{% code title="AgentExecutedHandler.cs" %}

```csharp
public class AgentExecutedHandler : INotificationAsyncHandler<AIAgentExecutedNotification>
{
    public async Task HandleAsync(AIAgentExecutedNotification notification, CancellationToken ct)
    {
        // Record execution metrics
        await _metricsService.RecordAsync(new AgentExecutionMetric
        {
            AgentId = notification.Agent.Id,
            AgentAlias = notification.Agent.Alias,
            ThreadId = notification.Request.ThreadId,
            RunId = notification.Request.RunId,
            Duration = notification.Duration,
            IsSuccess = notification.IsSuccess,
            FrontendToolCount = notification.FrontendTools?.Count() ?? 0,
            Timestamp = DateTime.UtcNow
        });

        // Alert on failures
        if (!notification.IsSuccess)
        {
            _logger.LogError(
                "Agent execution failed: {AgentAlias} (RunId: {RunId})",
                notification.Agent.Alias,
                notification.Request.RunId);

            await _alertService.SendAsync(
                "Agent Execution Failure",
                $"Agent '{notification.Agent.Name}' execution failed after {notification.Duration.TotalSeconds:F2}s");
        }

        // Track performance
        if (notification.Duration > TimeSpan.FromMinutes(5))
        {
            _logger.LogWarning(
                "Long-running agent execution: {AgentAlias} took {Duration}",
                notification.Agent.Alias,
                notification.Duration);
        }
    }
}
```

{% endcode %}

## Registration Patterns

### Single Handler

Register a single handler in a Composer:

{% code title="SingleHandlerComposer.cs" %}

```csharp
public class NotificationComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationAsyncHandler<AIProfileSavingNotification, ProfileValidationHandler>();
    }
}
```

{% endcode %}

### Multiple Handlers

Register multiple handlers for different events:

{% code title="MultipleHandlerComposer.cs" %}

```csharp
public class NotificationComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder
            // Profile notifications
            .AddNotificationAsyncHandler<AIProfileSavingNotification, ProfileValidationHandler>()
            .AddNotificationAsyncHandler<AIProfileSavedNotification, ProfileAuditHandler>()
            .AddNotificationAsyncHandler<AIProfileDeletingNotification, ProfileDeletionGuard>()

            // Prompt execution notifications
            .AddNotificationAsyncHandler<AIPromptExecutingNotification, PromptRateLimitHandler>()
            .AddNotificationAsyncHandler<AIPromptExecutedNotification, PromptUsageTracker>()

            // Agent execution notifications
            .AddNotificationAsyncHandler<AIAgentExecutingNotification, AgentAuthorizationHandler>()
            .AddNotificationAsyncHandler<AIAgentExecutedNotification, AgentMetricsCollector>();
    }
}
```

{% endcode %}

### Dependency Injection

Handlers support constructor injection:

{% code title="ProfileAuditHandler.cs" %}

```csharp
public class ProfileAuditHandler : INotificationAsyncHandler<AIProfileSavedNotification>
{
    private readonly IAuditService _auditService;
    private readonly ILogger<ProfileAuditHandler> _logger;
    private readonly IMemoryCache _cache;

    public ProfileAuditHandler(
        IAuditService auditService,
        ILogger<ProfileAuditHandler> logger,
        IMemoryCache cache)
    {
        _auditService = auditService;
        _logger = logger;
        _cache = cache;
    }

    public async Task HandleAsync(AIProfileSavedNotification notification, CancellationToken ct)
    {
        // Use injected services
        await _auditService.LogAsync(notification.Entity);
        _cache.Remove($"profile:{notification.Entity.Id}");
    }
}
```

{% endcode %}

## Best Practices

### Performance

- **Keep handlers fast** - Notifications are synchronous by default
- **Use async appropriately** - Don't block on I/O operations
- **Consider background processing** - For expensive operations, queue work instead of executing inline
- **Avoid circular dependencies** - Don't trigger operations that publish the same notification

### Error Handling

- **Don't throw in Saved/Deleted handlers** - Operation already completed, throwing won't undo it
- **Use Cancel + Messages in Saving/Deleting** - Provide clear error messages
- **Log exceptions** - Failed handlers can break the operation pipeline

### Cancellation

```csharp
// ✅ Good - Clear message, sets Cancel
notification.Cancel = true;
notification.Messages.Add(new EventMessage(
    "Validation",
    "Profile alias cannot contain spaces",
    EventMessageType.Error));

// ❌ Bad - No message, user doesn't know why
notification.Cancel = true;

// ❌ Bad - Throws exception instead of canceling
throw new InvalidOperationException("Invalid alias");
```

### State Management

```csharp
// If you need to pass data from Saving to Saved handler,
// use the notification system's state propagation (automatic)
// or use a scoped service

public class ProfileWorkflowService
{
    public string? OperationContext { get; set; }
}

// In Saving handler
_workflowService.OperationContext = "user-initiated";

// In Saved handler
if (_workflowService.OperationContext == "user-initiated")
{
    // Different behavior for user vs system changes
}
```

## Common Patterns

### Audit Logging

{% code title="AuditLoggingHandler.cs" %}

```csharp
public class AuditLoggingHandler :
    INotificationAsyncHandler<AIProfileSavedNotification>,
    INotificationAsyncHandler<AIProfileDeletedNotification>
{
    public Task HandleAsync(AIProfileSavedNotification notification, CancellationToken ct)
        => LogAsync("Profile", notification.Entity.Id, "Saved");

    public Task HandleAsync(AIProfileDeletedNotification notification, CancellationToken ct)
        => LogAsync("Profile", notification.EntityId, "Deleted");

    private Task LogAsync(string entityType, Guid id, string action)
    {
        _logger.LogInformation("{EntityType} {Id} {Action} at {Time}",
            entityType, id, action, DateTime.UtcNow);
        return Task.CompletedTask;
    }
}
```

{% endcode %}

### Cache Invalidation

{% code title="CacheInvalidationHandler.cs" %}

```csharp
public class CacheInvalidationHandler :
    INotificationAsyncHandler<AIProfileSavedNotification>,
    INotificationAsyncHandler<AIProfileDeletedNotification>
{
    public Task HandleAsync(AIProfileSavedNotification notification, CancellationToken ct)
    {
        InvalidateProfileCache(notification.Entity.Id, notification.Entity.Alias);
        return Task.CompletedTask;
    }

    public Task HandleAsync(AIProfileDeletedNotification notification, CancellationToken ct)
    {
        _cache.RemoveByPrefix($"profile:{notification.EntityId}");
        return Task.CompletedTask;
    }

    private void InvalidateProfileCache(Guid id, string alias)
    {
        _cache.Remove($"profile:{id}");
        _cache.Remove($"profile:{alias}");
    }
}
```

{% endcode %}

### Webhook Integration

{% code title="WebhookHandler.cs" %}

```csharp
public class WebhookHandler : INotificationAsyncHandler<AIProfileSavedNotification>
{
    public async Task HandleAsync(AIProfileSavedNotification notification, CancellationToken ct)
    {
        var payload = new
        {
            Event = "profile.saved",
            ProfileId = notification.Entity.Id,
            ProfileAlias = notification.Entity.Alias,
            Timestamp = DateTime.UtcNow
        };

        await _webhookService.SendAsync("profile-events", payload, ct);
    }
}
```

{% endcode %}

## Summary

- **34 notifications** across 5 entities (Profile, Connection, Context, Prompt, Agent)
- **Cancelable** (Saving/Deleting/RollingBack/Executing) for validation and prevention
- **Stateful** (Saved/Deleted/RolledBack/Executed) for audit and automation
- **Umbraco CMS patterns** - Same familiar API as Content/Media notifications
- **Dependency injection** - Full DI support in handlers
- **State propagation** - Pass data between before/after notifications
