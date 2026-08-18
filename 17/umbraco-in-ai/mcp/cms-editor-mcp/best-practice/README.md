---
description: Get the most out of the Umbraco CMS Editor MCP server
---

# Best Practice

This page details the recommended way to use the Umbraco CMS Editor MCP Server for maximum effectiveness and reliability.

The Editor MCP Server gives you conversational access to your Umbraco site. To get good results, you should be deliberate about how you configure and manage each session.

## Use Only the Tools You Need

{% hint style="warning" %}
Do not enable all tools at once. Doing so makes requests inefficient and may cause the AI to produce less reliable results.
{% endhint %}

Each tool you add increases the amount of information (context) that gets sent to the model. This competes for limited space and can cause the model to lose focus or produce unreliable results.

Always enable only the tools (or tool collections) needed for the current task. For example, if you are working on content editing, enable the `content` mode rather than all modes.

### Keep It Lean: Cost and Sustainability

Every time you interact with the AI, the entire context is sent to the model. This includes the system prompt, tools, instruction files, and chat history. The smaller and more focused your context, the better.

Large prompts and bloated tool collections lead to slower and less accurate results. They also increase cost and environmental impact.

{% hint style="info" %}
Optimizing your context makes your work faster, cheaper, and greener.
{% endhint %}

## Recommended Workflow

1. **Start with a clean session.** Open a new session in your AI client. This ensures there is no leftover context from a previous task.

2. **Decide on the tools or mode.** Identify which MCP tools you need for the specific task. Use [modes](../configuration.md) to enable groups of related tools.

3. **Run your prompt or workflow.** Ask the AI to perform the task. Keep it focused on the tools you have enabled.

4. **Complete the task, then reset.** Once the task is done, clear the session. Start afresh before beginning another to avoid context bleed.

## Confirm Before You Act

The Editor MCP Server is designed to be safe for everyday use. All write operations require your confirmation before they execute:

* **Creating** pages, media, members, or dictionary items — you will be asked to confirm.
* **Editing** content, blocks, or properties — you will be asked to confirm.
* **Publishing and unpublishing** — you will be asked to confirm.
* **Deleting** items — you will be asked to confirm, and the operation is flagged as destructive.

{% hint style="info" %}
Read the confirmation prompts carefully. They tell you exactly what will change before you approve.
{% endhint %}

## Context Condensing

AI assistants have a limited context window, and every active tool, message, and instruction contributes to that total. If you are working on a complex or long-running task, you can quickly hit the limit.

### Strategies for Condensing Context

- **Use built-in compression tools (if available)**

Some clients (for example, Claude Code) include options to automatically compress or summarize earlier parts of the conversation. Use these to reduce noise while keeping relevant information accessible.

- **Checkpoint progress into a file**

If the context is filling up too quickly, ask the AI to generate a summary of progress so far. You can then start a new session and provide the summary at the beginning.

## Use Instruction Files to Guide the AI

For complex workflows, it can be helpful to include an instruction file that explains:

- What the enabled tools do
- When and how to use them
- Any naming conventions or content structure rules
- Expected sequences or common workflows

This helps the AI reason more effectively about how to use the Editor MCP Server, especially when multiple tools are involved.

View an example [instruction file](./example-instructions.md).

## Crafting Good Prompts

Your results depend heavily on how well you prompt the AI. A good prompt sets clear intent, scope, and expectations.

### Tips for Better Prompting

- **Be specific about the goal**
Instead of:
`Fix this content.`
Use:
`Update the 'About Us' page intro text to mention our new office in Copenhagen.`

- **Mention tools or entities by name**
If you have enabled tools like `content`, `media`, or `translation`, refer to them directly. This helps the AI understand what it can access.

- **Break up complex workflows**
Do not try to do everything in one prompt. Sequence multi-step operations across multiple turns for better results.

{% hint style="info" %}
If a prompt fails or produces a weak result, try simplifying it. Restate it with clearer intent or reduce the number of active tools.
{% endhint %}
