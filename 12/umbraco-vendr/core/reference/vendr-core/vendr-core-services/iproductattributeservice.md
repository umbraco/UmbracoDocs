---
title: IProductAttributeService
description: API reference for IProductAttributeService in Vendr, the eCommerce solution for Umbraco
---
## IProductAttributeService

Defines the Vendr Order Status service

```csharp
public interface IProductAttributeService : ICachedEntityService<ProductAttributePresetReadOnly>, 
    ICachedEntityService<ProductAttributeReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](../icachedentityservice-1/)
* interface [IService](../iservice/)

**Namespace**
* [Vendr.Core.Services](../)

### Methods

#### DeleteProductAttribute (1 of 2)

Deletes a [`ProductAttribute`](../../vendr-core-models/productattribute/)

```csharp
public void DeleteProductAttribute(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ProductAttribute`](../../vendr-core-models/productattribute/) to delete |

---

#### DeleteProductAttribute (2 of 2)

Deletes a [`ProductAttribute`](../../vendr-core-models/productattribute/)

```csharp
public void DeleteProductAttribute(ProductAttribute entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ProductAttribute`](../../vendr-core-models/productattribute/) to delete |


---

#### DeleteProductAttributePreset (1 of 2)

Deletes a [`ProductAttributePreset`](../../vendr-core-models/productattributepreset/)

```csharp
public void DeleteProductAttributePreset(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ProductAttributePreset`](../../vendr-core-models/productattributepreset/) to delete |

---

#### DeleteProductAttributePreset (2 of 2)

Deletes a [`ProductAttributePreset`](../../vendr-core-models/productattributepreset/)

```csharp
public void DeleteProductAttributePreset(ProductAttributePreset entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ProductAttributePreset`](../../vendr-core-models/productattributepreset/) to delete |


---

#### GetProductAttribute (1 of 2)

Get a [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entity by ID

```csharp
public ProductAttributeReadOnly GetProductAttribute(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entity to fetch |

**Returns**

A [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entity

---

#### GetProductAttribute (2 of 2)

Get a [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entity by [`Store`](../../vendr-core-models/store/) and Alias

```csharp
public ProductAttributeReadOnly GetProductAttribute(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entity belongs to |
| alias | The Alias of the [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entity to fetch |

**Returns**

A [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entity


---

#### GetProductAttributePreset (1 of 2)

Get a [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entity by ID

```csharp
public ProductAttributePresetReadOnly GetProductAttributePreset(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entity to fetch |

**Returns**

A [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entity

---

#### GetProductAttributePreset (2 of 2)

Get a [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entity by [`Store`](../../vendr-core-models/store/) and Alias

```csharp
public ProductAttributePresetReadOnly GetProductAttributePreset(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entity belongs to |
| alias | The Alias of the [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entity to fetch |

**Returns**

A [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entity


---

#### GetProductAttributePresets (1 of 2)

Get a list of all [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<ProductAttributePresetReadOnly> GetProductAttributePresets(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entities belong to |

**Returns**

A list of [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entities

---

#### GetProductAttributePresets (2 of 2)

Get a list of [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entities with the given IDs

```csharp
public IEnumerable<ProductAttributePresetReadOnly> GetProductAttributePresets(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entities to fetch |

**Returns**

A list of [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entities


---

#### GetProductAttributes (1 of 2)

Get a list of all [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<ProductAttributeReadOnly> GetProductAttributes(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entities belong to |

**Returns**

A list of [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entities

---

#### GetProductAttributes (2 of 2)

Get a list of [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entities with the given IDs

```csharp
public IEnumerable<ProductAttributeReadOnly> GetProductAttributes(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entities to fetch |

**Returns**

A list of [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entities


---

#### ProductAttributeExists

Check to see if a [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) exists in the given [`Store`](../../vendr-core-models/store/) with the given Alias

```csharp
public bool ProductAttributeExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entity belongs to |
| alias | The Alias of the [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) entity to check |

**Returns**

Returns `true` if the [`ProductAttributeReadOnly`](../../vendr-core-models/productattributereadonly/) exists, otherwise returns `false`.


---

#### ProductAttributePresetExists

Check to see if a [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) exists in the given [`Store`](../../vendr-core-models/store/) with the given Alias

```csharp
public bool ProductAttributePresetExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entity belongs to |
| alias | The Alias of the [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) entity to check |

**Returns**

Returns `true` if the [`ProductAttributePresetReadOnly`](../../vendr-core-models/productattributepresetreadonly/) exists, otherwise returns `false`.


---

#### SaveProductAttribute

Saves a [`ProductAttribute`](../../vendr-core-models/productattribute/)

```csharp
public void SaveProductAttribute(ProductAttribute entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ProductAttribute`](../../vendr-core-models/productattribute/) to save |


---

#### SaveProductAttributePreset

Saves a [`ProductAttributePreset`](../../vendr-core-models/productattributepreset/)

```csharp
public void SaveProductAttributePreset(ProductAttributePreset entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ProductAttributePreset`](../../vendr-core-models/productattributepreset/) to save |


---

#### SortProductAttributePresets

Sorts a list of [`ProductAttributePreset`](../../vendr-core-models/productattributepreset/) entities by ID according to the order of those IDs

```csharp
public void SortProductAttributePresets(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`ProductAttributePreset`](../../vendr-core-models/productattributepreset/) entities to sort, in the order by which to sort them |


---

#### SortProductAttributes

Sorts a list of [`ProductAttribute`](../../vendr-core-models/productattribute/) entities by ID according to the order of those IDs

```csharp
public void SortProductAttributes(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`ProductAttribute`](../../vendr-core-models/productattribute/) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
