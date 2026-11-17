---
title: IShippingMethodService
description: API reference for IShippingMethodService in Umbraco Commerce
---
## IShippingMethodService

Defines the Shipping Method service

```csharp
public interface IShippingMethodService : ICachedEntityService<ShippingMethodReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### DeleteShippingMethod (1 of 2)

Deletes a [`ShippingMethod`](../umbraco-commerce-core-models/shippingmethod.md)

```csharp
public void DeleteShippingMethod(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ShippingMethod`](../umbraco-commerce-core-models/shippingmethod.md) to delete |

---

#### DeleteShippingMethod (2 of 2)

Deletes a [`ShippingMethod`](../umbraco-commerce-core-models/shippingmethod.md)

```csharp
public void DeleteShippingMethod(ShippingMethod entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ShippingMethod`](../umbraco-commerce-core-models/shippingmethod.md) to delete |


---

#### GetShippingMethod (1 of 2)

Get a [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entity by ID

```csharp
public ShippingMethodReadOnly GetShippingMethod(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entity to fetch |

**Returns**

A [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entity

---

#### GetShippingMethod (2 of 2)

Get a [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Alias

```csharp
public ShippingMethodReadOnly GetShippingMethod(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entity belongs to |
| alias | The Alias of the [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entity to fetch |

**Returns**

A [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entity


---

#### GetShippingMethods (1 of 2)

Get a list of all [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<ShippingMethodReadOnly> GetShippingMethods(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entities belong to |

**Returns**

A list of [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entities

---

#### GetShippingMethods (2 of 2)

Get a list of [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entities with the given IDs

```csharp
public IEnumerable<ShippingMethodReadOnly> GetShippingMethods(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entities to fetch |

**Returns**

A list of [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entities


---

#### GetShippingMethodsAllowedIn

Get a list of all [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entities allowed in the given [`Country`](../umbraco-commerce-core-models/country.md) and [`Region`](../umbraco-commerce-core-models/region.md)

```csharp
public IEnumerable<ShippingMethodReadOnly> GetShippingMethodsAllowedIn(Guid countryId, 
    Guid? regionId = default(Guid?))
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryId | The ID of the [`Country`](../umbraco-commerce-core-models/country.md) the [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entities should be allowed in |
| regionId | The ID of the [`Region`](../umbraco-commerce-core-models/region.md) the [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entities should be allowed in |

**Returns**

A list of [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entities


---

#### SaveShippingMethod

Saves a [`ShippingMethod`](../umbraco-commerce-core-models/shippingmethod.md)

```csharp
public void SaveShippingMethod(ShippingMethod entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ShippingMethod`](../umbraco-commerce-core-models/shippingmethod.md) to save |


---

#### ShippingMethodExists

Check to see if a [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given Alias

```csharp
public bool ShippingMethodExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entity belongs to |
| alias | The Alias of the [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) entity to check |

**Returns**

Returns `true` if the [`ShippingMethodReadOnly`](../umbraco-commerce-core-models/shippingmethodreadonly.md) exists, otherwise returns `false`.


---

#### SortShippingMethods

Sorts a list of [`ShippingMethod`](../umbraco-commerce-core-models/shippingmethod.md) entities by ID according to the order of those IDs

```csharp
public void SortShippingMethods(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`ShippingMethod`](../umbraco-commerce-core-models/shippingmethod.md) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
