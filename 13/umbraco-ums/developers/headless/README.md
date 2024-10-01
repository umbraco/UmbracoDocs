---
description: >-
  Discover how to integrate the uMarketingSuite.Headless package with Umbraco 12.0+ for a Content Delivery API.
---

# Headless

The uMarketingSuite has a **uMarketingSuite.Headless** package that can be installed to integrate with Umbraco 12.0+. Headless Content Delivery API, enabling personalized content, A/B tests, and segmentation.

## Requirements

To install uMarketingSuite.Headless, ensure the following:

- Umbraco v12 or higher is required to integrate with the [Content Delivery API](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api).
- uMarketingSuite 1.25.0 or higher
- A SQL Server database is needed; SQLite databases are not supported.
- Enable the [Umbraco Content Delivery API](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api#enable-the-content-delivery-api) with the following configuration setting:

    ```json
    {
    "Umbraco": {
        "CMS": {
            "DeliveryApi": {
                "Enabled": true
            }
        }
    }
    }
    ```

## Installing uMarketingSuite Headless API

To install uMarketingSuite Headless API, follow these steps:

1. Ensure uMarketingSuite is upgraded:

    - Verify that uMarketingSuite is installed and upgraded to **1.25.0**. For more information, see the [installation instructions for uMarketingSuite](../../../../installing-umarketingsuite/).

2. Install the uMarketingSuite.Headless package:

    - **Using an IDE:** Install the [**uMarketingSuite.Headless**](https://www.nuget.org/packages/uMarketingSuite.Headless) package from NuGet in Visual Studio, JetBrains Rider
    - **Using the command line:**

        - Navigate to your Umbraco website root folder in your terminal.
        - Run the following command:

        ```cs
        dotnet add package uMarketingSuite.Headless
        ```

## Updating Startup.cs

To update the Startup.cs file, follow these steps:

1. Open your Startup.cs file.
2. Locate the **ConfigureServices** method.
3. Add the line **.AddMarketingApiDocumentation()** after **.AddDeliveryApi()**. Your ConfigureServices method should look like this:

    ```cs
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddUmbraco(_env, _config)
            .AddBackOffice()
            .AddWebsite()
            .AddDeliveryApi()
            .AddMarketingApiDocumentation()
            .AddComposers()
            .Build();
    }
    ```

4. Rebuild and run your site.
5. Navigate to **/umbraco/swagger** in your browser.
6. From the top right definition dropdown, check for the **uMarketingSuite Marketing API**

![]()
