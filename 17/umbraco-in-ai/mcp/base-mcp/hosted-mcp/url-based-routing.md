---
description: >-
  Serve multiple Umbraco Cloud projects from one hosted MCP Worker using
  per-project URLs and audience-bound OAuth tokens.
---

# URL-Based Routing

URL-based routing lets a single hosted MCP Worker serve many Umbraco projects. MCP clients connect to a per-project URL (`https://<worker-host>/at/<project-alias>/`) and the Worker resolves each project on demand. There is no site picker on the consent screen and no per-project Worker deployment.

This is the recommended pattern for Umbraco Cloud, where every project has a known alias.

## How It Compares to Other Patterns

| Pattern | Per-tenant deploy | Site picker | Tokens scoped per site |
|---------|-------------------|-------------|------------------------|
| Single-site (one Umbraco per Worker) | Yes | n/a | n/a |
| [Multi-site](multi-site.md) with consent picker | No | User picks at consent | No (shared) |
| **URL-based routing** | No | URL determines site | Yes (per the MCP spec) |

URL-based routing is the right shape for Umbraco Cloud because each Cloud project already has a unique alias. The alias becomes part of the MCP URL.

## URL Shape

```
https://<worker-host>/at/<project-alias>/
```

- `<project-alias>` is the project's Cloud alias verbatim. The `dev-` prefix on development environments works without extra configuration.
- The `/at/` prefix is a fixed namespace marker. The marker avoids collisions with reserved OAuth routes (`/authorize`, `/token`, `/.well-known/*`).

Examples:

```
https://mcp.example.com/at/hosted-mcp-worker-test/
https://mcp.example.com/at/cloud-setup-training-pjw/
https://mcp.example.com/at/dev-hosted-mcp-worker-test/
```

The MCP client URL is the only difference between projects. The consent flow, the discovery document, and the OAuth dance are shared across all projects.

## Architecture

```
┌──────────────┐  /at/abc/   ┌─────────────────┐   OAuth    ┌──────────────┐    SSO     ┌──────────────────────┐
│  MCP Client  │────────────▶│  Hosted Worker  │───────────▶│ Cloud Project│───────────▶│ identity.umbraco.com │
│              │             │   (Cloudflare)  │            │ (Umbraco CMS)│            │   (Azure B2C)        │
└──────────────┘   tokens    └─────────────────┘  redirect  └──────────────┘  redirect  └──────────────────────┘
```

Three things to know:

1. **The Worker validates per-project access tokens.** The token's `aud` claim binds to `<worker-host>/at/<alias>` (per RFC 8707). `OAuthProvider`'s built-in audience check enforces the binding.
2. **The Worker rewrites `/at/<alias>/` to `/mcp` internally.** The rewrite happens after the audience check, so token validation still passes.
3. **Each Cloud project must opt in.** Two composers are required (see [Cloud Project Setup](#cloud-project-setup) below).

## Worker Configuration

Use the `umbracoCloudSiteRouting` preset in `worker.ts`:

{% code title="worker.ts" %}
```typescript
import { umbracoCloudSiteRouting } from "@umbraco-cms/mcp-hosted/cloud";

const options = {
  name: "my-umbraco-mcp",
  version: "1.0.0",
  collections,
  modeRegistry: allModes,
  allModeNames,
  allSliceNames,
  siteRouting: umbracoCloudSiteRouting({
    oauthClientId: "umbraco-mcp-cms-hosted",
    // region: "euwest01",  // or set env.UMBRACO_CLOUD_REGION
  }),
};
```
{% endcode %}

The preset takes care of:

- URL composition: `https://{alias}.{region}.umbraco.io`.
- Project validation through a `HEAD /umbraco` probe with a five-second timeout.
- Per-isolate caching of resolved sites (60 seconds OK, 30 seconds miss, 10 seconds error).
- PKCE-only authentication. No client secret is required unless you set `resolveOauthClientSecret`.

You can override `pathPrefix`, `region`, `validateProject`, or `cacheTtl` if needed.

## OAuthProvider Wiring

`OAuthProvider` must recognise both `/mcp` and `/at/` as protected resources. The rewrite from `/at/<alias>/` to `/mcp` happens **inside** `apiHandler`, after the audience check passes:

{% code title="worker.ts" %}
```typescript
const provider = new OAuthProvider({
  apiRoute: ["/mcp", "/at/"],
  apiHandler: {
    async fetch(request, env, ctx) {
      // OAuthProvider has already validated the audience against /at/{alias}.
      // Rewrite to /mcp so McpAgent.serve("/mcp") dispatches.
      const url = new URL(request.url);
      if (url.pathname.startsWith("/at/")) {
        const rewritten = new URL(request.url);
        rewritten.pathname = "/mcp";
        request = new Request(rewritten.toString(), request);
      }
      return baseApiHandler.fetch(request, env, ctx);
    },
  },
  // ...rest of OAuthProvider config
});
```
{% endcode %}

`OAuthProvider.matchApiRoute()` matches both prefixes, so a request to `/at/abc/anything` is recognised as accessing the `/at/` resource. The token's `aud` is checked against that prefix. The rewrite then happens inside `apiHandler` so `McpAgent.serve("/mcp")` can dispatch the request.

## Cloud Project Setup

Each Umbraco Cloud project participating in URL-based routing needs three things:

### 1. The OAuth Composer

Register the Worker as a public OAuth client with PKCE. See [OAuth Client Registration](../../hosted-mcp-setup/oauth-composer.md) for the full Composer code. The redirect URI for each project must include the Cloud alias:

```csharp
descriptor.RedirectUris.Add(new Uri($"https://<worker-host>/callback/<alias>"));
descriptor.RedirectUris.Add(new Uri($"http://127.0.0.1:8787/callback/<alias>"));
```

The same `clientId` value works across all Cloud projects when you use `umbracoCloudSiteRouting` with a shared `oauthClientId`.

### 2. The External Login Short Circuit Composer

This composer ensures the cold-start MCP authentication flow routes through the Cloud SSO provider. Without it, first-time users land on a local username and password form they cannot use.

See [External Login Short Circuit](../../hosted-mcp-setup/external-login-short-circuit.md) for the full setup.

### 3. Redirect URI Registration

Each project's OpenIddict client must list the following redirect URIs:

| Environment | Redirect URI |
|-------------|--------------|
| Local development | `http://127.0.0.1:8787/callback/<alias>` |
| Production Worker | `https://<worker-host>/callback/<alias>` |

## Authentication Flow

The first time an MCP client connects to `/at/<alias>/`:

1. The Worker returns 401 with `WWW-Authenticate: Bearer`.
2. The client fetches `/.well-known/oauth-protected-resource/at/<alias>` and learns the token must bind to `https://<worker-host>/at/<alias>`.
3. The client registers (DCR) and reads the issuer metadata.
4. The client opens `/authorize?...&resource=https://<worker-host>/at/<alias>`. The Worker shows the consent screen.
5. The user approves. The Worker stores `siteId=<alias>` in KV state and redirects to the project's authorize endpoint.
6. The Cloud project redirects to Umbraco login. The short-circuit composer appends `identity_provider=Umbraco.UmbracoId` to route through the Cloud SSO provider.
7. The user logs in at `identity.umbraco.com` (Azure B2C).
8. The OIDC callback (`/umbraco-signin-oidc`) converts the external login into a back-office cookie sign-in.
9. The Cloud project redirects back to the Worker's `/callback/<alias>`. The Worker exchanges the authorization code and issues an access token bound to `aud=https://<worker-host>/at/<alias>`.
10. The MCP client retries `/at/<alias>/` with the access token. The audience matches, the request is rewritten to `/mcp`, and the tools list is returned.

The siteId reaches per-request server creation through `props.consentChoices.siteId`. `createPerRequestServer` calls `siteRouting.resolveSite` to look up the project's `baseUrl` for outbound API calls.

## Adding a New Cloud Project

Three steps, all on the project. The Worker requires no changes:

1. Add the OAuth composer and the external login short-circuit composer.
2. Register the standard OAuth client ID (for example, `umbraco-mcp-cms-hosted`) in OpenIddict.
3. Register `<worker-host>/callback/<alias>` and `http://127.0.0.1:8787/callback/<alias>` as allowed redirect URIs.

`umbracoCloudSiteRouting` resolves new aliases on demand the first time a client connects.

## Non-Cloud Usage

URL-based routing works with self-hosted Umbraco instances too. Pass a generic `siteRouting` config instead of `umbracoCloudSiteRouting`:

{% code title="worker.ts" %}
```typescript
const options = {
  // ...
  siteRouting: {
    pathPrefix: "/at/",
    resolveSite: async (alias, env) => {
      // Return SiteConfig: baseUrl, oauthClientId, optional oauthClientSecret
      return {
        baseUrl: `https://${alias}.example.com`,
        oauthClientId: "umbraco-mcp-cms-hosted",
      };
    },
  },
};
```
{% endcode %}

Audience validation works the same way for self-hosted projects.

## Troubleshooting

### "Token audience does not match resource server" on the first MCP request

**Cause**: The Worker's `apiRoute` configuration does not include `/at/`, or the path rewrite happens before `OAuthProvider` validates the audience.

**Fix**: Confirm `apiRoute: ["/mcp", "/at/"]` is set on `OAuthProvider`. Move the path rewrite inside `apiHandler`, not into `createWorkerExport`.

### Cold-start authentication dies on a local username and password form

**Cause**: The Cloud project is missing the [External Login Short Circuit](../../hosted-mcp-setup/external-login-short-circuit.md) composer, or `Umbraco.Cloud.Cms` is not installed.

**Fix**: Add the composer and confirm the project references the Cloud package.

### Authentication loops between the project authorize endpoint and `identity.umbraco.com`

**Cause**: The OIDC callback is not converting the external sign-in to a back-office cookie.

**Fix**: Confirm the short-circuit composer appends `identity_provider=Umbraco.UmbracoId` to the redirect, which routes through `BackOfficeController.AuthorizeExternal`. Direct OIDC challenges bypass the cookie sign-in.

## Related Articles

- [OAuth Client Registration](../../hosted-mcp-setup/oauth-composer.md) — register the OAuth client.
- [External Login Short Circuit](../../hosted-mcp-setup/external-login-short-circuit.md) — required Cloud-only composer.
- [Multi-Site Deployments](multi-site.md) — alternative pattern that uses a consent-screen site picker.
- [Architecture](architecture.md) — three-tier configuration and component diagram.
