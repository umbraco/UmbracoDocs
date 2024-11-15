---
description: Get started with Commerce telemetry.
---

## Telemetry

Commerce telemetry is connected directly to the CMS telemetry pipeline and runs with the [ReportSiteJob](https://github.com/umbraco/Umbraco-CMS/blob/v14/dev/src/Umbraco.Infrastructure/BackgroundJobs/Jobs/ReportSiteJob.cs).

It pulls commerce data using a custom provider.

### Captured data

Through the custom provider, the Commerce telemetry pipeline captures the following data defined per store:
* Store ID
* Product Count
* Order Count
* Location Count
* Country Count
* Country Codes
* Currency Count
* Currency Codes
* Payment Method Count
* Payment Providers
* Shipping Method Count
* Shipping Providers
* Shipping Method Types
* Tax Calculation Method Count
* Sales Tax Providers
* Is Custom Product Adapter Used
* Is Custom Product Calculator Used
* Is Custom Order Line Calculator Used
* Is Custom Payment Calculator Used
* Is Custom Shipping Calculator Used
* Is Storefront API Enabled

### Settings

Commerce telemetry reporting can be managed in the [Telemetry Data](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/settings-dashboards#telemetry-data) dashboard.

