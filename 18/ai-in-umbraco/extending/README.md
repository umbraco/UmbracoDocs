---
description: >-
    Extend Umbraco.AI with custom providers, middleware, and tools.
---

# Extending Umbraco.AI

Umbraco.AI is designed to be extensible. You can add support for new AI providers, customize the request pipeline with middleware, and create custom tools for AI agents.

## Extension Points

<table data-view="cards">
<thead>
<tr>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Custom Providers</strong></td>
<td>Add support for AI services not included out of the box</td>
</tr>
<tr>
<td><strong>Middleware</strong></td>
<td>Add logging, caching, rate limiting, and custom behavior</td>
</tr>
<tr>
<td><strong>Custom Tools</strong></td>
<td>Create tools that AI agents can use to perform actions</td>
</tr>
<tr>
<td><strong>Agent Workflows</strong></td>
<td>Create multi-agent orchestration workflows for orchestrated agents</td>
</tr>
<tr>
<td><strong>Custom Guardrail Evaluators</strong></td>
<td>Create evaluators for domain-specific safety and compliance rules</td>
</tr>
<tr>
<td><strong>Notifications</strong></td>
<td>Subscribe to entity lifecycle events for validation and automation</td>
</tr>
</tbody>
</table>

## When to Extend

### Create a Custom Provider When

- You need to connect to an AI service without an existing provider
- You want to use a self-hosted AI model
- You need custom authentication or API handling

### Create Middleware When

- You want to log all AI requests and responses
- You need to cache responses for identical requests
- You want to add rate limiting or retry logic
- You need to modify requests or responses globally

### Create Custom Tools When

- You want AI agents to interact with your systems
- You need to expose business logic to AI
- You want to enable AI to query databases or APIs

### Create Agent Workflows When

- You need multi-agent orchestration (e.g., writer + editor pipelines)
- You want to compose agents into sequential or parallel workflows
- You need custom agent collaboration patterns

### Subscribe to Notifications When

- You need to validate operations before they execute
- You want to audit changes for compliance
- You need to trigger automation in response to events
- You want to maintain data consistency across systems

## Architecture Overview

```mermaid
graph TD
    A["Your Code\n(IAIChatService / IAIEmbeddingService)"] --> B[Middleware Pipeline]
    B --> C["Provider\n(OpenAI / Azure / Your Provider)"]
    C --> D[AI Service API]
```

## In This Section

{% content-ref url="providers/README.md" %}
[Custom Providers](providers/README.md)
{% endcontent-ref %}

{% content-ref url="middleware/README.md" %}
[Middleware](middleware/README.md)
{% endcontent-ref %}

{% content-ref url="tools/README.md" %}
[Custom Tools](tools/README.md)
{% endcontent-ref %}

{% content-ref url="../add-ons/agent/workflows.md" %}
[Agent Workflows](../add-ons/agent/workflows.md)
{% endcontent-ref %}

{% content-ref url="notifications/README.md" %}
[Notifications](notifications/README.md)
{% endcontent-ref %}
