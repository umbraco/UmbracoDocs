---
description: Managing token usage and MCP tool context to reduce cost and improve agent performance.
---

# Token Efficiency

Token efficiency is the practice of controlling how many tokens your agent sends to the LLM on each interaction. Efficient token usage reduces cost, speeds up responses, and improves answer quality.

## Why Tokens Accumulate in Agent Sessions

LLMs are stateless. When you work with an agent, the agent sends the full session context to the LLM. The full session context includes message history, tool definitions, and injected system data.

For more on why context composition matters, see [Context Engineering](context-engineering.md).

Each tool added to an MCP server contributes to this context. By default, every registered tool adds its schema, description, and metadata to every request. A large tool set inflates token usage and drives up cost.

## Active Context Management

Some platforms address this problem with active context management. The platform loads only the tools needed for the current task, rather than all registered tools.

Claude Code applies this pattern with its MCP tool search feature. The agent queries to find tools relevant to the current task, then loads only those tools into the active context.

## Manual Tool Management

If your platform does not support active context management, you **must manually engineer** the context to get the most efficient session. You do this through environment variables when starting the MCP server, choosing which tools are exposed to the agent.

The environment variables are the same across all Umbraco MCP servers. See [Tool Filtering](../mcp/base-mcp/sdk/tool-filtering.md) for the full list of filtering options.

{% hint style="warning" %}
If your platform does not manage context and you do not filter tools, token usage grows quickly. Costs rise and subscription limits are reached sooner.
{% endhint %}
