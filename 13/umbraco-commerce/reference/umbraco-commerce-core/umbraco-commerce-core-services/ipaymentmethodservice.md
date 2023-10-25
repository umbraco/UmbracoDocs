---
title: IPaymentMethodService
description: API reference for IPaymentMethodService in Umbraco Commerce
---
## IPaymentMethodService

Defines the Payment Method service

```csharp
public interface IPaymentMethodService : ICachedEntityService<PaymentMethodReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### DeletePaymentMethod (1 of 2)

Deletes a [`PaymentMethod`](../umbraco-commerce-core-models/paymentmethod.md)

```csharp
public void DeletePaymentMethod(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`PaymentMethod`](../umbraco-commerce-core-models/paymentmethod.md) to delete |

---

#### DeletePaymentMethod (2 of 2)

Deletes a [`PaymentMethod`](../umbraco-commerce-core-models/paymentmethod.md)

```csharp
public void DeletePaymentMethod(PaymentMethod entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`PaymentMethod`](../umbraco-commerce-core-models/paymentmethod.md) to delete |


---

#### GetPaymentMethod (1 of 2)

Get a [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entity by ID

```csharp
public PaymentMethodReadOnly GetPaymentMethod(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entity to fetch |

**Returns**

A [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entity

---

#### GetPaymentMethod (2 of 2)

Get a [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Alias

```csharp
public PaymentMethodReadOnly GetPaymentMethod(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entity belongs to |
| alias | The Alias of the [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entity to fetch |

**Returns**

A [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entity


---

#### GetPaymentMethods (1 of 2)

Get a list of all [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<PaymentMethodReadOnly> GetPaymentMethods(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entities belong to |

**Returns**

A list of [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entities

---

#### GetPaymentMethods (2 of 2)

Get a list of [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entities with the given IDs

```csharp
public IEnumerable<PaymentMethodReadOnly> GetPaymentMethods(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entities to fetch |

**Returns**

A list of [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entities


---

#### GetPaymentMethodsAllowedIn

Get a list of all [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entities allowed in the given [`Country`](../umbraco-commerce-core-models/country.md) and [`Region`](../umbraco-commerce-core-models/region.md)

```csharp
public IEnumerable<PaymentMethodReadOnly> GetPaymentMethodsAllowedIn(Guid countryId, 
    Guid? regionId = default(Guid?))
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryId | The ID of the [`Country`](../umbraco-commerce-core-models/country.md) the [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entities should be allowed in |
| regionId | The ID of the [`Region`](../umbraco-commerce-core-models/region.md) the [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entities should be allowed in |

**Returns**

A list of [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entities


---

#### PaymentMethodExists

Check to see if a [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given Alias

```csharp
public bool PaymentMethodExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entity belongs to |
| alias | The Alias of the [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) entity to check |

**Returns**

Returns `true` if the [`PaymentMethodReadOnly`](../umbraco-commerce-core-models/paymentmethodreadonly.md) exists, otherwise returns `false`.


---

#### SavePaymentMethod

Saves a [`PaymentMethod`](../umbraco-commerce-core-models/paymentmethod.md)

```csharp
public void SavePaymentMethod(PaymentMethod entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`PaymentMethod`](../umbraco-commerce-core-models/paymentmethod.md) to save |


---

#### SortPaymentMethods

Sorts a list of [`PaymentMethod`](../umbraco-commerce-core-models/paymentmethod.md) entities by ID according to the order of those IDs

```csharp
public void SortPaymentMethods(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`PaymentMethod`](../umbraco-commerce-core-models/paymentmethod.md) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
