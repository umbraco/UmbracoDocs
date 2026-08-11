---
description: >-
    The AI Copilot provides an interactive assistant sidebar in the Umbraco backoffice.
---

# Copilot

The Copilot is an AI-powered assistant that appears as a sidebar in the Umbraco backoffice. It provides conversational AI capabilities directly within your content editing workflow.

## Accessing the Copilot

The Copilot is available in the **Content** and **Media** sections:

1. Look for the **AI Assistant** button in the header
2. Click to toggle the sidebar open/closed
3. The button shows an active state when the sidebar is open

{% hint style="info" %}
The Copilot button only appears in sections where it's relevant (Content and Media).
{% endhint %}

![The AI Copilot sidebar showing a conversation in the Umbraco backoffice](../../.gitbook/assets/copilot-sidebar.png)

## Features

### Conversational Interface

Chat naturally with the AI assistant:

- Ask questions about your content
- Request suggestions and improvements
- Get help with writing tasks
- Multi-turn conversations maintain context

### Content Awareness

The Copilot understands your current editing context:

- Current content item being edited
- Property values and structure
- Content type information
- Media items and relationships

### Tool Execution

Agents can execute tools to interact with Umbraco:

- Read property values
- Update content fields
- Navigate to related content
- Perform custom actions

### Human-in-the-Loop Approval

For sensitive operations, the Copilot requests confirmation:

The approval workflow ensures editors maintain control over content changes.

![The Human-in-the-Loop approval dialog with Approve and Deny buttons](../../.gitbook/assets/copilot-hitl-approval.png)

## Configuring Copilot Agents

Agents power the Copilot's capabilities. Any agent in the **AI > Agents** backoffice section that is associated with the **Copilot** surface becomes available inside the sidebar.

### Opting an agent into the Copilot

The Copilot package registers an agent surface via `CopilotAgentSurface` with `SurfaceId = "copilot"`. When editing an agent in the backoffice, tick **Copilot** in the **Surfaces** selection to expose it to the sidebar. Internally this adds `"copilot"` to the agent's `SurfaceIds` collection, and the sidebar loads agents filtered by that surface ID.

If only one agent is associated with the Copilot surface, the sidebar uses it directly. If multiple agents are available, the Copilot uses Auto mode to route each prompt (see below).

### Agent Instructions

Configure agent instructions for Copilot behavior:

```
You are an AI assistant helping editors create content in Umbraco.

Your capabilities:
- Suggest improvements to content
- Help with writing and editing
- Answer questions about the current page
- Update properties when asked

Always be helpful and concise.
```

## Auto Mode and Agent Routing

When multiple agents are available on a surface, the Copilot uses "Auto" mode to automatically select the best agent for each user message. Auto mode works by sending the user's prompt to a classifier model that picks an agent based on each agent's name and description.

### Classifier Profile

By default, the classifier uses the default chat profile, which may be a powerful (and expensive) model. Since classification only returns a single GUID, you can configure a cheaper or faster model specifically for this task:

1. Navigate to the **AI** section > **Settings**
2. Set the **Classifier Chat Profile** to a lightweight model (e.g., GPT-4o Mini, Claude Haiku)
3. Save

See [Settings](../../concepts/settings.md#classifier-chat-profile) for more details on the fallback chain.

## Related

- [Agent Runtime](../agent/README.md) - Backend agent functionality
- [Frontend Tools](frontend-tools.md) - Custom tool integrations
