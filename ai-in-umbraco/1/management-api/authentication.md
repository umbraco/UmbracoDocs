---
description: >-
    Authentication requirements for the Umbraco.AI Management API.
---

# Authentication

The Management API uses Umbraco's backoffice authentication. All endpoints require an authenticated backoffice user with appropriate permissions.

## Authentication Method

The API uses cookie-based authentication through Umbraco's backoffice authentication system. Users must:

1. Be logged in to the Umbraco backoffice
2. Have access to the Settings section

## Required Permissions

All Management API endpoints require the **Settings section access** policy. Users need to have access to the Settings section in the backoffice to use the API.

## Making Authenticated Requests

### From Backoffice JavaScript

When calling from backoffice components (Lit elements, controllers), authentication is handled automatically through the browser's cookies:

{% code title="backoffice-example.ts" %}

```typescript
const response = await fetch("/umbraco/ai/management/api/v1/connections", {
    method: "GET",
    credentials: "include", // Include cookies
    headers: {
        "Content-Type": "application/json",
    },
});
```

{% endcode %}

### From Server-Side Code

For server-to-server calls or background processes, use `IBackOfficeSecurityAccessor` to get the current user's context, or consider using a service account pattern.

{% hint style="warning" %}
The Management API is designed for backoffice integration, not for public-facing applications. For external integrations, consider creating your own API that wraps the Umbraco.AI services.
{% endhint %}

## Authorization Errors

### 401 Unauthorized

Returned when:

- No authentication credentials provided
- Session has expired
- User is not logged in

### 403 Forbidden

Returned when:

- User lacks Settings section access
- User doesn't have required permissions

## Example Error Response

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.3",
    "title": "Forbidden",
    "status": 403,
    "detail": "User does not have access to the Settings section"
}
```

{% endcode %}

## Best Practices

1. **Use from backoffice only** - The Management API is intended for backoffice use
2. **Check permissions** - Ensure users have Settings access before relying on the API
3. **Handle auth errors** - Gracefully handle 401/403 responses in your UI
4. **Don't expose externally** - Don't proxy the Management API to public endpoints without additional security

## Creating a Public API

If you need to expose AI capabilities publicly, create your own API controllers:

{% code title="PublicChatController.cs" %}

```csharp
[ApiController]
[Route("api/chat")]
public class PublicChatController : ControllerBase
{
    private readonly IAIChatService _chatService;

    public PublicChatController(IAIChatService chatService)
    {
        _chatService = chatService;
    }

    [HttpPost]
    [AllowAnonymous] // Or use your own auth
    public async Task<IActionResult> Chat([FromBody] ChatRequest request)
    {
        // Add your own validation, rate limiting, etc.

        var messages = new List<ChatMessage>
        {
            new(ChatRole.User, request.Message)
        };

        var response = await _chatService.GetChatResponseAsync(
            chat => chat.WithAlias("public-chat"),
            messages);

        return Ok(new { response = response.Message.Text });
    }
}
```

{% endcode %}

Creating a custom API controller lets you:

- Implement custom authentication
- Add rate limiting
- Control which profiles are accessible
- Add logging and monitoring
