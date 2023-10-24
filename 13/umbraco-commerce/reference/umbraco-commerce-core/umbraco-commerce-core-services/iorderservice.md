---
title: IOrderService
description: API reference for IOrderService in Umbraco Commerce
---
## IOrderService

Defines the Order service

```csharp
public interface IOrderService : ICachedEntityService<OrderReadOnly>, IOrderFinderService, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IOrderFinderService](iorderfinderservice.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### DeleteOrder (1 of 4)

Deletes a [`Order`](../umbraco-commerce-core-models/order.md)

```csharp
public void DeleteOrder(Guid orderId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) to delete |

---

#### DeleteOrder (2 of 4)

Deletes a [`Order`](../umbraco-commerce-core-models/order.md)

```csharp
public void DeleteOrder(Order entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Order`](../umbraco-commerce-core-models/order.md) to delete |

---

#### DeleteOrder (3 of 4)

Deletes a [`Order`](../umbraco-commerce-core-models/order.md)

```csharp
public void DeleteOrder(Guid orderId, bool revertFinalized)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) to delete |
| revertFinalized | A boolean flag indicating whether to reverse the order finalization, undoing any stock reductions, discount code usages or gift card deductions |

---

#### DeleteOrder (4 of 4)

Deletes a [`Order`](../umbraco-commerce-core-models/order.md)

```csharp
public void DeleteOrder(Order entity, bool revertFinalized)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Order`](../umbraco-commerce-core-models/order.md) to delete |
| revertFinalized | A boolean flag indicating whether to reverse the order finalization, undoing any stock reductions, discount code usages or gift card deductions |


---

#### GetAllOrdersForCustomer

Gets a list of all open or finalized [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities for a given customer

```csharp
public IEnumerable<OrderReadOnly> GetAllOrdersForCustomer(Guid storeId, 
    string customerReferenceOrEmail)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities belong to |
| customerReferenceOrEmail | The unique reference or email address of the customer associated with the [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities |

**Returns**

A list of [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities


---

#### GetFinalizedOrderCount

Get the total number of finalized [`Order`](../umbraco-commerce-core-models/order.md) entities in a given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public long GetFinalizedOrderCount(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) to count from |

**Returns**

A count of the number of finalized [`Order`](../umbraco-commerce-core-models/order.md) entities in the given [`Store`](../umbraco-commerce-core-models/store.md)


---

#### GetFinalizedOrdersForCustomer

Gets a list of finalized [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities for a given customer

```csharp
public IEnumerable<OrderReadOnly> GetFinalizedOrdersForCustomer(Guid storeId, 
    string customerReferenceOrEmail)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities belong to |
| customerReferenceOrEmail | The unique reference or email address of the customer associated with the [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities |

**Returns**

A list of [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities


---

#### GetOpenOrdersForCustomer

Gets a list of open [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities for a given customer

```csharp
public IEnumerable<OrderReadOnly> GetOpenOrdersForCustomer(Guid storeId, 
    string customerReferenceOrEmail)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities belong to |
| customerReferenceOrEmail | The unique reference or email address of the customer associated with the [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities |

**Returns**

A list of [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities


---

#### GetOrder (1 of 2)

Get an [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entity by ID

```csharp
public OrderReadOnly GetOrder(Guid orderId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderId | The ID of the [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entity to fetch |

**Returns**

An [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entity

---

#### GetOrder (2 of 2)

Get a [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and cart or order number

```csharp
public OrderReadOnly GetOrder(Guid storeId, string cartOrOrderNumber)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entity belongs to |
| cartOrOrderNumber | The cart or order number to search for |

**Returns**

A [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entity


---

#### GetOrders

Gets a list of [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities matching the given IDs

```csharp
public IEnumerable<OrderReadOnly> GetOrders(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities to fetch |

**Returns**

A list of [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities


---

#### SaveOrder

Saves a [`Order`](../umbraco-commerce-core-models/order.md)

```csharp
public void SaveOrder(Order entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Order`](../umbraco-commerce-core-models/order.md) to save |


---

#### SearchOrders (1 of 4)

Search for [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities

```csharp
public PagedResult<OrderReadOnly> SearchOrders(IQuerySpecification<OrderReadOnly> query, 
    long currentPage = 1, long itemsPerPage = 50)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| query | The query specification to perform |
| currentPage | The page of results of which to retrieve |
| itemsPerPage | The number of items per page to return |

**Returns**

A paginated list of [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities

---

#### SearchOrders (2 of 4)

Search for [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities

```csharp
public PagedResult<OrderReadOnly> SearchOrders(IQuerySpecification<OrderReadOnly> query, 
    ISortSpecification<OrderReadOnly> sort, long currentPage = 1, long itemsPerPage = 50)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| query | The query specification to perform |
| sort | The sort order specification describinng the sort order in which to return the results |
| currentPage | The page of results of which to retrieve |
| itemsPerPage | The number of items per page to return |

**Returns**

A paginated list of [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities

---

#### SearchOrders (3 of 4)

Search for [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities

```csharp
public PagedResult<OrderReadOnly> SearchOrders(
    Func<IOrderQuerySpecificationFactory, IQuerySpecification<OrderReadOnly>> query, 
    long currentPage = 1, long itemsPerPage = 50)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| query | The factory method to generate the query specification to perform |
| currentPage | The page of results of which to retrieve |
| itemsPerPage | The number of items per page to return |

**Returns**

A paginated list of [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities

---

#### SearchOrders (4 of 4)

Search for [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities

```csharp
public PagedResult<OrderReadOnly> SearchOrders(
    Func<IOrderQuerySpecificationFactory, IQuerySpecification<OrderReadOnly>> query, 
    Func<IOrderSortSpecificationFactory, ISortSpecification<OrderReadOnly>> sort, 
    long currentPage = 1, long itemsPerPage = 50)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| query | The factory method to generate the query specification to perform |
| sort | The factory method to generate the sort order specification describinng the sort order in which to return the results |
| currentPage | The page of results of which to retrieve |
| itemsPerPage | The number of items per page to return |

**Returns**

A paginated list of [`OrderReadOnly`](../umbraco-commerce-core-models/orderreadonly.md) entities


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
