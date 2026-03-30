---
description: >-
    Get detailed information about a specific AI provider.
---

# Get Provider

Returns detailed information about a specific provider, including its settings schema.

## Request

```http
GET /umbraco/ai/management/api/v1/provider/{id}
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
    "settings": [
        {
            "alias": "apiKey",
            "name": "API Key",
            "description": "Your OpenAI API key from platform.openai.com",
            "type": "string",
            "isRequired": true,
            "isSensitive": true,
            "defaultValue": null,
            "options": null
        },
        {
            "alias": "organizationId",
            "name": "Organization ID",
            "description": "Optional organization identifier",
            "type": "string",
            "isRequired": false,
            "isSensitive": false,
            "defaultValue": null,
            "options": null
        },
        {
            "alias": "baseUrl",
            "name": "Base URL",
            "description": "Custom API endpoint (for proxies)",
            "type": "string",
            "isRequired": false,
            "isSensitive": false,
            "defaultValue": "https://api.openai.com/v1",
            "options": null
        }
    ]
}
```

{% endcode %}

### Response Properties

| Property       | Type     | Description                 |
| -------------- | -------- | --------------------------- |
| `id`           | string   | Unique provider identifier  |
| `name`         | string   | Display name                |
| `capabilities` | string[] | Supported capabilities      |
| `settings`     | array    | Settings schema definitions |

### Setting Definition Properties

| Property       | Type      | Description                                    |
| -------------- | --------- | ---------------------------------------------- |
| `alias`        | string    | Setting identifier used in connection settings |
| `name`         | string    | Human-readable display name                    |
| `description`  | string?   | Help text for the setting                      |
| `type`         | string    | Data type: `string`, `number`, `boolean`       |
| `isRequired`   | bool      | Whether the setting must be provided           |
| `isSensitive`  | bool      | Whether to mask in UI (passwords, keys)        |
| `defaultValue` | string?   | Default value if not specified                 |
| `options`      | string[]? | Valid options for dropdown selection           |

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
curl -X GET "https://localhost:44331/umbraco/ai/management/api/v1/provider/openai" \
  -H "Authorization: Bearer {token}"
```

### C# HttpClient

{% code title="Example" %}

```csharp
using var client = new HttpClient();
client.DefaultRequestHeaders.Authorization =
    new AuthenticationHeaderValue("Bearer", token);

var response = await client.GetAsync(
    "https://localhost:44331/umbraco/ai/management/api/v1/provider/openai");

if (response.IsSuccessStatusCode)
{
    var provider = await response.Content
        .ReadFromJsonAsync<ProviderResponseModel>();

    Console.WriteLine($"Provider: {provider.Name}");
    Console.WriteLine("Settings:");
    foreach (var setting in provider.Settings)
    {
        var required = setting.IsRequired ? " (required)" : "";
        Console.WriteLine($"  - {setting.Name}{required}: {setting.Type}");
    }
}
```

{% endcode %}

### JavaScript

{% code title="Example" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/provider/openai", {
    headers: {
        Authorization: `Bearer ${token}`,
    },
});

if (response.ok) {
    const provider = await response.json();
    console.log(`Provider: ${provider.name}`);

    provider.settings.forEach((setting) => {
        console.log(`${setting.name}: ${setting.type}${setting.isRequired ? " (required)" : ""}`);
    });
}
```

{% endcode %}

## Use Cases

### Building Connection Forms

Use the settings schema to dynamically generate connection configuration forms:

{% code title="Example" %}

```javascript
function renderSettingsForm(settings) {
    return settings
        .map((setting) => {
            const inputType = setting.isSensitive ? "password" : setting.type === "boolean" ? "checkbox" : "text";

            return `
      <div class="form-group">
        <label>${setting.name}${setting.isRequired ? " *" : ""}</label>
        <input type="${inputType}"
               name="${setting.alias}"
               value="${setting.defaultValue || ""}"
               ${setting.isRequired ? "required" : ""}>
        ${setting.description ? `<small>${setting.description}</small>` : ""}
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
    foreach (var definition in provider.Settings.Where(s => s.IsRequired))
    {
        if (!settings.ContainsKey(definition.Alias) ||
            settings[definition.Alias] == null)
        {
            return false;
        }
    }
    return true;
}
```

{% endcode %}

## Notes

- Settings schema is defined by the provider using `[AISetting]` attributes
- Sensitive settings (like API keys) should support config references (`$Config:Path`)
- The schema enables dynamic UI generation without hardcoding provider details
