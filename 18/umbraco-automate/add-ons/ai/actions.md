---
description: >-
  Reference for the actions contributed by the Umbraco.AI.Automate add-on.
---

# Actions

The AI add-on contributes the following actions.

## Run AI Agent

Alias: `umbracoAI.runAgent`. Run an AI agent and capture its response. Useful for tasks like generating translations, summarising content, or scoring leads.

The action picks an agent from the list of agents that are scoped to the **Automations** surface in Umbraco.AI. The user message supports [bindings](../../concepts/bindings.md).

When the agent declares a structured-output schema, each output field is exposed as a named binding under the step output. Inspect a real run to see the available fields.

## Transcribe Audio

Alias: `umbracoAI.transcribeAudio`. Transcribe an audio file using Umbraco.AI's speech-to-text capability. The Umbraco.AI profile used by the action must use a provider that supports speech-to-text.

{% hint style="info" %}
Open the step in the canvas to see each action's settings and output fields.
{% endhint %}
