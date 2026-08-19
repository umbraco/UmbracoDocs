---
description: >-
  An example guardrail that keeps personal data a marketer pastes into chat
  from reaching the AI provider.
---

# Guardrails: protecting personal data in chat

Engage.AI's tools only ever return aggregates and marketer-authored labels — campaign names, segment counts, performance figures. They can't return an individual visitor's Personally Identifiable Information (PII), so there's nothing to filter on the way *out*. The real risk sits on the way *in*. A marketer might paste something like "a visitor with email jane@example.com keeps abandoning cart" into the chat. That personal data then gets sent straight to your AI provider.

A **guardrail** can catch this before it happens. Guardrails are an Umbraco.AI feature. They evaluate a request against a set of rules and act — block, redact, and so on — when one matches. They apply to whichever agent they're attached to, on **either** Copilot surface.

## Example: Input PII Redaction

A guardrail with two rules, both **Regex Match**, phase **Pre-Generate**, action **Redact** — evaluated before the message reaches the model, replacing any match with `[REDACTED]`:

| Rule | Regex pattern |
|---|---|
| Email | `[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}` |
| Central Person Register (CPR), Danish national ID | `\b\d{6}-\d{4}\b` |

![The Input PII Redaction guardrail's two rules](.gitbook/assets/ai-guardrail-pii-rules-list.png)

![The Email rule's configuration](.gitbook/assets/ai-guardrail-pii-rule-email.png)

![The Danish CPR rule's configuration](.gitbook/assets/ai-guardrail-pii-rule-danish-cpr.png)

### Attaching it to an agent

A guardrail does nothing until it's attached to an agent:

1. Open the agent, go to the **Governance** tab.
2. Scroll to **Guardrails**, click **Add**, and select the guardrail.
3. Save.

![The Governance tab's Guardrails section, with Input PII Redaction attached](.gitbook/assets/ai-agent-governance-guardrails.png)

### What it stops

Same message, sent to two agents — one with the guardrail attached, one without:

{% code title="Without the guardrail — the provider receives the raw values" %}
```
A visitor with email john.doe@example.com and CPR 010203-4567 keeps abandoning cart — what should I do?
```
{% endcode %}

{% code title="With the guardrail — redacted before it leaves your installation" %}
```
A visitor with email [REDACTED] and CPR [REDACTED] keeps abandoning cart — what should I do?
```
{% endcode %}

Without the guardrail, a real-shaped email and Danish national ID number would have been sent to a third-party model outside your control. That's a concrete GDPR exposure, not an abstract one. The reply itself still made sense either way; only the guardrail decided whether personal data made the trip.

## Limits worth knowing

- **Best-effort, not comprehensive.** Regex rules catch the specific patterns you define — these two cover email addresses and Danish CPR numbers, nothing else. Add more rules the same way for other PII you expect marketers to paste — phone numbers, other national IDs, card numbers. Test each against realistic input before relying on it.
- **Pre-Generate acts on the input, not the answer.** These rules run on what the user sends, not on what the assistant replies with.
