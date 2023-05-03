---
title: IDiscountService
description: API reference for IDiscountService in Vendr, the eCommerce solution for Umbraco
---
## IDiscountService

Defines the Vendr Discount service

```csharp
public interface IDiscountService : ICachedEntityService<DiscountReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](../icachedentityservice-1/)
* interface [IService](../iservice/)

**Namespace**
* [Vendr.Core.Services](../)

### Methods

#### DeleteDiscount (1 of 2)

Deletes a [`Discount`](../../vendr-core-models/discount/)

```csharp
public void DeleteDiscount(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`Discount`](../../vendr-core-models/discount/) to delete |

---

#### DeleteDiscount (2 of 2)

Deletes a [`Discount`](../../vendr-core-models/discount/)

```csharp
public void DeleteDiscount(Discount entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Discount`](../../vendr-core-models/discount/) to delete |


---

#### DiscountCodeExists

Check to see if a Discount Code already exists in the given [`Store`](../../vendr-core-models/store/)

```csharp
public bool DiscountCodeExists(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity belongs to |
| code | The Discount Code to check |

**Returns**

Returns `true` if the Discount Code exists, otherwise returns `false`.


---

#### DiscountExists

Check to see if a [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) exists in the given [`Store`](../../vendr-core-models/store/) with the given Alias

```csharp
public bool DiscountExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity belongs to |
| alias | The Alias of the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity to check |

**Returns**

Returns `true` if the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) exists, otherwise returns `false`.


---

#### GetActiveDiscounts

Get a list of currently active [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<DiscountReadOnly> GetActiveDiscounts(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entities belong to |

**Returns**

A list of [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entities

**Remarks**

A discount is active if it's Active status is `true` and it's StartDate and ExpiryDate are either `null`, or the current UTC Date Time is between these two dates


---

#### GetDiscount (1 of 2)

Get a [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity by ID

```csharp
public DiscountReadOnly GetDiscount(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity to fetch |

**Returns**

A [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity

---

#### GetDiscount (2 of 2)

Get a [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity by [`Store`](../../vendr-core-models/store/) and Alias

```csharp
public DiscountReadOnly GetDiscount(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity belongs to |
| alias | The Alias of the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity to fetch |

**Returns**

A [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity


---

#### GetDiscountByCode

Get a [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity by [`Store`](../../vendr-core-models/store/) and Discount Code

```csharp
public DiscountReadOnly GetDiscountByCode(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity belongs to |
| code | A Discount Code associated with the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity to fetch |

**Returns**

A [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity


---

#### GetDiscountRewardProviderDefinitions

Get a list of [`DiscountRewardProviderDefinition`](../../vendr-core-discounts-rewards/discountrewardproviderdefinition/) entities for all [`IDiscountRewardProvider`](../../vendr-core-discounts-rewards/idiscountrewardprovider/) instances

```csharp
public IEnumerable<DiscountRewardProviderDefinition> GetDiscountRewardProviderDefinitions()
```

**Returns**

A list of [`DiscountRewardProviderDefinition`](../../vendr-core-discounts-rewards/discountrewardproviderdefinition/) entities


---

#### GetDiscountRewardProviderScaffold

Get a [`DiscountRewardProviderScaffold`](../../vendr-core-discounts-rewards/discountrewardproviderscaffold/) by [`IDiscountRewardProvider`](../../vendr-core-discounts-rewards/idiscountrewardprovider/) Alias

```csharp
public DiscountRewardProviderScaffold GetDiscountRewardProviderScaffold(string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| alias | The Alias of the [`IDiscountRewardProvider`](../../vendr-core-discounts-rewards/idiscountrewardprovider/) to create a [`DiscountRewardProviderScaffold`](../../vendr-core-discounts-rewards/discountrewardproviderscaffold/) for |

**Returns**

A [`DiscountRewardProviderScaffold`](../../vendr-core-discounts-rewards/discountrewardproviderscaffold/)


---

#### GetDiscountRuleProviderDefinitions

Get a list of [`DiscountRuleProviderDefinition`](../../vendr-core-discounts-rules/discountruleproviderdefinition/) entities for all [`IDiscountRuleProvider`](../../vendr-core-discounts-rules/idiscountruleprovider/) instances

```csharp
public IEnumerable<DiscountRuleProviderDefinition> GetDiscountRuleProviderDefinitions()
```

**Returns**

A list of [`DiscountRuleProviderDefinition`](../../vendr-core-discounts-rules/discountruleproviderdefinition/) entities


---

#### GetDiscountRuleProviderScaffold

Get a [`DiscountRuleProviderScaffold`](../../vendr-core-discounts-rules/discountruleproviderscaffold/) by [`IDiscountRuleProvider`](../../vendr-core-discounts-rules/idiscountruleprovider/) Alias

```csharp
public DiscountRuleProviderScaffold GetDiscountRuleProviderScaffold(string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| alias | The Alias of the [`IDiscountRuleProvider`](../../vendr-core-discounts-rules/idiscountruleprovider/) to create a [`DiscountRuleProviderScaffold`](../../vendr-core-discounts-rules/discountruleproviderscaffold/) for |

**Returns**

A [`DiscountRuleProviderScaffold`](../../vendr-core-discounts-rules/discountruleproviderscaffold/)


---

#### GetDiscounts (1 of 2)

Get a list of all [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<DiscountReadOnly> GetDiscounts(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entities belong to |

**Returns**

A list of [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entities

---

#### GetDiscounts (2 of 2)

Get a list of [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entities with the given IDs

```csharp
public IEnumerable<DiscountReadOnly> GetDiscounts(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entities to fetch |

**Returns**

A list of [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entities


---

#### SaveDiscount

Saves a [`Discount`](../../vendr-core-models/discount/)

```csharp
public void SaveDiscount(Discount entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Discount`](../../vendr-core-models/discount/) to save |


---

#### SortDiscounts

Sorts a list of [`Discount`](../../vendr-core-models/discount/) entities by ID according to the order of those IDs

```csharp
public void SortDiscounts(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`Discount`](../../vendr-core-models/discount/) entities to sort, in the order by which to sort them |


---

#### ValidateDiscountCode

Check whether a Discount Code is valid

```csharp
public bool ValidateDiscountCode(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`DiscountReadOnly`](../../vendr-core-models/discountreadonly/) entity belongs to |
| code | The Discount Code to validate |

**Returns**

Returns `true` if the Discount Code is valid, otherwise returns `false`.

**Remarks**

A Discount Code is valid if it's associated Discount has an Active status of `true` and it's StartDate and ExpiryDate are either `null`, or the current UTC Date Time is between these two dates, and the given Discount Code has not yet reached it's usage limit


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
