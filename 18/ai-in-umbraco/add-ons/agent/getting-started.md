---
description: >-
    Get started with Agent Runtime.
---

# Getting Started with Agents

This guide walks you through creating your first AI agent and using it via the Copilot sidebar.

## Prerequisites

Before starting, ensure you have:

- Umbraco.AI installed and configured
- At least one AI connection set up
- At least one chat profile created

## Step 1: Install the Packages

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Agent
Install-Package Umbraco.AI.Agent.Copilot
```

{% endcode %}

Restart your application to run database migrations.

{% hint style="info" %}
The Agent Copilot package provides the sidebar UI. Without it, agents can only be used programmatically.
{% endhint %}

## Step 2: Create an Agent

1. Navigate to the **AI** section > **Agents**
2. Click **Create Agent**
3. Fill in the details:

| Field        | Value                          |
| ------------ | ------------------------------ |
| Alias        | `writing-assistant`            |
| Name         | Writing Assistant              |
| Description  | Helps improve and edit content |
| Instructions | See below                      |
| Profile      | (select your chat profile)     |

**Instructions:**

```
You are a helpful writing assistant for a content management system.

Your capabilities:
- Improve grammar and clarity
- Suggest better word choices
- Help structure content

Guidelines:
- Be concise and helpful
- Explain your suggestions
- Maintain the author's voice
```

4. Set the **Scope** to **Content** so the agent appears in the Content section
5. Set the **Surface** to **Copilot**
6. Click **Save**

## Step 3: Use the Agent

1. Navigate to the **Content** section
2. Open a content item
3. Click the **AI Assistant** button in the header to open the Copilot sidebar
4. The Writing Assistant agent is available in the agent selector
5. Start a conversation — try "Help me improve this page title"

See [Agent Copilot](../agent-copilot/copilot.md) for details on using the Copilot sidebar.

## Next Steps

- [Instructions](instructions.md) — Write better agent instructions
- [Scopes](scopes.md) — Control where agents appear
- [Permissions](permissions.md) — Configure tool access
- [Agent Copilot](../agent-copilot/README.md) — Copilot sidebar features
