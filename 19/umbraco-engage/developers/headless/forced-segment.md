---
description: >-
  Use the Forced-Segment HTTP header to deterministically request a specific
  personalization or A/B testing variant from the Umbraco Engage API and the
  Umbraco Content Delivery API v2.
---

# Forced-Segment header

The `Forced-Segment` HTTP header lets you bypass Umbraco Engage's automatic segmentation and request a specific content variant directly. This suits headless and decoupled setups where you already know which variant to render. Common examples include preview tooling, automated tests, and server-rendered flows that pick a variant outside of Engage.

When Umbraco Engage receives a request with this header, it uses the supplied segment alias for variant resolution. The visitor's personalization rules and A/B test assignment are bypassed.

## When to use it

Reach for `Forced-Segment` when the caller — not Engage — decides which variant to render. Typical scenarios:

* **Preview tooling** that needs to render a specific personalization variant on demand.
* **Automated tests** that verify each variant renders correctly without relying on visitor behavior.
* **Decoupled or server-side frontends** (for example, a `Next.js` or `Nuxt` server) that resolve the variant themselves and forward the decision to Umbraco.
* **Content debugging** when you want to inspect a single variant in isolation.

For regular visitor-driven segmentation, use the `External-Visitor-Id` header instead. See [Using the Engage API](using-the-marketing-api.md) for that flow.

## Supported endpoints

The `Forced-Segment` header is honored on the following routes:

* **Umbraco Content Delivery API v2**, for any request starting with `/umbraco/delivery/api/v2/content`. This covers:
  * `/umbraco/delivery/api/v2/content/item/{id}`
  * `/umbraco/delivery/api/v2/content/item/{path}`
  * `/umbraco/delivery/api/v2/content/items`
  * `/umbraco/delivery/api/v2/content`
* **Umbraco Engage API v1**, for any request starting with:
  * `/umbraco/engage/api/v1/analytics/`
  * `/umbraco/engage/api/v1/segmentation/`

{% hint style="warning" %}
The header is ignored on the Content Delivery API **v1** (`/umbraco/delivery/api/v1/...`). If you need forced segmentation from a headless client, target the v2 endpoints.
{% endhint %}

## How to find a segment alias

The value of the `Forced-Segment` header is a segment alias. Engage generates aliases automatically for each personalization variant and A/B test variant.

| Source               | Alias format                                      |
| -------------------- | ------------------------------------------------- |
| Personalization      | `engage_personalization_{segmentId}`              |
| A/B testing          | `engage_ab-testing_{segmentId}`                   |

For example, a personalization with ID `1` has an alias `engage_personalization_1`.

You can retrieve the alias for a page programmatically by calling the [segment information API](../personalization/segment-information.md) or the segmentation content endpoint:

```
GET /umbraco/engage/api/v1/segmentation/content/segments/{id}
```

The response contains an `umbracoSegmentAlias` field per segment. Use that value verbatim as the `Forced-Segment` header.

## Example request

The following request fetches a page from the Content Delivery API v2 and forces Engage to return the variant linked to personalization ID `1`:

```http
GET /umbraco/delivery/api/v2/content/item/ca4249ed-2b23-4337-b522-63cabe5587d1 HTTP/1.1
Host: your-site.com
Accept: application/json
Forced-Segment: engage_personalization_1
```

The response contains the content for that specific variant — the same payload a visitor would receive if they were scored into the `All Developers` segment.

Equivalent `curl` invocation:

```bash
curl -H "Forced-Segment: engage_personalization_1" \
  "https://your-site.com/umbraco/delivery/api/v2/content/item/ca4249ed-2b23-4337-b522-63cabe5587d1"
```

To force an A/B test variant instead, supply the test's segment alias:

```http
Forced-Segment: engage_ab-testing_1
```

{% hint style="info" %}
`Forced-Segment` takes precedence over both personalization rules and A/B test assignment for the duration of the request. The visitor's Engage profile is not updated or scored based on a forced request.
{% endhint %}

## Limitations and error behavior

Keep the following in mind when using `Forced-Segment`:

* **Only active when Engage is enabled.** If the Engage app state is disabled, the middleware skips the header entirely. The request falls back to the default (non-segmented) content.
* **Not validated.** Engage does not check whether the supplied alias matches a real segment. An unknown or malformed value does not return an error. It silently falls through to the default variant.
* **Empty values are ignored.** A `Forced-Segment` header with an empty string is treated as if no header was sent.
* **Respects the legacy naming toggle.** If your installation sets `UseLegacySegmentNames` to `true`, aliases use the `umarketingsuite_personalization_` and `umarketingsuite_ab-testing_` prefixes instead of `engage_*`. Supply the alias that matches your configured naming.
* **Does not override property-level exclusions.** Properties listed in the Engage property alias exclusion list are not segment-aware and remain unchanged.
* **Scoped to Content Delivery API v2 and Engage API v1.** The header has no effect on other routes or on the Content Delivery API v1.

{% hint style="warning" %}

`Forced-Segment` fails open. A wrong alias returns default content with no error. Double-check the alias value during development against what the `/umbraco/engage/api/v1/segmentation/content/segments/{id}` endpoint returns.

{% endhint %}

## Related reading

* [Using the Engage API](using-the-marketing-api.md) — the standard visitor-driven flow.
* [Headless Example](headless-example.md) — end-to-end walkthrough of a headless setup.
* [Retrieve segment information from code](../personalization/segment-information.md) — how to read segment aliases server-side.
