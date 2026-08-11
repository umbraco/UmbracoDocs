---
description: Customize the consent screen with tool selection, branding, custom CSS, or a fully custom renderer.
---

# Customization

The consent screen is displayed to users during the OAuth flow, before they authenticate with Umbraco. It identifies the requesting MCP client, shows what access is being requested, and optionally lets users choose which tool modes to enable.

See [Architecture - Auth Flow](architecture.md#auth-flow) for where the consent screen fits in the overall flow.

## Tool Selection

Set `enableConsentToolSelection: true` in your `HostedMcpServerOptions` to enable tool selection. When enabled, the consent screen shows:

- A checkbox for each mode (with its display name, description, and collections listed).
- All modes checked by default.
- A "Read-only mode" toggle.

The tool config is auto-generated from your `modeRegistry` by `buildConsentToolConfig()`. User selections are stored in `AuthProps.consentChoices` and applied at tool registration time via `mergeConsentChoices()`.

### How It Interacts with Three-Tier Configuration

Tool selection is the **user tier**. It can only narrow what the admin tier allows. If the admin restricts modes to `[content, media]` via `UMBRACO_TOOL_MODES`, the consent screen shows only those two modes. Users cannot enable modes beyond the admin boundary.

See [Architecture - How Tiers Combine](architecture.md#how-tiers-combine) for the full cascade.

## User Switching

When a user completes the OAuth flow, Umbraco sets a browser session cookie. On subsequent authorizations in the same browser, Umbraco skips the login form and re-authenticates via this cookie. Umbraco does not prompt for login again.

Enable the "Log in as different user" button on the consent screen:

```typescript
const options = {
  // ...
  authOptions: {
    showReauthButton: true,
  },
};
```

When enabled, the consent screen shows a third button ("Log in as different user") between Approve and Deny. The button appears only after the client has completed at least one authorization. On the first authorization, only Approve and Deny are shown.

### How It Works

Clicking "Log in as different user" triggers OpenID Connect RP-Initiated Logout:

1. The Worker redirects to Umbraco's signout endpoint (`/umbraco/management/api/v1/security/back-office/signout`) with a `post_logout_redirect_uri` pointing to the Worker's `/logout-callback` route.
2. Umbraco clears the session cookie and redirects back to `/logout-callback`.
3. The Worker redirects to Umbraco's authorize endpoint. Since the cookie is cleared, the login form appears.

### Umbraco Setup Required

The Umbraco OAuth client registration must include:

- `PostLogoutRedirectUris` with the Worker's `/logout-callback` URL.
- `OpenIddictConstants.Permissions.Endpoints.EndSession` permission.

See [Umbraco Setup - Post-Logout Redirect URIs](umbraco-setup.md#post-logout-redirect-uris) for the full registration example.

## Custom Server Name

Display a custom name in the consent screen header:

```typescript
const options = {
  // ...
  authOptions: {
    serverName: "Contoso CMS Tools",
  },
};
```

## Custom CSS

Inject custom CSS to style the consent screen. The built-in consent screen uses these targetable selectors:

| Selector | Element |
|----------|---------|
| `.card` | White card container (max-width: 480px) |
| `h1` | Header (default color: `#1b264f`) |
| `.field`, `.field-label`, `.field-value` | Info fields (client name, Umbraco URL, and so on) |
| `.scopes`, `.scopes li` | Scope list |
| `.actions` | Button container |
| `.btn-approve` | Approve button (default background: `#1b264f`) |
| `.btn-reauth` | "Log in as different user" button (only rendered when `showReauthButton` is true) |
| `.btn-deny` | Deny button |
| `.tool-selection`, `.tool-selection h2` | Tool selection container and heading |
| `.mode-item`, `.mode-item label` | Individual mode checkbox rows |
| `.mode-description`, `.mode-collections` | Mode detail text |
| `.readonly-toggle`, `.readonly-toggle label` | Read-only toggle row |
| `.site-selection`, `.site-selection h2` | Multi-site picker container and heading |
| `.site-option`, `.site-option label` | Individual site radio rows |
| `.site-url` | Site URL text |

All checkboxes and radio buttons use `accent-color: #1b264f` by default.

Example:

```typescript
const options = {
  // ...
  authOptions: {
    customCss: `
      .btn-approve { background: #e74c3c; border-color: #e74c3c; }
      h1 { color: #e74c3c; }
    `,
  },
};
```

## Custom Consent Renderer

Replace the entire consent screen with your own HTML. Use this when you need full control over layout, branding, or behavior.

```typescript
const options = {
  // ...
  authOptions: {
    renderConsent: (opts) => `
      <html>
        <body>
          <h1>Authorize ${opts.clientName}</h1>
          <form method="POST" action="${opts.actionUrl}">
            <input type="hidden" name="state" value="${opts.state}" />
            <button name="action" value="approve">Allow</button>
            <button name="action" value="deny">Deny</button>
          </form>
        </body>
      </html>
    `,
  },
};
```

### Required Form Fields

Your custom renderer **must** include these form fields:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `state` | `hidden` | Yes | CSRF protection. Use `opts.state`. |
| `action` | `submit` button value | Yes | `"approve"`, `"reauth"`, or `"deny"` |
| `selectedModes[]` | `checkbox` | No | Mode names the user selected (enables user-tier filtering) |
| `readOnly` | `checkbox` value `"true"` | No | Whether read-only mode is enabled |
| `siteId` | `radio` or `hidden` | No | Site selection for multi-site deployments |

### Security Responsibilities

When using a custom renderer, you are responsible for:

- **HTML escaping** all dynamic values (`opts.clientName`, `opts.umbracoBaseUrl`, and so on) to prevent XSS.
- Including the `state` hidden field (required for CSRF protection).
- Including `action` buttons with values `"approve"` and `"deny"`.

The framework still applies security response headers (`X-Frame-Options: DENY`, `Content-Security-Policy: frame-ancestors 'none'`, `X-Content-Type-Options: nosniff`) regardless of the renderer.

### ConsentScreenOptions Reference

The `opts` parameter passed to `renderConsent` has the full `ConsentScreenOptions` shape. See [API Reference - ConsentScreenOptions](api-reference.md#consentscreenoptions) for all available properties.
