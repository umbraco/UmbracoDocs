---
title: Order
description: API reference for Order in Vendr, the eCommerce solution for Umbraco
---
## Order

A Vendr writable Order entity

```csharp
public class Order : OrderReadOnly, ITaggableWritableEntity<Order>
```

**Inheritance**

* class [OrderReadOnly](../orderreadonly/)
* interface [ITaggableWritableEntity&lt;TEntity&gt;](../itaggablewritableentity-1/)

**Namespace**
* [Vendr.Core.Models](../)

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

Creates a new instance of an [`Order`](../order/)

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
| storeId | The ID of the [`Store`](../store/) the order belongs to |
| languageIsoCode | The ISO Code of the language of the order |
| currencyId | The ID of the [`Currency`](../currency/) of the order |
| taxClassId | The ID of the [`TaxClass`](../taxclass/) of the order |
| orderStatusId | The ID of the [`OrderStatus`](../orderstatus/) of the order |
| paymentMethodId | The ID of the [`PaymentMethod`](../paymentmethod/) of the order |
| paymentCountryId | The ID of the payment [`Country`](../country/) of the order |
| paymentRegionId | The ID of the payment [`Region`](../region/) of the order |
| shippingMethodId | The ID of the [`ShippingMethod`](../shippingmethod/) of the order |
| shippingCountryId | The ID of the shipping [`Country`](../country/) of the order |
| shippingRegionId | The ID of the shipping [`Region`](../region/) of the order |
| customerReference | The unique reference of the customer the order belongs to |

**Returns**

A new [`Order`](../order/) instance

---

#### Create (2 of 2)

Creates a new instance of an [`Order`](../order/)

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
| id | And explicit ID to assign to the [`Order`](../order/) |
| storeId | The ID of the [`Store`](../store/) the order belongs to |
| languageIsoCode | The ISO Code of the language of the order |
| currencyId | The ID of the [`Currency`](../currency/) of the order |
| taxClassId | The ID of the [`TaxClass`](../taxclass/) of the order |
| orderStatusId | The ID of the [`OrderStatus`](../orderstatus/) of the order |
| paymentMethodId | The ID of the [`PaymentMethod`](../paymentmethod/) of the order |
| paymentCountryId | The ID of the payment [`Country`](../country/) of the order |
| paymentRegionId | The ID of the payment [`Region`](../region/) of the order |
| shippingMethodId | The ID of the [`ShippingMethod`](../shippingmethod/) of the order |
| shippingCountryId | The ID of the shipping [`Country`](../country/) of the order |
| shippingRegionId | The ID of the shipping [`Region`](../region/) of the order |
| customerReference | The unique reference of the customer the order belongs to |

**Returns**

A new [`Order`](../order/) instance


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
| productService | A [`IProductService`](../../vendr-core-services/iproductservice/) instance to fetch the product information from |

**Returns**

The updated [`Order`](../order/) entity

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
| productService | A [`IProductService`](../../vendr-core-services/iproductservice/) instance to fetch the product information from |

**Returns**

The updated [`Order`](../order/) entity

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

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity


---

#### ClearPaymentCountryRegion

Clears the payment [`Country`](../country/) and [`Region`](../region/) of the order

```csharp
public Order ClearPaymentCountryRegion()
```

**Returns**

The updated [`Order`](../order/) entity


---

#### ClearPaymentMethod

Clears the current [`PaymentMethod`](../paymentmethod/) of the order

```csharp
public Order ClearPaymentMethod()
```

**Returns**

The updated [`Order`](../order/) entity


---

#### ClearShippingCountryRegion

Clears the shipping [`Country`](../country/) and [`Region`](../region/) of the order

```csharp
public Order ClearShippingCountryRegion()
```

**Returns**

The updated [`Order`](../order/) entity


---

#### ClearShippingMethod

Clears the current [`ShippingMethod`](../shippingmethod/) of the order

```csharp
public Order ClearShippingMethod()
```

**Returns**

The updated [`Order`](../order/) entity


---

#### ClearTags

Clears all the tags assigned to this order

```csharp
public Order ClearTags()
```

**Returns**

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity

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

The updated [`Order`](../order/) entity


---

#### InitializeTransaction

Initializes a transaction ready to send to the payment gateway

```csharp
public Order InitializeTransaction(IOrderNumberGenerator orderNumberGenerator)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderNumberGenerator | The [`IOrderNumberGenerator`](../../vendr-core-generators/iordernumbergenerator/) to use to generate and order number with |

**Returns**

The updated [`Order`](../order/) entity


---

#### Recalculate (1 of 2)

Recalculates the order

```csharp
public Order Recalculate(IOrderCalculator orderCalculator)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderCalculator | A [`IOrderCalculator`](../../vendr-core-calculators/iordercalculator/) instance to use for the calculation |

**Returns**

The updated [`Order`](../order/) entity

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
| orderCalculator | A [`IOrderCalculator`](../../vendr-core-calculators/iordercalculator/) instance to use for the calculation |

**Returns**

The updated [`Order`](../order/) entity


---

#### Redeem

Redeems a [`Discount`](../discount/) or [`GiftCard`](../giftcard/) against the order

```csharp
public Order Redeem(string discountOrGiftCardCode, IDiscountService discountService, 
    IGiftCardService giftCardService)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| discountOrGiftCardCode | The [`Discount`](../discount/) or [`GiftCard`](../giftcard/) code |
| discountService | A [`IDiscountService`](../../vendr-core-services/idiscountservice/) instance to fetch discounts from |
| giftCardService | A [`IGiftCardService`](../../vendr-core-services/igiftcardservice/) instance to fetch gift cards from |

**Returns**

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity

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

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity


---

#### SetCurrency (1 of 2)

Sets the [`Currency`](../currency/) of the order

```csharp
public Order SetCurrency(CurrencyReadOnly currency)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| currency | The [`Currency`](../currency/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity

---

#### SetCurrency (2 of 2)

Sets the [`Currency`](../currency/) of the order

```csharp
public Order SetCurrency(Guid currencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| currencyId | The ID of the [`Currency`](../currency/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity


---

#### SetOrderStatus (1 of 4)

Sets the [`OrderStatus`](../orderstatus/) of the order

```csharp
public Order SetOrderStatus(OrderStatusReadOnly orderStatus)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderStatus | The [`OrderStatus`](../orderstatus/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity

---

#### SetOrderStatus (2 of 4)

Sets the [`OrderStatus`](../orderstatus/) of the order

```csharp
public Order SetOrderStatus(Guid orderStatusId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderStatusId | The ID of the [`OrderStatus`](../orderstatus/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity

---

#### SetOrderStatus (3 of 4)

Sets the [`OrderStatus`](../orderstatus/) of the order

```csharp
public Order SetOrderStatus(OrderStatusReadOnly orderStatus, OrderStatusCode orderStatusCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderStatus | The [`OrderStatus`](../orderstatus/) to set the order to |
| orderStatusCode | An [`OrderStatusCode`](../orderstatuscode/) to set on the order for additional order status context |

**Returns**

The updated [`Order`](../order/) entity

---

#### SetOrderStatus (4 of 4)

Sets the [`OrderStatus`](../orderstatus/) of the order

```csharp
public Order SetOrderStatus(Guid orderStatusId, OrderStatusCode orderStatusCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderStatusId | The ID of the [`OrderStatus`](../orderstatus/) to set the order to |
| orderStatusCode | An [`OrderStatusCode`](../orderstatuscode/) to set on the order for additional order status context |

**Returns**

The updated [`Order`](../order/) entity


---

#### SetPaymentCountryRegion (1 of 2)

Sets the payment [`Country`](../country/) and [`Region`](../region/) of the order

```csharp
public Order SetPaymentCountryRegion(CountryReadOnly country, RegionReadOnly region = null)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| country | The payment [`Country`](../country/) to set the order to |
| region | The payment [`Region`](../region/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity

---

#### SetPaymentCountryRegion (2 of 2)

Sets the payment [`Country`](../country/) and [`Region`](../region/) of the order

```csharp
public Order SetPaymentCountryRegion(Guid? countryId, Guid? regionId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryId | The ID of the payment [`Country`](../country/) to set the order to |
| regionId | The ID of the payment [`Region`](../region/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity


---

#### SetPaymentMethod (1 of 2)

Sets the [`PaymentMethod`](../paymentmethod/) of the order

```csharp
public Order SetPaymentMethod(PaymentMethodReadOnly paymentMethod)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| paymentMethod | The [`PaymentMethod`](../paymentmethod/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity

---

#### SetPaymentMethod (2 of 2)

Sets the [`PaymentMethod`](../paymentmethod/) of the order

```csharp
public Order SetPaymentMethod(Guid? paymentMethodId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| paymentMethodId | The ID of the [`PaymentMethod`](../paymentmethod/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity

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

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity

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
| value | The [`PropertyValue`](../propertyvalue/) of the property |

**Returns**

The updated [`Order`](../order/) entity


---

#### SetShippingCountryRegion (1 of 2)

Sets the shipping [`Country`](../country/) and [`Region`](../region/) of the order

```csharp
public Order SetShippingCountryRegion(CountryReadOnly country, RegionReadOnly region = null)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| country | The shipping [`Country`](../country/) to set the order to |
| region | The shipping [`Region`](../region/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity

---

#### SetShippingCountryRegion (2 of 2)

Sets the shipping [`Country`](../country/) and [`Region`](../region/) of the order

```csharp
public Order SetShippingCountryRegion(Guid? countryId, Guid? regionId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryId | The ID of the shipping [`Country`](../country/) to set the order to |
| regionId | The ID of the shipping [`Region`](../region/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity


---

#### SetShippingMethod (1 of 2)

Sets the [`ShippingMethod`](../shippingmethod/) of the order

```csharp
public Order SetShippingMethod(ShippingMethodReadOnly shippingMethod)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| shippingMethod | The [`ShippingMethod`](../shippingmethod/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity

---

#### SetShippingMethod (2 of 2)

Sets the [`ShippingMethod`](../shippingmethod/) of the order

```csharp
public Order SetShippingMethod(Guid? shippingMethodId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| shippingMethodId | The ID of the [`ShippingMethod`](../shippingmethod/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity


---

#### SetTaxClass (1 of 2)

Sets the [`TaxClass`](../taxclass/) of the order

```csharp
public Order SetTaxClass(TaxClassReadOnly taxClass)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| taxClass | The [`TaxClass`](../taxclass/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity

---

#### SetTaxClass (2 of 2)

Sets the [`TaxClass`](../taxclass/) of the order

```csharp
public Order SetTaxClass(Guid taxClassId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| taxClassId | The ID of the [`TaxClass`](../taxclass/) to set the order to |

**Returns**

The updated [`Order`](../order/) entity


---

#### UnassignFromCustomer

Unassigns the order from a customer

```csharp
public Order UnassignFromCustomer()
```

**Returns**

The updated [`Order`](../order/) entity


---

#### Unredeem

Unredeems a [`Discount`](../discount/) or [`GiftCard`](../giftcard/) from the order

```csharp
public Order Unredeem(string discountOrGiftCardCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| discountOrGiftCardCode | The [`Discount`](../discount/) or [`GiftCard`](../giftcard/) code |

**Returns**

The updated [`Order`](../order/) entity


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

The updated [`Order`](../order/) entity

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

The updated [`Order`](../order/) entity


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

An [`OrderLineContext`](../order-orderlinecontext/)

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

An [`OrderLineContext`](../order-orderlinecontext/)


### Classes

#### Order.OrderLineContext

The fluent write context for a Vendr order line

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

The updated [`OrderLineContext`](../order-orderlinecontext/) instance


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

The updated [`OrderLineContext`](../order-orderlinecontext/) instance


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

The updated [`OrderLineContext`](../order-orderlinecontext/) instance


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

The updated [`OrderLineContext`](../order-orderlinecontext/) instance


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

The updated [`OrderLineContext`](../order-orderlinecontext/) instance

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

The updated [`OrderLineContext`](../order-orderlinecontext/) instance


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

The updated [`OrderLineContext`](../order-orderlinecontext/) instance

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
| value | The [`PropertyValue`](../propertyvalue/) of the property |

**Returns**

The updated [`OrderLineContext`](../order-orderlinecontext/) instance


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

The updated [`OrderLineContext`](../order-orderlinecontext/) instance


---

#### SetTaxClass (1 of 2)

Sets the [`TaxClass`](../taxclass/) of the order line

```csharp
public OrderLineContext SetTaxClass(TaxClassReadOnly taxClass)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| taxClass | The [`TaxClass`](../taxclass/) to set the order to |

**Returns**

The updated [`OrderLineContext`](../order-orderlinecontext/) instance

---

#### SetTaxClass (2 of 2)

Sets the [`TaxClass`](../taxclass/) of the order line

```csharp
public OrderLineContext SetTaxClass(Guid taxClassId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| taxClassId | The ID of the [`TaxClass`](../taxclass/) to set the order to |

**Returns**

The updated [`OrderLineContext`](../order-orderlinecontext/) instance



**Remarks**

See [`OrderExtensions`](../../vendr-extensions/orderextensions/) for additional Order methods

<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
