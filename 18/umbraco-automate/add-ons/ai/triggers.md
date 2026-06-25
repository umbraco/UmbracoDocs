---
description: >-
  Reference for the triggers contributed by the Umbraco.AI.Automate add-on.
---

# Triggers

The AI add-on contributes the following triggers. The triggers fire on AI agent lifecycle events emitted by Umbraco.AI.Agent.

## AI Agent Run Completed

Alias: `umbracoAI.agentRunCompleted`. Fires when an AI agent run finishes successfully. Use this to react to the agent's response in another automation step.

## AI Agent Run Failed

Alias: `umbracoAI.agentRunFailed`. Fires when an AI agent run fails. Use this to alert an editor or log the failure for review.

## AI Agent Request

Alias: `umbracoAI.agentTrigger`. Fires when an AI agent invokes the automation as a tool. Use this when you want an AI agent to be able to start the automation as part of its workflow.

{% hint style="info" %}
The exact output fields for each AI trigger depend on the agent and the event payload. Inspect a real run in the **Runs** view to see the available fields, then use the binding picker to reference them.
{% endhint %}
