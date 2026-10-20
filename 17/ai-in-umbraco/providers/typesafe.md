---
description: Configure TypeSafe AI as a provider for the experimental Decision capability.
---

# TypeSafe AI

TypeSafe AI provides access to Jev, a model for typed yes/no, pick-one, and score questions. The provider supports only the [Decision](../using-the-api/decision/README.md) capability. It has no Chat or Embedding models.

{% hint style="warning" %}
Decision is **experimental** and disabled by default. Until you enable the `Umbraco:AI:Experimental:Decision` feature flag, TypeSafe AI does not appear in the provider list. See [Enabling Decision](../using-the-api/decision/README.md#enabling-decision).
{% endhint %}

## Installation

{% code title="Package Manager Console" %}
```powershell
Install-Package Umbraco.AI.TypeSafe
```
{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}
```bash
dotnet add package Umbraco.AI.TypeSafe
```
{% endcode %}

Then enable the feature flag in `appsettings.json` and restart the site:

{% code title="appsettings.json" %}
```json
{
    "Umbraco": {
        "AI": {
            "Experimental": {
                "Decision": true
            }
        }
    }
}
```
{% endcode %}

## Connection Settings

| Setting  | Required | Description |
| -------- | -------- | ----------- |
| API Key  | Yes      | Your TypeSafe AI API key. Stored as a sensitive value and masked in the backoffice. |
| Endpoint | No       | Custom endpoint URL, for example a proxy. Defaults to `https://api.typesafe.ai`. |

Like other sensitive fields, the API key can reference a configuration value instead of storing it in the database. See [Configuration References](../reference/configuration/ai-options.md#configuration-references).

{% hint style="warning" %}
Keep your API key secure. Never commit it to source control or expose it in client-side code.
{% endhint %}

## Models

| Model | Description |
| ----- | ----------- |
| `jev-latest` | Jev (latest). The only model the provider lists, and the default. |

Create a profile with the **Decision** capability and the `jev-latest` model. Decision profiles have no extra settings.

## How Requests Are Sent

The provider sends each Decision request to TypeSafe AI as one HTTP call, however many questions it holds:

- The request's state is sent as the content to judge. When there is no state, the first question's instructions are sent instead, because TypeSafe AI requires one.
- Every question is sent in the same call, keyed by its question ID. The answers come back under the same IDs.
- A yes/no question is answered with the probability of "yes".
- Pick-one and score questions are answered with a choice or score, a confidence, and a probability for each option or level. Score probabilities are keyed by level index. Options or levels that TypeSafe AI leaves out are filled in with a probability of 0.
- Token usage is recorded once for the call.

This means [asking multiple questions at once](../using-the-api/decision/README.md#asking-multiple-questions-at-once) costs a single request to TypeSafe AI. The provider sets no limit on the number of questions in a request.

## Test Connection

TypeSafe AI has no models endpoint to check. Instead, **Test connection** sends one small, authenticated yes/no question to TypeSafe AI:

- A valid key passes the test.
- An invalid key, or any other error, fails the test.

A successful check is cached for one hour for the same endpoint and API key. Repeated tests within that hour do not send a new request. A failed check is not cached.

## Retries

When TypeSafe AI responds with `429` (rate limited) or `529` (overloaded), the provider retries the request up to 2 more times:

- It waits for the time given in the `Retry-After` header, when present.
- Without the header, it waits 1 second, then 2 seconds.
- A single wait is never longer than 30 seconds.

Other errors are not retried. For example, `401` (invalid API key) and `422` (request rejected) fail straight away.

## Related

* [Providers Overview](providers.md)
* [Decision](../using-the-api/decision/README.md)
* [Managing Connections](../backoffice/managing-connections.md)
