---
title: OrderQuerySpecificationFactory
description: API reference for OrderQuerySpecificationFactory in Umbraco Commerce
---
## OrderQuerySpecificationFactory

```csharp
public class OrderQuerySpecificationFactory : IOrderQuerySpecificationFactory
```

**Inheritance**

* interface [IOrderQuerySpecificationFactory](iorderqueryspecificationfactory.md)

**Namespace**
* [Umbraco.Commerce.Core.Specifications.Order](README.md)

### Constructors

#### OrderQuerySpecificationFactory

The default constructor.

```csharp
public OrderQuerySpecificationFactory()
```


### Methods

#### ByCustomer

```csharp
public IQuerySpecification<OrderReadOnly> ByCustomer(string customerReferenceOrEmail)
```


---

#### CreatedAfter

```csharp
public IQuerySpecification<OrderReadOnly> CreatedAfter(DateTime date)
```


---

#### CreatedBefore

```csharp
public IQuerySpecification<OrderReadOnly> CreatedBefore(DateTime date)
```


---

#### CreatedBetween

```csharp
public IQuerySpecification<OrderReadOnly> CreatedBetween(DateTime fromDate, DateTime toDate)
```


---

#### FromStore

```csharp
public IQuerySpecification<OrderReadOnly> FromStore(Guid storeId)
```


---

#### HasCartNumber

```csharp
public IQuerySpecification<OrderReadOnly> HasCartNumber(string cartNumber, 
    StringComparisonType comparisonType = StringComparisonType.Equals)
```


---

#### HasCustomerEmailAddress

```csharp
public IQuerySpecification<OrderReadOnly> HasCustomerEmailAddress()
```


---

#### HasCustomerEmailAddress

```csharp
public IQuerySpecification<OrderReadOnly> HasCustomerEmailAddress(string email, 
    StringComparisonType comparisonType = StringComparisonType.Equals)
```


---

#### HasCustomerFirstName

```csharp
public IQuerySpecification<OrderReadOnly> HasCustomerFirstName(string firstName, 
    StringComparisonType comparisonType = StringComparisonType.Equals)
```


---

#### HasCustomerLastName

```csharp
public IQuerySpecification<OrderReadOnly> HasCustomerLastName(string lastName, 
    StringComparisonType comparisonType = StringComparisonType.Equals)
```


---

#### HasOrderLines

```csharp
public IQuerySpecification<OrderReadOnly> HasOrderLines()
```


---

#### HasOrderLineWithProduct (1 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasOrderLineWithProduct(string productReferenceOrSku)
```

---

#### HasOrderLineWithProduct (2 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasOrderLineWithProduct(string productReferenceOrSku, 
    string productVariantReferenceOrSku)
```


---

#### HasOrderLineWithProperty (1 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasOrderLineWithProperty(string key, string value, 
    StringComparisonType comparisonType = StringComparisonType.Equals)
```

---

#### HasOrderLineWithProperty (2 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasOrderLineWithProperty(
    KeyValuePair<string, string> property, 
    StringComparisonType comparisonType = StringComparisonType.Equals)
```


---

#### HasOrderNumber

```csharp
public IQuerySpecification<OrderReadOnly> HasOrderNumber(string orderNumber, 
    StringComparisonType comparisonType = StringComparisonType.Equals)
```


---

#### HasOrderStatus (1 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasOrderStatus(Guid orderStatusId)
```

---

#### HasOrderStatus (2 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasOrderStatus(IEnumerable<Guid> orderStatusIds)
```


---

#### HasPaymentMethod (1 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasPaymentMethod(Guid paymentMethodId)
```

---

#### HasPaymentMethod (2 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasPaymentMethod(IEnumerable<Guid> paymentMethodIds)
```


---

#### HasPaymentStatus (1 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasPaymentStatus(PaymentStatus paymentStatus)
```

---

#### HasPaymentStatus (2 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasPaymentStatus(
    IEnumerable<PaymentStatus> paymentStatuses)
```


---

#### HasProperty (1 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasProperty(string key, string value, 
    StringComparisonType comparisonType = StringComparisonType.Equals)
```

---

#### HasProperty (2 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasProperty(KeyValuePair<string, string> property, 
    StringComparisonType comparisonType = StringComparisonType.Equals)
```


---

#### HasShippingMethod (1 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasShippingMethod(Guid shippingMethodId)
```

---

#### HasShippingMethod (2 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> HasShippingMethod(IEnumerable<Guid> shippingMethodIds)
```


---

#### HasTag

```csharp
public IQuerySpecification<OrderReadOnly> HasTag(string tag)
```


---

#### HasTags

```csharp
public IQuerySpecification<OrderReadOnly> HasTags(IEnumerable<string> tags)
```


---

#### InCurrency (1 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> InCurrency(Guid currencyId)
```

---

#### InCurrency (2 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> InCurrency(IEnumerable<Guid> currencyIds)
```


---

#### IsDiscounted (1 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> IsDiscounted(Guid discountId)
```

---

#### IsDiscounted (2 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> IsDiscounted(IEnumerable<Guid> discountIds)
```


---

#### IsFinalized

```csharp
public IQuerySpecification<OrderReadOnly> IsFinalized()
```


---

#### LastUpdatedAfter

```csharp
public IQuerySpecification<OrderReadOnly> LastUpdatedAfter(DateTime date)
```


---

#### LastUpdatedBefore

```csharp
public IQuerySpecification<OrderReadOnly> LastUpdatedBefore(DateTime date)
```


---

#### LastUpdatedBetween

```csharp
public IQuerySpecification<OrderReadOnly> LastUpdatedBetween(DateTime fromDate, DateTime toDate)
```


---

#### PlacedAfter

```csharp
public IQuerySpecification<OrderReadOnly> PlacedAfter(DateTime date)
```


---

#### PlacedBefore

```csharp
public IQuerySpecification<OrderReadOnly> PlacedBefore(DateTime date)
```


---

#### PlacedBetween

```csharp
public IQuerySpecification<OrderReadOnly> PlacedBetween(DateTime fromDate, DateTime toDate)
```


---

#### Redeems (1 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> Redeems(string discountOrGiftCardCode)
```

---

#### Redeems (2 of 2)

```csharp
public IQuerySpecification<OrderReadOnly> Redeems(IEnumerable<string> discountOrGiftCardCodes)
```


---

#### SearchableFieldsMatch

```csharp
public IQuerySpecification<OrderReadOnly> SearchableFieldsMatch(string searchTerm, 
    StringComparisonType comparisonType = StringComparisonType.Equals)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
