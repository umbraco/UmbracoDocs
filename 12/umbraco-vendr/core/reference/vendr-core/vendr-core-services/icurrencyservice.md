---
title: ICurrencyService
description: API reference for ICurrencyService in Vendr, the eCommerce solution for Umbraco
---
## ICurrencyService

Defines the Vendr Currency service

```csharp
public interface ICurrencyService : ICachedEntityService<CurrencyReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](../icachedentityservice-1/)
* interface [IService](../iservice/)

**Namespace**
* [Vendr.Core.Services](../)

### Methods

#### CurrencyExists

Check to see if a [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) exists in the given [`Store`](../../vendr-core-models/store/) with the given ISO Code

```csharp
public bool CurrencyExists(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entity belongs to |
| code | The ISO Code of the [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entity to check |

**Returns**

Returns `true` if the [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) exists, otherwise returns `false`.


---

#### DeleteCurrency (1 of 2)

Deletes a [`Currency`](../../vendr-core-models/currency/)

```csharp
public void DeleteCurrency(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`Currency`](../../vendr-core-models/currency/) to delete |

---

#### DeleteCurrency (2 of 2)

Deletes a [`Currency`](../../vendr-core-models/currency/)

```csharp
public void DeleteCurrency(Currency entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Currency`](../../vendr-core-models/currency/) to delete |


---

#### GetCurrencies (1 of 2)

Get a list of all [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<CurrencyReadOnly> GetCurrencies(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entities belong to |

**Returns**

A list of [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entities

---

#### GetCurrencies (2 of 2)

Get a list of [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entities with the given IDs

```csharp
public IEnumerable<CurrencyReadOnly> GetCurrencies(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entities to fetch |

**Returns**

A list of [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entities


---

#### GetCurrenciesAllowedIn

Get a list of all [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entities allowed in the given [`Country`](../../vendr-core-models/country/)

```csharp
public IEnumerable<CurrencyReadOnly> GetCurrenciesAllowedIn(Guid countryId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryId | The ID of the [`Country`](../../vendr-core-models/country/) the [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entity should be allowed in |

**Returns**

A list of [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entities


---

#### GetCurrency (1 of 2)

Get a [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entity by ID

```csharp
public CurrencyReadOnly GetCurrency(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entity to fetch |

**Returns**

A [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entity

---

#### GetCurrency (2 of 2)

Get a [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entity by [`Store`](../../vendr-core-models/store/) and ISO Code

```csharp
public CurrencyReadOnly GetCurrency(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entity belongs to |
| code | The ISO Code of the [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entity to fetch |

**Returns**

A [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) entity


---

#### SaveCurrency

Saves a [`Currency`](../../vendr-core-models/currency/)

```csharp
public void SaveCurrency(Currency entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Currency`](../../vendr-core-models/currency/) to save |


---

#### SortCurrencies

Sorts a list of [`Currency`](../../vendr-core-models/currency/) entities by ID according to the order of those IDs

```csharp
public void SortCurrencies(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`Currency`](../../vendr-core-models/currency/) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
