[nuget_url]: https://www.nuget.org/packages/Umbraco.Commerce.ProductFeeds/

## Quick start
1. Install the package from [NuGet][nuget_url] &middot; [![NuGet](https://img.shields.io/nuget/v/Umbraco.Commerce.ProductFeeds.svg?style=modern&label=nuget)][nuget_url]

2. Locate where you [register the dependencies](https://docs.umbraco.com/umbraco-commerce/key-concepts/umbraco-commerce-builder#registering-dependencies) `IUmbracoBuilder.AddUmbracoCommerce()` and add a call to `IUmbracoCommerceBuilder.AddCommerceProductFeeds()` to add this plugin to your website.
```csharp
        umbracoBuilder.AddUmbracoCommerce(ucBuilder => {
            ucBuilder.AddCommerceProductFeeds(); // add this line
        }
```

3. Open your store's setting page in the backoffice 
	
4. Click on `Product Feed` section
![product feed list page](./media/product-feed-list-page.png)

5. Click on `Create Product Feed` button and fill in the feed settings. Mandatory fields are marked with a red asterisk (*). You can add more product data by adding new mappings in `Property And Node Mapping` section.
![feed setting page](./media/feed-setting-page.png)

6. After saving the feed setting, a link to access the feed will show up under `Feed URL Segment` field and at the bottom of the page.
![open feed link](./media/open-feed-link.png)
`Google Merchant Center Feed` sample:
![google merchant center feed](./media/google-merchant-center-feed.png)