---
description: Effective and optimal communication with LLMs
---

# Context Engineering

Context Engineering is the foundation of any interaction with large language models (LLMs). This practice controls how the Umbraco Developer MCP Server delivers precise, reliable, and efficient results. It shapes what the LLM sees and understands about your request to produce the best possible responses.

## Context Overview

At its most basic level, context is the conversation between you and a tool like ChatGPT. It includes:

- The entire message history (your inputs and the model’s outputs).

- The most recent system and user instructions that define the current topic or task.

![Conversation window in ChatGPT](../images/chat-gpt-conversation.png)

LLMs are stateless, they do not retain information between individual requests. Each time you send a message, the entire context is sent to the model. This includes conversation history and any injected system data.

You can never fully control what an LLM with return. You can influence the outcome, and context is the only way that you do that.

{% hint style="info" %}
The more intentional and relevant your context, the more predictable and useful the model’s output becomes.
{% endhint %}

## Context Engineering Overview

**Context engineering** is the practice of providing the LLM with only the information needed to produce accurate and reliable results.

It involves curating and managing the information sent to the model:

- Ensuring the context is correct, concise, and relevant for the current task.

- Avoiding information overload by sending too much or contradictory context can confuse the model and lead to poor-quality responses or hallucinations.

## Why Context Engineering Is Important

In the early days of large language models (LLMs), the context of a conversation was straightforward, only your messages and the model's responses.
Conversations were short and straightforward to follow, but even then, you could see context drift. As earlier parts of the discussion faded, the model's memory weakened and response quality declined.

Today, however, the landscape has changed dramatically.

Modern AI systems rely on increasingly complex and layered context, which include far more than only the user conversation. A single MCP-driven interaction may now contain:

- A **system prompt** instructions defining the model’s role and tone.
- **Rules or instruction** files that constrain or enhance model behavior.
- **MCP definitions**, describing how external tools and data sources are used during a conversation.

All elements must fit inside the model’s context window, the limited amount of information the model can “see” at once. The most advanced models today have larger but still finite context windows, so how you fill that space still matters.

![Claude Code Context Window](../images/claude-code-context-window.png)

If too much irrelevant, poorly structured, or contradictory information is included, useful parts of the context may get pushed out or forgotten. This leads to confusion, incomplete answers, or hallucinations.
That’s why context engineering is more important now than ever. It’s about managing this limited space carefully and intentionally.

{% hint style="info" %}
Be mindful of which MCP tools you’ve added and why. Each one adds new context data that competes for space and affects how effectively the model can respond.
{% endhint %}

## Context Engineering in Umbraco CMS Developer MCP

In the Umbraco CMS Developer MCP (Model Context Protocol), context engineering is applied through structured tool contexts and well-defined prompts.
This makes requests more effective, efficient, and more likely to succeed. It also makes prompts easier to write, reuse, and maintain.

{% hint style="info" %}
Think of context engineering as the art of precision storytelling. Every piece of information you include should help the model stay on track and deliver value.
{% endhint %}

Your choice of enabled tools directly shapes the quality of your context. By managing which tools and tool collections are active, you control how much information is sent to the model. This improves both performance and response reliability. For more information, see the [Tool Collections](../available-tools.md) article.
