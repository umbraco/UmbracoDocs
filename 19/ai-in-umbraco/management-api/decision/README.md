---
description: >-
    REST API endpoint for asking typed yes/no, pick-one, and score questions (experimental).
---

# Decision API

{% hint style="warning" %}
Decision is **experimental**. When the `Umbraco:AI:Experimental:Decision` feature flag is disabled, these endpoints return **404** with an empty body. See [Enabling Decision](../../using-the-api/decision/README.md#enabling-decision).
{% endhint %}

The Decision API asks a Decision profile one typed question about an optional piece of content. It returns a typed answer.

To ask multiple questions about the same content in one call, use [`IAIDecisionService.GetDecisionResponseAsync`](../../using-the-api/decision/README.md#asking-multiple-questions-at-once) from C#. The Management API asks one question per call.

## Base URL

```
/umbraco/ai/management/api/v1/decision
```

## Authentication

The endpoint requires an authenticated backoffice user (policy: `BackOfficeAccess`). Access to the AI section is not required, so backoffice extensions outside the AI section can call it. See [Authentication](../management-api/authentication.md).

## Endpoints

| Method | Endpoint | Description |
| ------ | -------- | ----------- |
| POST   | `/umbraco/ai/management/api/v1/decision/ask` | [Ask a decision](ask-decision.md) |

## Checking Whether Decision Is Enabled

To check whether Decision is enabled before you call it, use the `GET /umbraco/ai/management/api/v1/capabilities/enabled` endpoint. The response includes `"Decision"` only when the feature flag is on. See [List Capabilities](../connections/capabilities.md#list-enabled-capabilities).

## In This Section

{% content-ref url="ask-decision.md" %}
[Ask Decision](ask-decision.md)
{% endcontent-ref %}
