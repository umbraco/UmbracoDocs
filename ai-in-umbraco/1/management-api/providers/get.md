---
description: >-
    Get detailed information about a specific AI provider.
---

# Get Provider

Returns detailed information about a specific provider, including its settings schema.

## Request

```http
GET /umbraco/ai/management/api/v1/providers/{id}
```

### Headers

| Header          | Value                  |
| --------------- | ---------------------- |
| `Authorization` | Bearer token or cookie |

### Path Parameters

| Parameter | Type   | Description                      |
| --------- | ------ | -------------------------------- |
| `id`      | string | The provider's unique identifier |

## Response

### Success (200 OK)

Returns the provider with its full settings schema.

{% code title="Response" %}

```json
{
    "id": "openai",
    "name": "OpenAI",
    "capabilities": ["Chat", "Embedding"],
    "settingsSchema": {
        "fields": [
            {
                "key": "apiKey",
                "label": "API Key",
                "description": "Your OpenAI API key from platform.openai.com",
                "editorUiAlias": "Umb.PropertyEditorUi.TextBox",
                "defaultValue": null,
                "sortOrder": 0,
                "isRequired": true
            },
            {
                "key": "organizationId",
                "label": "Organization ID",
                "description": "Optional organization identifier",
                "editorUiAlias": "Umb.PropertyEditorUi.TextBox",
                "defaultValue": null,
                "sortOrder": 1,
                "isRequired": false
            },
            {
                "key": "baseUrl",
                "label": "Base URL",
                "description": "Custom API endpoint (for proxies)",
                "editorUiAlias": "Umb.PropertyEditorUi.TextBox",
                "defaultValue": "https://api.openai.com/v1",
                "sortOrder": 2,
                "isRequired": false
            }
        ]
    }
}
```

{% endcode %}

### Response Properties

| Property         | Type     | Description                                        |
| ---------------- | -------- | -------------------------------------------------- |
| `id`             | string   | Unique provider identifier                         |
| `name`           | string   | Display name                                       |
| `capabilities`   | string[] | Supported capabilities                             |
| `settingsSchema` | object   | Settings schema (nullable if provider has no settings) |

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

Returned when the provider ID doesn't exist.

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404
}
```

{% endcode %}

## Example

### cURL

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/providers/openai" \
  -H "Authorization: Bearer {token}"
```

### C# HttpClient

{% code title="Example" %}

```csharp
using var client = new HttpClient();
client.DefaultRequestHeaders.Authorization =
    new AuthenticationHeaderValue("Bearer", token);

var response = await client.GetAsync(
    "https://your-site.com/umbraco/ai/management/api/v1/providers/openai");

if (response.IsSuccessStatusCode)
{
    var provider = await response.Content
        .ReadFromJsonAsync<ProviderResponseModel>();

    Console.WriteLine($"Provider: {provider.Name}");
    Console.WriteLine("Settings:");
    foreach (var field in provider.SettingsSchema?.Fields ?? [])
    {
        var required = field.IsRequired ? " (required)" : "";
        Console.WriteLine($"  - {field.Label}{required}");
    }
}
```

{% endcode %}

### JavaScript

{% code title="Example" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/providers/openai", {
    headers: {
        Authorization: `Bearer ${token}`,
    },
});

if (response.ok) {
    const provider = await response.json();
    console.log(`Provider: ${provider.name}`);

    provider.settingsSchema?.fields.forEach((field) => {
        console.log(`${field.label}${field.isRequired ? " (required)" : ""}`);
    });
}
```

{% endcode %}

## Use Cases

### Building Connection Forms

Use the settings schema to dynamically generate connection configuration forms:

{% code title="Example" %}

```javascript
function renderSettingsForm(schema) {
    return (schema?.fields ?? [])
        .map((field) => {
            return `
      <div class="form-group">
        <label>${field.label}${field.isRequired ? " *" : ""}</label>
        <input type="text"
               name="${field.key}"
               value="${field.defaultValue ?? ""}"
               ${field.isRequired ? "required" : ""}>
        ${field.description ? `<small>${field.description}</small>` : ""}
      </div>
    `;
        })
        .join("");
}
```

{% endcode %}

### Validating Connection Settings

Use the schema to validate settings before saving:

{% code title="Example" %}

```csharp
public bool ValidateSettings(ProviderResponseModel provider, Dictionary<string, object> settings)
{
    foreach (var field in (provider.SettingsSchema?.Fields ?? []).Where(f => f.IsRequired))
    {
        if (!settings.ContainsKey(field.Key) ||
            settings[field.Key] == null)
        {
            return false;
        }
    }
    return true;
}
```

{% endcode %}

## Notes

- Settings schema is defined by the provider using `[AIField]` attributes
- Sensitive settings (like API keys) should support config references (`$Config:Path`)
- The schema enables dynamic UI generation without hardcoding provider details
