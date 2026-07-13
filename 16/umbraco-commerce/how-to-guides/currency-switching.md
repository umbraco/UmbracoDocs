---
description: Learn how to implement a currency switcher in Umbraco Commerce.
---

# Implementing a Currency Switcher

In a globalized world, it is essential to provide users with the ability to switch between different currencies. This feature is especially important for e-commerce websites that cater to customers from different countries.

In this guide, you can learn how to implement a currency switcher in Umbraco Commerce.

{% hint style="info" %}
In this guide, it is assumed that each country has a single currency. If your store supports multiple currencies per country, you must adjust the implementation accordingly.
{% endhint %}

## Configure Countries and Currencies

1. Define the countries and currencies you want to support, in the Umbraco backoffice.

![Countries](images/localization/store-countries.png)

![Currencies](images/localization/store-currencies.png)

2. Navigate to the Content section.
3. Populate the product prices for each currency.

![Product Prices](images/localization/product-prices.png)

## Create a Currency Switcher Component

A partial view is used on the frontend to allow users to toggle between existing currencies.

![Currency Switcher](images/localization/country-switch.png)

This is done by creating a `CurerrencySwitcher.cshtml` partial with the following implementation:

{% code title="CurerrencySwitcher.cshtml" %}

````csharp
@using Umbraco.Commerce.Core.Api;
@using Umbraco.Commerce.SwiftShop.Extensions;
@inject IUmbracoCommerceApi UmbracoCommerceApi
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage

@{
    var store = Model.GetStore();
    var countries = await UmbracoCommerceApi.GetCountriesAsync(store.Id);
    var currencies = await UmbracoCommerceApi.GetCurrenciesAsync(store.Id);
    var currentCountry = await UmbracoCommerceApi.GetDefaultShippingCountryAsync(store.Id);
}

@if (countries.Count() > 1)
{
    @using (Html.BeginUmbracoForm("ChangeCountry", "Culture", FormMethod.Post, new { @name = "changeCountryForm" }))
    {
        @Html.DropDownList("countryIsoCode", countries.Select(x 
            => new SelectListItem(currencies.First(y => y.Id == x.DefaultCurrencyId!.Value).Code, x.Code, x.Code == currentCountry.Code)),
        new
        {
            @class = "form-select form-select-sm",
            @onchange = "document.forms['changeCountryForm'].submit()"
        })
    }
}
````

{% endcode %}

This can then be placed in your sites base template by adding the following:

{% code title="Layout.cshtml" %}

```csharp
@(await Html.PartialAsync("CurerrencySwitcher"))
```

{% endcode %}

## Handle Switching Currencies

Switching the culture is handled by a Surface controller.

Create a new Surface controller called `CultureSurfaceController` and add the following code:

{% code title="CultureSurfaceController.cs" %}

````csharp
public class CultureSurfaceController : SurfaceController
{
    private readonly IUmbracoCommerceApi _commerceApi;

    public CultureSurfaceController(
        IUmbracoContextAccessor umbracoContextAccessor, 
        IUmbracoDatabaseFactory databaseFactory, 
        ServiceContext services, 
        AppCaches appCaches, 
        IProfilingLogger profilingLogger, 
        IPublishedUrlProvider publishedUrlProvider,
        IUmbracoCommerceApi commerceApi) 
        : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
        _commerceApi = commerceApi;
    }
    
    [HttpPost]
    public async Task<IActionResult> ChangeCountry(ChangeCountryDto changeCountryDto)
    {
        var store = CurrentPage.GetStore();
        var country = await _commerceApi.GetCountryAsync(store.Id, changeCountryDto.CountryIsoCode);
        var currency = await _commerceApi.GetCurrencyAsync(country.DefaultCurrencyId.Value);
    
        await _commerceApi.SetDefaultPaymentCountryAsync(store.Id, country);
        await _commerceApi.SetDefaultShippingCountryAsync(store.Id, country);
        await _commerceApi.SetDefaultCurrencyAsync(store.Id, currency);
    
        var currentOrder = await _commerceApi.GetCurrentOrderAsync(store.Id);
        if (currentOrder != null)
        {
            await _commerceApi.Uow.ExecuteAsync(async uow =>
            {
                var writableOrder = await currentOrder.AsWritableAsync(uow)
                    .ClearPaymentCountryRegionAsync()
                    .ClearShippingCountryRegionAsync()
                    .SetCurrencyAsync(currency.Id);
    
                await _commerceApi.SaveOrderAsync(writableOrder);
    
                uow.Complete();
            });
        }
    
        return RedirectToCurrentUmbracoPage();
    }
}
````

{% endcode %}

The `ChangeCountryDto` class binds the country ISO code from the form.

{% code title="ChangeCountryDto.cs" %}

````csharp
public class ChangeCountryDto
{
    public string CountryIsoCode { get; set; }
}
````

{% endcode %}

## Result

With the currency switcher implemented, users can switch between countries/currencies on your website.

The changes are reflected on the product details pages.

![product-gb](images/localization/product-gb.png)

![product-dk](images/localization/product-dk.png)
