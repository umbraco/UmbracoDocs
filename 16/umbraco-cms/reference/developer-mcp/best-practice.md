---
description: Get the most out of the Umbraco CMS developer MCP server
---

# Best Practice

This page details the recommended way to use the Umbraco CMS Developer MCP Server for maximum effectiveness and reliability.

The Developer MCP Server gives you powerful fine-grained control over what the LLM can do — but to get good results, you must be deliberate about how you configure and manage for each session.

## Use Only the Tools You Need

{% hint style="warning" %}
**Do not enable** all tools at once. This will make requests inefficient and may cause the LLM to fail or hallucinate.
{% endhint %}

Each tool you add increases the amount of information (context) that gets sent to the model. This competes for limited space and can cause the model to lose focus or produce unreliable results.

Always enable only the tools (or tool collection) needed for the current task.

## Recommended Workflow

1. Start with a clean session
Open a new session in your LLM client (e.g., Claude Desktop, Cursor or others). This ensures there’s no leftover context from a previous task.

2. Decide on the tools or tool collection
Identify which MCP tools you'll need for the specific task. Avoid loading unnecessary functionality.

3. Update the environment variables
Use .env or launch-time environment variables to switch tool configs easily.

4. Run your prompt or workflow
Ask the model to perform the task. Keep it focused on the tools you've enabled.

5. Complete the task, then reset
Once the task is done, clear the session. Start fresh before beginning another to avoid context bleed.

{% hint style="info" %}
For fast, flexible configuration changes, manage tool settings using environment variables, not hardcoded secrets or source-controlled files.
{% endhint %}

## Context Condensing

Large Language Models have a limited context window, and every active tool, message, and instruction contributes to that total. If you're working on a complex or long-running task, it's easy to hit the limit — especially when multiple tools are enabled.

To help manage this, you can condense context to keep the model focused and free up space.

**Strategies for Condensing Context**

- **Use built-in compression tools (if available)**  
Some clients (e.g., Claude Code) include options to automatically compress or summarise earlier parts of the conversation. Use these to reduce noise while keeping relevant information accessible.

- **Checkpoint progress into a file**  
If you find the context filling up too quickly or you need to pause and resume later, ask the model to generate a **Markdown summary** file containing:

    - What it's working on
    - How far along it is
    - Any critical information or design decisions so far

You can then start a new session and reintroduce this file at the beginning to restore continuity without needing the full conversation history.

{% hint style="info" %}
When using Claude Code or other editor-based tools, saving progress as .md or .txt files in your repo can serve as lightweight session memory between interactions.
{% endhint %}

## Use Instruction Files to Guide the Model

In some cases, it’s helpful to include a rules or instruction file that explains:

- What the enabled tools do
- When and how to use them
- Any naming conventions or API-specific considerations
- Expected sequences or common workflows

This helps the LLM reason more effectively about how to use the Developer MCP Server — especially when multiple tools are involved.

## Crafting Good Prompts

While the Developer MCP Server provides structured access to tools, your results still depend heavily on **how well you prompt the model**. A good prompt sets clear intent, scope, and expectations — and helps the LLM make the most of the tools available to it.

Tips for Better Prompting

- **Be specific about the goal** 
Instead of:  
Fix this content model.  
Use:  
Update the document type to include a new "SEO Description" property and apply it to all "Blog Post" nodes.

- **Mention tools or entities by name**
If you've enabled tools like document-type, media, or data-type, refer to them directly in your prompt to help the model understand what it can access.

- **Use system instructions or context files for background**  
Offload rules, terminology, or structural constraints into a dedicated instruction file. This keeps prompts cleaner and context more focused.

-- **Break up complex workflows**
Don’t try to do everything in one prompt. Sequence multi-step operations (e.g., create types → add content → apply relations) across multiple turns for better results.

{% hint style="info" %}
If a prompt fails or produces a weak result, simplify it, restate it with clearer intent, or reduce the number of active tools and try again.
{% endhint %}