---
title: IExportTemplateService
description: API reference for IExportTemplateService in Umbraco Commerce
---
## IExportTemplateService

Defines the Export Template service

```csharp
public interface IExportTemplateService : ICachedEntityService<ExportTemplateReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### DeleteExportTemplate (1 of 2)

Deletes a [`ExportTemplate`](../umbraco-commerce-core-models/exporttemplate.md)

```csharp
public void DeleteExportTemplate(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ExportTemplate`](../umbraco-commerce-core-models/exporttemplate.md) to delete |

---

#### DeleteExportTemplate (2 of 2)

Deletes a [`ExportTemplate`](../umbraco-commerce-core-models/exporttemplate.md)

```csharp
public void DeleteExportTemplate(ExportTemplate entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ExportTemplate`](../umbraco-commerce-core-models/exporttemplate.md) to delete |


---

#### ExportTemplateExists

Check to see if a [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given Alias

```csharp
public bool ExportTemplateExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entity belongs to |
| alias | The Alias of the [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entity to check |

**Returns**

Returns `true` if the [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) exists, otherwise returns `false`.


---

#### GetExportTemplate (1 of 2)

Get a [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entity by ID

```csharp
public ExportTemplateReadOnly GetExportTemplate(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entity to fetch |

**Returns**

A [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entity

---

#### GetExportTemplate (2 of 2)

Get a [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Alias

```csharp
public ExportTemplateReadOnly GetExportTemplate(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entity belongs to |
| alias | The Alias of the [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entity to fetch |

**Returns**

A [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entity


---

#### GetExportTemplates (1 of 2)

Get a list of all [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<ExportTemplateReadOnly> GetExportTemplates(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entities belong to |

**Returns**

A list of [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entities

---

#### GetExportTemplates (2 of 2)

Get a list of [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entities with the given IDs

```csharp
public IEnumerable<ExportTemplateReadOnly> GetExportTemplates(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entities to fetch |

**Returns**

A list of [`ExportTemplateReadOnly`](../umbraco-commerce-core-models/exporttemplatereadonly.md) entities


---

#### SaveExportTemplate

Saves a [`ExportTemplate`](../umbraco-commerce-core-models/exporttemplate.md)

```csharp
public void SaveExportTemplate(ExportTemplate entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ExportTemplate`](../umbraco-commerce-core-models/exporttemplate.md) to save |


---

#### SortExportTemplates

Sorts a list of [`ExportTemplate`](../umbraco-commerce-core-models/exporttemplate.md) entities by ID according to the order of those IDs

```csharp
public void SortExportTemplates(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`ExportTemplate`](../umbraco-commerce-core-models/exporttemplate.md) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
