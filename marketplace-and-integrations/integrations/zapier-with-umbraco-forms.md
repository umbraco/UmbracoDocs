---
description: >-
  Details an integration available for Zapier with Umbraco Forms, built and
  maintained by Umbraco HQ.
---

# Zapier With Umbraco Forms

This integration is an add-on to the [Zapier CMS](zapier.md) integration and provides necessary components for handling form submissions based on the registered subscription hooks.

A **Zap** is an automated workflow that connects apps and services together. Each Zap consists of a trigger and one or more actions.

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Forms.Integrations.Automation.Zapier)
* [Source code](https://github.com/umbraco/Umbraco.Forms.Integrations/tree/main/src/Umbraco.Forms.Integrations.Automation.Zapier)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.forms.integrations.automation.zapier)

## Minimum version requirements

### Umbraco CMS

| Major      | Minor/Patch |
| ---------- | ----------- |
| Version 8  | 8.1.0       |
| Version 10 | 10.1.0      |
| Version 11 | 11.0.0      |

### Umbraco Forms

| Major      | Minor/Patch |
| ---------- | ----------- |
| Version 8  | 8.9.1       |
| Version 10 | 10.1.0      |
| Version 11 | 11.0.0      |

## Authentication

For this integration, the authentication is managed on Zapier's side by using the Umbraco Marketplace app.

The Umbraco app manages two types of events:

* New Form Submission - triggers when a form is submitted.
* New Content Published - triggers when new content has been published.

The trigger event to be used by this integration is _New Form Submission_.

When creating the Zap trigger, you will be prompted to enter a username, password, and URL for your Umbraco website.

It is also possible to use an API key. If the following setting is present, the API key-based authentication will take precedence and will be used for authorization.

{% tabs %}
{% tab title="Versions 9 and above" %}
{% code title="appsettings.json" %}
```json
"Umbraco": {
  "Forms": {
    "Integrations": {
      "Automation": {
        "Zapier": {
          "Settings": {
            "ApiKey": "[your_api_key]"
          }
        }
      }
    }
  }
}
```
{% endcode %}
{% endtab %}

{% tab title="Version 8" %}
{% code title="web.config" %}
```xml
<appSettings>
...
  <add key="Umbraco.Forms.Integrations.Automation.Zapier.ApiKey" value="[your_api_key]" />
...
</appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}

If no API key is present, the Umbraco application will validate the credentials entered and return a message in case the validation fails.

To enhance security, you can specify a User Group that the user connecting needs to be a part of, by adding the following setting to the configuration file:

{% tabs %}
{% tab title="Version 9 and above" %}
{% code title="appsettings.json" %}
```json
"Umbraco": {
  "Forms": {
    "Integrations": {
      "Automation": {
        "Zapier": {
          "Settings": {
            "UserGroup": "[your_user_group]"
          }
        }
      }
    }
  }
}
```
{% endcode %}
{% endtab %}

{% tab title="Version 8" %}
{% code title="web.config" %}
```xml
<appSettings>
  <add key="Umbraco.Forms.Integrations.Automation.Zapier.UserGroup" value="[your_user_group]" />
</appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}
