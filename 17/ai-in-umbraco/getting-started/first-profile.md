---
description: >-
    Create a profile to configure how AI requests are made and use it in your code.
---

# The First Profile

A profile combines a connection with model settings for a specific use case. Profiles let you configure temperature, model selection, and system prompts once and reuse them throughout your application.

## Prerequisites

- At least one connection created

## Create a Profile

1. In the Umbraco backoffice, navigate to the **AI** section
2. Click **Profiles** in the tree
3. Click **Create Profile**

![The Create Profile capability selection showing Chat and Embedding](../.gitbook/assets/backoffice-create-profile-modal.png)

## Configure the Profile

Fill in the profile details:

| Field          | Description                     | Example             |
| -------------- | ------------------------------- | ------------------- |
| **Name**       | A display name for this profile | "Content Assistant" |
| **Alias**      | A unique identifier for lookups | "content-assistant" |
| **Capability** | The type of AI capability       | "Chat"              |
| **Connection** | Which connection to use         | "OpenAI Production" |
| **Model**      | The specific model to use       | "gpt-4o"            |

### Chat Settings

For chat profiles, you can configure:

| Setting           | Description                                       | Default          |
| ----------------- | ------------------------------------------------- | ---------------- |
| **Temperature**   | Controls randomness (0-2). Lower is more focused. | Provider default |
| **Max Tokens**    | Maximum tokens in the response                    | Provider default |
| **System Prompt** | Instructions sent with every request              | None             |

{% hint style="info" %}
Leave settings empty to use the model's default values. Only set values you want to override.
{% endhint %}

![The Create Profile form with connection and model settings](../.gitbook/assets/backoffice-create-profile-form.png)

## Set as Default

To use this profile when no profile is specified in code:

1. Navigate to the **AI** section > **Settings**
2. Select "Content Assistant" in the **Default Chat Profile** picker
3. Click **Save**

{% hint style="info" %}
See [Managing Settings](../backoffice/managing-settings.md) for more details on configuring defaults.
{% endhint %}

## Use the Profile in Code

### Using the Default Profile

{% code title="ContentController.cs" %}

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Chat;

[ApiController]
[Route("/api/content")]
public class ContentController : Controller
{
    private readonly IAIChatService _chatService;

    public ContentController(IAIChatService chatService)
    {
        _chatService = chatService;
    }

    [HttpPost]
    public async Task<IActionResult> GenerateSummary([FromBody] string content)
    {
        var messages = new List<ChatMessage>
        {
            new(ChatRole.User, $"Summarize this content:\n\n{content}")
        };

        // Uses the default profile configured in Settings
        var response = await _chatService.GetChatResponseAsync(
            chat => chat.WithAlias("content-summary"),
            messages);

        return Ok(response.Text);
    }
}
```

{% endcode %}

### Using a Specific Profile

To use a specific profile, pass its alias (or ID) to `WithProfile`:

{% code title="ContentController.cs" %}

```csharp
public async Task<IActionResult> GenerateSummary([FromBody] string content)
{
    var messages = new List<ChatMessage>
    {
        new(ChatRole.User, $"Summarize this content:\n\n{content}")
    };

    var response = await _chatService.GetChatResponseAsync(
        chat => chat.WithAlias("content-summary").WithProfile("content-assistant"),
        messages);

    return Ok(response.Text);
}
```

{% endcode %}

## Understanding Profile Resolution

When you make a chat request:

1. The system resolves the profile by ID or alias
2. The connection provides the credentials
3. Profile settings (model, temperature, and so on) configure the request
4. The system applies any registered middleware
5. The system sends the request to the AI provider

## Multiple Profiles

Create different profiles for different use cases:

| Profile             | Use Case            | Model       | Temperature |
| ------------------- | ------------------- | ----------- | ----------- |
| `content-assistant` | Content suggestions | gpt-4o      | 0.7         |
| `code-helper`       | Code generation     | gpt-4o      | 0.2         |
| `translator`        | Translation         | gpt-4o-mini | 0.3         |

## Next Steps

Learn more about using the chat API:

{% content-ref url="../using-the-api/chat/README.md" %}
[Chat](../using-the-api/chat/README.md)
{% endcontent-ref %}

Or explore the core concepts:

{% content-ref url="../concepts/README.md" %}
[Core Concepts](../concepts/README.md)
{% endcontent-ref %}
