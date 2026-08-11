---
description: >-
    Understand the core concepts that make up Umbraco.AI's architecture.
---

# Core Concepts

Umbraco.AI is built around a hierarchical configuration model that separates concerns and enables flexibility. Understanding these concepts helps you make the most of the platform.

## The Configuration Hierarchy

```mermaid
graph TD
    A["Provider\n(plugin with capabilities)"] --> B["Connection\n(authentication/credentials)"]
    B --> C["Profile\n(use-case configuration)"]
    C --> D["AI Request\n(the actual call)"]
```

Each level adds configuration that flows down to the actual AI request.

## Key Concepts

<table data-view="cards">
<thead>
<tr>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Providers</strong></td>
<td>Installable plugins that connect to AI services like OpenAI or Azure</td>
</tr>
<tr>
<td><strong>Connections</strong></td>
<td>Store credentials and endpoint settings for a provider</td>
</tr>
<tr>
<td><strong>Profiles</strong></td>
<td>Combine a connection with model settings for specific use cases</td>
</tr>
<tr>
<td><strong>Capabilities</strong></td>
<td>The types of AI operations available: Chat, Embedding, and more</td>
</tr>
<tr>
<td><strong>Middleware</strong></td>
<td>Extensible pipeline for logging, caching, and custom behavior</td>
</tr>
<tr>
<td><strong>Guardrails</strong></td>
<td>Rules that evaluate AI inputs and responses for safety and compliance</td>
</tr>
</tbody>
</table>

## Built on Microsoft.Extensions.AI

Umbraco.AI is built on [Microsoft.Extensions.AI](https://learn.microsoft.com/en-us/dotnet/ai/ai-extensions), Microsoft's official abstraction for AI services. Building on M.E.AI provides:

- Standard types like `IChatClient`, `ChatMessage`, and `ChatResponse`
- Familiar patterns for .NET developers
- Compatibility with the broader M.E.AI ecosystem
- Compatible with future M.E.AI releases

The service layer in Umbraco.AI is lightweight - it adds Umbraco-specific features (profiles, connections, backoffice UI) while exposing standard M.E.AI types.

## In This Section

{% content-ref url="providers.md" %}
[Providers](providers.md)
{% endcontent-ref %}

{% content-ref url="connections.md" %}
[Connections](connections.md)
{% endcontent-ref %}

{% content-ref url="profiles.md" %}
[Profiles](profiles.md)
{% endcontent-ref %}

{% content-ref url="capabilities.md" %}
[Capabilities](capabilities.md)
{% endcontent-ref %}

{% content-ref url="middleware.md" %}
[Middleware](middleware.md)
{% endcontent-ref %}

{% content-ref url="guardrails.md" %}
[Guardrails](guardrails.md)
{% endcontent-ref %}
