---
description: Get an overview of the configurations options in Umbraco Engage.
---

# Configuration

Most of the Umbraco Engage configuration options are stored in the configuration file. Umbraco Engage uses the standard for .NET Core applications, in which we make use of the `appsettings.json` (and environment variable support). Because of this new standard, most configuration options no longer require the application to restart to take effect. This comes with a few exceptions.

Umbraco Engage ships with an `appsettings-schema.json` file, allowing Visual Studio or Jetbrains Rider to auto-complete the configuration options. It comes with information about default values and a description of what each configuration option does. Do not change the `-schema.json` files.

The default configuration will look like this:

{% code title="appSettings.json" %}
```json
{
  "Engage": {
    "Settings": {
      "DatabaseConnectionStringName": "umbracoDbDSN",
      "Enabled": true
    },
    "Analytics": {
      "VisitorCookie": {
        "ExpirationInDays": 365,
        "CookieName": "umbracoEngageAnalyticsVisitorId",
        "IncludeSubdomains": false
      },
      "DataCollection": {
        "AnonymizeIPAddress": true,
        "FlushRateInRecords": 100,
        "FlushIntervalInSeconds": 30,
        "InternalSiteSearch": {
          "AutomaticSearchTracking": true,
          "SearchTermParameters": "q",
          "SearchBoxParameters": "",
          "CategoryParameters": ""
        }
      },
      "DataProcessing": {
        "IntervalInSeconds": 30,
        "SessionLengthInMinutes": 30,
        "IsProcessingServer": true
      },
      "DataStorage": {
        "AnonymizeAnalyticsDataAfterDays": 730,
        "DeleteAnalyticsDataAfterDays": 1095,
        "DeleteControlGroupDataAfterDays": 180,
        "DeleteRawDataAfterDays": 5
      },
      "DataCleanup": {
        "Enabled": true,
        "FirstRunTime": null,
        "StartupDelay": "00:05:00",
        "Interval": "1.00:00:00",
        "CommandTimeout": 1200
      }
    },
    "ABTesting": {
      "RequiredVisitorPercentageBeforeShowingAdvice": 10,
      "MinimumPercentageMacroGoalWarning": 10
    },
    "DeliveryApi": {
      "Segmentation": {
        "ContentById": true,
        "ContentByIds": true,
        "ContentByPath": true,
        "ContentByQuery": true
      }
    },
    "Profiles": {
      "Potential": {
        "ActiveThresholdInDays": 30,
        "EngagedThresholdInSeconds": 300,
        "EngagedThresholdNumberOfSessions": 3
      },
      "Identification": {
        "Name": "{{name}}",
        "Abbreviation": "{{name[0]}}",
        "ImagePropertyAlias": "avatar"
      }
    },
    "Reporting": {
      "DataGenerationEnabled": true,
      "DataGenerationTime": "04:00:00"
    }
  }
}
```
{% endcode %}

{% hint style="info" %}
**DataCleanup settings:**

* `Enabled`: Whether the data cleanup process runs at all.
* `FirstRunTime`: Optional crontab expression (`"0 2 * * *"` for 2 AM daily) to schedule the first cleanup run. Takes precedence over `StartupDelay` when set.
* `StartupDelay`: Time after application startup before the first cleanup run (default: 5 minutes). Used only when `FirstRunTime` is not set.
* `Interval`: Interval between cleanup runs (default: 24 hours).
* `CommandTimeout`: Database command timeout in seconds (default: 1200 = 20 minutes).

The previous settings `StartAfterSeconds`, `IntervalInSeconds`, and `NumberOfRows` are deprecated and no longer used.
{% endhint %}

All these settings are also visualized in Umbraco Engage. This overview can be found in the **Engage** -> **Settings** -> **Configuration** section.

![Settings Configuration Overview](<../../.gitbook/assets/engage-settings-configuration (1).png>)

{% hint style="warning" %}
You cannot change any of the settings in the backoffice. To use the new settings, the website must be restarted.
{% endhint %}
