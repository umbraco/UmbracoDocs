---
title: DiscountRewardCalculation
description: API reference for DiscountRewardCalculation in Umbraco Commerce
---
## DiscountRewardCalculation

```csharp
public class DiscountRewardCalculation
```

**Namespace**
* [Umbraco.Commerce.Core.Discounts.Rewards](README.md)

### Constructors

#### DiscountRewardCalculation

The default constructor.

```csharp
public DiscountRewardCalculation()
```


### Properties

#### OrderLineAdjustments

```csharp
public Dictionary<Guid, OrderLineDiscountRewardCalculation> OrderLineAdjustments { get; }
```


---

#### PaymentTotalPriceAdjustments

```csharp
public List<PriceAdjustment> PaymentTotalPriceAdjustments { get; }
```


---

#### ShippingTotalPriceAdjustments

```csharp
public List<PriceAdjustment> ShippingTotalPriceAdjustments { get; }
```


---

#### SubtotalPriceAdjustments

```csharp
public List<PriceAdjustment> SubtotalPriceAdjustments { get; }
```


---

#### TotalPriceAdjustments

```csharp
public List<PriceAdjustment> TotalPriceAdjustments { get; }
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
