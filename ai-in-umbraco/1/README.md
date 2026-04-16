---
description: >-
    Umbraco.AI is a provider-agnostic AI integration layer for Umbraco CMS,
    built on Microsoft.Extensions.AI.
---

# AI in Umbraco

`Umbraco.AI` brings AI capabilities to your Umbraco CMS installation through a flexible, provider-agnostic architecture. Whether you want to integrate OpenAI, Azure OpenAI, or other AI services, Umbraco.AI provides a consistent API and backoffice experience.

![Umbraco AI](.gitbook/assets/backoffice-ai-section-overview.png)

## Key Features

- **Provider-agnostic** - Install provider packages for the AI services you use
- **Profile-based configuration** - Create reusable profiles for different use cases
- **Built on Microsoft.Extensions.AI (M.E.AI)** - Uses standard M.E.AI types like `IChatClient` and `ChatMessage`
- **Extensible middleware** - Add logging, caching, rate limiting, and custom behavior
- **Backoffice integration** - Manage connections and profiles through the Umbraco UI

## Getting Started

New to Umbraco.AI? Start here:

{% content-ref url="getting-started/README.md" %}
[Getting Started](getting-started/README.md)
{% endcontent-ref %}

## Core Concepts

Understand how Umbraco.AI is structured:

{% content-ref url="concepts/README.md" %}
[Core Concepts](concepts/README.md)
{% endcontent-ref %}

## Using the API

Learn how to use AI services in your code:

{% content-ref url="using-the-api/README.md" %}
[Using the API](using-the-api/README.md)
{% endcontent-ref %}

## Extending

Create custom providers, middleware, and tools:

{% content-ref url="extending/README.md" %}
[Extending](extending/README.md)
{% endcontent-ref %}

## Quick Example

{% code title="ChatController.cs" %}

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Chat;

[ApiController]
[Route("/api/chat")]
public class ChatController : Controller
{
    private readonly IAIChatService _chatService;

    public ChatController(IAIChatService chatService)
    {
        _chatService = chatService;
    }

    [HttpPost]
    public async Task<IActionResult> Chat([FromBody] string message)
    {
        var messages = new List<ChatMessage>
        {
            new(ChatRole.User, message)
        };

        var response = await _chatService.GetChatResponseAsync(
            chat => chat.WithAlias("quick-chat"),
            messages);

        return Ok(response.Text);
    }
}
```

{% endcode %}

## Requirements

- Umbraco CMS 17.1 or later
- .NET 10.0 or later
- At least one AI provider package (for example, `Umbraco.AI.OpenAI`)
