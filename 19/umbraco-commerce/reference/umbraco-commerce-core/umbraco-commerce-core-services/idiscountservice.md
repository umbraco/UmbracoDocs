---
title: IDiscountService
description: API reference for IDiscountService in Umbraco Commerce
---
## IDiscountService

Defines the Discount service

```csharp
public interface IDiscountService : ICachedEntityService<DiscountReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### DeleteDiscount (1 of 2)

Deletes a [`Discount`](../umbraco-commerce-core-models/discount.md)

```csharp
public void DeleteDiscount(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`Discount`](../umbraco-commerce-core-models/discount.md) to delete |

---

#### DeleteDiscount (2 of 2)

Deletes a [`Discount`](../umbraco-commerce-core-models/discount.md)

```csharp
public void DeleteDiscount(Discount entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Discount`](../umbraco-commerce-core-models/discount.md) to delete |


---

#### DiscountCodeExists

Check to see if a Discount Code already exists in the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public bool DiscountCodeExists(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity belongs to |
| code | The Discount Code to check |

**Returns**

Returns `true` if the Discount Code exists, otherwise returns `false`.


---

#### DiscountExists

Check to see if a [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given Alias

```csharp
public bool DiscountExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity belongs to |
| alias | The Alias of the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity to check |

**Returns**

Returns `true` if the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) exists, otherwise returns `false`.


---

#### GetActiveDiscounts

Get a list of currently active [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<DiscountReadOnly> GetActiveDiscounts(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entities belong to |

**Returns**

A list of [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entities

**Remarks**

A discount is active if it's Active status is `true` and it's StartDate and ExpiryDate are either `null`, or the current UTC Date Time is between these two dates


---

#### GetDiscount (1 of 2)

Get a [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity by ID

```csharp
public DiscountReadOnly GetDiscount(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity to fetch |

**Returns**

A [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity

---

#### GetDiscount (2 of 2)

Get a [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Alias

```csharp
public DiscountReadOnly GetDiscount(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity belongs to |
| alias | The Alias of the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity to fetch |

**Returns**

A [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity


---

#### GetDiscountByCode

Get a [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Discount Code

```csharp
public DiscountReadOnly GetDiscountByCode(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity belongs to |
| code | A Discount Code associated with the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity to fetch |

**Returns**

A [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity


---

#### GetDiscountRewardProviderDefinitions

Get a list of [`DiscountRewardProviderDefinition`](../umbraco-commerce-core-discounts-rewards/discountrewardproviderdefinition.md) entities for all [`IDiscountRewardProvider`](../umbraco-commerce-core-discounts-rewards/idiscountrewardprovider.md) instances

```csharp
public IEnumerable<DiscountRewardProviderDefinition> GetDiscountRewardProviderDefinitions()
```

**Returns**

A list of [`DiscountRewardProviderDefinition`](../umbraco-commerce-core-discounts-rewards/discountrewardproviderdefinition.md) entities


---

#### GetDiscountRewardProviderScaffold

Get a [`DiscountRewardProviderScaffold`](../umbraco-commerce-core-discounts-rewards/discountrewardproviderscaffold.md) by [`IDiscountRewardProvider`](../umbraco-commerce-core-discounts-rewards/idiscountrewardprovider.md) Alias

```csharp
public DiscountRewardProviderScaffold GetDiscountRewardProviderScaffold(string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| alias | The Alias of the [`IDiscountRewardProvider`](../umbraco-commerce-core-discounts-rewards/idiscountrewardprovider.md) to create a [`DiscountRewardProviderScaffold`](../umbraco-commerce-core-discounts-rewards/discountrewardproviderscaffold.md) for |

**Returns**

A [`DiscountRewardProviderScaffold`](../umbraco-commerce-core-discounts-rewards/discountrewardproviderscaffold.md)


---

#### GetDiscountRuleProviderDefinitions

Get a list of [`DiscountRuleProviderDefinition`](../umbraco-commerce-core-discounts-rules/discountruleproviderdefinition.md) entities for all [`IDiscountRuleProvider`](../umbraco-commerce-core-discounts-rules/idiscountruleprovider.md) instances

```csharp
public IEnumerable<DiscountRuleProviderDefinition> GetDiscountRuleProviderDefinitions()
```

**Returns**

A list of [`DiscountRuleProviderDefinition`](../umbraco-commerce-core-discounts-rules/discountruleproviderdefinition.md) entities


---

#### GetDiscountRuleProviderScaffold

Get a [`DiscountRuleProviderScaffold`](../umbraco-commerce-core-discounts-rules/discountruleproviderscaffold.md) by [`IDiscountRuleProvider`](../umbraco-commerce-core-discounts-rules/idiscountruleprovider.md) Alias

```csharp
public DiscountRuleProviderScaffold GetDiscountRuleProviderScaffold(string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| alias | The Alias of the [`IDiscountRuleProvider`](../umbraco-commerce-core-discounts-rules/idiscountruleprovider.md) to create a [`DiscountRuleProviderScaffold`](../umbraco-commerce-core-discounts-rules/discountruleproviderscaffold.md) for |

**Returns**

A [`DiscountRuleProviderScaffold`](../umbraco-commerce-core-discounts-rules/discountruleproviderscaffold.md)


---

#### GetDiscounts (1 of 2)

Get a list of all [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<DiscountReadOnly> GetDiscounts(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entities belong to |

**Returns**

A list of [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entities

---

#### GetDiscounts (2 of 2)

Get a list of [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entities with the given IDs

```csharp
public IEnumerable<DiscountReadOnly> GetDiscounts(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entities to fetch |

**Returns**

A list of [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entities


---

#### SaveDiscount

Saves a [`Discount`](../umbraco-commerce-core-models/discount.md)

```csharp
public void SaveDiscount(Discount entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Discount`](../umbraco-commerce-core-models/discount.md) to save |


---

#### SortDiscounts

Sorts a list of [`Discount`](../umbraco-commerce-core-models/discount.md) entities by ID according to the order of those IDs

```csharp
public void SortDiscounts(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`Discount`](../umbraco-commerce-core-models/discount.md) entities to sort, in the order by which to sort them |


---

#### ValidateDiscountCode

Check whether a Discount Code is valid

```csharp
public bool ValidateDiscountCode(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`DiscountReadOnly`](../umbraco-commerce-core-models/discountreadonly.md) entity belongs to |
| code | The Discount Code to validate |

**Returns**

Returns `true` if the Discount Code is valid, otherwise returns `false`.

**Remarks**

A Discount Code is valid if it's associated Discount has an Active status of `true` and it's StartDate and ExpiryDate are either `null`, or the current UTC Date Time is between these two dates, and the given Discount Code has not yet reached it's usage limit


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
