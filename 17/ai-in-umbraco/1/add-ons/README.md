---
description: >-
    Add-on packages that extend Umbraco.AI with additional capabilities.
---

# Add-ons

Umbraco.AI can be extended with add-on packages that provide specialized functionality. Each add-on builds on the core AI infrastructure while adding domain-specific features.

## Available Add-ons

| Add-on                                   | Package                    | Description                                            |
| ---------------------------------------- | -------------------------- | ------------------------------------------------------ |
| [Prompt Management](prompt/README.md)    | `Umbraco.AI.Prompt`        | Create, manage, and execute reusable prompt templates  |
| [Agent Runtime](agent/README.md)         | `Umbraco.AI.Agent`         | Configure and run AI agents with streaming responses   |
| [Agent Copilot](agent-copilot/README.md) | `Umbraco.AI.Agent.Copilot` | Chat sidebar UI for agent interaction (requires Agent) |
| [Semantic Search](search/README.md)      | `Umbraco.AI.Search`        | AI-powered vector search for content and media         |
| [Deploy Support](deploy/README.md)       | `Umbraco.AI.Deploy`        | Deploy AI configuration across environments            |

## Architecture

Add-ons depend on the core `Umbraco.AI` package and extend its capabilities:

```
┌─────────────────────────────────────────────────────────────────┐
│                      Your Application                            │
├─────────────────────────────────────────────────────────────────┤
│                                  ┌──────────────────────────┐   │
│                                  │ Umbraco.AI.Agent.Copilot │   │
│                                  │     (Chat UI Add-on)     │   │
│                                  └────────────┬─────────────┘   │
│                                               │                 │
│   ┌───────────────────┐      ┌────────────────▼───────────┐     │
│   │ Umbraco.AI.Prompt │      │     Umbraco.AI.Agent       │     │
│   │   (Prompt Mgmt)   │      │     (Agent Runtime)        │     │
│   └────────┬──────────┘      └─────────────┬──────────────┘     │
│            │                               │                    │
│            └───────────────┬───────────────┘                    │
│                            │                                    │
│                  ┌─────────▼─────────┐                          │
│                  │    Umbraco.AI     │                          │
│                  │      (Core)       │                          │
│                  └─────────┬─────────┘                          │
│                            │                                    │
│           ┌────────────────┼───────────────┐                    │
│           │                │               │                    │
│      ┌────▼─────┐    ┌─────▼─────┐    ┌────▼─────┐              │
│      │ OpenAI   │    │ Anthropic │    │ Google   │  ...        │
│      │ Provider │    │ Provider  │    │ Provider │              │
│      └──────────┘    └───────────┘    └──────────┘              │
└─────────────────────────────────────────────────────────────────┘
```

## Installing Add-ons

Add-ons are installed via NuGet alongside the core package:

{% code title="Package Manager Console" %}

```powershell
# Install core (required)
Install-Package Umbraco.AI

# Install a provider (at least one required)
Install-Package Umbraco.AI.OpenAI

# Install add-ons (optional)
Install-Package Umbraco.AI.Prompt
Install-Package Umbraco.AI.Agent

# Install Deploy support (requires Umbraco Deploy)
Install-Package Umbraco.AI.Deploy
Install-Package Umbraco.AI.Prompt.Deploy
Install-Package Umbraco.AI.Agent.Deploy
```

{% endcode %}

## Common Features

All add-ons share these features from the core package:

- **Version History** - Track changes to prompts and agents
- **Audit Logging** - Log all AI operations
- **Backoffice UI** - Manage through the Umbraco backoffice
- **Management API** - RESTful API for programmatic access
- **Context Injection** - Use AI Contexts for brand voice and guidelines

## Add-on Databases

Add-ons that store data have their own database tables with a package-specific prefix:

| Add-on | Migration Prefix   |
| ------ | ------------------ |
| Prompt | `UmbracoAIPrompt_` |
| Agent  | `UmbracoAIAgent_`  |
| Search | `UmbracoAISearch_` |

{% hint style="info" %}
Agent Copilot and Deploy packages are integration-only packages with no database tables.
{% endhint %}

Migrations run automatically on application startup.

## Related

- [Umbraco.AI Core](../getting-started/README.md) - Core package documentation
- [Providers](../providers/README.md) - AI provider configuration
