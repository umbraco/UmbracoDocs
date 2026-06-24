---
description: >-
    Get a context resource type with its settings schema.
---

# Get Context Resource Type

Retrieve a specific context resource type by its ID, including the full settings schema that defines how resources of this type are configured.

## Endpoint

{% code title="Endpoint" %}

```
GET /umbraco/ai/management/api/v1/context-resource-types/{id}
```

{% endcode %}

## Path Parameters

| Parameter | Type   | Description                  |
| --------- | ------ | ---------------------------- |
| `id`      | string | The resource type identifier |

## Response

### Success (200 OK)

{% code title="Response" %}

```json
{
    "id": "document",
    "name": "Document",
    "description": "Adds content items as context resources.",
    "icon": "icon-document",
    "settingsSchema": {
        "fields": [
            {
                "key": "contentId",
                "label": "Content",
                "description": "The unique identifier of the content item.",
                "editorUiAlias": "Umb.PropertyEditorUi.DocumentPicker",
                "defaultValue": null,
                "sortOrder": 0,
                "isRequired": true
            },
            {
                "key": "includeDescendants",
                "label": "Include Descendants",
                "description": "Whether to include descendant content items.",
                "editorUiAlias": "Umb.PropertyEditorUi.Toggle",
                "defaultValue": false,
                "sortOrder": 1,
                "isRequired": false
            }
        ]
    }
}
```

{% endcode %}

### Properties

| Property         | Type   | Description                                           |
| ---------------- | ------ | ----------------------------------------------------- |
| `id`             | string | Unique identifier for the type                        |
| `name`           | string | Display name                                          |
| `description`    | string | Description of the resource type                      |
| `icon`           | string | Icon identifier for the backoffice UI                 |
| `settingsSchema` | object | Settings schema (nullable if type has no settings)    |

### Settings Schema Field Properties

| Property        | Type    | Description                                         |
| --------------- | ------- | --------------------------------------------------- |
| `key`           | string  | Unique key identifying the setting                  |
| `label`         | string  | Display label for the setting                       |
| `description`   | string  | Help text for the setting                           |
| `editorUiAlias` | string  | UI alias of the editor used for the setting        |
| `editorConfig`  | object  | Configuration for the editor                        |
| `defaultValue`  | object  | Default value for the setting                       |
| `sortOrder`     | int     | Sort order of the setting in the UI                 |
| `isRequired`    | boolean | Whether the setting must be provided                |
| `group`         | string  | Optional group name for visual grouping in the UI   |

### Not Found (404)

Returned when the specified resource type ID does not exist.

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Context resource type not found"
}
```

{% endcode %}

## Examples

### Get a Resource Type

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/context-resource-types/content" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/context-resource-types/content", {
    credentials: "include",
});

const resourceType = await response.json();

// Use the settings schema to build a dynamic form
console.log(`Settings schema for ${resourceType.name}:`, resourceType.settingsSchema);
```

{% endcode %}

{% hint style="info" %}
The `settingsSchema` describes the configurable fields for this resource type. Use the `editorUiAlias` on each field to render the appropriate Umbraco backoffice editor.
{% endhint %}
