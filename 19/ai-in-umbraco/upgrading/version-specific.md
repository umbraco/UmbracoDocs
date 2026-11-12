---
description: >-
  Version specific notes for upgrading Umbraco.AI and its add-ons to version 19.
---

# Version Specific Upgrade Notes

This article lists the changes to know about when you upgrade Umbraco.AI and its add-ons from version 18 to version 19.

## Upgrading to version 19

Umbraco.AI 19 runs on Umbraco CMS 19 and .NET 11. Upgrade every Umbraco.AI package to 19 at the same time as the CMS. Umbraco.AI packages share the major version of the CMS they run on.

{% hint style="info" %}

Version 19 is a release candidate (`19.0.0-rc.1`). To install it, pass the version to `dotnet add package`, for example `dotnet add package Umbraco.AI --version 19.0.0-rc.1`. You can also add the `--prerelease` option.

{% endhint %}

### Packages not yet available for version 19

These packages don't have a version 19 release yet:

| Package | Available when |
| --- | --- |
| `Umbraco.AI.Deploy`, `Umbraco.AI.Prompt.Deploy`, `Umbraco.AI.Agent.Deploy` | Umbraco Deploy 19 is released |
| `Umbraco.AI.Automate` | Umbraco Automate 19 is released |

If your site uses one of these packages, wait for its version 19 release before you upgrade.

## Breaking changes

### Removed chat, embedding, and speech-to-text overloads

The service methods marked "Will be removed in v19" are removed. Each one has a replacement that takes an `Action<...Builder> configure` argument as its first parameter.

| Service | Removed | Use instead |
| --- | --- | --- |
| `IAIChatService` | `GetChatResponseAsync(messages, options)` and `GetChatResponseAsync(profileId, messages, options)` | `GetChatResponseAsync(configure, messages)` |
| `IAIChatService` | `GetStreamingChatResponseAsync` (both overloads) | `StreamChatResponseAsync(configure, messages)` |
| `IAIChatService` | `GetChatClientAsync(profileId)` | `CreateChatClientAsync(configure)` |
| `IAIEmbeddingService` | `GenerateEmbeddingAsync(value, ...)` and `GenerateEmbeddingAsync(profileId, value, ...)` | `GenerateEmbeddingAsync(configure, value)` |
| `IAIEmbeddingService` | `GenerateEmbeddingsAsync(values, ...)` and `GenerateEmbeddingsAsync(profileId, values, ...)` | `GenerateEmbeddingsAsync(configure, values)` |
| `IAIEmbeddingService` | `GetEmbeddingGeneratorAsync(profileId)` | `CreateEmbeddingGeneratorAsync(configure)` |
| `IAISpeechToTextService` | `TranscribeAsync(audioStream, options)` and `TranscribeAsync(profileId, audioStream, options)` | `TranscribeAsync(configure, audioStream)` |
| `IAISpeechToTextService` | `GetSpeechToTextClientAsync(profileId)` | `CreateSpeechToTextClientAsync(configure)` |

Every builder needs an alias. Call `.WithAlias(...)` in `configure`, or the call throws an `InvalidOperationException`. Use `.WithProfile(...)` to pick a profile, and `.WithChatOptions(...)`, `.WithEmbeddingOptions(...)`, or `.WithSpeechToTextOptions(...)` to pass options.

The removed methods logged their calls under a fixed alias: `chat`, `embedding`, or `speech-to-text`. Pass the same alias to keep your log and audit entries under the same name.

{% code title="Before (version 18)" %}

```csharp
var response = await _chatService.GetChatResponseAsync(profileId, messages, options);
```

{% endcode %}

{% code title="After (version 19)" %}

```csharp
var response = await _chatService.GetChatResponseAsync(
    chat => chat
        .WithAlias("chat")
        .WithProfile(profileId)
        .WithChatOptions(options),
    messages);
```

{% endcode %}

For more information, see the [IAIChatService](../reference/services/ai-chat-service.md) and [IAIEmbeddingService](../reference/services/ai-embedding-service.md) reference articles.

`AISerializedProperty` is also removed. It was obsolete and unused. Entity data lives in `AISerializedEntity.Data`.

### Usage analytics endpoints

The usage analytics endpoints of the Management API have two replacements: `usage-overview` and `usage-breakdown`. The old endpoints still work in version 19 but are obsolete. They will be removed in version 20.

| Obsolete endpoint | Use instead |
| --- | --- |
| `GET /analytics/usage-summary` | `GET /analytics/usage-overview` |
| `GET /analytics/usage-time-series` | `GET /analytics/usage-overview` |
| `GET /analytics/usage-by-provider` | `GET /analytics/usage-breakdown?dimension=Provider` |
| `GET /analytics/usage-by-model` | `GET /analytics/usage-breakdown?dimension=Model` |
| `GET /analytics/usage-by-profile` | `GET /analytics/usage-breakdown?dimension=Profile` |
| `GET /analytics/usage-by-user` | `GET /analytics/usage-breakdown?dimension=User` |

The new endpoints take whole local days (`from` and `to` as `yyyy-MM-dd`) and a time zone. They return raw counts for the range and, optionally, for a comparison range. For more information, see the [Analytics API](../management-api/analytics/README.md) article.

The Usage dashboard in the backoffice now uses these endpoints. For more information, see the [Usage Analytics](../backoffice/usage-analytics.md) article.

### Search tool uses CMS search

The built-in `search_umbraco` tool now searches through the CMS search abstractions instead of Examine. It searches the published content index and the media index.

`SearchUmbracoTool` constructors no longer take an `IExamineManager`. Update any code that creates or extends the tool.

Results can differ from version 18. The tool first looks for items that match every word of the query. When that finds too little, it searches for each word on its own.

### Anthropic sampling settings

Anthropic API version 2026-10-21 removed `temperature`, `top_p`, and `top_k`. The Anthropic provider no longer sends sampling settings for any Claude model. A temperature saved on a profile stays saved, but it doesn't reach the request. The profile editor hides the field for Anthropic models.

`Umbraco.AI.Anthropic` now uses version 13 of the Anthropic SDK. Update your code if it references the SDK directly.

### Agent frontend on AG-UI 1.x

The `@umbraco-ai/agent` package now uses version 1.x of `@ag-ui/client` and `@ag-ui/core`. This affects you if you build on the agent client or its AG-UI types:

* Approval resume entries now travel in `RunAgentInput.resume` instead of `forwardedProps.resume`. A custom `AgentTransport`, or code that calls `UaiHttpAgent.run` directly, must set `input.resume`. Otherwise approvals never resume, and the user is asked again.
* `AgentTransport.run` takes the AG-UI 1.x `RunAgentInput`.
* `EventType` no longer has the `THINKING_*` members. It has new `SUBAGENT_*` members.
* `ToolMessage.content` and `ToolCallResultEvent.content` are now `string | ContentPart[]`.
* `RunFinishedOutcome` has a new `cancelled` variant.
* `zod` is now a dependency of `@umbraco-ai/agent`.

### ImageSharp 4 and image re-encoding

Umbraco.AI 19 depends on SixLabors.ImageSharp 4, the version that Umbraco CMS 19 uses. Update any code in your site that uses ImageSharp 3 APIs.

When an image is resized or cropped before it goes to a provider, Umbraco.AI re-encodes it. An image with transparent pixels stays PNG. Other images become JPEG. A PNG with an alpha channel but no transparent pixels is now sent as JPEG. In version 18, it stayed PNG.

### Database migrations run earlier at startup

Umbraco.AI and its add-ons now run their database migrations on `PostRuntimePremigrationsUpgradeNotification`. This is before any `UmbracoApplicationStartingNotification` handler runs. Startup work in other packages, such as an Umbraco Deploy import on start, finds the AI tables in place.

On `RunAIMigrationNotificationHandler`, the `HandleAsync(UmbracoApplicationStartedNotification, ...)` overload is obsolete. It will be removed in version 20.

A failed migration is still logged without stopping the site.

## Umbraco Deploy

These changes apply when the Deploy Support packages are released for version 19.

* `UmbracoAIDeployComponent`, `UmbracoAIPromptDeployComponent`, and `UmbracoAIAgentDeployComponent` no longer take an `IDiskEntityService` constructor parameter. Umbraco Deploy 19 removed the method they used it for. The composers now register the disk entity types through `DeployEntityTypesOptions`.
* On a site that uses SQLite, give Umbraco.AI its own database with an `umbracoAIDbDSN` connection string. When Umbraco.AI shares the SQLite file with the CMS, a Deploy import can fail with "database is locked".

{% code title="appsettings.json" %}

```json
{
    "ConnectionStrings": {
        "umbracoAIDbDSN": "Data Source=|DataDirectory|/Umbraco.AI.sqlite.db;Cache=Shared;Foreign Keys=True;Pooling=True",
        "umbracoAIDbDSN_ProviderName": "Microsoft.Data.Sqlite"
    }
}
```

{% endcode %}
