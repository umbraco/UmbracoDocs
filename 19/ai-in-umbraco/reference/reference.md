---
description: >-
    API reference documentation for Umbraco.AI.
---

# Reference

This section provides detailed API reference documentation for Umbraco.AI services, models, and configuration.

## Services

Core services for AI operations:

| Service                                                   | Description                |
| --------------------------------------------------------- | -------------------------- |
| [IAIChatService](services/ai-chat-service.md)             | Chat completion operations |
| [IAIEmbeddingService](services/ai-embedding-service.md)   | Embedding generation       |
| [IAIProfileService](services/ai-profile-service.md)       | Profile management         |
| [IAIConnectionService](services/ai-connection-service.md) | Connection management      |

## Models

Domain models used throughout the API:

| Model                                   | Description            |
| --------------------------------------- | ---------------------- |
| [AIProfile](models/ai-profile.md)       | Profile configuration  |
| [AIConnection](models/ai-connection.md) | Provider connection    |
| [AICapability](models/ai-capability.md) | Capability enumeration |
| [AIModelRef](models/ai-model-ref.md)    | Model reference struct |

## Configuration

Application configuration options:

| Class                                    | Description        |
| ---------------------------------------- | ------------------ |
| [AIOptions](configuration/ai-options.md) | Global AI settings |

## In This Section

{% content-ref url="services/README.md" %}
[Services](services/README.md)
{% endcontent-ref %}

{% content-ref url="models/README.md" %}
[Models](models/README.md)
{% endcontent-ref %}

{% content-ref url="configuration/README.md" %}
[Configuration](configuration/README.md)
{% endcontent-ref %}
