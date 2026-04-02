---
description: >-
    Stream chat responses in real-time via Server-Sent Events.
---

# Stream Chat

Stream chat responses in real-time using Server-Sent Events (SSE). This provides a better user experience for longer responses.

## Endpoints

| Method | Endpoint                          | Description              |
| ------ | --------------------------------- | ------------------------ |
| POST   | `/chat/stream`                    | Use default chat profile |
| POST   | `/chat/{profileIdOrAlias}/stream` | Use specific profile     |

## Request

### Headers

| Header       | Value               |
| ------------ | ------------------- |
| Content-Type | `application/json`  |
| Accept       | `text/event-stream` |

### Body

{% code title="Request Body" %}

```json
{
    "messages": [
        {
            "role": "user",
            "content": "Write a short poem about coding."
        }
    ]
}
```

{% endcode %}

## Response

### Content-Type

```
text/event-stream
```

### Event Format

The stream returns Server-Sent Events with JSON data:

```
data: {"content":"In"}

data: {"content":" lines"}

data: {"content":" of"}

data: {"content":" code"}

data: {"content":","}

data: {"content":" we"}

data: {"content":" weave"}

data: {"finishReason":"stop"}

data: [DONE]
```

### Event Properties

| Property       | Type   | Description                 |
| -------------- | ------ | --------------------------- |
| `content`      | string | Text chunk                  |
| `finishReason` | string | Present in final data event |

### Stream End

The stream ends with:

```
data: [DONE]
```

## Errors

Errors that occur before streaming starts return standard JSON error responses. Errors during streaming will terminate the stream.

### 400 Bad Request

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "detail": "Messages cannot be empty"
}
```

### 404 Not Found

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Profile 'non-existent' not found"
}
```

## Examples

### cURL

{% code title="cURL" %}

```bash
curl -X POST "https://localhost:44331/umbraco/ai/management/api/v1/chat/stream" \
  -H "Content-Type: application/json" \
  -H "Accept: text/event-stream" \
  -d '{
    "messages": [
      {"role": "user", "content": "Write a haiku about programming."}
    ]
  }'
```

{% endcode %}

### JavaScript (Fetch + ReadableStream)

{% code title="JavaScript" %}

```javascript
async function streamChat(message) {
    const response = await fetch("/umbraco/ai/management/api/v1/chat/stream", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            Accept: "text/event-stream",
        },
        credentials: "include",
        body: JSON.stringify({
            messages: [{ role: "user", content: message }],
        }),
    });

    const reader = response.body.getReader();
    const decoder = new TextDecoder();
    let fullText = "";

    while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        const chunk = decoder.decode(value);
        const lines = chunk.split("\n");

        for (const line of lines) {
            if (line.startsWith("data: ")) {
                const data = line.slice(6);

                if (data === "[DONE]") {
                    console.log("Stream complete");
                    return fullText;
                }

                try {
                    const parsed = JSON.parse(data);
                    if (parsed.content) {
                        fullText += parsed.content;
                        // Update UI with new content
                        document.getElementById("output").textContent = fullText;
                    }
                } catch (e) {
                    // Skip invalid JSON
                }
            }
        }
    }

    return fullText;
}
```

{% endcode %}

### JavaScript (EventSource Alternative)

For GET requests you could use EventSource, but since this is POST, use the fetch approach above.

### C# (HttpClient)

{% code title="C#" %}

```csharp
public async IAsyncEnumerable<string> StreamChat(
    string message,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    var request = new HttpRequestMessage(HttpMethod.Post,
        "/umbraco/ai/management/api/v1/chat/stream");

    request.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("text/event-stream"));
    request.Content = JsonContent.Create(new
    {
        messages = new[] { new { role = "user", content = message } }
    });

    var response = await _httpClient.SendAsync(
        request,
        HttpCompletionOption.ResponseHeadersRead,
        cancellationToken);

    response.EnsureSuccessStatusCode();

    await using var stream = await response.Content.ReadAsStreamAsync(cancellationToken);
    using var reader = new StreamReader(stream);

    while (!reader.EndOfStream)
    {
        var line = await reader.ReadLineAsync(cancellationToken);

        if (line?.StartsWith("data: ") == true)
        {
            var data = line[6..];

            if (data == "[DONE]")
                yield break;

            var parsed = JsonSerializer.Deserialize<StreamChunk>(data);
            if (parsed?.Content is not null)
                yield return parsed.Content;
        }
    }
}

record StreamChunk(string? Content, string? FinishReason);
```

{% endcode %}

### Usage in Blazor

{% code title="Blazor" %}

```csharp
@code {
    private string _output = "";

    private async Task StreamResponse()
    {
        _output = "";

        await foreach (var chunk in _chatService.StreamChat("Tell me a joke"))
        {
            _output += chunk;
            StateHasChanged();
        }
    }
}
```

{% endcode %}

## Best Practices

1. **Show progress** - Display a typing indicator while waiting for first chunk
2. **Handle disconnects** - Reconnect or show error if stream terminates unexpectedly
3. **Support cancellation** - Allow users to stop generation mid-stream
4. **Buffer display** - Consider slight buffering to smooth out display updates
