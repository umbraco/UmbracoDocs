---
description: Enable hosted MCP support on your Umbraco site, self-hosted or on Umbraco Cloud.
---

# Setting Up Hosted MCP for Your Site

Before an AI client can connect to a hosted Umbraco MCP server, your Umbraco site needs to support it. This means registering the MCP Worker as an OAuth client so it can drive your backoffice login flow.

The [`Umbraco.Mcp.HostedAuth`](https://www.myget.org/feed/umbracoprereleases/package/nuget/Umbraco.Mcp.HostedAuth) package does this automatically — no hand-written OAuth client registration needed. Install it and it configures itself on Umbraco Cloud. Self-hosted, it picks up a small config block instead.

{% hint style="info" %}
`Umbraco.Mcp.HostedAuth` is a prerelease package on Umbraco's MyGet feed, versioned to match your Umbraco major — `17.0.0-beta.2` for Umbraco 17.
{% endhint %}

## Umbraco Cloud

Umbraco Cloud already runs the shared MCP Worker infrastructure at `mcp.umbraco.ai` — you don't deploy anything yourself.

1. Add the MyGet prerelease feed as a NuGet source. This follows the same steps as [Installing Nightly Builds](https://docs.umbraco.com/umbraco-cms/get-started/installation/installing-nightly-builds), using this feed URL instead:

   ```
   https://www.myget.org/F/umbracoprereleases/api/v3/index.json
   ```

2. Install the package:

   ```bash
   dotnet add package Umbraco.Mcp.HostedAuth --version 17.0.0-beta.2
   ```

3. Deploy. That's it — no configuration is required.

The package detects that your project has an `umbraco-cloud.json` file (every Cloud project does) and registers itself in **Cloud mode** automatically. On startup it checks which Umbraco products are installed. CMS is always present, and Commerce, Engage, or Workflow are picked up if their package is installed. It then registers an editor and developer OAuth client for each product it finds.

Your site is then reachable at the URLs in [Finding Your MCP URL](README.md#finding-your-mcp-url) — no further setup needed on your side.

## Self-Hosted

Self-hosting means two separate things need to happen: deploying the MCP Worker itself, and wiring it into your Umbraco site's OAuth.

### 1. Deploy the Worker

Deploy one of Umbraco's pre-built MCP servers (Editor or Developer) to your own Cloudflare account:

* [Hosted MCP Server](../base-mcp/hosted-mcp/README.md) — overview and prerequisites.
* [Deployment](../base-mcp/hosted-mcp/deployment/README.md) — deploy with the `wrangler` CLI.
* [Infrastructure as Code](../base-mcp/hosted-mcp/deployment/infrastructure-as-code.md) — provision with OpenTofu or Terraform.

Note the Worker's origin once deployed, for example `https://mcp.example.com`.

### 2. Wire it into Umbraco

1. Add the MyGet prerelease feed as a NuGet source, same as the Cloud steps above.
2. Install the package:

   ```bash
   dotnet add package Umbraco.Mcp.HostedAuth --version 17.0.0-beta.2
   ```

3. List your Worker under `HostedMcp:Clients` in `appsettings.json`:

   ```jsonc
   {
     "HostedMcp": {
       "Mode": "SelfHosted", // optional — Auto already resolves here when there's no umbraco-cloud.json
       "Clients": [
         {
           "ClientId": "umbraco-cms-editor-mcp-hosted",
           "Origins": [ "https://mcp.example.com" ]
         }
       ]
     }
   }
   ```

`ClientId` must match the value your Worker is configured with (its `UMBRACO_OAUTH_CLIENT_ID`). Redirect and logout URIs are derived from each origin as `{origin}/callback` and `{origin}/logout-callback` — there's no per-alias segment, unlike Cloud mode.

{% hint style="info" %}
Building a fully custom MCP server on the SDK, rather than deploying a pre-built Editor or Developer MCP server? `Umbraco.Mcp.HostedAuth` assumes a pre-built server. Use the [manual Composer approach](../base-mcp/hosted-mcp/deployment/umbraco-setup.md) instead.
{% endhint %}

## Next Steps

Once your site is set up, continue to [Finding Your MCP URL](README.md#finding-your-mcp-url) and connect your AI client using one of the [Setup Guides](README.md#setup-guides).
