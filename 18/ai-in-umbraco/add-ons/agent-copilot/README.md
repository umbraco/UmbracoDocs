---
description: >-
    Contextual Copilot chat UI add-on for AI agents with sidebar, tool execution, and Human In The Loop (HITL) support.
---

# Contextual Copilot

The Contextual Copilot add-on (`Umbraco.AI.Agent.Copilot`) provides an interactive AI assistant sidebar in the Umbraco backoffice, scoped to the content or media item currently being edited. It depends on `Umbraco.AI.Agent.UI` (shared chat components), which in turn depends on the Agent Runtime (`Umbraco.AI.Agent`).

{% hint style="info" %}
In the Umbraco backoffice itself, this add-on's sidebar and its agent surface are both labeled **Copilot**. This documentation uses **Contextual Copilot** to distinguish it from [Copilot Workspace](../copilot-workspace/README.md) (`Umbraco.AI.Agent.Copilot.Workspace`), a separate add-on for broader, persisted, cross-site conversations. Where a step below tells you to tick or select an on-screen option, that option is exactly as labeled in the backoffice.
{% endhint %}

## Installation

Install the Contextual Copilot package — `Umbraco.AI.Agent.UI` and `Umbraco.AI.Agent` are pulled in transitively:

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Agent.Copilot
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Agent.Copilot
```

{% endcode %}

{% hint style="info" %}
`Umbraco.AI.Agent.Copilot` depends on `Umbraco.AI.Agent.UI`, which depends on `Umbraco.AI.Agent`. Installing Contextual Copilot installs all three packages.
{% endhint %}

## Features

- **Sidebar Chat UI** - Conversational interface in the backoffice
- **Content Awareness** - Understands current editing context
- **Tool Execution** - Frontend tools execute in the browser
- **HITL Approval** - Human-in-the-loop confirmation for actions
- **AG-UI Integration** - Real-time streaming responses
- **Entity Selector** - Target specific content items

## Quick Start

### Step 1: Install the Contextual Copilot Package

```bash
dotnet add package Umbraco.AI.Agent.Copilot
```

### Step 2: Create an Agent for the Contextual Copilot Surface

In the backoffice, navigate to the **AI** section > **Agents** and create an agent. To make it available in the Contextual Copilot sidebar, tick **Copilot** in the agent's **Surfaces** selection. This is the option registered by the Contextual Copilot add-on, as distinct from the **Copilot Workspace** option next to it.

The Contextual Copilot surface is registered by `CopilotAgentSurface` with `SurfaceId = "copilot"`. At runtime the sidebar loads only agents whose `SurfaceIds` contains `"copilot"`. If more than one agent matches, Contextual Copilot uses Auto mode (see [Usage](copilot.md)) to route each prompt to the most relevant agent.

### Step 3: Access Contextual Copilot

The Contextual Copilot sidebar appears in sections that declare compatibility with it (Content and Media out of the box). Open a content or media item and click the floating **AI Assistant** button in the bottom-right corner of the workspace to toggle the sidebar.

## Package Architecture

```
┌───────────────────────────────────────────────────┐
│                 Umbraco.AI.Agent                   │
│  (Backend APIs, Agent Definitions, AG-UI streaming)│
└───────────────────────────────────────────────────┘
                        ▲
                        │ depends on
                        │
┌───────────────────────────────────────────────────┐
│               Umbraco.AI.Agent.UI                  │
│  (Shared chat components, frontend tool manager)   │
└───────────────────────────────────────────────────┘
                        ▲
                        │ depends on
                        │
┌───────────────────────────────────────────────────┐
│            Umbraco.AI.Agent.Copilot                │
│    (Sidebar, Contextual Copilot, example tools)    │
└───────────────────────────────────────────────────┘
```

The Agent package provides:

- Agent CRUD operations
- AG-UI streaming endpoints (`StreamAgentAGUIAsync`)
- Backend tool execution
- Management API

The Agent UI package provides:

- Shared chat element (`<uai-chat>`)
- Frontend tool manager and executor
- HITL approval infrastructure and the `uaiAgentFrontendTool` / `uaiAgentToolRenderer` manifest types

The Contextual Copilot package provides:

- Sidebar host and the floating trigger button shown in supported workspaces
- The `copilot` agent surface (`CopilotAgentSurface`)
- Example frontend tools

## Documentation

| Section                             | Description                       |
| ----------------------------------- | --------------------------------- |
| [Usage](copilot.md)                 | Using the chat interface          |
| [Frontend Tools](frontend-tools.md) | Creating browser-executable tools |

## Related

- [Copilot Workspace](../copilot-workspace/README.md) - Broader, cross-site AI conversations with persisted history and projects
- [Agent Runtime](../agent/README.md) - Backend agent functionality
- [Add-ons Overview](../README.md) - All add-on packages
- [AI Contexts](../../concepts/contexts.md) - Brand voice and guidelines
