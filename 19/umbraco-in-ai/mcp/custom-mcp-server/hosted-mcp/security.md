---
description: Security model for the Hosted MCP server including token isolation, consent screens, CSRF protection, and MCP Authorization spec compliance.
---

# Security

## Token Isolation

MCP clients need to call the Umbraco Management API on behalf of a backoffice user. Passing the Umbraco token directly to the MCP client would be dangerous. The client could leak the token, reuse it for API calls outside the MCP server's scope, or gain direct Umbraco API access if compromised.

The hosted MCP server uses a **dual-OAuth architecture** to solve this. The Worker maintains two independent OAuth flows. The MCP client sees tokens from only one of them: the Worker's own tokens. The Umbraco tokens exist only inside the Worker and its Key-Value (KV) storage.

```
MCP Client ---Worker-issued token---> Worker ---Umbraco token---> Umbraco
```

The Worker is simultaneously:

- An **OAuth Authorization Server** to the MCP client (issues its own tokens).
- An **OAuth Client** to Umbraco (holds Umbraco tokens privately).

### How Token Isolation Works

1. The MCP client authenticates to the Worker and receives a **Worker-issued token**.
2. The Worker stores the **Umbraco token** in Workers KV under a random key.
3. On each MCP request, the Worker validates the Worker token and looks up the Umbraco token from KV.
4. The Worker uses the Umbraco token to call the Umbraco Management API.
5. Only tool results (not tokens) are returned to the MCP client.

### What Each Party Sees

| Party | What it holds | What it never sees |
|---|---|---|
| **MCP Client** | Worker-issued access token | Umbraco access token, refresh token, KV reference key |
| **Worker** | Both tokens (briefly during exchange); KV reference key in props | — |
| **Workers KV** | Umbraco access token + refresh token (keyed by random hex) | Worker-issued tokens |
| **Umbraco** | Its own tokens | Worker-issued tokens, KV reference key |

### Why Token Isolation Matters

- **Revocation** — The Worker can revoke access by deleting the KV entry. The MCP client's Worker token becomes useless because the KV lookup resolves to nothing.
- **Blast radius** — If an MCP client is compromised, the attacker gets a Worker token, not an Umbraco token. The Worker token works only with the Worker's MCP endpoint.
- **Scope restriction** — Even if the Umbraco token has broad scopes, the Worker exposes only specific tool handlers. User consent choices further narrow which tools are available.
- **Auditability** — All Umbraco API calls originate from the Worker. The Worker can log, rate-limit, and monitor every request.

### Token Lifetimes

| Token | Typical Duration |
|---|---|
| Worker access token | Managed by OAuthProvider |
| Umbraco access token | Approximately 1 hour |
| KV entry TTL | 30 days |
| Refresh token | Long-lived (days/weeks) |

The KV entry uses a long TTL (30 days) rather than matching the access token lifetime. The access token expires naturally. The refresh token stored in the same KV entry allows the Worker to obtain a new access token on 401 responses. A shorter TTL would delete both tokens from KV. This would leave the MCP session with no way to recover.

### Token Refresh

When an Umbraco access token expires:

1. The fetch client detects a 401 response.
2. If a refresh token is stored, the client exchanges the token for a new access token.
3. The new tokens are stored in KV under the same key.
4. The original request is retried with the new token.
5. If refresh fails, the user must re-authenticate.

## Consent Screen

The per-client consent screen prevents **Confused Deputy attacks**:

- Shows the name of the MCP client requesting access.
- Shows the Umbraco instance that will be accessed.
- Shows the requested scopes.
- Shows the registered redirect URI.
- The user must approve before any Umbraco redirect occurs.
- Protected against CSRF via state parameter.

### Enhanced Consent with Tool Selection

When `enableConsentToolSelection` is enabled, the consent screen also shows:

- Checkboxes for each tool mode (for example, Content Management, Media, Settings).
- A read-only toggle to disable write operations.
- Descriptions and collection listings for each mode.

User selections are stored securely in KV state alongside the OAuth request and flow through to `AuthProps.consentChoices`. Consent choices can only **narrow** the admin configuration — users cannot enable modes or slices that the admin has restricted via environment variables.

### Multi-Site Consent

In multi-site deployments, the consent screen identifies which Umbraco site the user is authorizing against. The site ID is stored in KV state and flows through to `AuthProps.consentChoices.siteId`.

### Custom Consent Rendering

You can override the consent screen rendering via `renderConsent`. When using a custom renderer:

- You are responsible for HTML escaping.
- The form must include the `state` hidden field and `action` submit buttons.
- Tool selection fields (`selectedModes[]`, `readOnly`) are optional but enable user-tier filtering.

## Consent Choices Security

User consent choices follow a **narrowing-only** model:

| Scenario | Result |
|---|---|
| Admin allows `[content, media]`, user selects `[content]` | `[content]` (intersection) |
| Admin allows `[content, media]`, user selects `[content, settings]` | `[content]` (settings filtered out) |
| No admin restriction, user selects `[content]` | `[content]` (user restriction applied) |
| Admin sets read-only, user does not check read-only | Read-only (admin overrides) |
| Admin does not set read-only, user checks read-only | Read-only (user restriction applied) |

The admin tier is the **maximum boundary**. No user action can exceed it. Users can self-limit but never self-escalate.

## CSRF and State Protection

- OAuth state parameters are generated with `crypto.getRandomValues()` (64 hex chars).
- State is stored in KV with a 10-minute TTL and is single-use (deleted immediately after consumption).
- Consent choices are stored alongside the OAuth state, not in cookies or URL parameters.
- The consent form includes a hidden state field.
- `X-Frame-Options: DENY` and `Content-Security-Policy: frame-ancestors 'none'` are set on all HTML responses.

## Server-Side Request Forgery (SSRF) Mitigations

- `UMBRACO_BASE_URL` is configured as a secret, not from user input.
- All API calls go through the configured base URL only.
- No user-controlled URL construction is used in API calls.
- Multi-site base URLs are defined in operator code or environment variables, not from user input.

## Backoffice Endpoint Resolution

Umbraco's backoffice uses OpenIdDict but does **not** expose a separate OIDC discovery document for backoffice endpoints. The generic `/.well-known/openid-configuration` returns member/delivery API endpoints, not backoffice ones. The Worker constructs URLs from well-known paths instead:

| Endpoint | Path |
|---|---|
| Authorization | `/umbraco/management/api/v1/security/back-office/authorize` |
| Token | `/umbraco/management/api/v1/security/back-office/token` |

### Dual Base URLs

The Worker supports two base URLs:

- **`UMBRACO_BASE_URL`** — used for the authorization endpoint (browser-facing). Must be reachable by the user's browser.
- **`UMBRACO_SERVER_URL`** (optional) — used for the token endpoint (server-side). Falls back to `UMBRACO_BASE_URL` if not set.

In local development, the Worker runtime (`workerd`) cannot reach HTTPS endpoints with self-signed certificates. Setting `UMBRACO_SERVER_URL` to an HTTP address allows server-side token exchange to succeed while the browser redirect still uses the real HTTPS URL.

## Multi-Site Security

In multi-site deployments:

- Each site has its own OAuth client credentials. A compromise of one site's credentials does not affect others.
- Site IDs are validated against the configured site list. Unknown site IDs return 404.
- Per-site tool filter overrides can further restrict (but not expand) the base admin configuration.
- Site selection is explicit — the user picks a site on the consent screen, preventing confused deputy attacks across sites.

## MCP Authorization Spec Compliance

| Requirement | Implementation |
|---|---|
| Token passthrough forbidden | Worker issues its own tokens; Umbraco tokens stored in KV |
| Third-Party Authorization Flow | Worker is both OAuth AS and OAuth Client |
| Per-client consent | Consent screen shown before Umbraco redirect |
| PKCE required | S256 challenge for both Worker-to-Umbraco and Client-to-Worker flows |
| Dynamic Client Registration (RFC 7591) | OAuthProvider supports `/register` endpoint |
| Per-request McpServer | `createPerRequestServer()` called per request |
| Cryptographic session IDs | `crypto.getRandomValues()` for all tokens and state |
| Origin header validation | OAuthProvider validates origin headers |

## Scope Minimization

- Request only the scopes needed for your tool collections.
- Configure scopes via `authOptions.scopes` in `HostedMcpServerOptions`.
- Default scopes: `openid`, `offline_access`.
