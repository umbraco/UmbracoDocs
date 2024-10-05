## Delete item from cart
Following on from the previous guide on [updating an item in the cart](/umbraco-commerce/how-to-guides/update-cart.md), we will now look at how to delete an item from the cart.

{% hint style="warning" %}
This tutorial focuses only on the delete functionality. Please see the other guides for more information for areas not covered here. 
{% endhint %}

Your view will be similar to the below for the `cart.cshtml` page.

```csharp
@inherits UmbracoViewPage
@{
	var store = Model.Value<StoreReadOnly>("store", fallback: Fallback.ToAncestors);
	var currentOrder = CommerceApi.Instance.GetCurrentOrder(store!.Id);
	if (currentOrder == null) return;

    @using (Html.BeginUmbracoForm("UpdateCart", "CartSurface"))
  {
    @foreach (var item in currentOrder.OrderLines.Select((ol, i) => new
    {
        OrderLine = ol,
        Index = i
    }))
    {
        <p>
            @Html.Hidden($"orderLines[{item.Index}].Id", item.OrderLine.Id)
            @item.OrderLine.Name @Html.Hidden($"orderLines[{item.Index}].Quantity", (int)item.OrderLine.Quantity, new { @type = "number" })
            @Html.Hidden($"orderLines[{item.Index}].ProductReference", item.OrderLine.ProductReference)
            <a href="@Url.SurfaceAction("RemoveFromCart", "CartSurface", new { OrderLineId = item.OrderLine.Id })">Remove Item</a>
        </p>

    }

    <button type="submit">Update Cart</button>

    var success = TempData["SuccessMessage"]?.ToString();

    if (!string.IsNullOrWhiteSpace(success))
    {
        <div class="success">@success</div>
    }
  }
}
```

- The below code allows the Umbraco `SurfaceAction` to call `RemoveFromCart` when the link is clicked as well as passing the `OrderLineId`.
```csharp
<a href="@Url.SurfaceAction("RemoveFromCart", "BasketSurface", new { OrderLineId = item.OrderLine.Id })">Remove</a>
```
## Adding the Controller

Create a new Controller called `CartSurfaceController.cs`

{% hint style="warning" %}

The namespaces used in this Controller are important and need to be included.

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

{% endhint %}

```csharp
public class CartSurfaceController : SurfaceController
{
    public CartSurfaceController(IUmbracoContextAccessor umbracoContextAccessor, IUmbracoDatabaseFactory databaseFactory, ServiceContext services, AppCaches appCaches, IProfilingLogger profilingLogger, IPublishedUrlProvider publishedUrlProvider, IUmbracoCommerceApi commerceApi) : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
        _commerceApi = commerceApi;
    }
}
```

The equivalent code for having this as a Primary Constructor

```csharp
public class CartSurfaceController(IUmbracoContextAccessor umbracoContextAccessor, IUmbracoDatabaseFactory databaseFactory, ServiceContext services, AppCaches appCaches, IProfilingLogger profilingLogger, IPublishedUrlProvider publishedUrlProvider, IUmbracoCommerceApi commerceApi) : SurfaceController(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
{
}
```



The `CartDto` is a class that is used to pass data to the Controller. In this instance it is passing over the OrderLineId.

```csharp
    public class CartDto
    {
        public Guid OrderLineId { get; set; }
    }
```

We now need to add the `Action` in order to delete the item from the cart. This will be called when the button is clicked.

```csharp
        [HttpGet]
        public IActionResult RemoveFromCart(CartDto cart)
        {
            try
            {
                _commerceApi.Uow.Execute(uow =>
                {
                    var store = CurrentPage?.Value<StoreReadOnly>("store", fallback: Fallback.ToAncestors);

                    if (store == null) return;

                    var order = _commerceApi.GetOrCreateCurrentOrder(store.Id)
                    .AsWritable(uow)
                    .RemoveOrderLine(cart.OrderLineId);

                    _commerceApi.SaveOrder(order);

                    uow.Complete();
                });
            }
            catch (ValidationException)
            {
                ModelState.AddModelError(string.Empty, "Failed to remove product from cart");

                return CurrentUmbracoPage();
            }

            TempData["SuccessMessage"] = "Item removed";

            return RedirectToCurrentUmbracoPage();
        }
```

- A `try catch` block is used to capture any validation errors that may occur when updating items in the cart.
- `store` variable is used to access the store to retrieve the store ID.
- `order` is used to retrieve the current order. In the Commerce Api everything is read-only for performance so we need to make it writable in order to add the product.
- `SaveOrder` is called to save the order.
- If there are any validation errors, they are added to ModelState error and the user is redirected back to the current page.
- `TempData` is used to store a message to be displayed to the user if the product has been succesfully updated.

{% hint style="warning" %}
Umbraco Commerce uses the Unit of Work pattern in order to complete saving the item (uow.Complete). When retrieving or saving data ideally you would want the entire transaction to be committed however if there is an error then nothing is changed on the database.
{% endhint %}

If you have followed the 'Add item to cart' article then run the application, add an item to your cart and navigate to your cart.cshtml page. Clicking the `Remove Item` button would delete the the item in your cart and display a success message.
