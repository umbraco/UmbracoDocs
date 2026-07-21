---
description: >-
    Ship background knowledge about your product to the AI by dropping a decorated class into your package.
---

# Knowledge Sets

A knowledge set is a code-defined, package-embeddable collection of background knowledge about a subject — for example a product such as Umbraco Engage — that is surfaced to the AI. A package author ships knowledge by dropping a single decorated class into an assembly: it is discovered at startup, needs no configuration, and its content flows to the model on demand.

Knowledge sets are the content complement to [Contexts](../../concepts/contexts.md): context resource types define the _shape_ of context, while knowledge sets provide ready-made _content_.

## Overview

Each knowledge set:

- Has a stable ID, a display name, and an optional description and icon
- Contains one or more **items** (shown as "Topics" in the backoffice), each a chunk of markdown
- Is auto-discovered at startup via the `[AIKnowledgeSet]` attribute — no registration code
- Is auto-active — installed sets are available to every request with nothing to configure
- Is surfaced **on demand** — the model retrieves an item's content only when it is relevant

## How It Works

Installed knowledge sets flow through the same context resolution pipeline as contexts. For each request, the AI is shown a grouped list of the available items — each item's name and description act as a breadcrumb — and the model pulls an item's full markdown content only when it decides the item is relevant. Item content is produced lazily, so listing a set never loads its content.

## Creating a Knowledge Set

Derive from `AIKnowledgeSetBase`, decorate the class with `[AIKnowledgeSet]`, and override `GetItemsAsync` to return the items. Use `AIKnowledgeSetItem.FromContent` for static markdown:

{% code title="EngageKnowledgeSet.cs" %}

```csharp
using Umbraco.AI.Core.Contexts.KnowledgeSets;

[AIKnowledgeSet("umbraco-engage", "Umbraco Engage",
    Description = "Background knowledge about Umbraco Engage.",
    Icon = "icon-book")]
public sealed class EngageKnowledgeSet : AIKnowledgeSetBase
{
    public override Task<IReadOnlyList<AIKnowledgeSetItem>> GetItemsAsync(
        CancellationToken cancellationToken = default)
    {
        IReadOnlyList<AIKnowledgeSetItem> items =
        [
            AIKnowledgeSetItem.FromContent(
                key: "goals",
                name: "Goals",
                content: "# Goals\nEngage goals let you track conversions across a visit...",
                description: "How goals work in Umbraco Engage."),
        ];

        return Task.FromResult(items);
    }
}
```

{% endcode %}

That is the complete happy path. On startup the class is discovered, and its items become knowledge the AI can draw on — no further wiring required.

### Loading Content Dynamically

`FromContent` wraps a literal string. When an item's content needs to be built at request time — for example loaded from a service — set `GetContentAsync` directly instead. The producer is invoked lazily, only when the content is actually retrieved:

{% code title="Dynamic item" %}

```csharp
new AIKnowledgeSetItem
{
    Key = "segments",
    Name = "Segments",
    Description = "The audience segments configured on this site.",
    GetContentAsync = async token => await _segmentService.GetSegmentsMarkdownAsync(token),
}
```

{% endcode %}

## AIKnowledgeSetItem

| Property | Type | Description |
| --- | --- | --- |
| `Key` | `string` | Stable, URL-safe identity within the set (e.g. `"goals"`). Keep it stable across renames. |
| `Name` | `string` | Display name, shown in the backoffice. |
| `Description` | `string?` | The breadcrumb the AI sees when the item is advertised — write it to help the model decide whether to retrieve the item. |
| `GetContentAsync` | `Func<CancellationToken, Task<string>>` | Lazily produces the markdown content, injected as-is when retrieved. |

## Registration

Knowledge sets are auto-discovered via the `[AIKnowledgeSet]` attribute and the `IDiscoverable` interface. No manual registration is needed.

To add a set that isn't auto-discovered, or to exclude one, use the collection builder in a Composer:

{% code title="KnowledgeSetComposer.cs" %}

```csharp
using Umbraco.AI.Extensions;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

public class KnowledgeSetComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIKnowledgeSets()
            .Add<EngageKnowledgeSet>()
            .Exclude<LegacyKnowledgeSet>();
    }
}
```

{% endcode %}

## Viewing Installed Knowledge Sets

Installed sets appear under **AI Configuration > Knowledge Sets** in the backoffice. This view is read-only: you can browse the installed sets and open a topic to inspect its content. Knowledge sets are defined in code, so they cannot be created or edited from the backoffice.

## Related

- [Contexts](../../concepts/contexts.md) - Injecting brand voice, guidelines, and content into AI operations
- [Custom Tools](../tools/README.md) - Give AI agents actions to perform
