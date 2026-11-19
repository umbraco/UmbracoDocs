---
description: >-
  Configure Cloudflare Workers AI as a provider for the experimental Extraction
  capability.
---

# Cloudflare

The Cloudflare provider gives access to Clairic, a Cloudflare Workers AI model that reads typed values out of text. The provider supports only the [Extraction](../using-the-api/extraction.md) capability. It has no Chat or Embedding models.

{% hint style="warning" %}
Extraction is **experimental** and disabled by default. Until you enable the `Umbraco:AI:Experimental:Extraction` feature flag, Cloudflare does not appear in the provider list. See [Enabling Extraction](../using-the-api/extraction.md#enabling-extraction).
{% endhint %}

## Installation

{% code title="Package Manager Console" %}
```powershell
Install-Package Umbraco.AI.Cloudflare
```
{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}
```bash
dotnet add package Umbraco.AI.Cloudflare
```
{% endcode %}

Then enable the feature flag in `appsettings.json` and restart the site:

{% code title="appsettings.json" %}
```json
{
    "Umbraco": {
        "AI": {
            "Experimental": {
                "Extraction": true
            }
        }
    }
}
```
{% endcode %}

## Connection Settings

| Setting    | Required | Description                                                                                                   |
| ---------- | -------- | ------------------------------------------------------------------------------------------------------------- |
| Account ID | Yes      | Your Cloudflare account ID. Find it in the Cloudflare dashboard.                                              |
| API Token  | Yes      | A Cloudflare API token with Workers AI permissions. Stored as a sensitive value and masked in the backoffice. |
| Endpoint   | No       | Custom endpoint URL, for example a proxy. Defaults to `https://api.cloudflare.com/client/v4`.                 |

Both the Account ID and the API Token can reference a configuration value instead of storing it in the database. See [Configuration References](../reference/configuration/ai-options.md#configuration-references). The API Token is a sensitive field, so it can use a `$Umbraco:AI:Secrets:...` reference. The Account ID is not, so use a `$Umbraco:AI:Variables:...` reference for it.

{% code title="Connection settings with configuration references" %}
```
Account ID: $Umbraco:AI:Variables:CloudflareAccountId
API Token:  $Umbraco:AI:Secrets:CloudflareApiToken
```
{% endcode %}

{% hint style="warning" %}
Keep your API token secure. Never commit it to source control or expose it in client-side code.
{% endhint %}

## Models

| Model                    | Name    | Description                                         |
| ------------------------ | ------- | --------------------------------------------------- |
| `@cf/cloudflare/clairic` | Clairic | The only model the provider lists, and the default. |

Create a profile with the **Extraction** capability and the **Clairic** model. Extraction profiles have no extra settings.

Cloudflare bills Workers AI usage to your Cloudflare account. Check Cloudflare's own pricing for Clairic before you use it in production.

## How Requests Are Sent

The provider sends each Extraction request to Cloudflare as one HTTP call, however many fields it holds:

* The request's state is sent as the text to extract from.
* Every field is sent in the same call, keyed by its field ID. The answers come back under the same IDs.
* The reference date, when set, is sent so that relative dates such as "yesterday" resolve correctly.
* When Cloudflare returns a confidence and a probability that the value is not in the text, they are set on the answer.
* Text and list answers include where each value sits in the text. A value that was not found has no span.
* A date and time with a `Z` suffix or a time zone offset, such as `+02:00`, is converted to a UTC `DateTime`.
* Token usage is recorded once for the call.

This means [extracting multiple fields at once](../using-the-api/extraction.md#extracting-multiple-fields-at-once) costs a single request to Cloudflare. The provider sets no limit on the number of fields in a request.

## Test Connection

**Test Connection** searches your Cloudflare account's Workers AI models for Clairic. This checks the Account ID and the API Token without running the model:

* A valid account and token pass the test.
* An invalid token, an unknown account, or any other error fails the test.

A successful check is cached for one hour for the same endpoint, account, and token. Repeated tests within that hour do not send a new request. A failed check is not cached.

## Retries

When Cloudflare responds with `429` (rate limited), the provider retries the request up to 2 more times:

* It waits for the time given in the `Retry-After` header, when present.
* Without the header, it waits 1 second, then 2 seconds.
* A single wait is never longer than 30 seconds.

Other errors are not retried. For example, `401` (invalid token) and `400` (request rejected) fail straight away.

## Related

* [Providers Overview](providers.md)
* [Extraction](../using-the-api/extraction.md)
* [Managing Connections](../backoffice/managing-connections.md)
