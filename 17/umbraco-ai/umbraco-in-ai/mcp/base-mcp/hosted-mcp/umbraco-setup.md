---
description: Register the Hosted MCP Worker as an OAuth client in your Umbraco instance.
---

# Umbraco Setup

The Umbraco instance needs the hosted MCP server registered as an OAuth client. This is a one-time setup per Umbraco instance.

## Prerequisites

- Umbraco 14+ with Management API enabled
- Admin access to the Umbraco project source code
- The hosted MCP server's callback URL (for example, `https://my-umbraco-mcp.workers.dev/callback`)

## Register the OAuth Client

The hosted MCP Worker must be registered as an **Authorization Code** OAuth client in Umbraco's OpenIdDict. This cannot be done through the backoffice UI (which supports only client credentials grants). Instead, register the client in C# code using an Umbraco Composer.

### Add the Composer

Create a file in your Umbraco project (for example, `McpOAuthComposer.cs`):

```csharp
using OpenIddict.Abstractions;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

public class McpOAuthComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationAsyncHandler<UmbracoApplicationStartingNotification,
            RegisterMcpClientHandler>();
    }
}

public class RegisterMcpClientHandler
    : INotificationAsyncHandler<UmbracoApplicationStartingNotification>
{
    private readonly IOpenIddictApplicationManager _applicationManager;

    public RegisterMcpClientHandler(IOpenIddictApplicationManager applicationManager)
    {
        _applicationManager = applicationManager;
    }

    public async Task HandleAsync(
        UmbracoApplicationStartingNotification notification,
        CancellationToken cancellationToken)
    {
        const string clientId = "umbraco-back-office-mcp";

        // Remove any existing registration so we can update it cleanly
        var existing = await _applicationManager.FindByClientIdAsync(clientId, cancellationToken);
        if (existing is not null)
        {
            await _applicationManager.DeleteAsync(existing, cancellationToken);
        }

        var descriptor = new OpenIddictApplicationDescriptor
        {
            ClientId = clientId,
            ClientType = OpenIddictConstants.ClientTypes.Public,
            DisplayName = "Umbraco MCP Server",
            RedirectUris =
            {
                // Production callback URL
                new Uri("https://my-umbraco-mcp.workers.dev/callback"),
                // Local development callback URL
                new Uri("http://localhost:8787/callback"),
            },
            // Required for "Log in as different user" (RP-Initiated Logout)
            PostLogoutRedirectUris =
            {
                new Uri("https://my-umbraco-mcp.workers.dev/logout-callback"),
                new Uri("http://localhost:8787/logout-callback"),
            },
            Permissions =
            {
                OpenIddictConstants.Permissions.Endpoints.Authorization,
                OpenIddictConstants.Permissions.Endpoints.Token,
                OpenIddictConstants.Permissions.Endpoints.Revocation,
                OpenIddictConstants.Permissions.Endpoints.EndSession,
                OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode,
                OpenIddictConstants.Permissions.GrantTypes.RefreshToken,
                OpenIddictConstants.Permissions.ResponseTypes.Code,
            }
        };

        await _applicationManager.CreateAsync(descriptor, cancellationToken);
    }
}
```

## How It Works

- **Composer auto-discovery**: Umbraco discovers `McpOAuthComposer` via `IComposer`. No changes to `Program.cs` are needed.
- **Runs on startup**: The `UmbracoApplicationStartingNotification` handler registers the client each time the application starts. This ensures the configuration is always up to date.
- **Idempotent**: The handler deletes any existing registration before creating a new one. It is safe to restart.

## Why Not the Backoffice UI?

The backoffice Settings > Users page creates **API users** that use the **client credentials** grant type. These are designed for server-to-server authentication (for example, the stdio MCP server).

The hosted MCP server requires the **authorization code** grant type because end users authenticate interactively through Umbraco's backoffice login. This grant type requires a redirect URI and a **public** client type (PKCE-only, no client secret). Neither is configurable through the backoffice UI.

## Allow HTTP for Token Exchange

The Cloudflare Workers runtime (`workerd`) cannot connect to HTTPS endpoints with self-signed certificates. For local development, allow HTTP in your Umbraco OpenIdDict configuration.

Add this to your `Program.cs` **after** the Umbraco builder and **before** `app.Build()`:

```csharp
using OpenIddict.Server.AspNetCore;

// ... existing Umbraco builder code ...

// Allow HTTP for local dev so Cloudflare Workers (workerd) can reach
// Umbraco's token endpoint without needing to trust a self-signed cert.
if (builder.Environment.IsDevelopment())
{
    builder.Services.Configure<OpenIddictServerAspNetCoreOptions>(options =>
    {
        options.DisableTransportSecurityRequirement = true;
    });
}

WebApplication app = builder.Build();
```

{% hint style="warning" %}
This is gated behind `IsDevelopment()` so it applies only when `ASPNETCORE_ENVIRONMENT=Development`. Never disable transport security in production.
{% endhint %}

## Post-Logout Redirect URIs

The `PostLogoutRedirectUris` and `Endpoints.EndSession` permission are required for the "Log in as different user" feature (`showReauthButton: true` in the Worker). This uses OpenID Connect RP-Initiated Logout to clear Umbraco's session cookie before starting a fresh authorization.

If you do not need user switching, you can omit `PostLogoutRedirectUris` and the `Endpoints.EndSession` permission.

## Multi-Site Setup

For multi-site deployments, each Umbraco instance needs its own OAuth client registered. Include the site ID in the callback path (for example, `/callback/prod`). Each site can use different OAuth client IDs. Register a separate Composer (or parameterize a single one) for each Umbraco instance.

See [Multi-Site Deployments](multi-site.md) for the full setup including redirect URI examples.

## Set Worker Secrets

The Worker's `UMBRACO_OAUTH_CLIENT_ID` must match the `clientId` in the Composer above. No client secret is needed — the OAuth client is registered as a **public** client with PKCE.

See [Deployment](deployment.md) for all required secrets and [Local Development Setup](local-dev-setup.md) for `.dev.vars` configuration.

## Redirect URI Configuration

The redirect URI registered in the Composer must match the Worker's callback URL exactly:

| Environment | Redirect URI |
|-------------|-------------|
| Production | `https://my-umbraco-mcp.workers.dev/callback` |
| Production (multi-site) | `https://my-umbraco-mcp.workers.dev/callback/:siteId` |
| Custom domain | `https://mcp.example.com/callback` |
| Local dev | `http://localhost:8787/callback` |

You can register multiple redirect URIs in the Composer for different environments.

## Verifying the Setup

1. Restart the Umbraco instance (so the Composer runs).
2. Start the Worker: `npx wrangler dev --port 8787`.
3. Visit `http://localhost:8787`. You should see the landing page.
4. Use the MCP Inspector in Direct mode with `http://localhost:8787/`.
5. The Inspector should trigger the OAuth flow: consent screen, then Umbraco login, then connected.

## Troubleshooting

### "The specified `redirect_uri` is not valid" (OpenIdDict ID2043)

**Cause**: The callback URL sent by the Worker does not match any URI in the Composer's `RedirectUris`.

**Fix**: Ensure `http://localhost:8787/callback` is listed for local dev. For multi-site, ensure `/callback/:siteId` is registered for each site. The URL must match exactly with no trailing slashes and the correct protocol.

### "Token exchange failed" / TLS errors in local dev

**Cause**: The Worker (`workerd`) cannot connect to Umbraco over HTTPS with a self-signed certificate.

**Fix**: Disable OpenIdDict's transport security requirement in dev mode and set `UMBRACO_SERVER_URL` to Umbraco's HTTP port. See [Local Development Setup](local-dev-setup.md) for the full walkthrough.

### `invalid_client` on token exchange

**Cause**: The OAuth client ID in the Worker does not match the Composer registration, or the client type is wrong.

**Fix**: Verify that `UMBRACO_OAUTH_CLIENT_ID` (in `.dev.vars` or Wrangler secrets) matches the `ClientId` in your `McpOAuthComposer.cs`. Check that the client is registered as `Public` (not `Confidential`). A public client uses PKCE and does not require a client secret.

For Worker-specific errors (Durable Object bindings, SQLite migrations), see the [Troubleshooting](troubleshooting.md) guide.
