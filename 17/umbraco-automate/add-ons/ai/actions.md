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

### Settings

| Setting          | Description |
| ---------------- | ----------- |
| Agent            | The agent to run. Only agents scoped to the **Automations** surface are listed. |
| Message          | The message sent to the agent. Supports bindings. |
| Attachments      | Optional media to send with the message. Supports bindings. See [Attachments](#attachments). |
| Tool permissions | Whether the agent can make changes. See [Tool permissions](#tool-permissions). |

### Attachments

Attach media items so the agent can work with files, for example to describe an image or summarize a document. Enter one or more media references, separated by commas or new lines. Each reference can be:

- A media key (GUID).
- A media UDI, such as `umb://media/…`.
- A media picker value, for example bound from a trigger or an earlier step.

Images are passed to the model directly, so use an agent whose model supports images. Documents and audio are turned into text first. Plain text (`.txt`, `.md`, `.csv`) and Office files (`.docx`, `.xlsx`, `.pptx`) have their text extracted. Audio is transcribed, which needs a speech-to-text profile in Umbraco.AI.

Access to each media item is checked using the service account of the automation's workspace. If a reference can't be read, doesn't exist, or can't be accessed, the step fails and the agent does not run. A run can include up to 10 attachments, with a combined size of 20 MB.

### Tool permissions

Nobody is watching an automation run, so nothing can be approved mid-run. **Tool permissions** decides which changes the agent may make without a human:

| Option | Behavior |
| ------ | -------- |
| Read only (default) | The agent can look things up but can't make any changes. Every destructive tool is denied. |
| Changes that don't need approval | The agent can also make changes editors can undo, such as creating or editing draft content and media. Changes that need approval, such as publishing, unpublishing, or deleting, are always denied. |

This setting only narrows what the agent may do. The agent must also be allowed the tools in Umbraco.AI, for example through the `content-write` scope. Saved automations without this setting run as **Read only**.

## Transcribe Audio

Alias: `umbracoAI.transcribeAudio`. Transcribe an audio file using Umbraco.AI's speech-to-text capability. The Umbraco.AI profile used by the action must use a provider that supports speech-to-text.

{% hint style="info" %}
Open the step in the canvas to see each action's settings and output fields.
{% endhint %}
