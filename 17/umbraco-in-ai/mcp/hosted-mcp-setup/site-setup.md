---
description: Enable hosted MCP support on your Umbraco site, self-hosted or on Umbraco Cloud.
---

# Setting Up Hosted MCP for Your Site

Before an AI client can connect to a hosted Umbraco MCP server, your Umbraco site needs to support it. This means registering the MCP Worker as an OAuth client so it can drive your backoffice login flow.

The [`Umbraco.Mcp.HostedAuth`](https://www.nuget.org/packages/Umbraco.Mcp.HostedAuth) package does this automatically — no hand-written OAuth client registration needed. Install it and it configures itself on Umbraco Cloud. Self-hosted, it picks up a small config block instead.

{% hint style="info" %}
`Umbraco.Mcp.HostedAuth` is versioned to match your Umbraco major — `17.x` for Umbraco 17.
{% endhint %}

## Umbraco Cloud

Umbraco Cloud already runs the shared MCP Worker infrastructure at `mcp.umbraco.ai` — you don't deploy anything yourself.

1. Install the package:

   ```bash
   dotnet add package Umbraco.Mcp.HostedAuth
   ```

2. Deploy. That's it — no configuration is required.

The package detects that your project has an `umbraco-cloud.json` file (every Cloud project does) and registers itself in **Cloud mode** automatically. On startup it checks which Umbraco products are installed. CMS is always present, and Commerce, Engage, or Workflow are picked up if their package is installed. It then registers an editor and developer OAuth client for each product it finds.

Your site is then reachable at the URLs in [Finding Your MCP URL](README.md#finding-your-mcp-url) — no further setup needed on your side.

## Self-Hosted

Self-hosting means two separate things need to happen: deploying the MCP Worker itself, and wiring it into your Umbraco site's OAuth. See [Self-Hosted Quick Start](self-hosted-quickstart.md) for the full step-by-step walkthrough, from cloning the Editor MCP source through to a working connection.

{% hint style="info" %}
Building a fully custom MCP server on the SDK, rather than deploying a pre-built Editor or Developer MCP server? `Umbraco.Mcp.HostedAuth` assumes a pre-built server. Use the [manual Composer approach](../base-mcp/hosted-mcp/deployment/umbraco-setup.md) instead.
{% endhint %}

## Next Steps

Once your site is set up, continue to [Finding Your MCP URL](README.md#finding-your-mcp-url) and connect your AI client using one of the [Setup Guides](README.md#setup-guides).
