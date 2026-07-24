---
description: >-
  Add the Umbraco Cloud short-circuit composer so cold-start MCP authentication
  redirects to the Cloud SSO provider instead of the local login form.
---

# External Login Short Circuit

This composer is required for hosted MCP servers that connect to **Umbraco Cloud** projects. It fixes the cold-start authentication flow. Unauthenticated users are routed to the Cloud SSO provider (`identity.umbraco.com`) rather than the local username and password form.

{% hint style="info" %}
Self-hosted Umbraco instances do not need this composer. Skip this page if your project is not running on Umbraco Cloud.
{% endhint %}

## The Problem

When an unauthenticated browser hits the Management API OAuth authorize endpoint, the backoffice cookie scheme redirects to `/umbraco/login`. That URL is served by the standalone Umbraco Login app, which does not render external authentication providers.

A first-time MCP user lands on a local username and password form they cannot complete with their Cloud credentials. The authentication flow dead-ends before reaching the Cloud SSO provider.

## How the Composer Fixes It

The composer intercepts the redirect and bounces the user back to the same OAuth authorize URL with `identity_provider=Umbraco.UmbracoId` appended.

That second request routes through `BackOfficeController.AuthorizeExternal`, which:

1. Configures the OIDC challenge with the original authorize URL as the return target.
2. Calls `BackOfficeSignInManager.ExternalLoginSignInAsync` after the `/umbraco-signin-oidc` callback fires, converting the external claims into a backoffice cookie sign-in.
3. Completes the OAuth flow by issuing an authorization code.

Challenging the OIDC scheme directly skips the controller path and the backoffice cookie never gets set, which causes an authentication loop. Going via `AuthorizeExternal` matches the path the single-page application uses for its working `/umbraco` flow.

## Add the Composer

Create a file in your Umbraco Cloud project (for example, `McpExternalLoginShortCircuitComposer.cs`):

{% code title="McpExternalLoginShortCircuitComposer.cs" %}
```csharp
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

public class McpExternalLoginShortCircuitComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services
            .AddSingleton<IPostConfigureOptions<CookieAuthenticationOptions>,
                McpExternalLoginShortCircuitCookieOptions>();
    }
}

internal sealed class McpExternalLoginShortCircuitCookieOptions
    : IPostConfigureOptions<CookieAuthenticationOptions>
{
    private const string OAuthAuthorizePath =
        "/umbraco/management/api/v1/security/back-office/authorize";

    private const string IdentityProviderParam = "identity_provider";

    // Registered by Umbraco.Cloud.Cms via AddUmbracoId.
    private const string ExternalLoginScheme = "Umbraco.UmbracoId";

    private readonly ILogger<McpExternalLoginShortCircuitCookieOptions> _logger;

    public McpExternalLoginShortCircuitCookieOptions(
        ILogger<McpExternalLoginShortCircuitCookieOptions> logger)
    {
        _logger = logger;
    }

    public void PostConfigure(string? name, CookieAuthenticationOptions options)
    {
        if (name != Constants.Security.BackOfficeAuthenticationType)
        {
            return;
        }

        Func<RedirectContext<CookieAuthenticationOptions>, Task> previousLogin =
            options.Events.OnRedirectToLogin;

        options.Events.OnRedirectToLogin = ctx =>
        {
            string path = ctx.Request.Path.Value ?? string.Empty;
            bool isOAuthAuthorize = path.StartsWith(
                OAuthAuthorizePath,
                StringComparison.OrdinalIgnoreCase);
            bool isHtmlGet = HttpMethods.IsGet(ctx.Request.Method)
                && ctx.Request.Headers.Accept.ToString().Contains(
                    "text/html",
                    StringComparison.OrdinalIgnoreCase);
            bool alreadyHasIdentityProvider =
                ctx.Request.Query.ContainsKey(IdentityProviderParam);

            if (!isOAuthAuthorize || !isHtmlGet || alreadyHasIdentityProvider)
            {
                return previousLogin(ctx);
            }

            string pathAndQuery = ctx.Request.Path + ctx.Request.QueryString;
            string redirectUrl = QueryHelpers.AddQueryString(
                pathAndQuery,
                IdentityProviderParam,
                ExternalLoginScheme);

            _logger.LogInformation(
                "[McpAuth] Adding identity_provider to OAuth authorize. Redirect={RedirectUrl}",
                redirectUrl);

            ctx.Response.Redirect(redirectUrl);
            return Task.CompletedTask;
        };
    }
}
```
{% endcode %}

## Scope of the Interception

The composer only rewrites the redirect when all three conditions are met:

| Condition | Reason |
|-----------|--------|
| The path starts with `/umbraco/management/api/v1/security/back-office/authorize` | Limits the rewrite to the OAuth authorize endpoint |
| The request is an HTML `GET` (`Accept: text/html`) | Targets browser requests, not API or AJAX calls |
| `identity_provider` is not already in the query string | Prevents redirect loops when `AuthorizeExternal` falls back to the default |

Other unauthenticated requests fall through to the previous `OnRedirectToLogin` handler, which preserves the default behaviour for non-MCP traffic.

## Troubleshooting

### Cold-start authentication lands on the local username and password form

**Cause**: The composer is not registered, or `Umbraco.Cloud.Cms` is not installed in the project.

**Fix**: Confirm the composer file is present in the project and the project references `Umbraco.Cloud.Cms`. Restart the project and try again.

### Authentication loops between the project authorize endpoint and `identity.umbraco.com`

**Cause**: The OIDC callback is not converting the external sign-in to a backoffice cookie. The composer might be challenging the OIDC scheme directly instead of routing through `AuthorizeExternal`.

**Fix**: Confirm the composer appends `identity_provider=Umbraco.UmbracoId` to the redirect URL. Direct OIDC challenges bypass the cookie sign-in and cause the loop.

## Related Articles

- [OAuth Client Registration](oauth-composer.md) — register the OAuth client used by the Worker.
- [URL-Based Routing](../base-mcp/hosted-mcp/url-based-routing.md) — connect multiple Cloud projects through one hosted Worker.
