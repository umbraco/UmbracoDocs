Security is a first-class citizen in the uMarketingSuite. Besides performance and all the cool features, security is important in all parts of the uMarketingSuite.

We did our best to make sure that the uMarketingSuite is a secure and safe package which allows you to be safe & secure as well and have total control of all data of your visitors.

In this section we dive deeper in some aspects, but please [feel free to reach out](mailto:info@umarketingsuite.com?subject=Security%20and%20privacy) if you have any questions, remarks or concerns!

## Security settings

The uMarketingSuite works in most ways in the exactly the same as any other Umbraco package. It is smart to read and apply the [security documentation & guidelines](https://our.umbraco.com/Documentation/Reference/Security/) of Umbraco.

If you have [locked down access to your Umbraco-folder](https://our.umbraco.com/Documentation/Reference/Security/Security-hardening/#lock-down-access-to-your-umbraco-folders), please make sure that /umbraco/uMarketingSuite/\* is allowed for all clients and it's not blocked based on a IP Whitelist or something like that. This is needed to collect [clientside events](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-collection/).

## Privacy settings

The uMarketingSuite stores a lot of data, but because it's stored in your own database(s) you have full control over this data. The data is never stored in a central datacenter of uMarketingSolutions and no visitordata is ever transmitted to us. It's the data that the visitor gave to you as a website and it should be yours.

The uMarketingSuite can be [configured](/installing-umarketingsuite/configuration-options-1-x/) to store the data in whatever database you specify. This can be the same database as the Umbraco installation, but also another database. Because you have probably already discussed storage and security of the data of your Umbraco installation, you can use it exactly the same for the uMarketingSuite data. How cool is that!

The uMarketingSuite gives you control over this data and especially give you some tooling to make sure that data is [anonymized at some moment](/security-privacy/anonymization/) in the future and even [fully deleted](/security-privacy/retention-periods-of-data/).