---
title: OrderReadOnly
description: API reference for OrderReadOnly in Umbraco Commerce
---
## OrderReadOnly

A read only Order entity

```csharp
public class OrderReadOnly : StoreAggregateBase<OrderReadOnly, Order, OrderState>, 
    IHasReadableOrderLines, IHasReadableOrderLines<OrderLineReadOnly>, IHasReadableProperties, 
    ITaggableReadOnlyEntity
```

**Inheritance**

* Class [StoreAggregateBase&lt;TReadOnlySelf,TWritableSelf,TState&gt;](storeaggregatebase-3.md)
* interface [IHasReadableOrderLines](ihasreadableorderlines.md)
* interface [IHasReadableOrderLines&lt;T&gt;](ihasreadableorderlines-1.md)
* interface [IHasReadableProperties](ihasreadableproperties.md)
* interface [ITaggableReadOnlyEntity](itaggablereadonlyentity.md)

**Namespace**
* [Umbraco.Commerce.Core.Models](README.md)

### Properties

#### CartNumber

Gets the Cart Number of the order

```csharp
public string CartNumber { get; }
```


---

#### CopiedFromOrderId

Gets the ID of a parent order this order was copied from

```csharp
public Guid? CopiedFromOrderId { get; }
```


---

#### CreateDate

Gets the DateTime the order was created

```csharp
public DateTime CreateDate { get; }
```


---

#### CurrencyId

Gets the ID of the [`Currency`](currency.md) of the order

```csharp
public Guid CurrencyId { get; }
```


---

#### CustomerInfo

Gets the [`OrderCustomerInfo`](ordercustomerinfo.md) of the order

```csharp
public OrderCustomerInfo CustomerInfo { get; }
```


---

#### DiscountCodes

Gets a list of discount codes applied to the order

```csharp
public IReadOnlyCollection<AppliedDiscountCode> DiscountCodes { get; }
```


---

#### Discounts

Gets a list of discounts applies to the order

```csharp
public IReadOnlyCollection<FulfilledDiscount> Discounts { get; }
```


---

#### FinalizedDate

Gets the DateTime the order was finalized

```csharp
public DateTime? FinalizedDate { get; }
```


---

#### GiftCards

Gets a list of gift cards applied to the order

```csharp
public IReadOnlyCollection<AppliedGiftCard> GiftCards { get; }
```


---

#### IsFinalized

Gets a boolean flag indicating whether the order is finalized

```csharp
public virtual bool IsFinalized { get; }
```


---

#### IsFinalizing

Gets a boolean flag indicating whether the order is currently being finalized

```csharp
public virtual bool IsFinalizing { get; }
```


---

#### IsProcessing

Gets a boolean flag indicating whether the order is currently being processed by a payment gateway

```csharp
public virtual bool IsProcessing { get; }
```


---

#### LanguageIsoCode

Gets the ISO Code of the Language of the order

```csharp
public string LanguageIsoCode { get; }
```


---

#### OrderLines

Gets the order lines of the order

```csharp
public IReadOnlyCollection<OrderLineReadOnly> OrderLines { get; }
```


---

#### OrderNumber

Gets the order Number of the order

```csharp
public string OrderNumber { get; }
```


---

#### OrderStatusCode

Gets the `OrderStatusCode` of the [`OrderStatus`](orderstatus.md) of the order

```csharp
public OrderStatusCode OrderStatusCode { get; }
```


---

#### OrderStatusId

Gets the ID of the [`OrderStatus`](orderstatus.md) of the order

```csharp
public Guid OrderStatusId { get; }
```


---

#### PaymentInfo

Gets the [`OrderPaymentInfo`](orderpaymentinfo.md) of the order

```csharp
public OrderPaymentInfo PaymentInfo { get; }
```


---

#### Properties

Gets the properties collection of the order

```csharp
public IReadOnlyDictionary<string, PropertyValue> Properties { get; }
```


---

#### ShippingInfo

Gets the [`OrderShippingInfo`](ordershippinginfo.md) of the order

```csharp
public OrderShippingInfo ShippingInfo { get; }
```


---

#### SubtotalPrice

Gets the subtotal price of the order

```csharp
public ReadOnlyOrderSubtotalPrice SubtotalPrice { get; }
```


---

#### Tags

Gets the list of tags assigned to this order

```csharp
public virtual IReadOnlyCollection<string> Tags { get; }
```


---

#### TaxClassId

Gets the ID of the [`TaxClass`](taxclass.md) of the order

```csharp
public Guid TaxClassId { get; }
```


---

#### TaxRate

Gets the `TaxRate` of the order

```csharp
public TaxRate TaxRate { get; }
```


---

#### TotalPrice

Gets the total price of the order

```csharp
public ReadOnlyOrderTotalPrice TotalPrice { get; }
```


---

#### TotalQuantity

Gets the total quantity of all order line items in the order

```csharp
public decimal TotalQuantity { get; }
```


---

#### TransactionAmount

Gets the calculated transaction amount for the order

```csharp
public ReadOnlyOrderTransactionAmount TransactionAmount { get; }
```


---

#### TransactionInfo

Gets the [`OrderTransactionInfo`](ordertransactioninfo.md) of the order

```csharp
public OrderTransactionInfo TransactionInfo { get; }
```


---

#### UpdateDate

Gets the DateTime the order was last updated

```csharp
public DateTime UpdateDate { get; }
```


### Methods

#### GetBundle

Gets a bundle order line by bundle ID

```csharp
public BundleOrderLineReadOnly GetBundle(string bundleId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| bundleId | The bundle ID of the order line to fetch |

**Returns**

An [`BundleOrderLineReadOnly`](bundleorderlinereadonly.md) entity for the order line


---

#### GetBundles

Gets a collection of all the bundle order lines present in this order

```csharp
public IReadOnlyCollection<BundleOrderLineReadOnly> GetBundles()
```

**Returns**

An IReadOnlyCollection entity for the order line


---

#### GetOrderLine

Get an order line by ID

```csharp
public OrderLineReadOnly GetOrderLine(Guid orderLineId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderLineId | The ID of the order line to fetch |

**Returns**

An [`OrderLineReadOnly`](orderlinereadonly.md) entity for the order line


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
