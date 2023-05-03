---
title: IPaymentMethodService
description: API reference for IPaymentMethodService in Vendr, the eCommerce solution for Umbraco
---
## IPaymentMethodService

Defines the Vendr Payment Method service

```csharp
public interface IPaymentMethodService : ICachedEntityService<PaymentMethodReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](../icachedentityservice-1/)
* interface [IService](../iservice/)

**Namespace**
* [Vendr.Core.Services](../)

### Methods

#### DeletePaymentMethod (1 of 2)

Deletes a [`PaymentMethod`](../../vendr-core-models/paymentmethod/)

```csharp
public void DeletePaymentMethod(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`PaymentMethod`](../../vendr-core-models/paymentmethod/) to delete |

---

#### DeletePaymentMethod (2 of 2)

Deletes a [`PaymentMethod`](../../vendr-core-models/paymentmethod/)

```csharp
public void DeletePaymentMethod(PaymentMethod entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`PaymentMethod`](../../vendr-core-models/paymentmethod/) to delete |


---

#### GetPaymentMethod (1 of 2)

Get a [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entity by ID

```csharp
public PaymentMethodReadOnly GetPaymentMethod(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entity to fetch |

**Returns**

A [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entity

---

#### GetPaymentMethod (2 of 2)

Get a [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entity by [`Store`](../../vendr-core-models/store/) and Alias

```csharp
public PaymentMethodReadOnly GetPaymentMethod(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entity belongs to |
| alias | The Alias of the [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entity to fetch |

**Returns**

A [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entity


---

#### GetPaymentMethods (1 of 2)

Get a list of all [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<PaymentMethodReadOnly> GetPaymentMethods(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entities belong to |

**Returns**

A list of [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entities

---

#### GetPaymentMethods (2 of 2)

Get a list of [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entities with the given IDs

```csharp
public IEnumerable<PaymentMethodReadOnly> GetPaymentMethods(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entities to fetch |

**Returns**

A list of [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entities


---

#### GetPaymentMethodsAllowedIn

Get a list of all [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entities allowed in the given [`Country`](../../vendr-core-models/country/) and [`Region`](../../vendr-core-models/region/)

```csharp
public IEnumerable<PaymentMethodReadOnly> GetPaymentMethodsAllowedIn(Guid countryId, 
    Guid? regionId = default(Guid?))
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryId | The ID of the [`Country`](../../vendr-core-models/country/) the [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entities should be allowed in |
| regionId | The ID of the [`Region`](../../vendr-core-models/region/) the [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entities should be allowed in |

**Returns**

A list of [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entities


---

#### PaymentMethodExists

Check to see if a [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) exists in the given [`Store`](../../vendr-core-models/store/) with the given Alias

```csharp
public bool PaymentMethodExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entity belongs to |
| alias | The Alias of the [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) entity to check |

**Returns**

Returns `true` if the [`PaymentMethodReadOnly`](../../vendr-core-models/paymentmethodreadonly/) exists, otherwise returns `false`.


---

#### SavePaymentMethod

Saves a [`PaymentMethod`](../../vendr-core-models/paymentmethod/)

```csharp
public void SavePaymentMethod(PaymentMethod entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`PaymentMethod`](../../vendr-core-models/paymentmethod/) to save |


---

#### SortPaymentMethods

Sorts a list of [`PaymentMethod`](../../vendr-core-models/paymentmethod/) entities by ID according to the order of those IDs

```csharp
public void SortPaymentMethods(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`PaymentMethod`](../../vendr-core-models/paymentmethod/) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
