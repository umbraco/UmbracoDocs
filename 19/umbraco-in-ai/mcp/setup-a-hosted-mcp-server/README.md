---
description: >-
  Enable hosted MCP access for your Umbraco site before connecting an AI client.
---

# Set Up a Hosted MCP Server

A hosted MCP server lets AI clients connect to your Umbraco site remotely over HTTP. Before an AI client can connect, you need to enable hosted MCP access on your site. This is a one-time step per Umbraco instance.

The setup path depends on how your site is hosted. For Umbraco Cloud projects, install the [`Umbraco.Mcp.HostedAuth`](https://www.nuget.org/packages/Umbraco.Mcp.HostedAuth) package and deploy. The shared MCP infrastructure at `mcp.umbraco.ai` is already running. Self-hosted and agency sites also need a Cloudflare Worker deployed to act as the MCP endpoint. Follow the guide that matches your hosting environment:

* [Umbraco Cloud Quick Start](cloud-quickstart.md)
* [Self-Hosted Quick Start](self-hosted-quickstart.md)
