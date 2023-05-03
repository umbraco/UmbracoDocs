---
title: ICountryService
description: API reference for ICountryService in Vendr, the eCommerce solution for Umbraco
---
## ICountryService

Defines the Vendr Country service

```csharp
public interface ICountryService : ICachedEntityService<CountryReadOnly>, 
    ICachedEntityService<RegionReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](../icachedentityservice-1/)
* interface [IService](../iservice/)

**Namespace**
* [Vendr.Core.Services](../)

### Methods

#### CountryExists

Check to see if a [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) exists in the given [`Store`](../../vendr-core-models/store/) with the given ISO Code

```csharp
public bool CountryExists(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entity belongs to |
| code | The ISO Code of the [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entity to check |

**Returns**

Returns `true` if the [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) exists, otherwise returns `false`.


---

#### CreateAllCountryRegions

Creates all [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) and [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities for a store based on IS03166 country list

```csharp
public void CreateAllCountryRegions(Guid storeId, Guid defaultCurrencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity belongs to |
| defaultCurrencyId | The ID of the [`CurrencyReadOnly`](../../vendr-core-models/currencyreadonly/) to use as the default currency |


---

#### DeleteCountry (1 of 2)

Deletes a [`Country`](../../vendr-core-models/country/)

```csharp
public void DeleteCountry(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`Country`](../../vendr-core-models/country/) to delete |

---

#### DeleteCountry (2 of 2)

Deletes a [`Country`](../../vendr-core-models/country/)

```csharp
public void DeleteCountry(Country entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Country`](../../vendr-core-models/country/) to delete |


---

#### DeleteRegion (1 of 2)

Deletes a [`Region`](../../vendr-core-models/region/)

```csharp
public void DeleteRegion(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`Region`](../../vendr-core-models/region/) to delete |

---

#### DeleteRegion (2 of 2)

Deletes a [`Region`](../../vendr-core-models/region/)

```csharp
public void DeleteRegion(Region entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Region`](../../vendr-core-models/region/) to delete |


---

#### GetCountries (1 of 2)

Get a list of all [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<CountryReadOnly> GetCountries(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entities belong to |

**Returns**

A list of [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entities

---

#### GetCountries (2 of 2)

Get a list of [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entities with the given IDs

```csharp
public IEnumerable<CountryReadOnly> GetCountries(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entities to fetch |

**Returns**

A list of [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entities


---

#### GetCountry (1 of 2)

Get a [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entity by ID

```csharp
public CountryReadOnly GetCountry(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entity to fetch |

**Returns**

A [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entity

---

#### GetCountry (2 of 2)

Get a [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entity by [`Store`](../../vendr-core-models/store/) and ISO Code

```csharp
public CountryReadOnly GetCountry(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entity belongs to |
| code | The ISO Code of the [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entity to fetch |

**Returns**

A [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) entity


---

#### GetIso3166CountryRegions

Get a list of [`Iso3166Country`](../../vendr-core-models/iso3166country/) entities

```csharp
public IEnumerable<Iso3166Country> GetIso3166CountryRegions()
```

**Returns**

A list of [`Iso3166Country`](../../vendr-core-models/iso3166country/) entities


---

#### GetRegion (1 of 2)

Get a [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity by ID

```csharp
public RegionReadOnly GetRegion(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity to fetch |

**Returns**

A [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity

---

#### GetRegion (2 of 2)

Get a [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity by [`Store`](../../vendr-core-models/store/) and Code

```csharp
public RegionReadOnly GetRegion(Guid storeId, Guid countryId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity belongs to |
| countryId | The ID of the [`Country`](../../vendr-core-models/country/) the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity belongs to |
| code | The Code of the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity to fetch |

**Returns**

A [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity


---

#### GetRegions (1 of 3)

Get a list of all [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<RegionReadOnly> GetRegions(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities belong to |

**Returns**

A list of [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities

---

#### GetRegions (2 of 3)

Get a list of [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities with the given IDs

```csharp
public IEnumerable<RegionReadOnly> GetRegions(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities to fetch |

**Returns**

A list of [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities

---

#### GetRegions (3 of 3)

Get a list of all [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities from the given [`Store`](../../vendr-core-models/store/) and [`Country`](../../vendr-core-models/country/)

```csharp
public IEnumerable<RegionReadOnly> GetRegions(Guid storeId, Guid countryId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities belong to |
| countryId | The ID of the [`Country`](../../vendr-core-models/country/) the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities belong to |

**Returns**

A list of [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entities


---

#### RegionExists

Check to see if a [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) exists in the given [`Store`](../../vendr-core-models/store/) / [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) with the given Code

```csharp
public bool RegionExists(Guid storeId, Guid countryId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity belongs to |
| countryId | The ID of the [`CountryReadOnly`](../../vendr-core-models/countryreadonly/) the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity belongs to |
| code | The Code of the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) entity to check |

**Returns**

Returns `true` if the [`RegionReadOnly`](../../vendr-core-models/regionreadonly/) exists, otherwise returns `false`.


---

#### SaveCountry

Saves a [`Country`](../../vendr-core-models/country/)

```csharp
public void SaveCountry(Country entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Country`](../../vendr-core-models/country/) to save |


---

#### SaveRegion

Saves a [`Region`](../../vendr-core-models/region/)

```csharp
public void SaveRegion(Region entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Region`](../../vendr-core-models/region/) to save |


---

#### SortCountries

Sorts a list of [`Country`](../../vendr-core-models/country/) entities by ID according to the order of those IDs

```csharp
public void SortCountries(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`Country`](../../vendr-core-models/country/) entities to sort, in the order by which to sort them |


---

#### SortRegions

Sorts a list of [`Region`](../../vendr-core-models/region/) entities by ID according to the order of those IDs

```csharp
public void SortRegions(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`Region`](../../vendr-core-models/region/) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
