---
title: OrderByCustomerSpecification
description: API reference for OrderByCustomerSpecification in Umbraco Commerce
---
## OrderByCustomerSpecification

```csharp
public class OrderByCustomerSpecification : IQuerySpecification<OrderReadOnly>, 
    ISpecification<OrderReadOnly>
```

**Inheritance**

* interface [IQuerySpecification&lt;!0&gt;](../../umbraco-commerce-common/umbraco-commerce-common-specifications/iqueryspecification-1.md)
* interface [ISpecification&lt;!0&gt;](../../umbraco-commerce-common/umbraco-commerce-common-specifications/ispecification-1.md)

**Namespace**
* [Umbraco.Commerce.Core.Specifications.Order](README.md)

### Constructors

#### OrderByCustomerSpecification

```csharp
public OrderByCustomerSpecification(string customerReferenceOrEmail)
```


### Properties

#### CustomerReferenceOrEmail

```csharp
public string CustomerReferenceOrEmail { get; }
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
