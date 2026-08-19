---
description: Install Engage.AI and set up an agent for the Copilot to use.
---

# Installation

## Prerequisites

- Umbraco CMS with Umbraco Engage installed and licensed.
- Umbraco.AI installed, with an API key from your AI provider of choice (for example Anthropic, DeepSeek, or OpenAI).

## Step 1: Install the packages

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Agent
dotnet add package Umbraco.AI.Agent.Copilot
dotnet add package Umbraco.Engage.AI
```

{% endcode %}

Restart your application to run the database migrations.

Installing `Umbraco.Engage.AI` automatically registers the Engage section as Copilot-compatible. It also makes the Engage tools available to any agent that has access to them — no separate configuration step needed for this part.

## Step 2: Create a connection

See [Connections](../ai-in-umbraco/concepts/connections.md) for what a connection is.

1. In the Umbraco backoffice, navigate to the **AI** section > **Connections**.
2. Click **Create** and pick a provider (Anthropic, DeepSeek, OpenAI, and others are supported).
3. Name it, add the provider's API key, and save.

Repeat for each provider you want available — an installation can have multiple connections active at once, for example one per model provider:

![The Connections list, with an Anthropic and a DeepSeek connection active](.gitbook/assets/ai-connections-list.png)

## Step 3: Create a profile

See [Profiles](../ai-in-umbraco/concepts/profiles.md) for what a profile is.

1. Navigate to the **AI** section > **Profiles**.
2. Click **Create**, select the **Chat** capability, pick the connection to use, and choose a model.
3. Save.

![The Profiles list, with an Anthropic and a DeepSeek chat profile](.gitbook/assets/ai-profiles-list.png)

## Step 4: Create an agent

1. In the Umbraco backoffice, navigate to the **AI** section > **Agents**.
2. Click **Create**.
3. Fill in the agent's **Description** and **Instructions**. Instructions define the agent's role, capabilities, and tone — they shape every answer, not the tools' descriptions. A minimal starting point:

   ```
   You are a Marketer Agent specialized in Umbraco Engage inside Umbraco CMS.

   Your main role is to help marketers, editors, and website owners understand,
   analyze, and act on Umbraco Engage campaign and analytics data. Focus on
   practical marketing insight, not raw numbers.
   ```

4. Select the **AI Profile** you created in Step 3, or leave it empty to use whichever profile is set as the default chat profile.
5. Optionally attach a **Context** — a reusable resource injected into every request. Useful for things like tone-of-voice rules, or (for Copilot Workspace specifically) the display-formatting context covered in [Copilot Workspace](copilot-workspace.md).
6. Click **Save**.

![Agent settings: Description, AI Profile, Contexts, and Instructions](.gitbook/assets/ai-agent-anthropic-config.png)

## Step 5: Make the agent available where you want it

An agent isn't reachable from a surface until it's explicitly attached to that surface. Having an agent Active in the list is not enough on its own.

1. Open the agent, go to the **Availability** tab.
2. Under **Surfaces**, enable **Copilot** to make the agent selectable from the Copilot sidebar, and/or **Copilot Workspace** to make it selectable from Copilot Workspace.
3. Save.

![The Availability tab, showing the Copilot and Copilot Workspace surface toggles](.gitbook/assets/ai-agent-anthropic-availability.png)

See [Copilot Sidebar](copilot-sidebar.md) and [Copilot Workspace](copilot-workspace.md) for what the agent looks like from each surface, with example prompts.
