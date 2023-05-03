---
title: IExportTemplateService
description: API reference for IExportTemplateService in Vendr, the eCommerce solution for Umbraco
---
## IExportTemplateService

Defines the Vendr Export Template service

```csharp
public interface IExportTemplateService : ICachedEntityService<ExportTemplateReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](../icachedentityservice-1/)
* interface [IService](../iservice/)

**Namespace**
* [Vendr.Core.Services](../)

### Methods

#### DeleteExportTemplate (1 of 2)

Deletes a [`ExportTemplate`](../../vendr-core-models/exporttemplate/)

```csharp
public void DeleteExportTemplate(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ExportTemplate`](../../vendr-core-models/exporttemplate/) to delete |

---

#### DeleteExportTemplate (2 of 2)

Deletes a [`ExportTemplate`](../../vendr-core-models/exporttemplate/)

```csharp
public void DeleteExportTemplate(ExportTemplate entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ExportTemplate`](../../vendr-core-models/exporttemplate/) to delete |


---

#### ExportTemplateExists

Check to see if a [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) exists in the given [`Store`](../../vendr-core-models/store/) with the given Alias

```csharp
public bool ExportTemplateExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entity belongs to |
| alias | The Alias of the [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entity to check |

**Returns**

Returns `true` if the [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) exists, otherwise returns `false`.


---

#### GetExportTemplate (1 of 2)

Get a [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entity by ID

```csharp
public ExportTemplateReadOnly GetExportTemplate(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entity to fetch |

**Returns**

A [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entity

---

#### GetExportTemplate (2 of 2)

Get a [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entity by [`Store`](../../vendr-core-models/store/) and Alias

```csharp
public ExportTemplateReadOnly GetExportTemplate(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entity belongs to |
| alias | The Alias of the [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entity to fetch |

**Returns**

A [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entity


---

#### GetExportTemplates (1 of 2)

Get a list of all [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<ExportTemplateReadOnly> GetExportTemplates(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entities belong to |

**Returns**

A list of [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entities

---

#### GetExportTemplates (2 of 2)

Get a list of [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entities with the given IDs

```csharp
public IEnumerable<ExportTemplateReadOnly> GetExportTemplates(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entities to fetch |

**Returns**

A list of [`ExportTemplateReadOnly`](../../vendr-core-models/exporttemplatereadonly/) entities


---

#### SaveExportTemplate

Saves a [`ExportTemplate`](../../vendr-core-models/exporttemplate/)

```csharp
public void SaveExportTemplate(ExportTemplate entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`ExportTemplate`](../../vendr-core-models/exporttemplate/) to save |


---

#### SortExportTemplates

Sorts a list of [`ExportTemplate`](../../vendr-core-models/exporttemplate/) entities by ID according to the order of those IDs

```csharp
public void SortExportTemplates(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`ExportTemplate`](../../vendr-core-models/exporttemplate/) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
