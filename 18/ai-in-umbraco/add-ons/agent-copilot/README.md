---
description: >-
    Copilot chat UI add-on for AI agents with sidebar, tool execution, and Human In The Loop (HITL) support.
---

# Agent Copilot

The Agent Copilot add-on (`Umbraco.AI.Agent.Copilot`) provides an interactive AI assistant sidebar in the Umbraco backoffice. It depends on `Umbraco.AI.Agent.UI` (shared chat components), which in turn depends on the Agent Runtime (`Umbraco.AI.Agent`).

## Installation

Install the Copilot package — `Umbraco.AI.Agent.UI` and `Umbraco.AI.Agent` are pulled in transitively:

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
`Umbraco.AI.Agent.Copilot` depends on `Umbraco.AI.Agent.UI`, which depends on `Umbraco.AI.Agent`. Installing Copilot installs all three packages.
{% endhint %}

## Features

- **Sidebar Chat UI** - Conversational interface in the backoffice
- **Content Awareness** - Understands current editing context
- **Tool Execution** - Frontend tools execute in the browser
- **HITL Approval** - Human-in-the-loop confirmation for actions
- **AG-UI Integration** - Real-time streaming responses
- **Entity Selector** - Target specific content items

## Quick Start

### 1. Install the Copilot Package

```bash
dotnet add package Umbraco.AI.Agent.Copilot
```

### 2. Create an Agent for the Copilot Surface

In the backoffice, navigate to the **AI** section > **Agents** and create an agent. To make it available in the Copilot sidebar, tick **Copilot** in the agent's **Surfaces** selection.

The Copilot surface is registered by `CopilotAgentSurface` with `SurfaceId = "copilot"`. At runtime the sidebar loads only agents whose `SurfaceIds` contains `"copilot"`. If more than one agent matches, the Copilot uses Auto mode (see [Copilot Usage](copilot.md)) to route each prompt to the most relevant agent.

### 3. Access the Copilot

The Copilot sidebar appears in sections that declare compatibility with it (Content and Media out of the box). Click the **AI Assistant** button in the backoffice header to toggle the sidebar.

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
│  (Sidebar, Copilot surface, example tools)         │
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

The Copilot package provides:

- Sidebar host and backoffice header app
- The `copilot` agent surface (`CopilotAgentSurface`)
- Example frontend tools

## Documentation

| Section                             | Description                       |
| ----------------------------------- | --------------------------------- |
| [Copilot Usage](copilot.md)         | Using the chat interface          |
| [Frontend Tools](frontend-tools.md) | Creating browser-executable tools |

## Related

- [Agent Runtime](../agent/README.md) - Backend agent functionality
- [Add-ons Overview](../README.md) - All add-on packages
- [AI Contexts](../../concepts/contexts.md) - Brand voice and guidelines
