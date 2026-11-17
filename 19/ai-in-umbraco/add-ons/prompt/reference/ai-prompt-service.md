---
description: >-
    Service for managing and executing prompts.
---

# IAIPromptService

Service for prompt CRUD operations and execution.

## Namespace

```csharp
using Umbraco.AI.Prompt.Core.Prompts;
```

## Interface

{% code title="IAIPromptService" %}

```csharp
public interface IAIPromptService
{
    Task<AIPrompt?> GetPromptAsync(Guid id, CancellationToken cancellationToken = default);

    Task<AIPrompt?> GetPromptByAliasAsync(string alias, CancellationToken cancellationToken = default);

    Task<IEnumerable<AIPrompt>> GetPromptsAsync(CancellationToken cancellationToken = default);

    Task<(IEnumerable<AIPrompt> Items, int Total)> GetPromptsPagedAsync(
        int skip,
        int take,
        string? filter = null,
        Guid? profileId = null,
        CancellationToken cancellationToken = default);

    Task<AIPrompt> SavePromptAsync(AIPrompt prompt, CancellationToken cancellationToken = default);

    Task<bool> DeletePromptAsync(Guid id, CancellationToken cancellationToken = default);

    Task<bool> PromptsExistWithProfileAsync(Guid profileId, CancellationToken cancellationToken = default);

    Task<bool> PromptAliasExistsAsync(string alias, Guid? excludeId = null, CancellationToken cancellationToken = default);

    Task<AIPromptExecutionResult> ExecutePromptAsync(
        Guid promptId,
        AIPromptExecutionRequest request,
        CancellationToken cancellationToken = default);

    Task<AIPromptExecutionResult> ExecutePromptAsync(
        Guid promptId,
        AIPromptExecutionRequest request,
        AIPromptExecutionOptions options,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Methods

### GetPromptAsync

Gets a prompt by its unique identifier.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The prompt ID      |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The prompt if found, otherwise `null`.

### GetPromptByAliasAsync

Gets a prompt by its alias.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `alias`             | `string`            | The prompt alias   |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The prompt if found, otherwise `null`.

### GetPromptsAsync

Gets all prompts.

**Returns**: All prompts in the system.

### GetPromptsPagedAsync

Gets prompts with pagination and filtering.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `skip`              | `int`               | Items to skip      |
| `take`              | `int`               | Items to take      |
| `filter`            | `string?`           | Filter by name or alias |
| `profileId`         | `Guid?`             | Filter by profile  |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: A tuple `(IEnumerable<AIPrompt> Items, int Total)` containing the filtered page and the total count.

### SavePromptAsync

Creates or updates a prompt. If `Id` is `Guid.Empty`, a new GUID is generated.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `prompt`            | `AIPrompt`          | The prompt to save |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The saved prompt with ID and version.

### DeletePromptAsync

Deletes a prompt by ID.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The prompt ID      |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: `true` if deleted, `false` if not found.

### PromptsExistWithProfileAsync

Checks whether any prompts reference the specified profile.

| Parameter           | Type                | Description            |
| ------------------- | ------------------- | ---------------------- |
| `profileId`         | `Guid`              | The profile ID         |
| `cancellationToken` | `CancellationToken` | Cancellation token     |

**Returns**: `true` if one or more prompts reference the profile.

### PromptAliasExistsAsync

Checks if an alias is in use.

| Parameter           | Type                | Description            |
| ------------------- | ------------------- | ---------------------- |
| `alias`             | `string`            | The alias to check     |
| `excludeId`         | `Guid?`             | Optional ID to exclude |
| `cancellationToken` | `CancellationToken` | Cancellation token     |

**Returns**: `true` if alias exists.

### ExecutePromptAsync

Executes a prompt and returns the AI response. Two overloads are available: one that uses the prompt's configured profile, contexts, and scope enforcement, and one that accepts an `AIPromptExecutionOptions` argument to override these.

| Parameter           | Type                       | Description                                   |
| ------------------- | -------------------------- | --------------------------------------------- |
| `promptId`          | `Guid`                     | The prompt ID                                 |
| `request`           | `AIPromptExecutionRequest` | Execution parameters                          |
| `options`           | `AIPromptExecutionOptions` | (Second overload) Validation and overrides    |
| `cancellationToken` | `CancellationToken`        | Cancellation token                            |

**Returns**: An `AIPromptExecutionResult` with the generated content, optional usage information, the chat messages that were sent, and the list of result options.

{% code title="ExecutePromptAsync.cs" %}

```csharp
var result = await _promptService.ExecutePromptAsync(
    promptId,
    new AIPromptExecutionRequest
    {
        EntityId = contentId,
        EntityType = "document",
        PropertyAlias = "metaDescription",
        ContentTypeAlias = "article"
    });

Console.WriteLine($"Content: {result.Content}");
if (result.Usage is not null)
{
    Console.WriteLine($"Tokens used: {result.Usage.TotalTokenCount}");
}
```

{% endcode %}

## Related Models

### AIPromptExecutionRequest

{% code title="AIPromptExecutionRequest" %}

```csharp
public class AIPromptExecutionRequest
{
    public required Guid EntityId { get; init; }
    public required string EntityType { get; init; }
    public required string PropertyAlias { get; init; }
    public required string ContentTypeAlias { get; init; }
    public Guid? ElementId { get; init; }
    public string? ElementType { get; init; }
    public string? Culture { get; init; }
    public string? Segment { get; init; }
    public IReadOnlyList<AIRequestContextItem>? Context { get; init; }
}
```

{% endcode %}

| Property           | Type                                    | Required | Description                                                                                  |
| ------------------ | --------------------------------------- | -------- | -------------------------------------------------------------------------------------------- |
| `EntityId`         | `Guid`                                  | Yes      | The entity (document, media, etc.) key. Used for scope validation and entity context lookup. |
| `EntityType`       | `string`                                | Yes      | The entity type (for example `document` or `media`).                                         |
| `PropertyAlias`    | `string`                                | Yes      | The property alias being edited.                                                             |
| `ContentTypeAlias` | `string`                                | Yes      | The content type alias (or element type alias when editing a block).                         |
| `ElementId`        | `Guid?`                                 | No       | Block content key when executing inside a block element.                                     |
| `ElementType`      | `string?`                               | No       | Element type identifier when executing inside a block element.                               |
| `Culture`          | `string?`                               | No       | Culture/language variant (for example `en-US`).                                              |
| `Segment`          | `string?`                               | No       | Segment variant.                                                                             |
| `Context`          | `IReadOnlyList<AIRequestContextItem>?` | No       | Additional context items passed from the frontend. Processed by runtime context contributors to populate template variables and system messages. |

### AIPromptExecutionResult

{% code title="AIPromptExecutionResult" %}

```csharp
public class AIPromptExecutionResult
{
    public required string Content { get; init; }
    public UsageDetails? Usage { get; init; }
    public IReadOnlyList<ChatMessage>? Messages { get; init; }
    public required IReadOnlyList<AIPromptResultOption> ResultOptions { get; init; }
}
```

{% endcode %}

| Property        | Type                                    | Description                                                                                      |
| --------------- | --------------------------------------- | ------------------------------------------------------------------------------------------------ |
| `Content`       | `string`                                | The generated response content.                                                                  |
| `Usage`         | `UsageDetails?`                         | Token usage information from `Microsoft.Extensions.AI`.                                          |
| `Messages`      | `IReadOnlyList<ChatMessage>?`           | The chat messages sent to the AI model (system messages, processed user template).               |
| `ResultOptions` | `IReadOnlyList<AIPromptResultOption>`   | Result options. Empty for informational prompts, a single entry for single-value prompts, multiple entries when the prompt is configured to generate options. |

Each `AIPromptResultOption` exposes:

| Property       | Type              | Description                                                       |
| -------------- | ----------------- | ----------------------------------------------------------------- |
| `Label`        | `string`          | Short title for the option.                                       |
| `DisplayValue` | `string`          | Value displayed in the UI.                                        |
| `Description`  | `string?`         | Optional explanation for the option.                              |
| `ValueChange`  | `AIValueChange?`  | The change to apply when the option is selected (null when the option is informational only). |

### AIPromptExecutionOptions

{% code title="AIPromptExecutionOptions" %}

```csharp
public class AIPromptExecutionOptions
{
    public bool ValidateScope { get; init; } = true;
    public Guid? ProfileIdOverride { get; init; }
    public IReadOnlyList<Guid>? ContextIdsOverride { get; init; }
    public IReadOnlyList<Guid>? GuardrailIdsOverride { get; init; }
}
```

{% endcode %}

| Property               | Type                       | Description                                                                                    |
| ---------------------- | -------------------------- | ---------------------------------------------------------------------------------------------- |
| `ValidateScope`        | `bool`                     | Whether to enforce the prompt's scope rules before execution (default `true`).                 |
| `ProfileIdOverride`    | `Guid?`                    | Overrides the prompt's configured profile (useful for cross-model testing).                    |
| `ContextIdsOverride`   | `IReadOnlyList<Guid>?`     | Overrides the prompt's configured context IDs.                                                 |
| `GuardrailIdsOverride` | `IReadOnlyList<Guid>?`     | Overrides the guardrail IDs evaluated during execution.                                        |

## Related

- [AIPrompt Model](ai-prompt.md) - Prompt model reference
- [Prompt Concepts](../concepts.md) - Concepts overview
