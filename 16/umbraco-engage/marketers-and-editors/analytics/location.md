---
description: Learn about what localization data is tracked and how you can view it.
---

# Location

{% hint style="info" %}
Locations are not visible out of the box. You need to add a location provider which can be set up by a development team.
{% endhint %}

The localization information is displayed under the Location tab in the Analytics section of the Umbraco Engage dashboard:

![Location tab, located under the Analytics section](<../../.gitbook/assets/Locations-tab-v16 (1).png>)

The graph contains all sessions started within the given time, similar to the "**New and returning visitors**" tab. This information is not location-bound and the graph is always displayed, even if no localization information is available.

Underneath the graph, is the table containing session and pageview information based on country.

If the pageviews contain location information, the table with countries is displayed:

![Location table with data](<../../.gitbook/assets/Locations-Analytics-v16 (1).png>)

There might be cases where you see a message saying that no data is available or that all locations are `<unknown>`. This will occur when the [LocationExtractor](../../developers/analytics/extending-analytics/getting-the-correct-ip-address.md) service is not implemented, or if the pageviews for the given date range do not contain location information. Please consult the technical team to implement the location extractor.

From the country, you can drill down to a city. This will filter the displayed data to display session and pageview information for the selected country. Even though Umbraco Engage does support the storage for county and province, currently the UI only supports displaying data by country and city.
