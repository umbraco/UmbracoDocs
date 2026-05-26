---
title: ICurrencyService
description: API reference for ICurrencyService in Umbraco Commerce
---
## ICurrencyService

Defines the Currency service

```csharp
public interface ICurrencyService : ICachedEntityService<CurrencyReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### CurrencyExists

Check to see if a [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given ISO Code

```csharp
public bool CurrencyExists(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entity belongs to |
| code | The ISO Code of the [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entity to check |

**Returns**

Returns `true` if the [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) exists, otherwise returns `false`.


---

#### DeleteCurrency (1 of 2)

Deletes a [`Currency`](../umbraco-commerce-core-models/currency.md)

```csharp
public void DeleteCurrency(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) to delete |

---

#### DeleteCurrency (2 of 2)

Deletes a [`Currency`](../umbraco-commerce-core-models/currency.md)

```csharp
public void DeleteCurrency(Currency entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Currency`](../umbraco-commerce-core-models/currency.md) to delete |


---

#### GetCurrencies (1 of 2)

Get a list of all [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<CurrencyReadOnly> GetCurrencies(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entities belong to |

**Returns**

A list of [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entities

---

#### GetCurrencies (2 of 2)

Get a list of [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entities with the given IDs

```csharp
public IEnumerable<CurrencyReadOnly> GetCurrencies(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entities to fetch |

**Returns**

A list of [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entities


---

#### GetCurrenciesAllowedIn

Get a list of all [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entities allowed in the given [`Country`](../umbraco-commerce-core-models/country.md)

```csharp
public IEnumerable<CurrencyReadOnly> GetCurrenciesAllowedIn(Guid countryId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryId | The ID of the [`Country`](../umbraco-commerce-core-models/country.md) the [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entity should be allowed in |

**Returns**

A list of [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entities


---

#### GetCurrency (1 of 2)

Get a [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entity by ID

```csharp
public CurrencyReadOnly GetCurrency(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entity to fetch |

**Returns**

A [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entity

---

#### GetCurrency (2 of 2)

Get a [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and ISO Code

```csharp
public CurrencyReadOnly GetCurrency(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entity belongs to |
| code | The ISO Code of the [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entity to fetch |

**Returns**

A [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) entity


---

#### SaveCurrency

Saves a [`Currency`](../umbraco-commerce-core-models/currency.md)

```csharp
public void SaveCurrency(Currency entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Currency`](../umbraco-commerce-core-models/currency.md) to save |


---

#### SortCurrencies

Sorts a list of [`Currency`](../umbraco-commerce-core-models/currency.md) entities by ID according to the order of those IDs

```csharp
public void SortCurrencies(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`Currency`](../umbraco-commerce-core-models/currency.md) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
