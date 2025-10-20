---
description: Effective and optimal communication with LLMs
---

# Model Context Protocol (MCP)

**Model Context Protocol (MCP)** is a standardised way to connect Large Language Models (LLMs) with external tools, APIs, and data sources. It brings order and consistency to how LLMs interact with the outside world — transforming what used to be complex, manual integrations into something modular and predictable.

## The History of MCP

MCP was developed by Anthropic and released publicly in November 2024.

Anthropic describes it as “the USB-C of connecting to LLMs.”
Before MCP, connecting an LLM to external systems such as APIs, files, or databases was a complex and manual process. Each integration required custom glue code and inconsistent communication patterns.

With MCP, this has changed. The protocol provides a standardised, declarative way to describe and expose capabilities — making it much easier for developers to connect logic and data to an LLM in a reliable, repeatable way.

## What Is MCP

MCP defines a structured relationship between hosts, clients, and servers.

### Host Applications

These are applications that implement MCP support — for example:

- Claude Desktop and Claude Code
- Cursor
- Windsurf
- GitHub Copilot
- and many others

A host provides the environment where the model runs and where MCP connections are managed.

---

### MCP Clients

An MCP client represents a single connection between the LLM and an MCP server. It routes information between the MCP servers and the model, makes each MCP capability visible to the LLM, passes calls from the model to the correct server, and returns the results back to the LLM. In short, the client acts as the traffic controller between the model and the external systems it can interact with.

--- 

### MCP Servers

An MCP server defines and exposes the elements that allow the LLM to interact with external systems.

Servers can represent:

- APIs
- Databases
- Filesystems
- Any other external system

A single client can connect to multiple servers, each running in parallel — for example, one server might expose Umbraco’s Management API, another might provide access to a local file system, and a third could connect to an external data source such as a CRM or analytics database. This allows the LLM to draw from and interact with several systems at once, all through a single, unified MCP connection.

Each exposed element has a name and a description, which the model uses to understand what the element does and when to use it.

## The Core Elements of MCP

MCP defines three primary element types:

**Tools**
These act like API calls, enabling the model to perform actions or trigger operations.

**Resources**
These are read-only, parameterised calls that retrieve data to add to the LLM’s context.
They are triggered by user interaction or as part of a larger process.

**Prompts**
These are predefined, parameterised conversations that define complex interactions with the model.
Prompts are ideal for multi-step tasks or for standardising a common process.

## What This Means for Umbraco

The Umbraco CMS Developer MCP Server builds on top of Umbraco’s Management API (introduced in v14), which exposes everything the Backoffice can do — from content and media to document and data types — through consistent, structured endpoints.

These APIs follow predictable patterns for CRUD operations, listings, and metadata, making them an ideal foundation for the Model Context Protocol (MCP).

However, the Backoffice UI can only ever expose a fraction of the functionality that the Management API makes possible. It’s designed for day-to-day content management — not for executing complex, multi-step operations that span across entities or require dynamic logic. Many advanced or edge case workflows are simply too specialised, too costly, or too confusing to implement in the UI.

By giving an LLM or AI agent access to these APIs through MCP, you can now ask it to perform powerful, compound tasks that are impossible in the Backoffice and impractical to achieve manually.

MCP turns Umbraco’s structured API surface into something the model can reason about, combine, and automate — unlocking the full depth of Umbraco’s capabilities, not just the parts surfaced through the UI.

{% hint style="info" %}
MCP is not a replacement for the Umbraco Backoffice. Many actions — like visual content design, layout composition, and structured editing — are best completed using the UI.
Instead, the Developer MCP Server augments the Backoffice, empowering you to run complex, technical operations that are better expressed as goals or workflows rather than manual clicks.
{% endhint %}

Because MCP exposes the Management API as composable tools, the model can chain endpoints in virtually unlimited combinations to solve real-world tasks. You describe the outcome you want, and the model figures out how to get there.

For example:

- **Bulk content operations** – Identify, update, and republish hundreds of nodes programmatically.
- **Media automation** – Rename, categorise, and relocate assets based on metadata or folder structure.
- **Schema scaffolding** – Generat or manage document types and data types directly from a or prompt.
- **Reporting** – Extract and analyze content patterns, audit site structure, or generate usage reports across your entire site. 

This represents a fundamental shift in how you build with Umbraco.

You’ve always had access to the Management API — but using it directly meant writing custom scripts or tooling. Now, with MCP, the model (or an agent) can dynamically plan and execute API calls on your behalf.

It looks like magic — but it’s really MCP orchestration: the LLM figures out what to call, when, and why based on the tools it’s been given and the goal you’ve described.

The only limit is your imagination. If you can explain what you want, an LLM that understands Umbraco and has the right MCP tools can be left to figure out how to make it happen.

## The LLM as a Collaborator

Beyond automation, MCP enables you to leverage the expertise of the LLM as an intelligent contributor to your Umbraco project. Instead of just executing tasks, the model can assist in planning schema changes, refactoring document types, improving naming conventions, and proposing best practices — all based on a deep understanding of the CMS. It can help you migrate, restructure, and optimise your setup, reducing manual effort while increasing technical quality. With the Developer MCP Server, the LLM becomes more than a command executor — it becomes a collaborative development partner.