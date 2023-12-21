---
title: Order
description: API reference for Order in Umbraco Commerce
---
## Order

A writable Order entity

```csharp
public class Order : OrderReadOnly, ITaggableWritableEntity<Order>
```

**Inheritance**

* Class [OrderReadOnly](orderreadonly.md)
* interface [ITaggableWritableEntity&lt;TEntity&gt;](itaggablewritableentity-1.md)

**Namespace**
* [Umbraco.Commerce.Core.Models](README.md)

### Properties

#### IsFinalized

```csharp
public override bool IsFinalized { get; }
```


---

#### IsFinalizing

```csharp
public override bool IsFinalizing { get; }
```


### Methods

#### Create (1 of 2)

Creates a new instance of an [`Order`](order.md)

```csharp
public static Order Create(IUnitOfWork uow, Guid storeId, string languageIsoCode, Guid currencyId, 
    Guid taxClassId, Guid orderStatusId, Guid? paymentMethodId = default(Guid?), 
    Guid? paymentCountryId = default(Guid?), Guid? paymentRegionId = default(Guid?), 
    Guid? shippingMethodId = default(Guid?), Guid? shippingCountryId = default(Guid?), 
    Guid? shippingRegionId = default(Guid?), string customerReference = null)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| uow | An active IUnitOfWork to use for write operations |
| storeId | The ID of the [`Store`](store.md) the order belongs to |
| languageIsoCode | The ISO Code of the language of the order |
| currencyId | The ID of the [`Currency`](currency.md) of the order |
| taxClassId | The ID of the [`TaxClass`](taxclass.md) of the order |
| orderStatusId | The ID of the [`OrderStatus`](orderstatus.md) of the order |
| paymentMethodId | The ID of the [`PaymentMethod`](paymentmethod.md) of the order |
| paymentCountryId | The ID of the payment [`Country`](country.md) of the order |
| paymentRegionId | The ID of the payment [`Region`](region.md) of the order |
| shippingMethodId | The ID of the [`ShippingMethod`](shippingmethod.md) of the order |
| shippingCountryId | The ID of the shipping [`Country`](country.md) of the order |
| shippingRegionId | The ID of the shipping [`Region`](region.md) of the order |
| customerReference | The unique reference of the customer the order belongs to |

**Returns**

A new [`Order`](order.md) instance

---

#### Create (2 of 2)

Creates a new instance of an [`Order`](order.md)

```csharp
public static Order Create(IUnitOfWork uow, Guid id, Guid storeId, string languageIsoCode, 
    Guid currencyId, Guid taxClassId, Guid orderStatusId, Guid? paymentMethodId = default(Guid?), 
    Guid? paymentCountryId = default(Guid?), Guid? paymentRegionId = default(Guid?), 
    Guid? shippingMethodId = default(Guid?), Guid? shippingCountryId = default(Guid?), 
    Guid? shippingRegionId = default(Guid?), string customerReference = null)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| uow | An active IUnitOfWork to use for write operations |
| id | And explicit ID to assign to the [`Order`](order.md) |
| storeId | The ID of the [`Store`](store.md) the order belongs to |
| languageIsoCode | The ISO Code of the language of the order |
| currencyId | The ID of the [`Currency`](currency.md) of the order |
| taxClassId | The ID of the [`TaxClass`](taxclass.md) of the order |
| orderStatusId | The ID of the [`OrderStatus`](orderstatus.md) of the order |
| paymentMethodId | The ID of the [`PaymentMethod`](paymentmethod.md) of the order |
| paymentCountryId | The ID of the payment [`Country`](country.md) of the order |
| paymentRegionId | The ID of the payment [`Region`](region.md) of the order |
| shippingMethodId | The ID of the [`ShippingMethod`](shippingmethod.md) of the order |
| shippingCountryId | The ID of the shipping [`Country`](country.md) of the order |
| shippingRegionId | The ID of the shipping [`Region`](region.md) of the order |
| customerReference | The unique reference of the customer the order belongs to |

**Returns**

A new [`Order`](order.md) instance


---

#### AddProduct (1 of 3)

Adds a product to the order

```csharp
public Order AddProduct(string productReference, decimal qty, 
    IDictionary<string, string> properties, string bundleId, string parentBundleId, 
    IEnumerable<string> uniquenessPropertyAliases, IProductService productService)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| productReference | The unique reference of the product |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |
| parentBundleId | The bundle ID of an existing bundle to assign the product order line to as a bundle item |
| uniquenessPropertyAliases | A collection of property aliases to use to identify product uniqueness when adding the product to the order |
| productService | A [`IProductService`](../umbraco-commerce-core-services/iproductservice.md) instance to fetch the product information from |

**Returns**

The updated [`Order`](order.md) entity

---

#### AddProduct (2 of 3)

Adds a product variant to the order

```csharp
public Order AddProduct(string productReference, string productVariantReference, decimal qty, 
    IDictionary<string, string> properties, string bundleId, string parentBundleId, 
    IEnumerable<string> uniquenessPropertyAliases, IProductService productService)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| productReference | The unique reference of the product |
| productVariantReference | The unique reference of the product variant |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |
| parentBundleId | The bundle ID of an existing bundle to assign the product order line to as a bundle item |
| uniquenessPropertyAliases | A collection of property aliases to use to identify product uniqueness when adding the product to the order |
| productService | A [`IProductService`](../umbraco-commerce-core-services/iproductservice.md) instance to fetch the product information from |

**Returns**

The updated [`Order`](order.md) entity

---

#### AddProduct (3 of 3)

Adds a product to the order

```csharp
public Order AddProduct(IProductSnapshot productSnapshot, decimal qty, 
    IDictionary<string, string> properties, string bundleId, string parentBundleId, 
    IEnumerable<string> uniquenessPropertyAliases)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| productSnapshot | A snapshot of the product to add |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| uniquenessPropertyAliases | A collection of property aliases to use to identify product uniqueness when adding the product to the order |

**Returns**

The updated [`Order`](order.md) entity


---

#### AddTag

Adds a tag to the order

```csharp
public Order AddTag(string tag)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| tag | The tag to add |

**Returns**

The updated [`Order`](order.md) entity


---

#### AddTags

Adds a series of tag to the order

```csharp
public Order AddTags(IEnumerable<string> tags)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| tags | The tags to add |

**Returns**

The updated [`Order`](order.md) entity


---

#### AssignToCustomer

Assigns the order to a customer

```csharp
public Order AssignToCustomer(string customerReference)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| customerReference | The unique reference of the customer to assign the order to, for Umbraco members this should be `member.Key.ToString()` |

**Returns**

The updated [`Order`](order.md) entity


---

#### ClearPaymentCountryRegion

Clears the payment [`Country`](country.md) and [`Region`](region.md) of the order

```csharp
public Order ClearPaymentCountryRegion()
```

**Returns**

The updated [`Order`](order.md) entity


---

#### ClearPaymentMethod

Clears the current [`PaymentMethod`](paymentmethod.md) of the order

```csharp
public Order ClearPaymentMethod()
```

**Returns**

The updated [`Order`](order.md) entity


---

#### ClearShippingCountryRegion

Clears the shipping [`Country`](country.md) and [`Region`](region.md) of the order

```csharp
public Order ClearShippingCountryRegion()
```

**Returns**

The updated [`Order`](order.md) entity


---

#### ClearShippingMethod

Clears the current [`ShippingMethod`](shippingmethod.md) of the order

```csharp
public Order ClearShippingMethod()
```

**Returns**

The updated [`Order`](order.md) entity


---

#### ClearTags

Clears all the tags assigned to this order

```csharp
public Order ClearTags()
```

**Returns**

The updated [`Order`](order.md) entity


---

#### Finalize (1 of 2)

Finalizes the order

```csharp
public Order Finalize(decimal amountAuthorized, string transactionId, PaymentStatus paymentStatus)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| amountAuthorized | The amount authorized by the payment gateway |
| transactionId | The ID of the transaction from the payment gateway |
| paymentStatus | The status of the payment |

**Returns**

The updated [`Order`](order.md) entity

---

#### Finalize (2 of 2)

Finalizes the order

```csharp
public Order Finalize(decimal amountAuthorized, decimal transactionFee, string transactionId, 
    PaymentStatus paymentStatus)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| amountAuthorized | The amount authorized by the payment gateway |
| transactionFee | The transaction fee charged by the payment gateway |
| transactionId | The ID of the transaction from the payment gateway |
| paymentStatus | The status of the payment |

**Returns**

The updated [`Order`](order.md) entity


---

#### InitializeTransaction

Initializes a transaction ready to send to the payment gateway

```csharp
public Order InitializeTransaction(IOrderNumberGenerator orderNumberGenerator)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderNumberGenerator | The [`IOrderNumberGenerator`](../umbraco-commerce-core-generators/iordernumbergenerator.md) to use to generate and order number with |

**Returns**

The updated [`Order`](order.md) entity


---

#### Recalculate (1 of 2)

Recalculates the order

```csharp
public Order Recalculate(IOrderCalculator orderCalculator)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderCalculator | A [`IOrderCalculator`](../umbraco-commerce-core-calculators/iordercalculator.md) instance to use for the calculation |

**Returns**

The updated [`Order`](order.md) entity

---

#### Recalculate (2 of 2)

Recalculates the order

```csharp
public Order Recalculate(bool force, IOrderCalculator orderCalculator)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| force | A boolean flag indicating whether to force recalculation whether the order needs recalculating or not |
| orderCalculator | A [`IOrderCalculator`](../umbraco-commerce-core-calculators/iordercalculator.md) instance to use for the calculation |

**Returns**

The updated [`Order`](order.md) entity


---

#### Redeem

Redeems a [`Discount`](discount.md) or [`GiftCard`](giftcard.md) against the order

```csharp
public Order Redeem(string discountOrGiftCardCode, IDiscountService discountService, 
    IGiftCardService giftCardService)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| discountOrGiftCardCode | The [`Discount`](discount.md) or [`GiftCard`](giftcard.md) code |
| discountService | A [`IDiscountService`](../umbraco-commerce-core-services/idiscountservice.md) instance to fetch discounts from |
| giftCardService | A [`IGiftCardService`](../umbraco-commerce-core-services/igiftcardservice.md) instance to fetch gift cards from |

**Returns**

The updated [`Order`](order.md) entity


---

#### RemoveOrderLine (1 of 2)

Removes an order line from the order

```csharp
public Order RemoveOrderLine(OrderLineReadOnly orderLine)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderLine | The order line to remove |

**Returns**

The updated [`Order`](order.md) entity

---

#### RemoveOrderLine (2 of 2)

Removes an order line from the order

```csharp
public Order RemoveOrderLine(Guid orderLineId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderLineId | The ID of the order line to remove |

**Returns**

The updated [`Order`](order.md) entity


---

#### RemoveProperties

Removes a series of properties from the order

```csharp
public Order RemoveProperties(IEnumerable<string> aliases)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| aliases | The aliases of the properties to remove |

**Returns**

The updated [`Order`](order.md) entity


---

#### RemoveProperty

Removes a property from the order

```csharp
public Order RemoveProperty(string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| alias | The alias of the property to remove |

**Returns**

The updated [`Order`](order.md) entity


---

#### RemoveTag

Removes a tag from the order

```csharp
public Order RemoveTag(string tag)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| tag | The tags to remove |

**Returns**

The updated [`Order`](order.md) entity


---

#### RemoveTags

Removes a series of from the order

```csharp
public Order RemoveTags(IEnumerable<string> tags)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| tags | The tags to remove |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetCurrency (1 of 2)

Sets the [`Currency`](currency.md) of the order

```csharp
public Order SetCurrency(CurrencyReadOnly currency)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| currency | The [`Currency`](currency.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetCurrency (2 of 2)

Sets the [`Currency`](currency.md) of the order

```csharp
public Order SetCurrency(Guid currencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| currencyId | The ID of the [`Currency`](currency.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetLanguage

Sets the language of the order

```csharp
public Order SetLanguage(string languageIsoCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| languageIsoCode | The ISO Code of the language to set the order to |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetOrderStatus (1 of 4)

Sets the [`OrderStatus`](orderstatus.md) of the order

```csharp
public Order SetOrderStatus(OrderStatusReadOnly orderStatus)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderStatus | The [`OrderStatus`](orderstatus.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetOrderStatus (2 of 4)

Sets the [`OrderStatus`](orderstatus.md) of the order

```csharp
public Order SetOrderStatus(Guid orderStatusId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderStatusId | The ID of the [`OrderStatus`](orderstatus.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetOrderStatus (3 of 4)

Sets the [`OrderStatus`](orderstatus.md) of the order

```csharp
public Order SetOrderStatus(OrderStatusReadOnly orderStatus, OrderStatusCode orderStatusCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderStatus | The [`OrderStatus`](orderstatus.md) to set the order to |
| orderStatusCode | An [`OrderStatusCode`](orderstatuscode.md) to set on the order for additional order status context |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetOrderStatus (4 of 4)

Sets the [`OrderStatus`](orderstatus.md) of the order

```csharp
public Order SetOrderStatus(Guid orderStatusId, OrderStatusCode orderStatusCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderStatusId | The ID of the [`OrderStatus`](orderstatus.md) to set the order to |
| orderStatusCode | An [`OrderStatusCode`](orderstatuscode.md) to set on the order for additional order status context |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetPaymentCountryRegion (1 of 2)

Sets the payment [`Country`](country.md) and [`Region`](region.md) of the order

```csharp
public Order SetPaymentCountryRegion(CountryReadOnly country, RegionReadOnly region = null)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| country | The payment [`Country`](country.md) to set the order to |
| region | The payment [`Region`](region.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetPaymentCountryRegion (2 of 2)

Sets the payment [`Country`](country.md) and [`Region`](region.md) of the order

```csharp
public Order SetPaymentCountryRegion(Guid? countryId, Guid? regionId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryId | The ID of the payment [`Country`](country.md) to set the order to |
| regionId | The ID of the payment [`Region`](region.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetPaymentMethod (1 of 2)

Sets the [`PaymentMethod`](paymentmethod.md) of the order

```csharp
public Order SetPaymentMethod(PaymentMethodReadOnly paymentMethod)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| paymentMethod | The [`PaymentMethod`](paymentmethod.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetPaymentMethod (2 of 2)

Sets the [`PaymentMethod`](paymentmethod.md) of the order

```csharp
public Order SetPaymentMethod(Guid? paymentMethodId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| paymentMethodId | The ID of the [`PaymentMethod`](paymentmethod.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetProperties (1 of 2)

Sets a series of properties on the order

```csharp
public Order SetProperties(IDictionary<string, string> properties, 
    SetBehavior setBehavior = SetBehavior.Merge)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| properties | The properties to set |
| setBehavior | The behavior of the set operation, whether to `Merge` the properties into the orders existing properties collection or `Replace` the orders property collection entirely |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetProperties (2 of 2)

Sets a series of properties on the order

```csharp
public Order SetProperties(IDictionary<string, PropertyValue> properties, 
    SetBehavior setBehavior = SetBehavior.Merge)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| properties | The properties to set |
| setBehavior | The behavior of the set operation, whether to `Merge` the properties into the orders existing properties collection or `Replace` the orders property collection entirely |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetProperty (1 of 2)

Sets a property on the order

```csharp
public Order SetProperty(string alias, string value)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| alias | The alias of the property to set |
| value | The value of the property |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetProperty (2 of 2)

Sets a property on the order

```csharp
public Order SetProperty(string alias, PropertyValue value)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| alias | The alias of the property to set |
| value | The [`PropertyValue`](propertyvalue.md) of the property |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetShippingCountryRegion (1 of 2)

Sets the shipping [`Country`](country.md) and [`Region`](region.md) of the order

```csharp
public Order SetShippingCountryRegion(CountryReadOnly country, RegionReadOnly region = null)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| country | The shipping [`Country`](country.md) to set the order to |
| region | The shipping [`Region`](region.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetShippingCountryRegion (2 of 2)

Sets the shipping [`Country`](country.md) and [`Region`](region.md) of the order

```csharp
public Order SetShippingCountryRegion(Guid? countryId, Guid? regionId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryId | The ID of the shipping [`Country`](country.md) to set the order to |
| regionId | The ID of the shipping [`Region`](region.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetShippingMethod (1 of 2)

Sets the [`ShippingMethod`](shippingmethod.md) of the order

```csharp
public Order SetShippingMethod(ShippingMethodReadOnly shippingMethod)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| shippingMethod | The [`ShippingMethod`](shippingmethod.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetShippingMethod (2 of 2)

Sets the [`ShippingMethod`](shippingmethod.md) of the order

```csharp
public Order SetShippingMethod(Guid? shippingMethodId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| shippingMethodId | The ID of the [`ShippingMethod`](shippingmethod.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetTags

Sets the rags of the order

```csharp
public Order SetTags(IEnumerable<string> tags, SetBehavior setBehavior = SetBehavior.Replace)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| tags | The tags to remove |
| setBehavior | The behavior of the set operation, whether to `Merge` the tags into the orders existing tags collection or `Replace` the orders tags collection entirely |

**Returns**

The updated [`Order`](order.md) entity


---

#### SetTaxClass (1 of 2)

Sets the [`TaxClass`](taxclass.md) of the order

```csharp
public Order SetTaxClass(TaxClassReadOnly taxClass)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| taxClass | The [`TaxClass`](taxclass.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity

---

#### SetTaxClass (2 of 2)

Sets the [`TaxClass`](taxclass.md) of the order

```csharp
public Order SetTaxClass(Guid taxClassId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| taxClassId | The ID of the [`TaxClass`](taxclass.md) to set the order to |

**Returns**

The updated [`Order`](order.md) entity


---

#### UnassignFromCustomer

Unassigns the order from a customer

```csharp
public Order UnassignFromCustomer()
```

**Returns**

The updated [`Order`](order.md) entity


---

#### Unredeem

Unredeems a [`Discount`](discount.md) or [`GiftCard`](giftcard.md) from the order

```csharp
public Order Unredeem(string discountOrGiftCardCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| discountOrGiftCardCode | The [`Discount`](discount.md) or [`GiftCard`](giftcard.md) code |

**Returns**

The updated [`Order`](order.md) entity


---

#### UpdateTransaction (1 of 2)

Updates the transaction info of the order

```csharp
public Order UpdateTransaction(decimal amountAuthorized, string transactionId, 
    PaymentStatus paymentStatus)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| amountAuthorized | The amount authorized by the payment gateway |
| transactionId | The ID of the transaction from the payment gateway |
| paymentStatus | The status of the payment |

**Returns**

The updated [`Order`](order.md) entity

---

#### UpdateTransaction (2 of 2)

Updates the transaction info of the order

```csharp
public Order UpdateTransaction(decimal amountAuthorized, decimal transactionFee, 
    string transactionId, PaymentStatus paymentStatus)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| amountAuthorized | The amount authorized by the payment gateway |
| transactionFee | The transaction fee charged by the payment gateway |
| transactionId | The ID of the transaction from the payment gateway |
| paymentStatus | The status of the payment |

**Returns**

The updated [`Order`](order.md) entity


---

#### WithOrderLine (1 of 2)

Gets the fluent write context of an order line

```csharp
public OrderLineContext WithOrderLine(OrderLineReadOnly orderLine)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderLine | The order line to get the fluent write context for |

**Returns**

An [`OrderLineContext`](order-orderlinecontext.md)

---

#### WithOrderLine (2 of 2)

Gets the fluent write context of an order line

```csharp
public OrderLineContext WithOrderLine(Guid orderLineId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderLineId | The ID of an order line to get the fluent write context for |

**Returns**

An [`OrderLineContext`](order-orderlinecontext.md)


### Classes

#### Order.OrderLineContext

The fluent write context for an order line

```csharp
public class OrderLineContext
```

##### Methods

#### DecrementQuantity

Decrements the quantity of the order line

```csharp
public OrderLineContext DecrementQuantity(decimal qty)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| qty | The amount to decrement the order line quantity by |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance


---

#### IncrementQuantity

Increments the quantity of the order line

```csharp
public OrderLineContext IncrementQuantity(decimal qty)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| qty | The amount to increment the order line quantity by |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance


---

#### RemoveProperties

Removes a series of properties from the order line

```csharp
public OrderLineContext RemoveProperties(IEnumerable<string> aliases)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| aliases | The aliases of the properties to remove |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance


---

#### RemoveProperty

Removes a property from the order line

```csharp
public OrderLineContext RemoveProperty(string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| alias | The alias of the property to remove |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance


---

#### SetProperties (1 of 2)

Sets a series of properties on the order line

```csharp
public OrderLineContext SetProperties(IDictionary<string, string> properties, 
    SetBehavior setBehavior = SetBehavior.Merge)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| properties | The properties to set |
| setBehavior | The behavior of the set operation, whether to `Merge` the properties into the orders existing properties collection or `Replace` the orders property collection entirely |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance

---

#### SetProperties (2 of 2)

Sets a series of properties on the order line

```csharp
public OrderLineContext SetProperties(IDictionary<string, PropertyValue> properties, 
    SetBehavior setBehavior = SetBehavior.Merge)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| properties | The properties to set |
| setBehavior | The behavior of the set operation, whether to `Merge` the properties into the orders existing properties collection or `Replace` the orders property collection entirely |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance


---

#### SetProperty (1 of 2)

Sets a property on the order line

```csharp
public OrderLineContext SetProperty(string alias, string value)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| alias | The alias of the property to set |
| value | The value of the property |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance

---

#### SetProperty (2 of 2)

Sets a property on the order line

```csharp
public OrderLineContext SetProperty(string alias, PropertyValue value)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| alias | The alias of the property to set |
| value | The [`PropertyValue`](propertyvalue.md) of the property |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance


---

#### SetQuantity

Sets the quantity of the order line

```csharp
public OrderLineContext SetQuantity(decimal qty)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| qty | The amount to set the order line quantity to |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance


---

#### SetTaxClass (1 of 2)

Sets the [`TaxClass`](taxclass.md) of the order line

```csharp
public OrderLineContext SetTaxClass(TaxClassReadOnly taxClass)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| taxClass | The [`TaxClass`](taxclass.md) to set the order to |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance

---

#### SetTaxClass (2 of 2)

Sets the [`TaxClass`](taxclass.md) of the order line

```csharp
public OrderLineContext SetTaxClass(Guid taxClassId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| taxClassId | The ID of the [`TaxClass`](taxclass.md) to set the order to |

**Returns**

The updated [`OrderLineContext`](order-orderlinecontext.md) instance



**Remarks**

See [`OrderExtensions`](../umbraco-commerce-extensions/orderextensions.md) for additional Order methods

<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
