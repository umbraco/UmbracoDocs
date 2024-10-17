---
description: >-
  Learn how to implement an IP to location provider in uMarketingSuite to
  enhance your analytics  with geographical data from incoming traffic.
---

# Implement an IP to location provider

The uMarketingSuite Analytics natively supports storing and reporting localization information for incoming traffic. Localization refers to identifying the (physical) origin of an incoming request. Web requests from a visitor's browser do not contain location information, so you must provide an implementation for this.

Most localization services, such as Maxmind, use IP addresses to perform a (rough) lookup. The information is compiled into a database where lookups can be performed. However IP addresses do not contain any information regarding their (physical) origin, rather they only identify a device on the internet. Localization information for any given IP address is tracked manually and can change overtime. We recommend either using an external service or acquiring a copy of a GeoIP database for localization lookup purposes.

## Implementation

Once you have a service that can provide localization information, integrating it into uMarketingSuite is straightforward.

For this purpose, implement the interface **uMarketingSuite.Business.Analytics.Processing.Extractors.IRawPageviewLocationExtractor**. This interface allows the localization information for a pageview, defined as a single visitor's visit to a specific point in time. The pageview contains the property **IpAddress** which can be used for Geo IP lookup.

First, define a class that implements **ILocation**, to hold the localization information that will be returned through the interface in our implementation:

{% code overflow="wrap" lineNumbers="true" %}
```cs
using uMarketingSuite.Business.Analytics.Processed;public class GeoIpLocation : ILocation{
    public string Country { get; set; }
    public string County { get; set; }
    public string Province { get; set; }
    public string City { get; set; }
}
```
{% endcode %}

Next, implement the location extractor to read and validate the incoming IP address and filter out local IP addresses with the native **IsLoopback** method. Then, call your Geo IP localization implementation:

{% code overflow="wrap" lineNumbers="true" %}
```cs
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
```
{% endcode %}

Lastly, let the IoC container know to use your implementation for the **IRawPageviewLocationExtractor**. The uMarketingSuite has a default implementation of this service, which only returns null. This default service is registered using Umbraco's **RegisterUnique** method. To override this service, call RegisterUnique **after** the uMarketingSuite dependencies have been initialized, which is **after** the uMarketingSuite's **UMarketingSuiteApplicationComposer**:

{% code overflow="wrap" lineNumbers="true" %}
```cs
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
```
{% endcode %}

After implementing this, the uMarketingSuite will begin collecting and displaying localization information for pageviews. This can be viewed in the Analytics section of the uMarketingSuite dashboard.

{% hint style="info" %}
If the custom implementation returns **null**, **ILocation** will display as "Unknown".
{% endhint %}

{% hint style="info" %}
The LocationExtractor only processes new pageviews and will not apply retroactively to historical data.
{% endhint %}

## Analytics Location Report

The localization information is displayed under the **Location** tab in the **Analytics** section of Umbraco Engage dashboard:

<div align="left">

<figure><img src="../../../.gitbook/assets/image (26).png" alt="Location tab, located under the Analytics section"><figcaption><p>Location tab, located under the Analytics section</p></figcaption></figure>

</div>

The graph contains all sessions that were started for the given time period, similar to the **New and returning visitors** tab. As this information is not location bound this graph is always displayed, even if no localization information is present.

Underneath the graph, you may find the table containing session and pageview information per country. If the LocationExtractor service is not implemented or the pageviews for the given date range do not contain location information, the following error is displayed:

<figure><img src="../../../.gitbook/assets/image (2) (4).png" alt="Location table - missing data error"><figcaption><p>Location table - missing data error</p></figcaption></figure>

If the pageviews contain location information, the table with countries is displayed:

<figure><img src="../../../.gitbook/assets/image (1) (4).png" alt="Location table - missing data error"><figcaption><p>Location table with data</p></figcaption></figure>

From the country, you can drill down to the city. This will then filter the displayed graph and table data to only display session and pageview information for the selected country. Even though the uMarketingSuite does support the storage for county and province as well, currently the UI only supports displaying data by country and city.
