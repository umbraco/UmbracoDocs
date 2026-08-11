---
description: >-
    Create and manage AI guardrails in the Umbraco backoffice.
---

# Managing Guardrails

AI Guardrails allow you to define safety, compliance, and quality rules that evaluate AI inputs and responses at runtime. Rules can block, warn, or redact when content is flagged.

## Accessing Guardrails

1. Navigate to the **AI** section in the main navigation.
2. Click **Guardrails** in the tree.

![The guardrails list showing Content Safety Policy and PII Protection](../.gitbook/assets/backoffice-guardrails-list.png)

## Creating a Guardrail

1. Click **Create Guardrail** in the toolbar.
2. Fill in the required fields:

| Field | Description                                                 |
| ----- | ----------------------------------------------------------- |
| Alias | Unique identifier for code references (URL-safe, no spaces) |
| Name  | Display name shown in the backoffice                        |

3. Click **Create**.

![The Create Guardrail form](../.gitbook/assets/backoffice-create-guardrail-form.png)

## Adding Rules

Guardrails contain one or more rules. Each rule references a registered evaluator that performs the actual content evaluation:

1. In the guardrail editor, click **Add Rule**.
2. Configure the rule:

| Field       | Description                                                    |
| ----------- | -------------------------------------------------------------- |
| Evaluator   | The evaluator to use (Contains, Regex Match, or LLM Safety Judge) |
| Name        | Display name for the rule                                      |
| Phase       | When to evaluate: Pre-Generate or Post-Generate                |
| Action      | What to do when flagged: Block, Warn, or Redact                |
| Config      | Evaluator-specific settings                                    |

3. Click **Add**.

![The Select Evaluator panel showing Contains, LLM Safety Judge, and Regex Match](../.gitbook/assets/backoffice-create-guardrail-add-guardrail.png)

![The rule configuration panel with name, phase, action, and settings](../.gitbook/assets/backoffice-create-guardrail-add-guardrail-details.png)

### Evaluation Phases

| Phase            | Description                                              |
| ---------------- | -------------------------------------------------------- |
| **Pre-Generate** | Evaluates user input before sending to the AI provider.   |
| **Post-Generate**| Evaluates the AI response before returning to the user.   |

{% hint style="info" %}
Use Pre-Generate rules to prevent sensitive data (like PII) from being sent to AI providers. Use Post-Generate rules to validate AI responses meet your quality and safety standards.
{% endhint %}

### Actions

| Action     | Description                                                                      |
| ---------- | -------------------------------------------------------------------------------- |
| **Block**  | Stops processing and returns an error to the caller.                              |
| **Warn**   | Allows the content through unchanged and logs a warning.                          |
| **Redact** | Replaces flagged content with `[REDACTED]` before it reaches the AI model or caller. |

{% hint style="info" %}
The Redact option is only available for code-based evaluators (Contains, Regex Match) that can identify specific text positions. The LLM Safety Judge evaluator does not support redaction because it evaluates content holistically.
{% endhint %}

### Available Evaluators

| Evaluator            | ID          | Type        | Description                                                                 | Supports Redact |
| -------------------- | ----------- | ----------- | --------------------------------------------------------------------------- | --------------- |
| **Contains**         | `contains`  | Code-based  | Flags content containing a specific substring.                               | Yes             |
| **Regex Match**      | `regex`     | Code-based  | Flags content matching a regular expression pattern.                         | Yes             |
| **LLM Safety Judge** | `llm-judge` | Model-based | Uses an AI model to evaluate content for safety, misinformation, and compliance. | No          |

#### Contains Evaluator

Searches for a substring in the content. Useful for blocking competitor brand mentions, prohibited terms, or specific phrases.

| Setting          | Description                              |
| ---------------- | ---------------------------------------- |
| Search Pattern   | The substring to find in the content     |
| Ignore Case      | Case-insensitive search (default: on)    |

#### Regex Match Evaluator

Matches content against a regular expression. Useful for detecting patterns like email addresses, phone numbers, Social Security Numbers (SSNs), or profanity patterns.

| Setting       | Description                                                     |
| ------------- | --------------------------------------------------------------- |
| Regex Pattern | Regular expression to match against content                     |
| Ignore Case   | Case-insensitive matching (default: on)                         |
| Multiline     | Enable multiline mode where `^` and `$` match line boundaries  |

{% hint style="info" %}
Regex evaluation has a 5-second timeout to prevent catastrophic backtracking.
{% endhint %}

#### LLM Safety Judge Evaluator

Uses an AI model to evaluate content against custom criteria. Returns a safety score between 0 and 1. Content is flagged when the score falls below the configured threshold.

| Setting              | Description                                                              |
| -------------------- | ------------------------------------------------------------------------ |
| Judge Profile ID     | AI profile to use for evaluation (leave empty for default)               |
| Evaluation Criteria  | What aspects to evaluate (safety, compliance, brand voice, etc.)         |
| Safety Threshold     | Content is flagged if the safety score is below this value (0-1, default: 0.7). |

{% hint style="info" %}
Code-based evaluators (Contains, Regex Match) run instantly using pattern matching. The LLM Safety Judge calls an AI model for nuanced evaluation and takes longer. You can also [create custom evaluators](../extending/guardrails/README.md).
{% endhint %}

### Reordering Rules

Rules are evaluated in order. To reorder:

1. Drag rules using the handle on the left.
2. Or use the arrow buttons to move rules up/down.

Rules at the top are evaluated first.

![Content Safety Policy guardrail showing configured rules](../.gitbook/assets/backoffice-guardrail-rules.png)

## Editing a Guardrail

1. Select the guardrail from the list.
2. Modify fields as needed.
3. Add, edit, or remove rules.
4. Click **Save**.

{% hint style="info" %}
Every save creates a new version. You can view and rollback to previous versions.
{% endhint %}

## Deleting a Guardrail

1. Select the guardrail from the list.
2. Click **Delete** in the toolbar.
3. Confirm the deletion.

{% hint style="warning" %}
Deleting a guardrail also removes all version history. Ensure the guardrail is not referenced by profiles, prompts, or agents before deletion.
{% endhint %}

## Example: Content Safety Guardrail

A typical content safety guardrail might include:

**Name**: Content Safety Policy

**Rules**:

1. **Block competitor mentions** (Pre-Generate, Redact)
    - Evaluator: Contains
    - Search Pattern: competitor brand name
    - Redacts competitor mentions before sending to the AI provider.

2. **Block profanity** (Pre-Generate, Block)
    - Evaluator: Regex Match
    - Pattern matching for prohibited language patterns

3. **LLM content safety check** (Post-Generate, Warn)
    - Evaluator: LLM Safety Judge
    - Evaluates response quality and safety against custom criteria.

## Example: PII Redaction Guardrail

A guardrail that strips sensitive data instead of blocking:

**Name**: PII Protection

**Rules**:

1. **Redact email addresses** (Pre-Generate, Redact)
    - Evaluator: Regex Match
    - Pattern: `[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}`
    - Replaces email addresses with `[REDACTED]` before sending to the AI provider.

2. **Redact phone numbers** (Pre-Generate, Redact)
    - Evaluator: Regex Match
    - Pattern: `\b\d{3}[-.]?\d{3}[-.]?\d{4}\b`
    - Replaces phone numbers with `[REDACTED]`.

3. **Block SSN patterns** (Pre-Generate, Block)
    - Evaluator: Regex Match
    - Pattern: `\b\d{3}-\d{2}-\d{4}\b`
    - Blocks requests containing Social Security Number patterns.

{% hint style="warning" %}
Post-generate Redact rules do not work during streaming responses. When streaming, post-generate Redact rules degrade to Warn because chunks have already been sent to the caller and cannot be retroactively modified. Pre-generate Redact rules work normally in both streaming and non-streaming scenarios.
{% endhint %}

## Assigning Guardrails

Guardrails are assigned via the **Governance** tab on profiles, prompts, and agents:

- **Profiles** - Open a chat profile and go to the **Governance** tab to assign guardrails.
- **Prompts** - Open a prompt and go to the **Governance** tab to assign guardrails (requires Prompt add-on).
- **Agents** - Open an agent and go to the **Governance** tab to assign guardrails (requires Agent add-on).

When multiple sources assign guardrails (e.g., both a profile and an agent), all guardrails are combined and deduplicated at runtime.

### Assigning to a Profile

When editing a chat profile:

1. Go to the **Governance** tab.
2. Click **Add Guardrail** in the Guardrails section.
3. Select the guardrail(s) to apply.
4. Save the profile.

{% hint style="info" %}
Guardrails are only available for **Chat** profiles. Embedding profiles do not support guardrails.
{% endhint %}

### Assigning to a Prompt

When editing a prompt (requires Prompt add-on):

1. Go to the **Governance** tab.
2. Click **Add Guardrail** in the Guardrails section.
3. Select the guardrail(s) to apply.
4. Save the prompt.

### Assigning to an Agent

When editing an agent (requires Agent add-on):

1. Go to the **Governance** tab.
2. Scroll to the **Guardrails** section (below Tool Permissions for standard agents).
3. Click **Add Guardrail**.
4. Select the guardrail(s) to apply.
5. Save the agent.

{% hint style="info" %}
The agent Governance tab also contains [Tool Permissions](../add-ons/agent/permissions.md) for standard agents.
{% endhint %}

## Version History

See [Version History](version-history.md) for information on viewing and restoring previous versions.

## Related

- [Guardrails Concept](../concepts/guardrails.md) - Understanding guardrails
- [Version History](version-history.md) - Tracking changes
