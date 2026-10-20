---
description: >-
    Get the AI disclosure notice setting.
---

# Get Disclosure Settings

Returns only the AI disclosure notice setting. The backoffice uses it to decide whether to show the "Responses are AI-generated and may be inaccurate." notice in chat and prompt responses.

Unlike [Get Settings](get.md), this endpoint does not require access to the AI section. Any authenticated backoffice user can call it, because editors without AI section access still see chat and prompt output. It never returns the rest of the AI settings.

## Request

```http
GET /umbraco/ai/management/api/v1/settings/disclosure
```

## Response

### Success

{% code title="200 OK" %}

```json
{
    "noticeMode": "Always"
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/settings/disclosure" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Response Properties

| Property     | Type   | Description                                                                 |
| ------------ | ------ | --------------------------------------------------------------------------- |
| `noticeMode` | string | How the AI-generated notice is shown: `Always`, `Dismissible`, or `Off` |

## Related

- [Managing Settings](../../backoffice/managing-settings.md#ai-disclosure-notice) - What each option does in the backoffice
- [Update Settings](update.md) - Change the setting
