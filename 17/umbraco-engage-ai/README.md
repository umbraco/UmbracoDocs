---
description: >-
  Ask your Umbraco Engage data questions in plain language, from a Copilot chat
  inside the backoffice.
---

# Engage.AI

Engage.AI brings a marketing-focused Copilot into Umbraco Engage. A marketer can ask questions in plain language instead of navigating dashboards. Questions can cover campaigns, segments, goals, personas, traffic, and A/B tests, with the answer coming from the same data Engage already collects.

Engage.AI is **read-only**: it reports and explains, it never changes your Engage configuration or data.

{% hint style="info" %}
This is a beta feature. Expect rough edges as Engage.AI matures.
{% endhint %}

![The Copilot sidebar open in the Engage section, answering a campaign question](.gitbook/assets/sidebar-01-campaigns.png)

## What it does

With Engage.AI installed, the Engage section is registered as Copilot-compatible, the same mechanism the Content and Media sections use. A set of Engage-specific tools becomes available to any agent granted access to them. See the full [Tools](tools.md) reference for what each one answers.

## Key features

- **Plain-language marketing questions.** Skip the dashboard: ask things like "Which campaign is giving us the best return right now?"
- **Explains, not only reports.** Dedicated tools explain what a segment, goal, or persona means and how it's scored, rather than only naming what it is.
- **Works from either Copilot surface.** The same agent and tools answer from the Copilot sidebar and from Copilot Workspace. See [Asking Engage Questions](asking-engage-questions.md).
- **Configurable, not fixed.** The agent's Instructions, AI Profile (model), and any attached Context resources shape tone and behavior. None of the answer format is hardcoded into Engage.AI itself.

## Packages

| Package | Purpose |
|---|---|
| `Umbraco.AI.Agent.Startup` | Agent runtime, required to run any Copilot agent. |
| `Umbraco.AI.Agent.Copilot` | The Copilot sidebar UI. |
| `Umbraco.Engage.AI` | This package. Registers the Engage section for Copilot and ships the Engage tools. |

## Next steps

- [Installation](installation.md). Install the packages and set up an agent.
- [Tools](tools.md). The full list of tools and what each one answers.
- [Asking Engage Questions](asking-engage-questions.md). Example prompts, from either Copilot surface.
- [Example: A Marketer Agent](example-marketer-agent.md). Profile, instructions, context, and a guardrail, put together as one configuration to copy.
