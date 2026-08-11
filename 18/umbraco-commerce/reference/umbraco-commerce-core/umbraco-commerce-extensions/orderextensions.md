---
title: OrderExtensions
description: API reference for OrderExtensions in Umbraco Commerce
---
## OrderExtensions

Extension methods for an Order

```csharp
public static class OrderExtensions
```

**Namespace**
* [Umbraco.Commerce.Extensions](README.md)

### Methods

#### AddProduct (1 of 12)

Adds a product to the order

```csharp
public static Order AddProduct(this Order order, string productReference, decimal qty)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productReference | The unique reference of the product |
| qty | The quantity of the product to add to the order |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (2 of 12)

Adds a product variant to the order

```csharp
public static Order AddProduct(this Order order, string productReference, 
    string productVariantReference, decimal qty)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productReference | The unique reference of the product |
| productVariantReference | The unique reference of the product variant |
| qty | The quantity of the product to add to the order |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (3 of 12)

Adds a product to the order

```csharp
public static Order AddProduct(this Order order, string productReference, decimal qty, 
    string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productReference | The unique reference of the product |
| qty | The quantity of the product to add to the order |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (4 of 12)

Adds a product variant to the order

```csharp
public static Order AddProduct(this Order order, string productReference, 
    string productVariantReference, decimal qty, string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productReference | The unique reference of the product |
| productVariantReference | The unique reference of the product variant |
| qty | The quantity of the product to add to the order |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (5 of 12)

Adds a product to the order

```csharp
public static Order AddProduct(this Order order, string productReference, decimal qty, 
    IDictionary<string, string> properties)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productReference | The unique reference of the product |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (6 of 12)

Adds a product variant to the order

```csharp
public static Order AddProduct(this Order order, string productReference, 
    string productVariantReference, decimal qty, IDictionary<string, string> properties)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productReference | The unique reference of the product |
| productVariantReference | The unique reference of the product variant |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (7 of 12)

Adds a product to the order

```csharp
public static Order AddProduct(this Order order, string productReference, decimal qty, 
    IDictionary<string, string> properties, string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productReference | The unique reference of the product |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (8 of 12)

Adds a product variant to the order

```csharp
public static Order AddProduct(this Order order, string productReference, 
    string productVariantReference, decimal qty, IDictionary<string, string> properties, 
    string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productReference | The unique reference of the product |
| productVariantReference | The unique reference of the product variant |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (9 of 12)

Adds a product to the order

```csharp
public static Order AddProduct(this Order order, IProductSnapshot productSnapshot, decimal qty)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productSnapshot | A snapshot of the product to add |
| qty | The quantity of the product to add to the order |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (10 of 12)

Adds a product to the order

```csharp
public static Order AddProduct(this Order order, IProductSnapshot productSnapshot, decimal qty, 
    string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productSnapshot | A snapshot of the product to add |
| qty | The quantity of the product to add to the order |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (11 of 12)

Adds a product to the order

```csharp
public static Order AddProduct(this Order order, IProductSnapshot productSnapshot, decimal qty, 
    IDictionary<string, string> properties)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productSnapshot | A snapshot of the product to add |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProduct (12 of 12)

Adds a product to the order

```csharp
public static Order AddProduct(this Order order, IProductSnapshot productSnapshot, decimal qty, 
    IDictionary<string, string> properties, string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| productSnapshot | A snapshot of the product to add |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity


---

#### AddProductToBundle (1 of 12)

Adds a product to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    string productReference, decimal qty)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productReference | The unique reference of the product |
| qty | The quantity of the product to add to the order |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (2 of 12)

Adds a product variant to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    string productReference, string productVariantReference, decimal qty)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productReference | The unique reference of the product |
| productVariantReference | The unique reference of the product variant |
| qty | The quantity of the product to add to the order |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (3 of 12)

Adds a product to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    string productReference, decimal qty, string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productReference | The unique reference of the product |
| qty | The quantity of the product to add to the order |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (4 of 12)

Adds a product variant to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    string productReference, string productVariantReference, decimal qty, string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productReference | The unique reference of the product |
| productVariantReference | The unique reference of the product variant |
| qty | The quantity of the product to add to the order |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (5 of 12)

Adds a product to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    string productReference, decimal qty, IDictionary<string, string> properties)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productReference | The unique reference of the product |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (6 of 12)

Adds a product variant to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    string productReference, string productVariantReference, decimal qty, 
    IDictionary<string, string> properties)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productReference | The unique reference of the product |
| productVariantReference | The unique reference of the product variant |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (7 of 12)

Adds a product to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    string productReference, decimal qty, IDictionary<string, string> properties, string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productReference | The unique reference of the product |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (8 of 12)

Adds a product variant to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    string productReference, string productVariantReference, decimal qty, 
    IDictionary<string, string> properties, string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productReference | The unique reference of the product |
| productVariantReference | The unique reference of the product variant |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (9 of 12)

Adds a product to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    IProductSnapshot productSnapshot, decimal qty)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productSnapshot | A snapshot of the product to add |
| qty | The quantity of the product to add to the order |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (10 of 12)

Adds a product to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    IProductSnapshot productSnapshot, decimal qty, string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productSnapshot | A snapshot of the product to add |
| qty | The quantity of the product to add to the order |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (11 of 12)

Adds a product to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    IProductSnapshot productSnapshot, decimal qty, IDictionary<string, string> properties)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productSnapshot | A snapshot of the product to add |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### AddProductToBundle (12 of 12)

Adds a product to a bundle in the order

```csharp
public static Order AddProductToBundle(this Order order, string parentBundleId, 
    IProductSnapshot productSnapshot, decimal qty, IDictionary<string, string> properties, 
    string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| parentBundleId | The bundle ID of an existing bundle order line to assign the product order line to as a bundle item |
| productSnapshot | A snapshot of the product to add |
| qty | The quantity of the product to add to the order |
| properties | A collection of properties to assign to the product order line |
| bundleId | A bundle ID to assign to the product order line to identify it as a bundle |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity


---

#### ApplyPaymentChanges

Applies the changes from a Payment Result to an order

```csharp
public static Order ApplyPaymentChanges(this Order order, PaymentResult result)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The order to update |
| result | The payment result changes to apply |

**Returns**

The updated order


---

#### FinalizeOrUpdateTransaction (1 of 2)

Finalizes or updates the transaction info of the order

```csharp
public static Order FinalizeOrUpdateTransaction(this Order order, decimal amountAuthorized, 
    string transactionId, PaymentStatus paymentStatus)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| amountAuthorized | The amount authorized by the payment gateway |
| transactionId | The ID of the transaction from the payment gateway |
| paymentStatus | The status of the payment |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### FinalizeOrUpdateTransaction (2 of 2)

Finalizes or updates the transaction info of the order

```csharp
public static Order FinalizeOrUpdateTransaction(this Order order, decimal amountAuthorized, 
    decimal transactionFee, string transactionId, PaymentStatus paymentStatus)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| amountAuthorized | The amount authorized by the payment gateway |
| transactionFee | The transaction fee charged by the payment gateway |
| transactionId | The ID of the transaction from the payment gateway |
| paymentStatus | The status of the payment |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity


---

#### GetTotalAmountAdjustmentByType&lt;T&gt;

Gets the total amount adjustment for a given amount adjustment type

```csharp
public static Amount GetTotalAmountAdjustmentByType<T>(this OrderReadOnly order)
    where T : AmountAdjustment
```

**Parameters**

| Parameter | Description |
| --- | --- |
| T | The type of the amount adjustment |
| order | The order to fetch the amount adjustments from |

**Returns**

The amount of the amount adjustments


---

#### GetTotalAmountAdjustmentWhere

Gets the total amount adjustment where amount adjustments match the supplied predicate

```csharp
public static Amount GetTotalAmountAdjustmentWhere(this OrderReadOnly order, 
    Func<AmountAdjustment, bool> predicate)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The order to fetch the amount adjustments from |
| predicate | The predicate function to include/exclude the amount adjustment |

**Returns**

The amount of the amount adjustments


---

#### GetTotalPriceAdjustmentByType&lt;T&gt;

Gets the total price adjustment for a given price adjustment type

```csharp
public static Price GetTotalPriceAdjustmentByType<T>(this OrderReadOnly order)
    where T : PriceAdjustment
```

**Parameters**

| Parameter | Description |
| --- | --- |
| T | The type of the price adjustment |
| order | The order to fetch the price adjustments from |

**Returns**

The price of the price adjustments


---

#### GetTotalPriceAdjustmentWhere

Gets the total price adjustment where price adjustments match the supplied predicate

```csharp
public static Price GetTotalPriceAdjustmentWhere(this OrderReadOnly order, 
    Func<PriceAdjustment, bool> predicate)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The order to fetch the price adjustments from |
| predicate | The predicate function to include/exclude the price adjustment |

**Returns**

The price of the price adjustments


---

#### InitializeTransaction

Initializes a transaction ready to send to the payment gateway

```csharp
public static Order InitializeTransaction(this Order order)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity


---

#### Recalculate (1 of 2)

Recalculates the order

```csharp
public static Order Recalculate(this Order order)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity

---

#### Recalculate (2 of 2)

Recalculates the order

```csharp
public static Order Recalculate(this Order order, bool force)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| force | A boolean flag indicating whether to force recalculation whether the order needs recalculating or not |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity


---

#### Redeem

Redeems a [`Discount`](../umbraco-commerce-core-models/discount.md) or [`GiftCard`](../umbraco-commerce-core-models/giftcard.md) against the order

```csharp
public static Order Redeem(this Order order, string discountOrGiftCardCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) instance |
| discountOrGiftCardCode | The [`Discount`](../umbraco-commerce-core-models/discount.md) or [`GiftCard`](../umbraco-commerce-core-models/giftcard.md) code |

**Returns**

The updated [`Order`](../umbraco-commerce-core-models/order.md) entity


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
