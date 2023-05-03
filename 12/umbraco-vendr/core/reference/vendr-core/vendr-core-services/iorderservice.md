---
title: IOrderService
description: API reference for IOrderService in Vendr, the eCommerce solution for Umbraco
---
## IOrderService

Defines the Vendr Order service

```csharp
public interface IOrderService : ICachedEntityService<OrderReadOnly>, IOrderFinderService, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](../icachedentityservice-1/)
* interface [IOrderFinderService](../iorderfinderservice/)
* interface [IService](../iservice/)

**Namespace**
* [Vendr.Core.Services](../)

### Methods

#### DeleteOrder (1 of 4)

Deletes a [`Order`](../../vendr-core-models/order/)

```csharp
public void DeleteOrder(Guid orderId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) to delete |

---

#### DeleteOrder (2 of 4)

Deletes a [`Order`](../../vendr-core-models/order/)

```csharp
public void DeleteOrder(Order entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Order`](../../vendr-core-models/order/) to delete |

---

#### DeleteOrder (3 of 4)

Deletes a [`Order`](../../vendr-core-models/order/)

```csharp
public void DeleteOrder(Guid orderId, bool revertFinalized)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) to delete |
| revertFinalized | A boolean flag indicating whether to reverse the order finalization, undoing any stock reductions, discount code usages or gift card deductions |

---

#### DeleteOrder (4 of 4)

Deletes a [`Order`](../../vendr-core-models/order/)

```csharp
public void DeleteOrder(Order entity, bool revertFinalized)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Order`](../../vendr-core-models/order/) to delete |
| revertFinalized | A boolean flag indicating whether to reverse the order finalization, undoing any stock reductions, discount code usages or gift card deductions |


---

#### GetAllOrdersForCustomer

Gets a list of all open or finalized [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities for a given customer

```csharp
public IEnumerable<OrderReadOnly> GetAllOrdersForCustomer(Guid storeId, 
    string customerReferenceOrEmail)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities belong to |
| customerReferenceOrEmail | The unique reference or email address of the customer associated with the [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities |

**Returns**

A list of [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities


---

#### GetFinalizedOrderCount

Get the total number of finalized [`Order`](../../vendr-core-models/order/) entities in a given [`Store`](../../vendr-core-models/store/)

```csharp
public long GetFinalizedOrderCount(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) to count from |

**Returns**

A count of the number of finalized [`Order`](../../vendr-core-models/order/) entities in the given [`Store`](../../vendr-core-models/store/)


---

#### GetFinalizedOrdersForCustomer

Gets a list of finalized [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities for a given customer

```csharp
public IEnumerable<OrderReadOnly> GetFinalizedOrdersForCustomer(Guid storeId, 
    string customerReferenceOrEmail)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities belong to |
| customerReferenceOrEmail | The unique reference or email address of the customer associated with the [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities |

**Returns**

A list of [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities


---

#### GetOpenOrdersForCustomer

Gets a list of open [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities for a given customer

```csharp
public IEnumerable<OrderReadOnly> GetOpenOrdersForCustomer(Guid storeId, 
    string customerReferenceOrEmail)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities belong to |
| customerReferenceOrEmail | The unique reference or email address of the customer associated with the [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities |

**Returns**

A list of [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities


---

#### GetOrder (1 of 2)

Get an [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entity by ID

```csharp
public OrderReadOnly GetOrder(Guid orderId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| orderId | The ID of the [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entity to fetch |

**Returns**

An [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entity

---

#### GetOrder (2 of 2)

Get a [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entity by [`Store`](../../vendr-core-models/store/) and cart or order number

```csharp
public OrderReadOnly GetOrder(Guid storeId, string cartOrOrderNumber)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entity belongs to |
| cartOrOrderNumber | The cart or order number to search for |

**Returns**

A [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entity


---

#### GetOrders

Gets a list of [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities matching the given IDs

```csharp
public IEnumerable<OrderReadOnly> GetOrders(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities to fetch |

**Returns**

A list of [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities


---

#### SaveOrder

Saves a [`Order`](../../vendr-core-models/order/)

```csharp
public void SaveOrder(Order entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Order`](../../vendr-core-models/order/) to save |


---

#### SearchOrders (1 of 4)

Search for [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities

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

A paginated list of [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities

---

#### SearchOrders (2 of 4)

Search for [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities

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

A paginated list of [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities

---

#### SearchOrders (3 of 4)

Search for [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities

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

A paginated list of [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities

---

#### SearchOrders (4 of 4)

Search for [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities

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

A paginated list of [`OrderReadOnly`](../../vendr-core-models/orderreadonly/) entities


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
