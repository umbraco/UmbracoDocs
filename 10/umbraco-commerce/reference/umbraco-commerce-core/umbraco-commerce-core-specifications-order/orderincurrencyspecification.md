---
title: OrderInCurrencySpecification
description: API reference for OrderInCurrencySpecification in Umbraco Commerce
---
## OrderInCurrencySpecification

```csharp
public class OrderInCurrencySpecification : IQuerySpecification<OrderReadOnly>, 
    ISpecification<OrderReadOnly>
```

**Inheritance**

* interface [IQuerySpecification&lt;!0&gt;](../../umbraco-commerce-common/umbraco-commerce-common-specifications/iqueryspecification-1.md)
* interface [ISpecification&lt;!0&gt;](../../umbraco-commerce-common/umbraco-commerce-common-specifications/ispecification-1.md)

**Namespace**
* [Umbraco.Commerce.Core.Specifications.Order](README.md)

### Constructors

#### OrderInCurrencySpecification (1 of 2)

```csharp
public OrderInCurrencySpecification(Guid currencyId)
```

---

#### OrderInCurrencySpecification (2 of 2)

```csharp
public OrderInCurrencySpecification(IEnumerable<Guid> currencyIds)
```


### Properties

#### CurrencyIds

```csharp
public IEnumerable<Guid> CurrencyIds { get; }
```


### Methods

#### Accept

```csharp
public void Accept(IVisitor visitor)
```


---

#### IsSatisfiedBy

```csharp
public bool IsSatisfiedBy(OrderReadOnly item)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
