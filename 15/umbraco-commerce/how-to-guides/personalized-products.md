# Personalized Products

Customers can provide personalized information for products when submitting an order. This can be managed by following these steps:

* Add a message field on the product page in the add to cart form
* Save the details in an orderline property
* Register an UI extension to display the value in the Backoffice.

### Add to Cart Form

In our product details page, we can toggle the product observations section with an anchor selection:

![observations-default](images/personalized-products/observations-default.png)

![observations-collapsed](images/personalized-products/observations-collapsed.png)

The value will be captured in the `Observations` property of the `AddToCartDto`

````csharp
public class AddToCartDto
{
    ...

    public string? Observations { get; set; }
}
````

### Add to Cart Action

In our `AddToCart` action, if a value has been sent with the request, we set a property on the writable order.

````csharp
[HttpPost]
public async Task<IActionResult> AddToCart(AddToCartDto postModel)
{
    try
    {
        await _commerceApi.Uow.ExecuteAsync(async uow =>
        {
            ...

            if (postModel.Observations is not null)
            {
                await order.SetPropertyAsync("productObservations", postModel.Observations);
            }

            await _commerceApi.SaveOrderAsync(order);

            uow.Complete();
        });
    }

    ...
}
````

### Backoffice Extension

To view the data in the Backoffice order details, we need to register an `ucOrderLineProperty` extension as sampled below:

````csharp
{
  "name": "SwiftShop",
  "extensions": [
    {
      "type": "ucOrderLineProperty",
      "alias": "Uc.OrderLineProperty.ProductObservations",
      "name": "Product Observations",
      "weight": 400,
      "meta": {
        "propertyAlias": "productObservations",
        "readOnly": false,
        "showInOrderLineSummary": true,
        "summaryStyle": "inline",
        "editorUiAlias": "Umb.PropertyEditorUi.TextBox",
        "labelUiAlias": "Umb.PropertyEditorUi.Label"
      }
    },
    {
      "type": "localization",
      "alias": "Uc.OrderLineProperty.ProductObservations.EnUS",
      "name": "English",
      "meta": {
        "culture": "en",
        "localizations": {
          "section": {
            "ucProperties_productObservationsLabel": "Observations",
            "ucProperties_productObservationsDescription": "Customer product observations"
          }
        }
      }
    }
  ]
}
````



