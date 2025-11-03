---
description: Effective and optimal communication with LLMs
---

# Model Context Protocol (MCP)

**Model Context Protocol (MCP)** is a standardised way to connect Large Language Models (LLMs) with external tools, APIs, and data sources. It brings order and consistency to how LLMs interact with the outside world. This transforms complex, manual integrations into something modular and predictable.

## The History of MCP

MCP was developed by Anthropic and released publicly in November 2024.

Anthropic describes it as “the USB-C of connecting to LLMs.”
Before MCP, connecting an LLM to external systems such as APIs, files, or databases was a complex and manual process. Each integration required custom glue code and inconsistent communication patterns.

With MCP, this has changed. The protocol provides a standardised, declarative way to describe and expose capabilities. This makes it much easier for developers to connect logic and data to an LLM in a reliable, repeatable way.

## What Is MCP

MCP defines a structured relationship between hosts, clients, and servers.

### Host Applications

These are applications that implement MCP support — for example:

- Claude Desktop and Claude Code
- Cursor
- Windsurf
- GitHub Copilot
- And many others

The host application is where you interact with the model and manage MCP connections. It coordinates between your input, the LLM, and any connected MCP tools via the client.

---

### MCP Clients

An MCP client represents a single connection between the LLM and an MCP server. It routes information between the MCP servers and the model. It makes each MCP capability visible to the LLM. The client passes calls from the model to the correct server and returns the results back. 

In short, the client acts as the traffic controller between the model and the external systems it can interact with.

--- 

### MCP Servers

An MCP server defines and exposes the elements that allow the LLM to interact with external systems.

Servers can represent:

- APIs
- Databases
- Filesystems
- Any other external system

A single client can connect to multiple servers, each running in parallel. For example, one server might expose Umbraco's Management API, another might provide access to a local file system. A third could connect to an external data source such as a CRM or analytics database. This allows the LLM to draw from and interact with many systems at once. All of this happens through a single, unified MCP connection.

Each exposed element has a name, a description, and an input schema. The model uses these to understand what the MCP server element does and when to use it.

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

The Developer MCP Server builds on top of Umbraco's Management API (introduced in v14). This API exposes everything the Backoffice can do through consistent, structured endpoints. This includes content, media, document types, and data types.

These APIs follow predictable patterns for CRUD operations, listings etc, making them an ideal foundation for the Model Context Protocol (MCP).

However, the Backoffice UI can only ever expose a fraction of the functionality that the Management API makes possible. It’s designed for day-to-day content management — not for executing complex, multi-step operations that span across entities or require dynamic logic. Many advanced or edge case workflows are often too specialised, too costly, or too confusing to implement in the UI.

By giving an LLM or AI agent access to these APIs through MCP, you can now ask it to perform powerful, compound tasks. These tasks would be impossible in the Backoffice and impractical to achieve manually.

MCP turns Umbraco's structured API surface into something the model can read from, reason about, and automate. This unlocks the full depth of Umbraco's capabilities, not only the parts surfaced through the UI.

{% hint style="info" %}
MCP is not a replacement for the Umbraco Backoffice. Many actions are best completed using the UI. This includes visual content design, layout composition, and structured editing.
Instead, the Developer MCP Server augments the Backoffice. It empowers you to run complex, technical operations that are better expressed as goals or workflows rather than manual clicks.
{% endhint %}

MCP exposes the Management API as composable tools. This means the model can chain endpoints in an unlimited number of combinations to solve real-world tasks. You describe the outcome you want, and the model figures out how to get there.

For example:

- **Bulk content operations** – Identify, update, and republish hundreds of nodes programmatically.
- **Media automation** – Rename, categorise, and relocate assets based on metadata or folder structure.
- **Schema scaffolding** – Generate or manage document types and data types directly from a prompt.
- **Maintenance** – Reorganise into folders, standardise naming conventions or tidy up accumulated technical debt.
- **Reporting** – Extract and analyze content patterns, audit site structure, or generate usage reports across your entire site. 
- [**Plus many, many more**](../scenarios.md)

This represents a fundamental shift in how you build with Umbraco.

You’ve always had access to the Management API — but using it directly meant writing custom scripts or tooling. Now, with MCP, the model (or an agent) can dynamically plan and execute API calls on your behalf.

It looks like magic — but it's really purely tool orchestration. The LLM figures out what to call, when, and why. It bases this on the tools it's been given and the goal you've described.

The only limit is your imagination. If you can explain what you want, an LLM that understands Umbraco can figure out how to make it happen. This assumes it has the right MCP tools available.

## The LLM as a Collaborator

Beyond automation, MCP enables you to leverage the expertise of the LLM as an intelligent contributor to your Umbraco project. Instead of just executing tasks, the model can assist in planning schema changes, refactoring document types, improving naming conventions, and proposing best practices. All of this is based on a deep understanding of the CMS. It can help you migrate, restructure, and optimise your setup, reducing manual effort while increasing technical quality. With the Developer MCP Server, the LLM becomes more than a command executor — it becomes a **collaborative development partner**.