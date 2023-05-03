---
title: IShippingMethodService
description: API reference for IShippingMethodService in Vendr, the eCommerce solution for Umbraco
---
## IShippingMethodService

Defines the Vendr Shipping Method service

```csharp
public interface IShippingMethodService : ICachedEntityService<ShippingMethodReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](../icachedentityservice-1/)
* interface [IService](../iservice/)

**Namespace**
* [Vendr.Core.Services](../)

### Methods

#### DeleteShippingMethod (1 of 2)

Deletes a [`ShippingMethod`](../../vendr-core-models/shippingmethod/)

```csharp
public void DeleteShippingMethod(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ShippingMethod`](../../vendr-core-models/shippingmethod/) to delete |

---

#### DeleteShippingMethod (2 of 2)

Deletes a [`ShippingMethod`](../../vendr-core-models/shippingmethod/)

```csharp
public void DeleteShippingMethod(ShippingMethod entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ShippingMethod`](../../vendr-core-models/shippingmethod/) to delete |


---

#### GetShippingMethod (1 of 2)

Get a [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entity by ID

```csharp
public ShippingMethodReadOnly GetShippingMethod(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entity to fetch |

**Returns**

A [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entity

---

#### GetShippingMethod (2 of 2)

Get a [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entity by [`Store`](../../vendr-core-models/store/) and Alias

```csharp
public ShippingMethodReadOnly GetShippingMethod(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entity belongs to |
| alias | The Alias of the [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entity to fetch |

**Returns**

A [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entity


---

#### GetShippingMethods (1 of 2)

Get a list of all [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<ShippingMethodReadOnly> GetShippingMethods(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entities belong to |

**Returns**

A list of [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entities

---

#### GetShippingMethods (2 of 2)

Get a list of [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entities with the given IDs

```csharp
public IEnumerable<ShippingMethodReadOnly> GetShippingMethods(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entities to fetch |

**Returns**

A list of [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entities


---

#### GetShippingMethodsAllowedIn

Get a list of all [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entities allowed in the given [`Country`](../../vendr-core-models/country/) and [`Region`](../../vendr-core-models/region/)

```csharp
public IEnumerable<ShippingMethodReadOnly> GetShippingMethodsAllowedIn(Guid countryId, 
    Guid? regionId = default(Guid?))
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryId | The ID of the [`Country`](../../vendr-core-models/country/) the [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entities should be allowed in |
| regionId | The ID of the [`Region`](../../vendr-core-models/region/) the [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entities should be allowed in |

**Returns**

A list of [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entities


---

#### SaveShippingMethod

Saves a [`ShippingMethod`](../../vendr-core-models/shippingmethod/)

```csharp
public void SaveShippingMethod(ShippingMethod entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ShippingMethod`](../../vendr-core-models/shippingmethod/) to save |


---

#### ShippingMethodExists

Check to see if a [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) exists in the given [`Store`](../../vendr-core-models/store/) with the given Alias

```csharp
public bool ShippingMethodExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entity belongs to |
| alias | The Alias of the [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) entity to check |

**Returns**

Returns `true` if the [`ShippingMethodReadOnly`](../../vendr-core-models/shippingmethodreadonly/) exists, otherwise returns `false`.


---

#### SortShippingMethods

Sorts a list of [`ShippingMethod`](../../vendr-core-models/shippingmethod/) entities by ID according to the order of those IDs

```csharp
public void SortShippingMethods(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`ShippingMethod`](../../vendr-core-models/shippingmethod/) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
