---
description: >-
    Install Umbraco.AI and a provider package to add AI capabilities to your Umbraco site.
---

# Installation

Umbraco.AI is distributed as NuGet packages. You need to install the core package and at least one provider package.

## Install the Core Package

Add the Umbraco.AI package to your Umbraco project:

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI
```

{% endcode %}

Or using the .NET CLI:

{% code title=".NET CLI" %}

```bash
dotnet add package Umbraco.AI
```

{% endcode %}

## Install a Provider Package

Umbraco.AI requires at least one provider to connect to AI services. Install the provider for your preferred AI service.

### OpenAI

{% code title=".NET CLI" %}

```bash
dotnet add package Umbraco.AI.OpenAI
```

{% endcode %}

{% hint style="info" %}
Additional providers will be available in future releases. You can also create custom providers for other AI services.
{% endhint %}

## Package Contents

The packages install the following components:

| Package             | Contents                                                          |
| ------------------- | ----------------------------------------------------------------- |
| `Umbraco.AI`        | Core services, backoffice UI, Management API, database migrations |
| `Umbraco.AI.OpenAI` | OpenAI provider with chat, embedding, and speech-to-text capabilities |

## Verify Installation

After installation, build your project:

{% code title=".NET CLI" %}

```bash
dotnet build
```

{% endcode %}

When you run your Umbraco site, a new **AI** section will appear in the backoffice.

![The AI section in the Umbraco backoffice main navigation](../.gitbook/assets/backoffice-ai-section-overview.png)

{% hint style="info" %}
**User Permissions**: The AI section is a standalone section in the backoffice. You may need to grant your user group access to the AI section:
1. Navigate to **Users** > **User Groups**
2. Edit the relevant user group (for example, Administrators)
3. Enable **AI** in the **Sections** list
4. Save the user group
5. Refresh your browser to see the AI section
{% endhint %}

![User Groups edit screen showing AI section access](../.gitbook/assets/user-group-ai-section-access.png)

## Next Steps

{% content-ref url="first-connection.md" %}
[Your First Connection](first-connection.md)
{% endcontent-ref %}
