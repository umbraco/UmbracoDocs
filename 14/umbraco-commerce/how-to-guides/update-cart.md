---
description: Learn how to update your cart when one or more quantities have changed.
---

# Update Cart

Functionality is needed to update the cart once an item has been added. In this guide, you can learn how to add this functionality. 

You need a new page to summarize the items in the cart and allow users to update each item.

Create a new Document With a Template. Call it "Cart Page" and update the template with the following code:

```csharp
@inherits UmbracoViewPage
@{
	var store = Model.Value<StoreReadOnly>("store", fallback: Fallback.ToAncestors);
	var currentOrder = CommerceApi.Instance.GetCurrentOrder(store!.Id);
	if (currentOrder == null) return;
}
```

- You need to access the store to see the relevant data for the current cart/order. The store has a `fallback` property allowing you to traverse the tree to find the store.
- `currentOrder` is used to get the current order for the store. If the current order is null then there is nothing to display.

To display the default layout when an order does exist, you need to add some markup or amend it to include the desired functionality. Add the following code to the template:

```csharp
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
            @item.OrderLine.Name | @Html.TextBox($"orderLines[{item.Index}].Quantity", (int)item.OrderLine.Quantity, new { @type = "number" })
            @Html.Hidden($"orderLines[{item.Index}].ProductReference", item.OrderLine.ProductReference)
            <a href="@Url.SurfaceAction("RemoveFromBasket", "BasketSurface", new { OrderLineId = item.OrderLine.Id })">Remove</a>
        </p>

    }

    <button type="submit">Update Cart</button>

    var success = TempData["SuccessMessage"]?.ToString();

    if (!string.IsNullOrWhiteSpace(success))
    {
        <div class="success">@success</div>
    }
}
```

You first loop through each item in the `cart/order` and display the product name and quantity.

A hidden input is added for the order ID, quantity, and product reference. This is so you can update the cart with the new number.

```csharp
    @Html.Hidden($"orderLines[{item.Index}].OrderId", item.OrderLine.Id)
```

The line below sets the ID of the order line (or the item in the current cart/order).

```csharp
    @item.OrderLine.Name @Html.Hidden($"orderLines[{item.Index}].Quantity", (int)item.OrderLine.Quantity, new { @type = "number" })
```

As well as setting the product name, the line below sets the quantity of the product in the cart/order. Finally, the number is set to a number input type.

```csharp
    @Html.Hidden($"orderLines[{item.Index}].ProductReference", item.OrderLine.ProductReference)
```

This is setting the product reference in the cart/order so there is a way to distinguish between products. This is hidden as it does not need to be displayed to the user.

{% hint style="warning" %}

The `remove` button is added here but is not covered in this guide. Learn more in the [Delete item from Cart](delete-item.md) article.

{% endhint %}

Finally, a button is added to submit the form to update the cart. This will call the `UpdateCart` action in the `CartSurfaceController` which will then show a success message to the user.

## Adding the Controller

Create a new Controller called `CartSurfaceController.cs`

{% hint style="warning" %}

The namespaces used in this Controller are important and need to be included.

```cs
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

The following is the equivalent code for having this as a Primary Constructor:

```csharp
public class CartSurfaceController(IUmbracoContextAccessor umbracoContextAccessor,
                                   IUmbracoDatabaseFactory databaseFactory, 
                                   ServiceContext services, AppCaches appCaches, 
                                   IProfilingLogger profilingLogger, 
                                   IPublishedUrlProvider publishedUrlProvider, 
                                   IUmbracoCommerceApi commerceApi) 
                                   : SurfaceController(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
{
}
```

The `CartDto` is a class that passes data to the Controller. This is a class that has a property for the `productReference` and an array of `OrderLineQuantityDto[]`.

```csharp
    public class CartDto
    {
        public string ProductReference { get; set; }
        public OrderLineQuantityDto[] OrderLines { get; set; }
    }

    public class OrderLineQuantityDto
    {
        public Guid Id { get; set; }
        public decimal Quantity { get; set; }
    }
```

{% hint style="warning" %}
The code example above adds the `ProductReference` but it is not used in this guide.

It is an example of passing the product reference to the controller for similar tasks.
{% endhint %}

You need to add the `Action` to update the items in the cart. This will be called when the button is clicked.

```csharp
[HttpPost]
        public IActionResult UpdateCart(CartDto cart)
        {
            try
            {
                _commerceApi.Uow.Execute(uow =>
                {
                    var store = CurrentPage?.Value<StoreReadOnly>("store", fallback: Fallback.ToAncestors);

                    if (store == null) return;

                    var order = _commerceApi.GetCurrentOrder(store.Id)
                    .AsWritable(uow);

                    foreach (var orderLine in cart.OrderLines)
                    {
                        order.WithOrderLine(orderLine.Id)
                        .SetQuantity(orderLine.Quantity);
                    }

                    _commerceApi.SaveOrder(order);

                    uow.Complete();
                });
            }
            catch (ValidationException)
            {
                ModelState.AddModelError(string.Empty, "Failed to update cart");

                return CurrentUmbracoPage();
            }

            TempData["SuccessMessage"] = "Cart updated";

            return RedirectToCurrentUmbracoPage();
        }
```

- A `try-catch` block captures any validation errors that may occur when updating items in the cart.
- The `store` variable is used to access the store to retrieve the store ID.
- `order` is used to retrieve the current order. In the Commerce API, everything is read-only for performance so you need to make it writable to add the product.
- You loop through all the `orderLines(items)` in the cart, set the new quantity amount set in the View, and pass it to the CartDto model.
- `SaveOrder` is called to save the order.
- If there are any validation errors, they are added to `ModelState` error, and the user is redirected back to the current page.
- `TempData` stores a message to be displayed to the user if the product has been successfully updated.

{% hint style="warning" %}
Umbraco Commerce uses the Unit of Work pattern to complete saving the item (`uow.Complete`). When retrieving or saving data you want the entire transaction to be committed. However, if there is an error nothing is changed on the database.
{% endhint %}

If you have followed the [Add item to cart](add-item.md) article then run the application, add an item to your cart, and navigate to your `cart.cshtml` page. Enter a new quantity, click the Update Cart button, and the item(s) in your cart will tell you the values have been updated.
