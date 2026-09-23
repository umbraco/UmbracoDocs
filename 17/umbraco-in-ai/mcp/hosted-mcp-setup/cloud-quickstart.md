---
description: Enable hosted MCP for your Umbraco Cloud project in two steps.
---

# Umbraco Cloud Quick Start

Umbraco Cloud already runs the shared MCP Worker infrastructure at `mcp.umbraco.ai` — there's no Worker to deploy. Getting your project reachable takes one package install.

## 1. Install the Package

```bash
dotnet add package Umbraco.Mcp.HostedAuth --prerelease
```

{% hint style="info" %}
[`Umbraco.Mcp.HostedAuth`](https://www.nuget.org/packages/Umbraco.Mcp.HostedAuth) is currently prerelease-only on NuGet, so `--prerelease` is required. It's versioned to match your Umbraco major — `17.x` for Umbraco 17. See the [package README](https://github.com/umbraco/Umbraco.Mcp.HostedAuth) for the full configuration reference.
{% endhint %}

## 2. Deploy

That's it — no configuration is required.

The package detects that your project has an `umbraco-cloud.json` file (every Cloud project does) and registers itself in **Cloud mode** automatically. On startup it checks which Umbraco products are installed. CMS is always present, and Commerce, Engage, or Workflow are picked up if their package is installed. It then registers an editor and developer OAuth client for each product it finds.

## Verify the Connection

Your site is reachable at the URLs in [Finding Your MCP URL](README.md#finding-your-mcp-url). Connect an MCP client using that URL — see the [Setup Guides](README.md#setup-guides). The client should trigger the OAuth flow: consent screen, then Umbraco login, then connected.

## Next Steps

* Setting up a self-hosted or agency instance instead? See the [Self-Hosted Quick Start](self-hosted-quickstart.md).
* Building a fully custom MCP server on the SDK, rather than deploying a pre-built Editor or Developer MCP? Use the [manual Composer approach](../base-mcp/hosted-mcp/deployment/umbraco-setup.md) instead.
