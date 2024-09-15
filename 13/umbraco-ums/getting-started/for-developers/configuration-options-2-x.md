There are quite some configuration options within the uMarketingSuite. For uMarketingSuite 2.x we have adopted the new standard for .NET Core applications, in which we make use of the appsettings.json (and environment variable support). This means we no longer use the umarketingsuite.config like in version 1.x of uMarketingSuite. Because of this new standard most of these configuration options are hot reloaded, no longer requiring the application to restart in order for them to take effect *(with some exceptions)*.

uMarketingSuite 2.x also ships with an **appsettings-schema.json** file, allowing editing environments like Visual Studio or Jetbrains Rider to auto-complete the various configuration options together with their default values and a description of what each configuration option does.

The default configuration will look like this:

    {
      "uMarketingSuite": {
        "Settings": {
          "DatabaseConnectionStringName": "umbracoDbDSN",
          "Enabled": true
        },
        "Analytics": {
          "VisitorCookie": {
            "ExpirationInDays": 365,
            "CookieName": "uMarketingSuiteAnalyticsVisitorId",
            "IncludeSubdomains": false
          },
          "DataCollection": {
            "AnonymizeIPAddress": false,
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
            "StartAfterSeconds": 300,
            "IntervalInSeconds": 1800,
            "NumberOfRows": 1000
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

All these settings are also visualized in the uMarketingSuite. This overview can be found in the section 'Marketing' -&gt; Settings -&gt; Configuration

![](?width=767&amp;height=574&amp;mode=max)

You cannot change any of the settings over here which is by design. To use the new settings the website must be restarted (by touching the web.config) and that is not something that we wanted to make possible via the Umbraco backoffice.