---
description: >-
    Core service interfaces for AI operations.
---

# Services

Umbraco.AI provides core services for AI operations. All services are registered with dependency injection and can be injected into controllers, composers, or other services.

## Available Services

| Service                                          | Purpose                                        |
| ------------------------------------------------ | ---------------------------------------------- |
| [IAIChatService](ai-chat-service.md)             | Chat completions (streaming and non-streaming) |
| [IAIEmbeddingService](ai-embedding-service.md)   | Text embedding generation                      |
| [IAIProfileService](ai-profile-service.md)       | Profile CRUD operations                        |
| [IAIConnectionService](ai-connection-service.md) | Connection management                          |

## Usage Pattern

All services follow standard dependency injection patterns:

{% code title="Using Services" %}

```csharp
using Umbraco.AI.Core.Chat;
using Umbraco.AI.Core.Profiles;

public class MyController : Controller
{
    private readonly IAIChatService _chatService;
    private readonly IAIProfileService _profileService;

    public MyController(IAIChatService chatService, IAIProfileService profileService)
    {
        _chatService = chatService;
        _profileService = profileService;
    }

    public async Task<IActionResult> Chat()
    {
        var messages = new[] { new ChatMessage(ChatRole.User, "Hello") };
        var response = await _chatService.GetChatResponseAsync(messages);
        return Ok(response.Message.Text);
    }
}
```

{% endcode %}

## In This Section

{% content-ref url="ai-chat-service.md" %}
[IAIChatService](ai-chat-service.md)
{% endcontent-ref %}

{% content-ref url="ai-embedding-service.md" %}
[IAIEmbeddingService](ai-embedding-service.md)
{% endcontent-ref %}

{% content-ref url="ai-profile-service.md" %}
[IAIProfileService](ai-profile-service.md)
{% endcontent-ref %}

{% content-ref url="ai-connection-service.md" %}
[IAIConnectionService](ai-connection-service.md)
{% endcontent-ref %}
