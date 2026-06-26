---
description: >-
    Give AI models the ability to call functions using the Microsoft.Extensions.AI (M.E.AI) tool system.
---

# Using Tools

Tools allow AI models to call functions during a conversation. The model decides when to use a tool based on the user's request. Tool results are fed back into the conversation for the model to formulate its final response.

## Defining a Tool

Use the `[Description]` attribute from `System.ComponentModel` to help the model understand when and how to use the tool:

{% code title="WeatherTool.cs" %}

```csharp
using System.ComponentModel;
using Microsoft.Extensions.AI;

public static class WeatherTools
{
    [Description("Gets the current weather for a given city")]
    public static string GetWeather(
        [Description("The city name")] string city)
    {
        // In production, call a real weather API
        return $"The weather in {city} is 22°C and sunny.";
    }
}
```

{% endcode %}

## Calling Chat with Tools

Create an `AIFunction` from your method and pass it via `ChatOptions`:

{% code title="ChatWithTools.cs" %}

```csharp
using Microsoft.Extensions.AI;

var tool = AIFunctionFactory.Create(WeatherTools.GetWeather);

var options = new ChatOptions
{
    Tools = [tool]
};

var messages = new List<ChatMessage>
{
    new(ChatRole.User, "What's the weather like in London?")
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("tool-chat").WithChatOptions(options),
    messages);
// The model calls GetWeather("London"), gets the result,
// and responds with a natural language answer.
```

{% endcode %}

## Automatic Tool Invocation

Umbraco.AI includes the `FunctionInvokingChatClient` middleware by default. This means tool calls are handled automatically:

1. The model receives the user message and available tools
2. The model decides to call a tool and returns a tool call request
3. The middleware invokes the function locally
4. The result is sent back to the model
5. The model generates its final response

You do not need to handle the tool call loop manually.

## Multiple Tools

Pass multiple tools to give the model more capabilities:

{% code title="MultipleTools.cs" %}

```csharp
var weatherTool = AIFunctionFactory.Create(WeatherTools.GetWeather);
var timeTool = AIFunctionFactory.Create(TimeTools.GetCurrentTime);

var options = new ChatOptions
{
    Tools = [weatherTool, timeTool]
};

var messages = new List<ChatMessage>
{
    new(ChatRole.User, "What time is it in Tokyo and what's the weather?")
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("tool-chat").WithChatOptions(options),
    messages);
```

{% endcode %}

## Tools with Complex Parameters

Tools can accept complex parameter types:

{% code title="ComplexTool.cs" %}

```csharp
public static class ContentTools
{
    [Description("Searches for content by type and keyword")]
    public static async Task<string> SearchContent(
        [Description("The Document Type alias to search")] string contentType,
        [Description("Search keyword")] string keyword,
        [Description("Maximum results to return")] int maxResults = 5)
    {
        // Query Umbraco content
        return $"Found {maxResults} items of type '{contentType}' matching '{keyword}'.";
    }
}
```

{% endcode %}

{% hint style="info" %}
Tool support varies by provider and model. Most modern models (GPT-4o, Claude 3.5, Gemini 1.5) support tools. Check your provider documentation for details.
{% endhint %}

## Related

- [Tools Overview](README.md) - Tools concepts
- [Basic Chat](../chat/basic-chat.md) - Chat without tools
- [Creating Custom Tools](../../extending/tools/creating-a-tool.md) - The `AIToolBase` pattern for agent tools
