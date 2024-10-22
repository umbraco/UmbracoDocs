---
description: How-To Guide to add an item to your cart.
---

# Add item to Cart

To add an item to the cart, configure Umbraco with a store and add the necessary properties for interaction. Learn more by following the [Getting started with Umbraco Commerce: The Backoffice tutorial](../tutorials/getting-started-with-commerce).

You will need the front end to be set up to allow an item to be added to the cart. This can be done by adding a button to the front end to call the Action to add the item to the cart.

Create a new Document Type with the template. Call it **Product Page** with the following property aliases: `productTitle`, `productDescription`, `price`, `stock`.

The following property editors are recommeded to be used for the above:

* `productTitle`: TextString
* `productDescription`: TextArea
* `price`: Umbraco Commerce Price
* `stock`: Umbraco Commerce Stock

The Product Page template can be implemented as shown below.

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ProductPage>
@{
var store = Model.Value<StoreReadOnly>("store", fallback: Fallback.ToAncestors);
var product = CommerceApi.Instance.GetProduct(store.Id, Model.Key.ToString(), "en-GB");
var price = product.TryCalculatePrice().ResultOrThrow("Unable to calculate product price");
}
```

The code above does the following:

- You need to access the store to access the relevant properties for your product, such as price. The store has a fallback property allowing you to traverse the tree to find the store.
- You retrieve the product based on the store and a reference for the product. The 'productReference' comes from the Model which is a single product. 
- The Product is returned as a ProductSnapshot which is Umbraco Commerce obtaining the page ID and carrying out necessary processes to bring in the data for further processing.
- Finally, you need to calculate the price which is then displayed without VAT. This can also be displayed with VAT.

To display this you need to add some markup or at least amend it to include a button to add an item. Add the following to the same file:

```csharp
@using (Html.BeginUmbracoForm("AddToCart", "CartSurface"))
{
	@Html.Hidden("productReference", Model.Key.ToString())
	<h1>@Model.Value<string>("productTitle")</h1>
	<h2>@Model.Value<string>("productDescription")</h2>

	<p>Our price excluding VAT <strong>@price.WithoutTax.ToString("C0") </strong></p>

	if (@Model.Value<int>("stock") == 0)
	{
		<p>Sorry, out of stock</p>
	}
	else
	{
		<button type="submit">Add to Basket</button>
	}

}
```

The hidden field uses the `productReference` to be passed across to the Controller.

## Adding the Controller

For the button to work, you need to implement a controller. An example of this is shown below.

Create a new Controller called `CartSurfaceController.cs`.

{% hint style="warning" %}

The namespaces used in this Controller are important and need to be included.

```
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Infrastructure.Persistence;
using Umbraco.Cms.Web.Website.Controllers;
using Umbraco.Commerce.Common.Validation;
using Umbraco.Commerce.Core.Api;
using Umbraco.Commerce.Core.Models;
using Umbraco.Commerce.Extensions;
using Umbraco.Extensions;
```

{% endhint %}

```csharp
public class CartSurfaceController : SurfaceController
{
    public CartSurfaceController(IUmbracoContextAccessor umbracoContextAccessor, 
                                 IUmbracoDatabaseFactory databaseFactory, 
                                 ServiceContext services, AppCaches appCaches,
                                 IProfilingLogger profilingLogger, 
                                 IPublishedUrlProvider publishedUrlProvider, 
                                 IUmbracoCommerceApi commerceApi) 
                                 : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
        _commerceApi = commerceApi;
    }
}
```

Below you can see the equivalent code for having this as a Primary Constructor:

```csharp
public class CartSurfaceController(IUmbracoContextAccessor umbracoContextAccessor, 
                                   IUmbracoDatabaseFactory databaseFactory, 
                                   ServiceContext services, AppCaches appCaches, 
                                   IProfilingLogger profilingLogger, 
                                   IPublishedUrlProvider publishedUrlProvider) 
                                   : SurfaceController(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
{
}
```

The CartDto class below is used to pass the `productReference` across to the Controller. This class has only one property for the `productReference`.

```csharp
public class CartDto
{
    public string ProductReference { get; set; }
}
```

We now need to add the Action to add the item to the cart. This action will be called when the button is clicked.

```csharp
[HttpPost]
public IActionResult AddToBasket(CartDto cart)
{
    commerceApi.Uow.Execute(uow =>
    {
        var store = CurrentPage.Value<StoreReadOnly>("store", fallback: Fallback.ToAncestors);

        if (store == null) return;

        try
        {
            var order = commerceApi.GetOrCreateCurrentOrder(store.Id)
                .AsWritable(uow)
                .AddProduct(cart.ProductReference, 1);

            commerceApi.SaveOrder(order);

            uow.Complete();

            TempData["SuccessFeedback"] = "Product added to cart";
            return RedirectToCurrentUmbracoPage();
        }
        catch (ValidationException ve)
        {
            throw new ValidationException(ve.Errors);
        }
        catch (Exception ex)
        {
            logger.Error(ex, "An error occurred.");
        }
    });
}
```

The code above does the following:

- The `store` variable is used to access the store to get the store ID.
- A try-catch block captures any errors that may occur when adding the item to the cart, including any validation errors.
- `order` is used to retrieve the current order if one exists or create a new order against the store found. In the Commerce API, everything is read-only for performance so you need to make it writable to add the product.
- `AddProduct` is called and `productReference` is passed along with the quantity.
- `SaveOrder` is called to save the order.
- `TempData` stores a message to be displayed to the user if the product has been added to the cart.

{% hint style="warning" %}
Umbraco Commerce uses the Unit of Work pattern to complete saving the item (`uow.Complete`). When retrieving or saving data ideally you would want the entire transaction to be committed. However, if there is an error nothing is changed on the database.
{% endhint %}

Finally, you need to add the `TempData` to tell the user that the product has been added to the cart.

## Add a partial view to display the message

Create a new partial view called `Feedback.cshtml`.

```csharp
@Html.ValidationSummary(true, "", new { @class = "danger" })

@{
	var success = TempData["SuccessFeedback"]?.ToString();

	if (!string.IsNullOrWhiteSpace(success))
	{
		<div class="success">@success</div>
	}
}
```

You can now run the application, click the button, and see the product added to the cart with a message displayed to the user.
