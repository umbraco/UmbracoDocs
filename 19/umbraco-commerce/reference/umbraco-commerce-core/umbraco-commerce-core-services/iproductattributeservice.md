---
title: IProductAttributeService
description: API reference for IProductAttributeService in Umbraco Commerce
---
## IProductAttributeService

Defines the Order Status service

```csharp
public interface IProductAttributeService : ICachedEntityService<ProductAttributePresetReadOnly>, 
    ICachedEntityService<ProductAttributeReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### DeleteProductAttribute (1 of 2)

Deletes a [`ProductAttribute`](../umbraco-commerce-core-models/productattribute.md)

```csharp
public void DeleteProductAttribute(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ProductAttribute`](../umbraco-commerce-core-models/productattribute.md) to delete |

---

#### DeleteProductAttribute (2 of 2)

Deletes a [`ProductAttribute`](../umbraco-commerce-core-models/productattribute.md)

```csharp
public void DeleteProductAttribute(ProductAttribute entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ProductAttribute`](../umbraco-commerce-core-models/productattribute.md) to delete |


---

#### DeleteProductAttributePreset (1 of 2)

Deletes a [`ProductAttributePreset`](../umbraco-commerce-core-models/productattributepreset.md)

```csharp
public void DeleteProductAttributePreset(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ProductAttributePreset`](../umbraco-commerce-core-models/productattributepreset.md) to delete |

---

#### DeleteProductAttributePreset (2 of 2)

Deletes a [`ProductAttributePreset`](../umbraco-commerce-core-models/productattributepreset.md)

```csharp
public void DeleteProductAttributePreset(ProductAttributePreset entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ProductAttributePreset`](../umbraco-commerce-core-models/productattributepreset.md) to delete |


---

#### GetProductAttribute (1 of 2)

Get a [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entity by ID

```csharp
public ProductAttributeReadOnly GetProductAttribute(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entity to fetch |

**Returns**

A [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entity

---

#### GetProductAttribute (2 of 2)

Get a [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Alias

```csharp
public ProductAttributeReadOnly GetProductAttribute(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entity belongs to |
| alias | The Alias of the [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entity to fetch |

**Returns**

A [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entity


---

#### GetProductAttributePreset (1 of 2)

Get a [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entity by ID

```csharp
public ProductAttributePresetReadOnly GetProductAttributePreset(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entity to fetch |

**Returns**

A [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entity

---

#### GetProductAttributePreset (2 of 2)

Get a [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Alias

```csharp
public ProductAttributePresetReadOnly GetProductAttributePreset(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entity belongs to |
| alias | The Alias of the [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entity to fetch |

**Returns**

A [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entity


---

#### GetProductAttributePresets (1 of 2)

Get a list of all [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<ProductAttributePresetReadOnly> GetProductAttributePresets(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entities belong to |

**Returns**

A list of [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entities

---

#### GetProductAttributePresets (2 of 2)

Get a list of [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entities with the given IDs

```csharp
public IEnumerable<ProductAttributePresetReadOnly> GetProductAttributePresets(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entities to fetch |

**Returns**

A list of [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entities


---

#### GetProductAttributes (1 of 2)

Get a list of all [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<ProductAttributeReadOnly> GetProductAttributes(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entities belong to |

**Returns**

A list of [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entities

---

#### GetProductAttributes (2 of 2)

Get a list of [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entities with the given IDs

```csharp
public IEnumerable<ProductAttributeReadOnly> GetProductAttributes(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entities to fetch |

**Returns**

A list of [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entities


---

#### ProductAttributeExists

Check to see if a [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given Alias

```csharp
public bool ProductAttributeExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entity belongs to |
| alias | The Alias of the [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) entity to check |

**Returns**

Returns `true` if the [`ProductAttributeReadOnly`](../umbraco-commerce-core-models/productattributereadonly.md) exists, otherwise returns `false`.


---

#### ProductAttributePresetExists

Check to see if a [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given Alias

```csharp
public bool ProductAttributePresetExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entity belongs to |
| alias | The Alias of the [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) entity to check |

**Returns**

Returns `true` if the [`ProductAttributePresetReadOnly`](../umbraco-commerce-core-models/productattributepresetreadonly.md) exists, otherwise returns `false`.


---

#### SaveProductAttribute

Saves a [`ProductAttribute`](../umbraco-commerce-core-models/productattribute.md)

```csharp
public void SaveProductAttribute(ProductAttribute entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ProductAttribute`](../umbraco-commerce-core-models/productattribute.md) to save |


---

#### SaveProductAttributePreset

Saves a [`ProductAttributePreset`](../umbraco-commerce-core-models/productattributepreset.md)

```csharp
public void SaveProductAttributePreset(ProductAttributePreset entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ProductAttributePreset`](../umbraco-commerce-core-models/productattributepreset.md) to save |


---

#### SortProductAttributePresets

Sorts a list of [`ProductAttributePreset`](../umbraco-commerce-core-models/productattributepreset.md) entities by ID according to the order of those IDs

```csharp
public void SortProductAttributePresets(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`ProductAttributePreset`](../umbraco-commerce-core-models/productattributepreset.md) entities to sort, in the order by which to sort them |


---

#### SortProductAttributes

Sorts a list of [`ProductAttribute`](../umbraco-commerce-core-models/productattribute.md) entities by ID according to the order of those IDs

```csharp
public void SortProductAttributes(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`ProductAttribute`](../umbraco-commerce-core-models/productattribute.md) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
