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

## Best Practices

### Be Specific

Instead of:

```
You are a helpful assistant.
```

Use:

```
You are a customer support specialist for an e-commerce platform.
You help customers with order tracking, returns, and product questions.
```

### Define Boundaries

```
## What you can help with:
- Answering product questions
- Checking order status
- Processing returns

## What you cannot do:
- Process payments
- Access customer personal data
- Make promises about delivery times
```

### Include Format Guidance

```
## Response Format
- Start with a brief acknowledgment
- Provide the main information
- End with a follow-up question or next step
- Keep responses under 100 words unless detail is needed
```

### Handle Edge Cases

```
## When you're unsure:
- Ask clarifying questions
- Suggest they contact human support
- Never make up information

## When asked about competitors:
- Stay neutral and factual
- Focus on our product's features
- Don't disparage other products
```

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

The brand voice context might contain:

```
Our brand voice is:
- Friendly but professional
- Empowering and positive
- Clear and jargon-free

Avoid:
- Passive voice
- Corporate buzzwords
- Condescending language
```

## Testing Instructions

When refining instructions:

1. **Start small** - Begin with basic instructions
2. **Test edge cases** - Try unusual inputs
3. **Iterate based on results** - Adjust problem areas
4. **Document changes** - Version history helps track what worked

## Related

- [Concepts](concepts.md) - Agent types and fundamentals
- [Workflows](workflows.md) - Orchestrated agent workflows
- [AI Contexts](../../concepts/contexts.md) - Brand voice injection
