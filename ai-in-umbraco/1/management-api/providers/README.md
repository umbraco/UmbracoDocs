---
description: >-
    REST API endpoints for querying registered AI providers.
---

# Providers API

The Providers API allows you to discover and inspect AI providers registered in your Umbraco installation.

## Overview

Providers are read-only resources - they're installed as NuGet packages and discovered automatically. The API lets you:

- List all registered providers
- Get detailed information about a specific provider
- Inspect provider settings schema for UI generation

## Base URL

```
/umbraco/ai/management/api/v1/provider
```

## Authentication

All endpoints require backoffice authentication with the `Umb.AI.Management.Api` authorization policy.

## Endpoints

| Method | Endpoint         | Description                    |
| ------ | ---------------- | ------------------------------ |
| GET    | `/provider`      | [List all providers](list.md)  |
| GET    | `/provider/{id}` | [Get provider details](get.md) |

## Response Models

### ProviderItemResponseModel

Lightweight model used in list responses:

```json
{
    "id": "openai",
    "name": "OpenAI",
    "capabilities": ["Chat", "Embedding"]
}
```

### ProviderResponseModel

Full model with settings schema:

```json
{
    "id": "openai",
    "name": "OpenAI",
    "capabilities": ["Chat", "Embedding"],
    "settings": [
        {
            "alias": "apiKey",
            "name": "API Key",
            "description": "Your OpenAI API key",
            "type": "string",
            "isRequired": true,
            "isSensitive": true
        }
    ]
}
```

## Settings Schema

The `settings` array describes the configuration options for a provider:

| Property       | Type      | Description                               |
| -------------- | --------- | ----------------------------------------- |
| `alias`        | string    | Setting identifier                        |
| `name`         | string    | Display name                              |
| `description`  | string?   | Help text                                 |
| `type`         | string    | Data type (`string`, `number`, `boolean`) |
| `isRequired`   | bool      | Whether the setting must be provided      |
| `isSensitive`  | bool      | Whether to mask the value in UI           |
| `defaultValue` | string?   | Default value if not specified            |
| `options`      | string[]? | Valid options for selection               |

## In This Section

{% content-ref url="list.md" %}
[List Providers](list.md)
{% endcontent-ref %}

{% content-ref url="get.md" %}
[Get Provider](get.md)
{% endcontent-ref %}
