---
description: Architecture of the Hosted MCP server including auth flow, three-tier configuration, and component design.
---

# Architecture

## Overview

The hosted MCP server runs as a Cloudflare Worker. It acts as both an **OAuth Authorization Server** (to MCP clients) and an **OAuth Client** (to Umbraco via OpenIdDict).

The MCP Authorization spec mandates this "Third-Party Authorization Flow." This flow ensures that Umbraco tokens are never exposed to MCP clients.

## Auth Flow

The following diagram shows the full authorization sequence between the MCP Client, the Worker, and Umbraco:

```
MCP Client                    Worker                         Umbraco
    |                           |                               |
    |-- 1. Connect / ---------->|                               |
    |<-- 2. 401 + discovery ----|                               |
    |                           |                               |
    |-- 3. GET /.well-known --->|                               |
    |<-- OAuth metadata --------|                               |
    |                           |                               |
    |-- 4. GET /authorize ----->|                               |
    |                           |-- 5. Show consent screen      |
    |<-- Consent HTML ----------|   (with tool selection if     |
    |                           |    enableConsentToolSelection) |
    |                           |                               |
    |-- 6. POST /authorize ---->|  (user approves + selects     |
    |                           |   modes, read-only)           |
    |                           |-- 7. Redirect to Umbraco ---->|
    |                           |   (consent choices stored     |
    |                           |    in KV state)               |
    |                           |                               |
    |                           |   8. User logs in             |
    |                           |                               |
    |                           |<-- 9. Callback with code -----|
    |                           |-- 10. Exchange code --------->|
    |                           |<-- 11. Umbraco tokens --------|
    |                           |                               |
    |                           |-- 12. Store tokens in KV      |
    |                           |-- 13. Issue Worker token      |
    |                           |   (with consentChoices in     |
    |                           |    AuthProps)                  |
    |<-- Auth code -------------|                               |
    |                           |                               |
    |-- 14. POST /token ------->|                               |
    |<-- Worker access token ---|                               |
    |                           |                               |
    |-- 15. / + Bearer -------->|                               |
    |                           |-- 16. Look up Umbraco token   |
    |                           |-- 17. Merge env config with   |
    |                           |       consent choices         |
    |                           |-- 18. API call -------------->|
    |                           |<-- 19. Response --------------|
    |<-- Tool result ------------|                               |
```

See [Security](security.md) for token isolation, CSRF protection, and MCP spec compliance details.

For security details including token isolation, consent, and CSRF protection, see [Security](security.md).

## Component Architecture

```
+-----------------------------------------------------+
|                  Worker Entry                        |
|  +----------------------------------------------+   |
|  |           OAuthProvider                       |   |
|  |  - /.well-known/oauth-authorization-server    |   |
|  |  - /authorize                                 |   |
|  |  - /token                                     |   |
|  |  - /register (dynamic client registration)    |   |
|  +-------------+--------------------------------+   |
|                |                                     |
|  +-------------v-----------+  +------------------+  |
|  |    McpAgent (DO)        |  |  Default Handler  |  |
|  |  - Per-request server   |  |  - /authorize     |  |
|  |  - Tool execution       |  |  - /callback      |  |
|  |  - Consent merging      |  |  - Landing page   |  |
|  +-------------+-----------+  |  - Multi-site     |  |
|                |              +------------------+   |
|                |                                     |
|  +-------------v-----------+                         |
|  |   Fetch Client          |                         |
|  |  - Bearer token         |                         |
|  |  - Token refresh        |                         |
|  +-------------+-----------+                         |
+-----------------+------------------------------------+
                  |
                  v
          Umbraco Management API
```

## Three-Tier Configuration

Tool availability is controlled by three tiers. Each tier narrows the one above.

| Tier | Where | Who | What it controls |
|------|-------|-----|------------------|
| **Admin** | `wrangler.toml` / env vars | DevOps | Maximum boundary: modes, slices, read-only |
| **Operator** | `worker.ts` options | Developer | What is available: collections, modes, consent features, sites |
| **User** | Consent screen | End user | What they get (narrowed within admin and operator bounds) |

### How Tiers Combine

```
Request arrives with AuthProps.consentChoices
          |
          v
+-------------------------+
| loadWorkerConfig()      |  Reads UMBRACO_TOOL_MODES, UMBRACO_READONLY, etc.
| (Admin tier)            |  Result: { toolModes: ["content","media"], excludeSlices: [] }
+----------+--------------+
           | [if multi-site]
           v
+-------------------------+
| loadSiteConfig()        |  Site overrides replace base values where specified
| (Site tier)             |  e.g. staging: { toolModes: ["content"], readOnly: "true" }
+----------+--------------+
           | [if consent choices]
           v
+-------------------------+
| mergeConsentChoices()   |  Intersection for modes, append for excludeSlices
| (User tier)             |  User selects [content] -> result is [content]
+----------+--------------+
           |
           v
   Effective config for this request
```

Each tier can only **narrow** the one above. Users cannot select modes the admin restricted. Sites cannot expand beyond the admin boundary.

### Admin Tier (Env Vars)

Set in `wrangler.toml` or via `wrangler secret put`. These define the maximum boundary:

```toml
[vars]
UMBRACO_TOOL_MODES = "content,media"
UMBRACO_READONLY = "true"
```

### Operator Tier (worker.ts)

The developer defines what collections and modes exist and enables consent features:

```typescript
const options = {
  collections: [contentCollection, mediaCollection, settingsCollection],
  modeRegistry: allModes,
  enableConsentToolSelection: true,
};
```

### User Tier (Consent Screen)

When `enableConsentToolSelection` is enabled, the consent screen shows mode checkboxes and a read-only toggle. Users select which modes they want. Their choices are stored in `AuthProps.consentChoices` and merged into the configuration at server creation time.

The merge rule is **intersection**: if the admin allows `[content, media]` and the user selects `[content]`, the result is `[content]`. Users cannot select modes the admin has restricted.

## Multi-Site Architecture

A single Worker can serve multiple Umbraco instances. All sites share one MCP endpoint (`/`). Site selection happens during authorization via the consent form. See [Multi-Site Deployments](multi-site.md) for setup instructions.

### Why a Single Endpoint?

MCP OAuth discovery (`.well-known/oauth-authorization-server`) returns one `authorization_endpoint`. Clients auto-discover this endpoint. Separate `/authorize/:siteId` routes would not work because the client does not know which site ID to use.

Instead, the consent screen shows a **site picker** (radio buttons) when multiple sites are configured. The user selects which Umbraco instance to authorize against as part of the consent flow.

### Route Structure

```
/                    - MCP endpoint (shared by all sites). Browser visits show site listing.
/authorize           - Consent screen with site picker.
/callback/:siteId    - OAuth callback (siteId matches Umbraco's redirect_uri).
```

## Stdio vs Hosted Comparison

| Aspect | Stdio (Local) | Hosted (Workers) |
|--------|--------------|------------------|
| Transport | stdin/stdout | Streamable HTTP |
| Authentication | Client credentials (API user) | Authorization Code (backoffice user) |
| HTTP client | Axios | Native fetch |
| Tool definitions | Same | Same |
| Tool filtering | Same | Same + user consent choices |
| Decorators | Same | Same |
| MCP chaining | Supported | Supported |
| Multi-site | N/A | Supported |

