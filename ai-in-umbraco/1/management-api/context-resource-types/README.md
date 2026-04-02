---
description: >-
    Query context resource types via the Management API.
---

# Context Resource Type Endpoints

Context resource types define the kinds of resources that can be added to AI contexts. Each resource type describes what data it provides and how it is configured.

You can use these endpoints to discover available resource types when building custom context management interfaces.

## Available Endpoints

| Method | Endpoint                      | Description                                      |
| ------ | ----------------------------- | ------------------------------------------------ |
| GET    | `/context-resource-types`      | List all resource types                          |
| GET    | `/context-resource-types/{id}` | Get a resource type with its settings schema     |

## Resource Type Model

{% code title="Resource Type Response" %}

```json
{
    "id": "content",
    "name": "Content",
    "description": "Adds content items as context resources.",
    "icon": "icon-document"
}
```

{% endcode %}

### Properties

| Property      | Type   | Description                           |
| ------------- | ------ | ------------------------------------- |
| `id`          | string | Unique identifier for the type        |
| `name`        | string | Display name                          |
| `description` | string | Description of the resource type      |
| `icon`        | string | Icon identifier for the backoffice UI |

{% hint style="info" %}
Use the [Get Resource Type](get.md) endpoint to retrieve the full settings schema for a specific resource type.
{% endhint %}

## In This Section

{% content-ref url="list.md" %}
[List Resource Types](list.md)
{% endcontent-ref %}

{% content-ref url="get.md" %}
[Get Resource Type](get.md)
{% endcontent-ref %}
