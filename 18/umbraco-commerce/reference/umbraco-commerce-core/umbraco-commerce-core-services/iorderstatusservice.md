---
title: IOrderStatusService
description: API reference for IOrderStatusService in Umbraco Commerce
---
## IOrderStatusService

Defines the Order Status service

```csharp
public interface IOrderStatusService : ICachedEntityService<OrderStatusReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### DeleteOrderStatus (1 of 2)

Deletes a [`OrderStatus`](../umbraco-commerce-core-models/orderstatus.md)

```csharp
public void DeleteOrderStatus(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`OrderStatus`](../umbraco-commerce-core-models/orderstatus.md) to delete |

---

#### DeleteOrderStatus (2 of 2)

Deletes a [`OrderStatus`](../umbraco-commerce-core-models/orderstatus.md)

```csharp
public void DeleteOrderStatus(OrderStatus entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`OrderStatus`](../umbraco-commerce-core-models/orderstatus.md) to delete |


---

#### GetOrderStatus (1 of 2)

Get a [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entity by ID

```csharp
public OrderStatusReadOnly GetOrderStatus(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entity to fetch |

**Returns**

A [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entity

---

#### GetOrderStatus (2 of 2)

Get a [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Alias

```csharp
public OrderStatusReadOnly GetOrderStatus(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entity belongs to |
| alias | The Alias of the [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entity to fetch |

**Returns**

A [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entity


---

#### GetOrderStatuses (1 of 2)

Get a list of all [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<OrderStatusReadOnly> GetOrderStatuses(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entities belong to |

**Returns**

A list of [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entities

---

#### GetOrderStatuses (2 of 2)

Get a list of [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entities with the given IDs

```csharp
public IEnumerable<OrderStatusReadOnly> GetOrderStatuses(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entities to fetch |

**Returns**

A list of [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entities


---

#### OrderStatusExists

Check to see if a [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given Alias

```csharp
public bool OrderStatusExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entity belongs to |
| alias | The Alias of the [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) entity to check |

**Returns**

Returns `true` if the [`OrderStatusReadOnly`](../umbraco-commerce-core-models/orderstatusreadonly.md) exists, otherwise returns `false`.


---

#### SaveOrderStatus

Saves a [`OrderStatus`](../umbraco-commerce-core-models/orderstatus.md)

```csharp
public void SaveOrderStatus(OrderStatus entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`OrderStatus`](../umbraco-commerce-core-models/orderstatus.md) to save |


---

#### SortOrderStatuses

Sorts a list of [`OrderStatus`](../umbraco-commerce-core-models/orderstatus.md) entities by ID according to the order of those IDs

```csharp
public void SortOrderStatuses(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`OrderStatus`](../umbraco-commerce-core-models/orderstatus.md) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
