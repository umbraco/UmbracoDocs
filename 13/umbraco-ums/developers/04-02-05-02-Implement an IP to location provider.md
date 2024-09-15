The uMarketingSuite Analytics provides native support for storing and reporting localization information for your incoming traffic. When we speak of localization, we refer to the ability to identify the (physical) origin of an incoming request. By design, requests sent to your website from a visitor's browser will never contain a location of origin. As the uMarketingSuite does not contain any localization information, you will have to provide your own implementation that provides this.

Most localization services, such as provided by Maxmind, use IP addresses to perform a (rough) lookup. The information is compiled into a database where lookups can be performed. However IP addresses do not contain any information regarding their (physical) origin, rather they only identify a device on the internet. Because of this the localization information for any given IP address is tracked manually and can change wildly (and sometimes regularly). We recommend either using an external service or acquiring a copy of a GeoIP database for localization lookup purposes.

## Implementation

Once you have a service that can provide localization information, it is very easy to integrate this into the uMarketingSuite. For this purpose we will be implementing the interface **uMarketingSuite.Business.Analytics.Processing.Extractors.IRawPageviewLocationExtractor**. As the name suggests, this interface defines a service that allows the provision of localization information given a pageview, defined as a single visit from a single visitor on a single page at one specific point in time. The pageview will contain the property **IpAddress** which you can use for the Geo IP lookup.

First we define a class implementing **ILocation**, which will hold the localization information that will be returned through the interface in our implementation:

    using uMarketingSuite.Business.Analytics.Processed;public class GeoIpLocation : ILocation{
        public string Country { get; set; }
        public string County { get; set; }
        public string Province { get; set; }
        public string City { get; set; }
    }

We are now ready to implement the location extractor. First, we will read and validate the incoming IP address. We also filter out local IP addresses with the native **IsLoopback** method. After this you can call your own Geo IP localization implementation:

    using uMarketingSuite.Business.Analytics.Processing.Extractors;public class MyCustomLocationExtractor : IRawPageviewLocationExtractor
    {
        public ILocation Extract(IRawPageview rawPageview)
        {
            if (!IPAddress.TryParse(rawPageview?.IpAddress, out var ipAddress) || IPAddress.IsLoopback(ipAddress)) return null;
    
            string country, county, province, city;
    
            //...
            // Perform your own GEO IP lookup here
            // ...
    
            var location = new GeoIpLocation
            {
                Country = country,
                County = county,
                Province = province,
                City = city
            };
    
            return location;
        }
    }

Lastly we will need to let the IoC container know to use your implementation for the **IRawPageviewLocationExtractor**. The uMarketingSuite has a default implementation of this service, which only returns null. This default service is registered using Umbraco's **RegisterUnique** method. To override this service we will need to call RegisterUnique **after** the uMarketingSuite dependencies have been initialised, which is **after** the uMarketingSuite's **UMarketingSuiteApplicationComposer**: 

    using uMarketingSuite.Business.Analytics.Processing.Extractors;
    using uMarketingSuite.Common.Composing;
    using Umbraco.Core;
    using Umbraco.Core.Composing;
    
    [ComposeAfter(typeof(UMarketingSuiteApplicationComposer))]
    public class UMarketingSuiteComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.services.AddUnique<IRawPageviewLocationExtractor, MyCustomLocationExtractor>();
        }
    }

After the service has been implemented correctly, the uMarketingSuite should start collecting and displaying localization information for pageviews. This can be viewed in the Analytics section of the uMarketingSuite dashboard in Umbraco. Note that if your custom implementation returns **null** as **ILocation** this will be displayed in uMarketingSuite as "Unknown".

**Keep in mind that the LocationExtractor is only executed for incoming pageviews and will not retroactively apply to historical data**.

## Analytics location report

The localization information is displayed under the tab Location in the Analytics section of the uMarketingSuite dashboard:

![Location tab, located under the Analytics section]()

The graph contains all sessions that were started for the given time period, similar to the tab "**New and returning visitors**". As this information is not location bound this graph is always displayed, even if no localization information is present.

Underneath the graph you may find the table containing session and pageview information per country. If you have not implemented the LocationExtractor service, or if the pageviews for the given date range do not contain location information, the following error is displayed instead of the table:

![Location table - missing data error]()

If the pageviews contain location information, the table with countries is displayed:

![Location table with data]()

From country, you can drilldown to city. This will then filter the displayed graph and table data to only display session and pageview information for the selected country. Even though the uMarketingSuite does support the storage for county and province as well, currently the UI only supports displaying data by country and city.