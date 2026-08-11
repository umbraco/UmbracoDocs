---
description: >-
    Transcribe audio files to text using the Speech-to-Text API.
---

# Speech-to-Text

The Speech-to-Text API transcribes audio into text. Use it for voice input, audio content processing, and accessibility features.

## IAISpeechToTextService

The primary interface for speech-to-text operations. It follows the same builder pattern as [IAIChatService](../reference/services/ai-chat-service.md), providing fluent configuration, profile resolution, guardrails, and observability.

{% code title="IAISpeechToTextService.cs" %}

```csharp
public interface IAISpeechToTextService
{
    Task<SpeechToTextResponse> TranscribeAsync(
        Action<AISpeechToTextBuilder> configure,
        Stream audioStream,
        CancellationToken cancellationToken = default);

    IAsyncEnumerable<SpeechToTextResponseUpdate> StreamTranscriptionAsync(
        Action<AISpeechToTextBuilder> configure,
        Stream audioStream,
        CancellationToken cancellationToken = default);

    Task<ISpeechToTextClient> CreateSpeechToTextClientAsync(
        Action<AISpeechToTextBuilder> configure,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Basic Usage

{% code title="VoiceNotes.cs" %}

```csharp
using Umbraco.AI.Core.SpeechToText;

public class VoiceNotes
{
    private readonly IAISpeechToTextService _sttService;

    public VoiceNotes(IAISpeechToTextService sttService)
    {
        _sttService = sttService;
    }

    public async Task<string> Transcribe(Stream audioStream)
    {
        var response = await _sttService.TranscribeAsync(
            stt => stt.WithAlias("voice-notes"),
            audioStream);

        return response.Text ?? string.Empty;
    }
}
```

{% endcode %}

## AISpeechToTextBuilder

All methods accept an `Action<AISpeechToTextBuilder>` to configure the request:

| Method | Description |
| --- | --- |
| `.WithAlias(string alias)` | **Required.** Sets an alias for auditing and telemetry. |
| `.WithProfile(Guid profileId)` | Selects a profile by ID. Uses default if omitted. |
| `.WithProfile(string profileAlias)` | Selects a profile by alias. |
| `.WithSpeechToTextOptions(SpeechToTextOptions options)` | Overrides profile defaults (language, model). |
| `.WithGuardrails(params Guid[] guardrailIds)` | Applies guardrails by ID. |
| `.WithGuardrails(params string[] guardrailAliases)` | Applies guardrails by alias. |
| `.WithContextItems(IEnumerable<AIRequestContextItem> contextItems)` | Attaches context items to the request. |

{% code title="Builder example" %}

```csharp
using Microsoft.Extensions.AI;

var response = await _sttService.TranscribeAsync(
    stt => stt
        .WithAlias("meeting-notes")
        .WithProfile("whisper-profile")
        .WithSpeechToTextOptions(new SpeechToTextOptions { SpeechLanguage = "en" })
        .WithGuardrails("content-filter"),
    audioStream,
    cancellationToken);
```

{% endcode %}

## Streaming Transcription

For real-time transcription, use `StreamTranscriptionAsync`:

{% code title="StreamingTranscription.cs" %}

```csharp
await foreach (var update in _sttService.StreamTranscriptionAsync(
    stt => stt
        .WithAlias("live-transcription")
        .WithProfile("gpt4o-transcribe"),
    audioStream))
{
    Console.Write(update.Text);
}
```

{% endcode %}

## Management API Endpoint

Transcription is available through the Management API:

```http
POST /umbraco/ai/management/api/v1/speech-to-text/transcribe
```

The endpoint accepts `multipart/form-data` with the following parameters:

| Parameter        | Type   | Required | Description                                         |
| ---------------- | ------ | -------- | --------------------------------------------------- |
| `file`           | file   | Yes      | Audio file to transcribe                            |
| `profileIdOrAlias` | string | No     | Profile ID or alias (uses default if omitted)       |
| `language`       | string | No       | Language hint (for example, `en`, `fr`, `de`)       |

### Example Request

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/speech-to-text/transcribe" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -F "file=@recording.wav" \
  -F "language=en"
```

{% endcode %}

### Response

The endpoint returns the transcribed text as a string.

## Setting Up Speech-to-Text

### 1. Install a Provider with Speech-to-Text Support

Currently, OpenAI is the only provider with Speech-to-Text support:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.OpenAI
```

{% endcode %}

### 2. Create a Connection

Create an OpenAI connection in the backoffice with your API key. See [Managing Connections](../backoffice/managing-connections.md).

### 3. Create a Profile

Create a profile with the **Speech-to-Text** capability. Supported models include:

| Model                    | Description                          |
| ------------------------ | ------------------------------------ |
| `whisper-1`              | General-purpose transcription        |
| `gpt-4o-transcribe`     | Higher accuracy transcription        |
| `gpt-4o-mini-transcribe`| Cost-effective transcription         |

## Copilot Voice Input

The Agent Copilot includes a built-in voice input button. When a Speech-to-Text profile is configured, a microphone button appears in the Copilot chat input. Click it to record and transcribe audio into text.

See [Copilot Usage](../add-ons/agent-copilot/copilot.md) for more details.

## Related

- [Capabilities](../concepts/capabilities.md) - Available capability types
- [OpenAI Provider](../providers/openai.md) - Provider with Speech-to-Text support
- [Copilot Usage](../add-ons/agent-copilot/copilot.md) - Voice input in the Copilot
