# Configuration

With Umbraco Workflow it's possible to customize the functionality with different configuration values.

## Editing configuration values

All configuration for Umbraco Workflow is held in the `appSettings.json` file found at the root of your Umbraco website. If the configuration has been customized to use another source, then the same keys and values discussed in this article can be applied there.

The convention for Umbraco configuration is to have package based options stored as a child structure below the Umbraco element and as a sibling of CMS. Workflow configuration follows this pattern, i.e.:

```json
{
  ...
  "Umbraco": {
    "CMS": {
        ...
    },
    "Workflow": {
        ...
    }
  }
}
```

All Workflow configuration is optional and will fallback to defaults, if not set. The following structure represents the full set of configuration options along with the default values:

```json
{
  “Workflow”: {
    “ReminderNotificationPeriod”: Timespan.FromHours(8),
    “EnableTestLicense”: false,
    “EmailTemplatePath”: “~/Views/Partials/WorkflowEmails”,
    “DateFormats”: {
      “DateFormat”: “MMMM d, yyyy h:mm tt”,
      “DateFormatNoMinute”: “MMMM d, yyyy h tt”,
      “DateFormatShort”: “MMMM d, yyyy”,
      “TimeFormat”: “h:mm tt”,
      “TimeFormatShort”: “HH:mm”
    },
    “SettingsCustomization”: {...}
  }
```

### Workflow Configuration

#### ReminderNotificationPeriod

<TBD>

#### EnableTestLicense

<TBD>

#### EmailTemplatePath

<TBD>

#### DateFormats

<TBD>

## SettingsCustomization

All Workflow settings can be customized in the `appSettings.json` file. Settings can be read-only or hidden entirely in the BackOffice. Optionally you can set the values here.

The `SettingsCustomization` object has two child properties:

- `General`
- `ContentReviews`

Both are dictionaries of `SettingsCustomizationDetail` objects. The value is set to the following structure that contains three settings:

```json
{
  …
  “MySettingKey”: {
    “IsHidden”: false,
    “IsReadOnly”: false,
    “Value”: 42
  }
  …
}
```

- `IsHidden` - <TBD>
- `IsReadOnly` - <TBD>
- `Value` - <TBD>

All available `SettingsCustomization` options are illustrated below along with their respective values:

```json
{
  “Workflow”: {
    …
    “SettingsCustomization”: {
      “General”: {
        “FlowType”: 0|1|2 matching the FlowType enum values,
        “LockIfActive”: bool,
        “AllowAttachments”: bool,
        “AllowScheduling”: bool,
        “RequireUnpublish”: bool,
        “ExtendPermissions”: bool,
        “SendNotifications”: bool,
        “Email”: string,
        “ReminderDelay”: int,
        “EditUrl”: string,
        “SiteUrl”: string,
        “NewNodeApprovalFlow”: *,
        “DocumentTypeApprovalFlow”: *,
        “ExcludeNodes”: *,
        “EmailTemplates”, *,
      },
      “ContentReviews”: {
        “EnableContentReviews”: bool,
        “ReviewPeriod”: int,
        “ReminderThreshold”: int,
        “SendNotifications”: bool,
        “SaveIsReview”: bool
      }
    }
  }
}
```

{% hint style="info" %}
These are complex types and not recommended to have values set from Configuration. Instead, these values can be set from the BackOffice to hidden or readonly to prevent further changes.
{% endhint %}

### General

#### FlowType

<TBD>

#### LockIfActive

<TBD>

#### AllowAttachments

<TBD>

#### AllowScheduling

<TBD>

#### RequireUnpublish

<TBD>

#### ExtendPermissions

<TBD>

#### SendNotifications

<TBD>

#### Email

<TBD>

#### ReminderDelay

<TBD>

#### EditUrl

<TBD>

#### SiteUrl

<TBD>

#### NewNodeApprovalFlow

<TBD>

#### DocumentTypeApprovalFlow

<TBD>

#### ExcludeNodes

<TBD>

#### EmailTemplates

<TBD>

### ContentReviews

#### EnableContentReviews

<TBD>

#### ReviewPeriod

<TBD>

#### ReminderThreshold

<TBD>

#### SendNotifications

<TBD>

#### SaveIsReview

<TBD>

For example: To set the site URL, hide it in the backoffice, and set the content review period but keep the property readonly, the configuration would look like this:

```json
{
  “Workflow”: {
    “SettingsCustomization”: {
      “General”: {
        “SiteUrl”: {
          “IsHidden”: true,
          “Value”: “https://www.myawesomesite.com”
        }
      },
      “ContentReviews”: {
        “ReviewPeriod”: {
          “IsReadOnly”: true,
          “Value”: 42
        }
      }
    }
  }
}
```

Your Integrated Development Environment (IDE) will provide intellisense for the available settings but does not provide the valid value types. Settings are validated on startup and Umbraco will throw an exception if a known setting is provided with an invalid value.

{% hint style="info" %}
It is possible to include settings outside of those referenced by Workflow, which can be useful for providing values for use in extensions and customisations. These settings are not validated on startup, so can have any value.
{% endhint %}
