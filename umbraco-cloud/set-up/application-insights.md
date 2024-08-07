---
description: >-
  With Application Insight, you can collect telemetry about your cloud project,
  including web server telemetry, web page telemetry, and performance counters.
---

# Application Insights

## Installing Application Insight

To install Application Insight on your Umbraco Cloud project read the[ Application Insights for ASP.NET Core applications](https://learn.microsoft.com/en-us/azure/azure-monitor/app/asp-net-core?tabs=netcorenew) article in the Microsoft documentation.

## Limitations on Umbraco Cloud

{% hint style="warning" %}
As projects on Umbraco Cloud are hosted on a shared infrastructure, the information that&#x20;

you gather through Application Insight can be a misrepresentation.

Since several projects share the same resources Application Insight will gather information based on the overall resources used.

To gather accurate information using Application Insight, you must move your project to a [dedicated server](project-settings/dedicated-resources.md).
{% endhint %}

## Microsoft Documentation

For more information about Application Insight, check out Microsoft's documentation on [Application Insights](https://docs.microsoft.com/en-us/azure/application-insights/app-insights-overview)
