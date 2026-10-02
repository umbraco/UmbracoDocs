---
description: Learn how to add a custom advanced filter to the order list in Umbraco Commerce.
---

# Create a Custom Order Advanced Filter

The order list in the **Commerce** section includes advanced filters, such as **Order Number**, **First Name**, and **Placed On or After**. You can add your own filters to search orders by other criteria.

This guide shows how to create a filter that lists orders by payment method. Combined with the built-in date filters, it can show, for example, how many orders a store completed with a given payment method each week.

## Create the filter

An advanced filter is a class that inherits from `OrderAdvancedFilterBase`, decorated with the `AdvancedFilter` attribute.

1. Create a new class, for example `OrderPaymentMethodAdvancedFilter.cs`.
2. Add the following code:

```csharp
using Umbraco.Commerce.Cms.Filters;
using Umbraco.Commerce.Common.Specifications;
using Umbraco.Commerce.Core.Models;
using Umbraco.Commerce.Core.Specifications.Order;
using Umbraco.Commerce.Extensions;

namespace MyProject.Filters;

[AdvancedFilter("paymentMethod",
    Group = "order",
    Label = "Payment method ID",
    Description = "Orders that use the given payment method",
    EditorUiAlias = "Umb.PropertyEditorUi.TextBox")]
public class OrderPaymentMethodAdvancedFilter : OrderAdvancedFilterBase
{
    public override bool CanApply(string value)
        => Guid.TryParse(value, out _);

    public override IQuerySpecification<OrderReadOnly> Apply(
        IQuerySpecification<OrderReadOnly> query,
        IOrderQuerySpecificationFactory where,
        string value)
        => query.And(where.HasPaymentMethod(Guid.Parse(value)));
}
```

The filter has three parts:

* The `AdvancedFilter` attribute sets the filter's alias and how it appears in the backoffice:
  * `Group` places the filter in the **Order** group. The built-in groups are `order`, `customer`, and `orderLine`.
  * `Label` and `Description` are shown next to the filter.
  * `EditorUiAlias` sets the property editor used to enter the value. This example uses a text box.
* `CanApply` checks whether the entered value is valid. The filter is only applied when it returns `true`.
* `Apply` adds the filter condition to the order query. `HasPaymentMethod` is one of the conditions available on `IOrderQuerySpecificationFactory`.

## Register the filter

Register the filter with a composer so Umbraco Commerce adds it to the order list.

1. Create a new class, for example `OrderFiltersComposer.cs`.
2. Add the following code:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Commerce.Extensions;

namespace MyProject.Filters;

public class OrderFiltersComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.WithUmbracoCommerceBuilder()
            .WithOrderAdvancedFilters()
            .Add<OrderPaymentMethodAdvancedFilter>();
}
```

3. Build and restart the site.

## Use the filter

The filter needs the ID of the payment method to filter on.

1. Go to the **Settings** section.
2. Expand your store under **Stores** and select **Payment Methods**.
3. Select the payment method.
4. Copy the **Id** from the **Info** panel.

![The payment method ID in the Info panel](images/custom-order-advanced-filter/payment-method-id.png)

To filter the order list:

1. Go to the **Commerce** section.
2. Expand your store and select **Orders**.
3. Select the filter icon next to **Payment Status**.
4. Enter the ID in **Payment method ID**.

![The Payment method ID filter in the Advanced Filters panel](images/custom-order-advanced-filter/advanced-filters-panel.png)

5. Select **Apply**.

The order list shows only the orders that use the given payment method.

![The order list filtered by payment method](images/custom-order-advanced-filter/filtered-order-list.png)

To count the orders for a specific week, also set **Placed On or After** and **Placed On or Before** in the **Advanced Filters** panel.
