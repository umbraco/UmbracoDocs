---
description: >-
    Copilot Workspace add-on: a full backoffice section for broad, cross-site AI conversations with persisted history and projects.
---

# Copilot Workspace

The Copilot Workspace add-on (`Umbraco.AI.Agent.Copilot.Workspace`) provides a full backoffice section for AI conversations that go beyond a single content or media item. It depends on the Agent Runtime (`Umbraco.AI.Agent`) and ships its own persistence, so conversations and projects survive across sessions.

{% hint style="info" %}
Copilot Workspace complements [Contextual Copilot](../agent-copilot/copilot.md), the existing docked sidebar scoped to the item you're editing. Both ship under the same **Copilot** brand in the backoffice. This section itself is labeled **Copilot**, with a **Workspace** dashboard sub-label. Contextual Copilot's sidebar and surface picker option are both labeled plain **Copilot** too. This documentation always says **Contextual Copilot** or **Copilot Workspace** to keep the two clear. Use Contextual Copilot for quick, in-context help while editing. Use Copilot Workspace for broader, cross-site tasks, or when you want a durable, searchable history of your conversations with AI.
{% endhint %}

## Installation

Install the Copilot Workspace package -- `Umbraco.AI.Agent` is pulled in transitively:

```powershell
Install-Package Umbraco.AI.Agent.Copilot.Workspace
```

Or via .NET CLI:

```bash
dotnet add package Umbraco.AI.Agent.Copilot.Workspace
```

{% hint style="info" %}
Copilot Workspace stores conversations and projects in its own database tables (migration prefix `UmbracoAIConversations_`). Contextual Copilot has no database of its own. Migrations run automatically on application startup.
{% endhint %}

## Features

- **Persisted Conversations** - Durable, searchable chat history stored server-side.
- **Projects** - Group conversations under shared instructions and reusable context/resources.
- **Context Panel** - See and manage the instructions, contexts, and resources grounding the current conversation.
- **Archived Conversations** - Archive conversations instead of deleting them, with a read-only recycle bin.
- **Pin, Rename, Move** - Organize conversations, including moving them between projects.
- **AG-UI Integration** - Real-time streaming responses, reusing the same chat UI as Contextual Copilot.

## Quick Start

### Step 1: Install the Copilot Workspace Package

```bash
dotnet add package Umbraco.AI.Agent.Copilot.Workspace
```

### Step 2: Create an Agent for the Copilot Workspace Surface

In the backoffice, navigate to the **AI** section > **Agents** and create an agent. To make it available in Copilot Workspace, tick **Copilot Workspace** in the agent's **Surfaces** selection.

The Copilot Workspace surface is registered with `SurfaceId = "copilot-workspace"`. Unlike Contextual Copilot, which shows agents scoped to the current section and entity type, Copilot Workspace availability depends solely on this surface opt-in. An agent enabled here is available everywhere in the Workspace.

### Step 3: Access Copilot Workspace

Copilot Workspace is its own backoffice section, labeled **Copilot** in the section rail. By default, it's assigned to the **Administrators** user group — grant other user groups access to the section if needed.

## Package Architecture

```
┌───────────────────────────────────────────────────────────┐
│                    Umbraco.AI.Agent                        │
│       (Backend APIs, Agent Definitions, AG-UI streaming)   │
└───────────────────────────────────────────────────────────┘
                        ▲
                        │ depends on
                        │
┌───────────────────────────────────────────────────────────┐
│         Umbraco.AI.Agent.Copilot.Workspace                 │
│  (Section UI, Workspace agent surface, Conversations)      │
│                                                             │
│  ┌───────────────────────────────────────────────────┐    │
│  │       Umbraco.AI.Agent.Conversations.*             │    │
│  │  (durable conversation/message/project store)      │    │
│  └───────────────────────────────────────────────────┘    │
└───────────────────────────────────────────────────────────┘
```

Installing `Umbraco.AI.Agent.Copilot.Workspace` pulls in its `Umbraco.AI.Agent.Conversations.*` sub-packages transitively — there is nothing extra to install for persistence to work.

The Copilot Workspace package provides:

- A standalone backoffice section (three regions: conversation/project sidebar, center chat, context panel).
- The `copilot-workspace` agent surface.
- Projects (instructions, contexts, and resources shared across a project's conversations).
- The `Conversations` persistence layer (conversation/message/project domain, repositories, and a `ChatHistoryProvider` bridge into the agent runtime).

## Documentation

| Section                          | Description                                    |
| --------------------------------- | ----------------------------------------------- |
| [Usage](copilot-workspace.md)     | Conversations, projects, and the context panel |

## Related

- [Contextual Copilot](../agent-copilot/copilot.md) - The contextual sidebar, scoped to the item you have open
- [Agent Runtime](../agent/README.md) - Backend agent functionality
- [Add-ons Overview](../README.md) - All add-on packages
- [AI Contexts](../../concepts/contexts.md) - Brand voice and guidelines
