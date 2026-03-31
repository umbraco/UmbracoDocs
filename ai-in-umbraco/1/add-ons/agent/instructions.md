---
description: >-
    Configuring agent instructions for optimal behavior.
---

# Agent Instructions

Instructions define how a **standard agent** behaves. Well-crafted instructions lead to better, more consistent responses.

{% hint style="info" %}
Instructions apply to **standard agents** only. **Orchestrated agents** use [workflows](workflows.md) where sub-agent instructions are defined in code.
{% endhint %}

## Structure

A good instruction set includes:

1. **Role definition** - What the agent is
2. **Capabilities** - What it can do
3. **Guidelines** - How it should behave
4. **Constraints** - What it should avoid
5. **Examples** - Sample interactions (optional)

## Example Instructions

{% code title="Content Editor Agent" %}

```
You are a content editing assistant for a news website.

## Role
You help journalists and editors improve their articles by providing suggestions for clarity, grammar, and style.

## Capabilities
- Improve grammar and punctuation
- Enhance readability and flow
- Suggest stronger word choices
- Identify unclear or ambiguous passages
- Check consistency in tone and style

## Guidelines
- Maintain the author's unique voice
- Preserve factual accuracy - never change facts
- Explain your suggestions briefly
- Ask for clarification when the intent is unclear
- Be encouraging and constructive

## Constraints
- Do not add opinions or editorializing
- Do not change quotes or attributed statements
- Do not make content longer unless asked
- Do not use complex jargon

## Style
- Professional but friendly tone
- Concise responses
- Use bullet points for multiple suggestions
```

{% endcode %}

## Using Contexts with Instructions

Combine agent instructions with AI Contexts for brand voice:

{% code title="BrandWriterAgent.cs" %}

```csharp
var agent = new AIAgent
{
    Alias = "brand-writer",
    Name = "Brand Writer",
    Instructions = @"You are a content writer for our brand.

## Your task
Write engaging content that follows our brand guidelines.

## Format
- Use headings and bullet points
- Keep paragraphs short
- Include calls to action",
    ContextIds = new[] { brandVoiceContextId, styleGuideContextId }
};
```

{% endcode %}

## Related

- [Concepts](concepts.md) - Agent types and fundamentals
- [Workflows](workflows.md) - Orchestrated agent workflows
- [AI Contexts](../../concepts/contexts.md) - Brand voice injection
