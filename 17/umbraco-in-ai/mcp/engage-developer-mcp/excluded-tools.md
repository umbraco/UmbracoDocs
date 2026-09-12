---
description: List of tools that are excluded from the Engage Developer MCP
---

# Excluded Tools

Certain Umbraco Engage Management API endpoints are intentionally not exposed as tools, typically because they back front-end/browser-specific features rather than backoffice or content-management workflows.

## Excluded Groups Summary

- **Cockpit (2 endpoints)** - Cookie and page-context lookups used by Engage's in-browser Cockpit overlay, not meaningful outside that front-end UI flow
- **Cockpit Auth (2 endpoints)** - Domain allow-listing and token issuance for the Cockpit overlay's cross-domain authentication; issuing auth tokens through an AI agent bypasses the normal authentication flow
- **Data Generation (1 endpoint)** - Logs for Engage's synthetic demo-data generator, a developer/demo-only feature
- **Front-end Tracking (4 endpoints)** - Public, unauthenticated visitor-tracking beacon endpoints called by the Engage client-side tracking script embedded on published pages, not part of the management API surface

## Ignored Endpoints

These endpoints are intentionally not implemented as MCP tools, typically because they:

- Back a specific front-end UI (the Cockpit overlay) rather than general backoffice/management workflows
- Handle authentication token issuance, which should not be delegated to an AI agent
- Are public tracking beacons meant to be called by the front-end tracking script, not a management client
- Cover a demo/development-only feature (synthetic data generation)

## Ignored by Category

### Cockpit (2 endpoints)

- `postCockpitDeleteCookie` - Deletes the Cockpit overlay's client-side cookie (front-end UI state, not applicable outside a browser session)
- `getCockpitGetUmbracoPageInfo` - Looks up Engage metadata for the current page as shown inside the Cockpit overlay (front-end-specific context lookup)

### Cockpit Auth (2 endpoints)

- `getCockpitAuthDomains` - Lists domains allow-listed for the Cockpit overlay's cross-domain authentication (security configuration)
- `postCockpitAuthGenerateToken` - Issues a Cockpit authentication token (token issuance should not be exposed to an AI agent)

### Data Generation (1 endpoint)

- `getDataGenerationLogs` - Lists logs from Engage's synthetic demo-data generator, a development/demo-only feature not relevant to a real site

### Front-end Tracking (4 endpoints)

- `postUmbracoEngagePagedataCollect` - Public beacon endpoint the Engage tracking script calls to record a pageview
- `postUmbracoEngagePagedataCollectEvent` - Public beacon endpoint the Engage tracking script calls to record a client-side event (scroll, click, video, and form events, among others)
- `getUmbracoEngagePagedataPing` / `postUmbracoEngagePagedataPing` - Public keep-alive beacons the Engage tracking script uses to measure session duration

{% hint style="info" %}
Read access to the data these endpoints produce is still available through the [`analytics`](available-tools.md#analytics-analytics) and [`profile`](available-tools.md#profile-profile) tool collections.

Only the write-side, front-end tracking calls themselves are excluded.
{% endhint %}
