---
description: >-
  Install the Slack add-on and register a Slack OAuth application so your
  automations can post messages.
---

# Installation

The Slack add-on adds Slack support to Umbraco Automate. Slack uses OAuth, so you must register a Slack app and configure the client credentials in `appsettings.json`.

## Prerequisites

* Umbraco Automate installed and configured
* Permission to create a Slack app in your workspace at <https://api.slack.com>

## Install the Package

{% code title=".NET CLI" %}
```bash
dotnet add package Umbraco.Automate.Slack
```
{% endcode %}

The Slack add-on depends on `Umbraco.Automate.OpenIddict`, the reusable OAuth infrastructure for Umbraco Automate provider packages. The OpenIddict package is installed automatically.

## Create a Slack App

1. Go to <https://api.slack.com/apps> and click **Create New App**.
2. Pick **From scratch** and choose a workspace to develop the app in.
3. Under **OAuth & Permissions**, add the `chat:write` bot token scope. Add more scopes if you plan to use them.
4. Under **OAuth & Permissions**, add the following **Redirect URL**: `https://<your-site>/umbraco/automate/oauth/callback/slack`.
5. Note the **Client ID** and **Client Secret** under **Basic Information**.

## Configure the Credentials

Add the Slack client credentials to `appsettings.json`:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "Providers": {
        "Slack": {
          "ClientId": "your-client-id",
          "ClientSecret": "your-client-secret"
        }
      }
    }
  }
}
```
{% endcode %}

{% hint style="warning" %}
Keep the client secret out of source control. Use environment variables, user secrets, or a key vault to inject it at deployment time.
{% endhint %}

## Verify

Restart your Umbraco site. When you build an automation, the **Send Slack Message** action appears in the action catalogue under the **Messaging** group.

## Next Steps

{% content-ref url="connection.md" %}
[Connection](connection.md)
{% endcontent-ref %}
