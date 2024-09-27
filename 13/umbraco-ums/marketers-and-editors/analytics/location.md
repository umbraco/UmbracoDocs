# Location

The localization information is displayed under the Location tab in the Analytics section of the uMS dashboard:

![Location tab, located under the Analytics section]()

The graph contains all sessions that were started for the given time period, similar to the tab "**New and returning visitors**". As this information is not location-bound the graph is always displayed, even if no localization information is present.

Underneath the graph you can find the table containing session and pageview information based on country.

If the pageviews contain location information, the table with countries is displayed:

![Location table with data]()

There might be cases where you will see the following error displayed in the table:

![Location table - missing data error]()

This will occur when you have not implemented the [LocationExtractor](/analytics/extending-analytics/implement-an-ip-to-location-provider/) service, or if the pageviews for the given date range do not contain location information.

From country, you can drilldown to city. This will then filter the displayed graph and table data to only display session and pageview information for the selected country. Even though uMS does support the storage for county and province, currently the UI only supports displaying data by country and city.
