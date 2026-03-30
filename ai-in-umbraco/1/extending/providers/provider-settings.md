---
description: >-
    Define provider settings with automatic UI generation.
---

# Provider Settings

Provider settings define the configuration properties needed to connect to an AI service. Use the `[AISetting]` attribute to control how settings appear in the backoffice UI.

## AISettingAttribute

The `[AISetting]` attribute decorates setting properties with UI metadata:

{% code title="AISettingAttribute Properties" %}

```csharp
[AISetting(
    Label = "Display Label",           // Shown in the UI
    Description = "Help text",         // Description below the field
    EditorUiAlias = "Umb.PropertyEditorUi.TextBox",  // Umbraco editor
    DefaultValue = "default",          // Default value
    SortOrder = 1                       // Display order
)]
public string? MyProperty { get; set; }
```

{% endcode %}

## Properties

| Property        | Type   | Description                           |
| --------------- | ------ | ------------------------------------- |
| `Label`         | string | Display label in the UI               |
| `Description`   | string | Help text shown below the field       |
| `EditorUiAlias` | string | Umbraco property editor UI alias      |
| `DefaultValue`  | object | Default value for the setting         |
| `SortOrder`     | int    | Order in which settings are displayed |

## Automatic Type Inference

If `EditorUiAlias` is not specified, the editor is inferred from the property type:

| C# Type                      | Inferred Editor                |
| ---------------------------- | ------------------------------ |
| `string`                     | `Umb.PropertyEditorUi.TextBox` |
| `int`                        | `Umb.PropertyEditorUi.Integer` |
| `bool`                       | `Umb.PropertyEditorUi.Toggle`  |
| `decimal`, `float`, `double` | `Umb.PropertyEditorUi.Decimal` |

## Example Settings Class

{% code title="MyProviderSettings.cs" %}

```csharp
using System.ComponentModel.DataAnnotations;
using Umbraco.AI.Core.Settings;

public class MyProviderSettings
{
    [AISetting(
        Label = "API Key",
        Description = "Your API key. Supports config references like $MyProvider:ApiKey",
        SortOrder = 1)]
    [Required]
    public required string ApiKey { get; set; }

    [AISetting(
        Label = "Base URL",
        Description = "Override the default API endpoint",
        DefaultValue = "https://api.myprovider.com",
        SortOrder = 2)]
    public string? BaseUrl { get; set; }

    [AISetting(
        Label = "Max Retries",
        Description = "Number of retry attempts for failed requests",
        DefaultValue = 3,
        SortOrder = 3)]
    public int MaxRetries { get; set; } = 3;

    [AISetting(
        Label = "Enable Logging",
        Description = "Log all requests and responses",
        DefaultValue = false,
        SortOrder = 4)]
    public bool EnableLogging { get; set; }

    [AISetting(
        Label = "Timeout (seconds)",
        Description = "Request timeout in seconds",
        DefaultValue = 30.0,
        SortOrder = 5)]
    public double TimeoutSeconds { get; set; } = 30.0;
}
```

{% endcode %}

## Validation Attributes

Use standard .NET validation attributes alongside `[AISetting]`:

{% code title="Validation Example" %}

```csharp
public class ValidatedSettings
{
    [AISetting(Label = "API Key")]
    [Required(ErrorMessage = "API Key is required")]
    public required string ApiKey { get; set; }

    [AISetting(Label = "Max Tokens")]
    [Range(1, 100000, ErrorMessage = "Max tokens must be between 1 and 100000")]
    public int? MaxTokens { get; set; }

    [AISetting(Label = "Email")]
    [EmailAddress(ErrorMessage = "Invalid email address")]
    public string? NotificationEmail { get; set; }

    [AISetting(Label = "Endpoint URL")]
    [Url(ErrorMessage = "Must be a valid URL")]
    public string? CustomEndpoint { get; set; }
}
```

{% endcode %}

{% hint style="info" %}
Non-nullable properties without `[Required]` automatically have a required validation added.
{% endhint %}

## Configuration References

Settings values starting with `$` are resolved from `appsettings.json`:

**In the UI:** Enter `$MyProvider:ApiKey`

**In appsettings.json:**
{% code title="appsettings.json" %}

```json
{
    "MyProvider": {
        "ApiKey": "sk-actual-key-here"
    }
}
```

{% endcode %}

This keeps secrets out of the database and supports environment-specific values.

## Sensitive Settings

For API keys and secrets, don't use a special editor - use a regular text field. The value will be masked when displayed back to the user.

{% code title="Sensitive Settings" %}

```csharp
[AISetting(
    Label = "API Key",
    Description = "Your secret API key")]
[Required]
public required string ApiKey { get; set; }

[AISetting(
    Label = "Secret Token",
    Description = "Authentication token")]
public string? SecretToken { get; set; }
```

{% endcode %}

## Custom Editors

Use Umbraco property editor UI aliases for specialized input:

{% code title="Custom Editors" %}

```csharp
// Textarea for longer text
[AISetting(
    Label = "System Prompt",
    EditorUiAlias = "Umb.PropertyEditorUi.TextArea")]
public string? SystemPrompt { get; set; }

// Integer with spinner
[AISetting(
    Label = "Max Tokens",
    EditorUiAlias = "Umb.PropertyEditorUi.Integer")]
public int? MaxTokens { get; set; }
```

{% endcode %}

## Accessing Settings in Capabilities

Settings are passed to capability methods after being resolved:

{% code title="Using Settings" %}

```csharp
public class MyChatCapability : AIChatCapabilityBase<MyProviderSettings>
{
    public MyChatCapability(IAIProvider provider) : base(provider) { }

    protected override IChatClient CreateClient(MyProviderSettings settings, string? modelId)
    {
        // Settings are fully resolved - config references replaced with actual values
        var client = new HttpClient
        {
            BaseAddress = new Uri(settings.BaseUrl ?? "https://api.default.com"),
            Timeout = TimeSpan.FromSeconds(settings.TimeoutSeconds)
        };

        client.DefaultRequestHeaders.Add("Authorization", $"Bearer {settings.ApiKey}");

        return new MyHttpChatClient(client, modelId);
    }
}
```

{% endcode %}
