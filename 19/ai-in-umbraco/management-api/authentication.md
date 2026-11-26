---
description: >-
    Authentication requirements for the Umbraco.AI Management API.
---

# Authentication

The Management API uses Umbraco's backoffice authentication. All endpoints require an authenticated backoffice user. Most endpoints also require access to the AI section.

## Authentication Method

The API uses the same authentication model as the Umbraco CMS Management API: Bearer tokens issued by Umbraco's OpenIddict-based backoffice authentication. Tokens are acquired through the standard backoffice login flow and validated on each request.

Users must:

1. Be authenticated backoffice users (policy: `BackOfficeAccess`). Every endpoint requires this policy.
2. Have access to the **AI** section (policy: `SectionAccessAI`). Most endpoints require this policy.

## Required Permissions

Every Management API endpoint requires the `BackOfficeAccess` authorization policy. Most endpoints also require the `SectionAccessAI` authorization policy. Internally this policy checks that the user's allowed applications claim includes the AI section (`"ai"`). Out of the box, the AI section is granted to the Administrators group; other groups must be given access explicitly.

The following endpoints only require the `BackOfficeAccess` policy. Users without access to the AI section can call them:

- `POST /umbraco/ai/management/api/v1/chat/complete`
- `POST /umbraco/ai/management/api/v1/embeddings/generate`
- `POST /umbraco/ai/management/api/v1/image-generation/generate`
- `POST /umbraco/ai/management/api/v1/speech-to-text/transcribe`
- `POST /umbraco/ai/management/api/v1/decision/ask`
- `GET /umbraco/ai/management/api/v1/settings/disclosure`
- `GET /umbraco/ai/management/api/v1/profiles`
- `GET /umbraco/ai/management/api/v1/contexts`
- `GET /umbraco/ai/management/api/v1/context-resource-types`
- `GET /umbraco/ai/management/api/v1/context-resource-types/{id}`

All other endpoints require the `SectionAccessAI` policy.

## Making Authenticated Requests

### From Backoffice JavaScript

When calling from backoffice extensions (Lit elements, controllers, workspaces), use the generated API client that ships with the Umbraco backoffice. It automatically attaches the current user's Bearer token to every request.

If you need to call the endpoints directly, include the Bearer token in the `Authorization` header:

{% code title="backoffice-example.ts" %}

```typescript
import { umbHttpClient } from "@umbraco-cms/backoffice/http-client";

const response = await fetch("/umbraco/ai/management/api/v1/connections", {
    method: "GET",
    headers: {
        "Authorization": `Bearer ${await umbHttpClient.getToken()}`,
        "Content-Type": "application/json",
    },
});
```

{% endcode %}

In practice, prefer the generated OpenAPI client over hand-rolled `fetch` calls so that tokens, versioning, and error handling are taken care of for you.

### From Server-Side Code

For server-side code that needs access to the current backoffice user, inject `IBackOfficeSecurityAccessor` to get the authenticated user context. The Management API is designed to be called by an authenticated backoffice user; it is not intended for server-to-server or public integrations.

{% hint style="warning" %}
The Management API is designed for backoffice integration, not for public-facing applications. For external integrations, create your own API that wraps the Umbraco.AI services.
{% endhint %}

## Authorization Errors

### 401 Unauthorized

Returned when:

- No Bearer token is provided.
- The token is invalid or has expired.
- The user is not authenticated.

### 403 Forbidden

Returned when:

- The endpoint requires the `SectionAccessAI` policy, and the authenticated user does not have access to the AI section.

## Example Error Response

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.3",
    "title": "Forbidden",
    "status": 403,
    "detail": "User does not have access to the AI section"
}
```

{% endcode %}

## Best Practices

1. **Use from the backoffice only** - The Management API is intended for backoffice use.
2. **Check permissions** - Ensure users have AI section access before relying on endpoints that require it.
3. **Handle auth errors** - Gracefully handle 401/403 responses in your UI.
4. **Don't expose externally** - Don't proxy the Management API to public endpoints without additional security.

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
