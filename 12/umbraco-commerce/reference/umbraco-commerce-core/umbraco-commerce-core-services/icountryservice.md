---
title: ICountryService
description: API reference for ICountryService in Umbraco Commerce
---
## ICountryService

Defines the Country service

```csharp
public interface ICountryService : ICachedEntityService<CountryReadOnly>, 
    ICachedEntityService<RegionReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### CountryExists

Check to see if a [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given ISO Code

```csharp
public bool CountryExists(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entity belongs to |
| code | The ISO Code of the [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entity to check |

**Returns**

Returns `true` if the [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) exists, otherwise returns `false`.


---

#### CreateAllCountryRegions

Creates all [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) and [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities for a store based on IS03166 country list

```csharp
public void CreateAllCountryRegions(Guid storeId, Guid defaultCurrencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity belongs to |
| defaultCurrencyId | The ID of the [`CurrencyReadOnly`](../umbraco-commerce-core-models/currencyreadonly.md) to use as the default currency |


---

#### DeleteCountry (1 of 2)

Deletes a [`Country`](../umbraco-commerce-core-models/country.md)

```csharp
public void DeleteCountry(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`Country`](../umbraco-commerce-core-models/country.md) to delete |

---

#### DeleteCountry (2 of 2)

Deletes a [`Country`](../umbraco-commerce-core-models/country.md)

```csharp
public void DeleteCountry(Country entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Country`](../umbraco-commerce-core-models/country.md) to delete |


---

#### DeleteRegion (1 of 2)

Deletes a [`Region`](../umbraco-commerce-core-models/region.md)

```csharp
public void DeleteRegion(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`Region`](../umbraco-commerce-core-models/region.md) to delete |

---

#### DeleteRegion (2 of 2)

Deletes a [`Region`](../umbraco-commerce-core-models/region.md)

```csharp
public void DeleteRegion(Region entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Region`](../umbraco-commerce-core-models/region.md) to delete |


---

#### GetCountries (1 of 2)

Get a list of all [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<CountryReadOnly> GetCountries(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entities belong to |

**Returns**

A list of [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entities

---

#### GetCountries (2 of 2)

Get a list of [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entities with the given IDs

```csharp
public IEnumerable<CountryReadOnly> GetCountries(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entities to fetch |

**Returns**

A list of [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entities


---

#### GetCountry (1 of 2)

Get a [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entity by ID

```csharp
public CountryReadOnly GetCountry(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entity to fetch |

**Returns**

A [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entity

---

#### GetCountry (2 of 2)

Get a [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and ISO Code

```csharp
public CountryReadOnly GetCountry(Guid storeId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entity belongs to |
| code | The ISO Code of the [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entity to fetch |

**Returns**

A [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) entity


---

#### GetIso3166CountryRegions

Get a list of [`Iso3166Country`](../umbraco-commerce-core-models/iso3166country.md) entities

```csharp
public IEnumerable<Iso3166Country> GetIso3166CountryRegions()
```

**Returns**

A list of [`Iso3166Country`](../umbraco-commerce-core-models/iso3166country.md) entities


---

#### GetRegion (1 of 2)

Get a [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity by ID

```csharp
public RegionReadOnly GetRegion(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity to fetch |

**Returns**

A [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity

---

#### GetRegion (2 of 2)

Get a [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Code

```csharp
public RegionReadOnly GetRegion(Guid storeId, Guid countryId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity belongs to |
| countryId | The ID of the [`Country`](../umbraco-commerce-core-models/country.md) the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity belongs to |
| code | The Code of the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity to fetch |

**Returns**

A [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity


---

#### GetRegions (1 of 3)

Get a list of all [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<RegionReadOnly> GetRegions(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities belong to |

**Returns**

A list of [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities

---

#### GetRegions (2 of 3)

Get a list of [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities with the given IDs

```csharp
public IEnumerable<RegionReadOnly> GetRegions(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities to fetch |

**Returns**

A list of [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities

---

#### GetRegions (3 of 3)

Get a list of all [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md) and [`Country`](../umbraco-commerce-core-models/country.md)

```csharp
public IEnumerable<RegionReadOnly> GetRegions(Guid storeId, Guid countryId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities belong to |
| countryId | The ID of the [`Country`](../umbraco-commerce-core-models/country.md) the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities belong to |

**Returns**

A list of [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entities


---

#### RegionExists

Check to see if a [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) / [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) with the given Code

```csharp
public bool RegionExists(Guid storeId, Guid countryId, string code)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity belongs to |
| countryId | The ID of the [`CountryReadOnly`](../umbraco-commerce-core-models/countryreadonly.md) the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity belongs to |
| code | The Code of the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) entity to check |

**Returns**

Returns `true` if the [`RegionReadOnly`](../umbraco-commerce-core-models/regionreadonly.md) exists, otherwise returns `false`.


---

#### SaveCountry

Saves a [`Country`](../umbraco-commerce-core-models/country.md)

```csharp
public void SaveCountry(Country entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Country`](../umbraco-commerce-core-models/country.md) to save |


---

#### SaveRegion

Saves a [`Region`](../umbraco-commerce-core-models/region.md)

```csharp
public void SaveRegion(Region entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`Region`](../umbraco-commerce-core-models/region.md) to save |


---

#### SortCountries

Sorts a list of [`Country`](../umbraco-commerce-core-models/country.md) entities by ID according to the order of those IDs

```csharp
public void SortCountries(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`Country`](../umbraco-commerce-core-models/country.md) entities to sort, in the order by which to sort them |


---

#### SortRegions

Sorts a list of [`Region`](../umbraco-commerce-core-models/region.md) entities by ID according to the order of those IDs

```csharp
public void SortRegions(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`Region`](../umbraco-commerce-core-models/region.md) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
