---
description: >-
  Details an integration available for Zapier with Umbraco Forms, built and maintained by Umbraco HQ.
---

# Zapier with Umbraco Forms Integration

This integration is an add-on to the [Zapier CMS](zapier.md) integration, and provides necessary components for handling form submissions based on the registered subscription hooks.

A Zap is an automated workflow that connects apps and services together. Each Zap consists of a trigger and one or more actions.

Install from NuGet via:
https://www.nuget.org/packages/Umbraco.Forms.Integrations.Automation.Zapier

Source code is at:
https://github.com/umbraco/Umbraco.Forms.Integrations/tree/main/src/Umbraco.Forms.Integrations.Automation.Zapier

Available on the Umbraco Marketplace at:
https://marketplace.umbraco.com/package/umbraco.forms.integrations.automation.zapier

## Prerequisites

Requires minimum versions of Umbraco:

- CMS: 10.1.0
- Forms: 10.1.0

## How To Use

### Authentication

For this integration, the authentication is managed on Zapier's side by using the Umbraco marketplace app.

The Umbraco app manages two types of events:
* New Form Submission - triggers when a form is submitted
* New Content Published - triggers when a new content has been published.

The trigger event to be used by this integration is _New Form Submission_.

When creating the Zap trigger, you will be prompted to enter a username, password and the URL for your Umbraco website.

It iss also possible to use an API key. If the following setting is present, then the API key based authentication will take precedence and will be used for authorization.

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

If no API key is present, then the Umbraco application will validate the credentials entered and return a message in case the validation fails.

To enhance security extend, you can specify a user group that the user connecting needs to be a part of, by adding the following
setting in `appsettings.json`:

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