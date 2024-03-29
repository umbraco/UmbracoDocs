---
title: GiftCardFromOrderSpecification
description: API reference for GiftCardFromOrderSpecification in Umbraco Commerce
---
## GiftCardFromOrderSpecification

```csharp
public class GiftCardFromOrderSpecification : IQuerySpecification<GiftCardReadOnly>, 
    ISpecification<GiftCardReadOnly>
```

**Inheritance**

* interface [IQuerySpecification&lt;!0&gt;](../../umbraco-commerce-common/umbraco-commerce-common-specifications/iqueryspecification-1.md)
* interface [ISpecification&lt;!0&gt;](../../umbraco-commerce-common/umbraco-commerce-common-specifications/ispecification-1.md)

**Namespace**
* [Umbraco.Commerce.Core.Specifications.GiftCard](README.md)

### Constructors

#### GiftCardFromOrderSpecification (1 of 2)

```csharp
public GiftCardFromOrderSpecification(Guid orderId)
```

---

#### GiftCardFromOrderSpecification (2 of 2)

```csharp
public GiftCardFromOrderSpecification(string orderNumber)
```


### Properties

#### OrderId

```csharp
public Guid? OrderId { get; }
```


---

#### OrderNumber

```csharp
public string OrderNumber { get; }
```


### Methods

#### Accept

```csharp
public void Accept(IVisitor visitor)
```


---

#### IsSatisfiedBy

```csharp
public bool IsSatisfiedBy(GiftCardReadOnly item)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
