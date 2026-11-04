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
Be aware that projects hosted on Umbraco Cloud operate on a shared infrastructure, which may lead to misleading information when using Application Insights.

Since multiple projects utilize the same resources, Application Insights will provide data based on the overall resource usage across these projects.

To obtain accurate information with Application Insights, you  must move your project to a [dedicated server](../../build-and-customize-your-solution/set-up-your-project/project-settings/dedicated-resources.md).
{% endhint %}

## Microsoft Documentation

For more information about Application Insight, check out Microsoft's documentation on [Application Insights](https://docs.microsoft.com/en-us/azure/application-insights/app-insights-overview)
