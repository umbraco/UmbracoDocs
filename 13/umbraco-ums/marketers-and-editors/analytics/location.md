The localization information is displayed under the tab Location in the Analytics section of the uMarketingSuite dashboard:

![Location tab, located under the Analytics section]()

The graph contains all sessions that were started for the given time period, similar to the tab "**New and returning visitors**". As this information is not location bound this graph is always displayed, even if no localization information is present.

Underneath the graph you may find the table containing session and pageview information per country. If you have not implemented the [LocationExtractor](/analytics/extending-analytics/implement-an-ip-to-location-provider/) service, or if the pageviews for the given date range do not contain location information, the following error is displayed instead of the table:

![Location table - missing data error]()

If the pageviews contain location information, the table with countries is displayed:

![Location table with data]()

From country, you can drilldown to city. This will then filter the displayed graph and table data to only display session and pageview information for the selected country. Even though the uMarketingSuite does support the storage for county and province as well, currently the UI only supports displaying data by country and city.