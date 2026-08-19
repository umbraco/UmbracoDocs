---
description: >-
  Ask your Umbraco Engage data questions in plain language, from a Copilot chat
  inside the backoffice.
---

# Engage.AI

Engage.AI brings a marketing-focused Copilot into Umbraco Engage. Instead of navigating
dashboards, a marketer can ask questions in plain language — about campaigns, segments,
goals, personas, traffic, and A/B tests — and get an answer sourced from the same data
Engage already collects.

Engage.AI is **read-only**: it reports and explains, it never changes your Engage
configuration or data.

![The Copilot sidebar open in the Engage section, answering a campaign question](.gitbook/assets/sidebar-01-campaigns.png)

## What it does

With Engage.AI installed, the Engage section is registered as Copilot-compatible (the
same mechanism the Content and Media sections use), and a set of 17 Engage-specific
tools becomes available to any agent granted access to them — see the full
[Toolset](tools.md) for what each one answers.

## Key features

- **Plain-language marketing questions** — "which campaign is giving us the best return
  right now?" instead of a dashboard detour.
- **Explains, not only reports** — dedicated tools answer "what does this segment/goal/
  persona mean and how is it scored?" rather than only "what is it".
- **Two surfaces, one agent** — the same agent and tools work from the Copilot sidebar
  (ambient, tied to the page you're on) and from Copilot Workspace (full-page, persistent
  conversations); see [Copilot Sidebar](copilot-sidebar.md) and
  [Copilot Workspace](copilot-workspace.md).
- **Configurable, not fixed** — the agent's Instructions, AI Profile (model), and any
  attached Context resources shape tone and behavior; nothing about the answer format is
  hardcoded into Engage.AI itself.

## Packages

| Package | Purpose |
|---|---|
| `Umbraco.AI.Agent` | Agent runtime — required to run any Copilot agent. |
| `Umbraco.AI.Agent.Copilot` | The Copilot sidebar UI. |
| `Umbraco.AI.Agent.Copilot.Workspace` | The Copilot Workspace UI (see [Copilot Workspace](copilot-workspace.md) for its current availability). |
| `Umbraco.Engage.AI` | This package — registers the Engage section for Copilot and ships the Engage tools. |

## Next steps

- [Installation](installation.md) — install the packages and set up an agent.
- [Toolset](tools.md) — the full list of tools and what each one answers.
- [Copilot Sidebar](copilot-sidebar.md) — using Engage.AI from the sidebar, with example
  prompts.
- [Copilot Workspace](copilot-workspace.md) — using Engage.AI from Copilot Workspace,
  including the optional Display Behavior context for table/chart output.
- [Guardrails](guardrails.md) — an example guardrail that keeps personal data marketers
  paste into chat from reaching your AI provider.
- [Example: A Marketer Agent](example-marketer-agent.md) — profile, instructions,
  context, and the guardrail above, put together as one configuration to copy.
