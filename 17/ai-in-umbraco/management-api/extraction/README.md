---
description: REST API endpoint for extracting typed values from text (experimental).
---

# Extraction

{% hint style="warning" %}
Extraction is **experimental**. When the `Umbraco:AI:Experimental:Extraction` feature flag is disabled, these endpoints return **404** with an empty body. See [Enabling Extraction](../../using-the-api/extraction.md#enabling-extraction).
{% endhint %}

The Extraction API reads typed values out of a piece of text using an Extraction profile. One call can extract multiple fields, and they are all answered in a single model call.

## Base URL

```
/umbraco/ai/management/api/v1/extraction
```

## Authentication

The endpoint requires an authenticated backoffice user (policy: `BackOfficeAccess`). Access to the AI section is not required, so backoffice extensions outside the AI section can call it. See [Authentication](../management-api/authentication.md).

## Endpoints

| Method | Endpoint                                           | Description                  |
| ------ | -------------------------------------------------- | ---------------------------- |
| POST   | `/umbraco/ai/management/api/v1/extraction/extract` | [Extract values](extract.md) |

## Checking Whether Extraction Is Enabled

To check whether Extraction is enabled before you call it, use the `GET /umbraco/ai/management/api/v1/capabilities/enabled` endpoint. The response includes `"Extraction"` only when the feature flag is on. Unlike the Extraction endpoint, that endpoint requires access to the AI section. See [List Capabilities](../connections/capabilities.md#list-enabled-capabilities).

## In This Section

{% content-ref url="extract.md" %}
[extract.md](extract.md)
{% endcontent-ref %}
