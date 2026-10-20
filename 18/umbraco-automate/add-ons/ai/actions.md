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

## Decision Actions

{% hint style="warning" %}
The Decision actions use Umbraco.AI's experimental [Decision](https://docs.umbraco.com/ai-in-umbraco/using-the-api/decision) capability. They only appear in the action picker when the `Umbraco:AI:Experimental:Decision` feature flag is enabled at startup. If the flag is turned off later without a restart, the steps fail with a validation error and no provider is called.
{% endhint %}

The four Decision actions ask typed questions and return typed answers. Bind their outputs in an [If or Switch](../../concepts/control-flow.md) node to branch the automation.

- **Ask Yes/No**, **Ask Pick-One**, and **Ask Score** each ask one question.
- **Ask Questions** asks multiple questions about the same content in a single call.

The three single-question actions share these settings:

| Setting | Required | Description |
| --- | --- | --- |
| **Instructions** | Yes | What to decide. Supports [bindings](../../concepts/bindings.md). |
| **Context** | No | The content to judge against the instructions, such as a content item's text. Supports bindings. |
| **Profile** | No | The Umbraco.AI Decision profile to use. Leave empty to use the default Decision profile. |

A step fails with a validation error when the settings are invalid or no Decision profile can be resolved. Provider errors, such as an invalid API key, fail the step with the provider's message.

### Ask Yes/No

Alias: `umbracoAI.askYesNoDecision`. Ask a yes/no question.

| Extra setting | Required | Description |
| --- | --- | --- |
| **True criteria** | No | What counts as "yes", beyond the instructions. Supports bindings. |
| **False criteria** | No | What counts as "no", beyond the instructions. Supports bindings. |
| **Threshold** | No | The minimum probability, from 0.0 to 1.0, counted as "yes". Defaults to 0.5. A value outside 0.0 to 1.0 fails the step with a validation error. |

| Output | Type | Description |
| --- | --- | --- |
| **Answer** | Boolean | `true` when **Probability** is at least **Threshold**. |
| **Probability** | Number | The estimated probability that the answer is "yes", from 0.0 to 1.0. |

### Ask Pick-One

Alias: `umbracoAI.askChoiceDecision`. Pick one option from a fixed list.

| Extra setting | Required | Description |
| --- | --- | --- |
| **Options** | Yes | The options to choose from. Between 2 and 255 rows, each with a unique key. |

The **Options** editor is a list of rows. Each row has a **Key** and a **Description**:

- **Key** is the value returned in the **Choice** output when the option is picked. It is required.
- **Description** is optional. It explains the option to the model, which helps when the key alone is not clear.

Use the editor to add, remove, and reorder rows.

| Output | Type | Description |
| --- | --- | --- |
| **Choice** | Text | The key of the chosen option. |
| **Confidence** | Number | The provider's own confidence in the choice, from 0.0 to 1.0. Empty when the provider does not report one. |

### Ask Score

Alias: `umbracoAI.askScoreDecision`. Score the content against labelled levels.

| Extra setting | Required | Description |
| --- | --- | --- |
| **Levels** | Yes | The level labels, lowest first, entered as a list. Between 2 and 10 entries. |

| Output | Type | Description |
| --- | --- | --- |
| **Score** | Number | A 0-based, fractional index into the levels. |
| **Level** | Text | The label of the level nearest to the score. |
| **Confidence** | Number | The provider's own confidence in the score, from 0.0 to 1.0. Empty when the provider does not report one. |

### Ask Questions

Alias: `umbracoAI.askDecisions`. Ask multiple questions about the same content in a single call. Each run makes one call to the Decision profile, however many questions the step has.

| Setting | Required | Description |
| --- | --- | --- |
| **Questions** | Yes | The questions to ask. Between 1 and 20. |
| **Context** | No | The content every question is judged against. Supports bindings. |
| **Profile** | No | The Umbraco.AI Decision profile to use. Leave empty to use the default Decision profile. |

To add a question, select **Add question** and pick a kind: **Yes/no**, **Pick-one**, or **Score**. Then fill in the question and save it. Select a question in the list to edit it, or remove it from the list.

Each question has:

| Field | Required | Description |
| --- | --- | --- |
| **Alias** | Yes | The name of the question's output. Must be unique within the step, start with a letter, and contain only letters, digits, and underscores. |
| **Instructions** | Yes | What to decide. |
| **True criteria**, **False criteria** | No | Yes/no only. What counts as "yes" and "no", beyond the instructions. |
| **Threshold** | No | Yes/no only. The minimum probability, from 0.0 to 1.0, counted as "yes". Defaults to 0.5. |
| **Options** | Yes | Pick-one only. Between 2 and 255 rows, using the same key and description editor as **Ask Pick-One**. |
| **Levels** | Yes | Score only. The level labels, lowest first. Between 2 and 10 entries. |

The fields inside a question do not support bindings. Use **Context** to pass content from earlier steps. If you need to bind the question text itself, use one of the single-question actions instead.

The output has one entry per question, named by its alias. Each entry has the same fields as the matching single-question action:

| Question kind | Output fields |
| --- | --- |
| Yes/no | `answer`, `probability` |
| Pick-one | `choice`, `confidence` |
| Score | `score`, `level`, `confidence` |

For example, a yes/no question with the alias `spam` produces `spam.answer` and `spam.probability`. The binding picker lists each alias and its fields once the questions are configured.

A missing, duplicated, or invalid alias, or any invalid question, fails the step with a validation error before any provider is called.

### Binding Support

| Setting | Supports bindings |
| --- | --- |
| **Instructions** (single-question actions) | Yes |
| **Context** (all four actions) | Yes |
| **True criteria**, **False criteria** (Ask Yes/No) | Yes |
| **Threshold**, **Options**, **Levels**, **Profile** | No |
| **Questions** (Ask Questions), including every field inside a question | No |

{% hint style="info" %}
Open the step in the canvas to see each action's settings and output fields.
{% endhint %}
