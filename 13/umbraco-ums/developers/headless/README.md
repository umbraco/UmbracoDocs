# headless

uMarketingSuite has an optional package that can be installed called **uMarketingSuite.Headless** that hooks into Umbraco 12.0+ Headless Content Delivery API to offer you the power of personalized content with your A/B tests and segmentation.

### Requirements

The main requirement to install uMarketingSuite Headless is that it depends on **Umbraco v12 and higher** due to integrating with the [content delivery API](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api).

This also requires uMarketingSuite 1.25.0 and higher and has the same requirements of needing a SQL Server database and can not be used with SQLite databases.

In addition to this the [Umbraco content delivery API needs to be enabled with the configuration setting](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api#enable-the-content-delivery-api)\
**Umbraco:CMS:DeliveryApi:Enabled** set to true

```
{    "Umbraco": {        "CMS": {            "DeliveryApi": {                "Enabled": true            }         }    }}
```

### Installing uMarketingSuite Headless API

**Ensure you already have uMarketingSuite installed and upgraded to 1.25.0**, you can follow the [normal install instructions for uMarketingSuite](../../../../installing-umarketingsuite/). Once this has been upgraded to 1.25.0+

You can install uMarketingSuite Headless API from Nuget with the package ID [**uMarketingSuite.Headless**](https://www.nuget.org/packages/uMarketingSuite.Headless) this can be installed using IDE (Visual Studio, JetBrains Rider) or via the command line.

If you are using the command line, navigate to your Umbraco website root folder in your terminal and then run the following command

```
dotnet add package uMarketingSuite.Headless
```

#### Updating Startup.cs

The next step requires updating your Startup.cs file to include the following line in the **ConfigureServices** method **.AddMarketingApiDocumentation()** and importantly to be specified after the line **.AddDeliveryApi()** from Umbraco. Your ConfigureServices method may look something like this:

```
public void ConfigureServices(IServiceCollection services){    services.AddUmbraco(_env, _config)        .AddBackOffice()        .AddWebsite()        .AddDeliveryApi()        .AddMarketingApiDocumentation()        .AddComposers()        .Build();}>
```

You can now rebuild your site and run it and navigate to **/umbraco/swagger** and from the top right definition dropdown you should be able to see the **uMarketingSuite Marketing API**

![]()
