---
title: IPrintTemplateService
description: API reference for IPrintTemplateService in Umbraco Commerce
---
## IPrintTemplateService

Defines the Print Template service

```csharp
public interface IPrintTemplateService : ICachedEntityService<PrintTemplateReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### DeletePrintTemplate (1 of 2)

Deletes a [`PrintTemplate`](../umbraco-commerce-core-models/printtemplate.md)

```csharp
public void DeletePrintTemplate(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`PrintTemplate`](../umbraco-commerce-core-models/printtemplate.md) to delete |

---

#### DeletePrintTemplate (2 of 2)

Deletes a [`PrintTemplate`](../umbraco-commerce-core-models/printtemplate.md)

```csharp
public void DeletePrintTemplate(PrintTemplate entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`PrintTemplate`](../umbraco-commerce-core-models/printtemplate.md) to delete |


---

#### GetPrintTemplate (1 of 2)

Get a [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entity by ID

```csharp
public PrintTemplateReadOnly GetPrintTemplate(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entity to fetch |

**Returns**

A [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entity

---

#### GetPrintTemplate (2 of 2)

Get a [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Alias

```csharp
public PrintTemplateReadOnly GetPrintTemplate(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entity belongs to |
| alias | The Alias of the [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entity to fetch |

**Returns**

A [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entity


---

#### GetPrintTemplates (1 of 2)

Get a list of all [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<PrintTemplateReadOnly> GetPrintTemplates(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entities belong to |

**Returns**

A list of [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entities

---

#### GetPrintTemplates (2 of 2)

Get a list of [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entities with the given IDs

```csharp
public IEnumerable<PrintTemplateReadOnly> GetPrintTemplates(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entities to fetch |

**Returns**

A list of [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entities


---

#### PrintTemplateExists

Check to see if a [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given Alias

```csharp
public bool PrintTemplateExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entity belongs to |
| alias | The Alias of the [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) entity to check |

**Returns**

Returns `true` if the [`PrintTemplateReadOnly`](../umbraco-commerce-core-models/printtemplatereadonly.md) exists, otherwise returns `false`.


---

#### SavePrintTemplate

Saves a [`PrintTemplate`](../umbraco-commerce-core-models/printtemplate.md)

```csharp
public void SavePrintTemplate(PrintTemplate entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`PrintTemplate`](../umbraco-commerce-core-models/printtemplate.md) to save |


---

#### SortPrintTemplates

Sorts a list of [`PrintTemplate`](../umbraco-commerce-core-models/printtemplate.md) entities by ID according to the order of those IDs

```csharp
public void SortPrintTemplates(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`PrintTemplate`](../umbraco-commerce-core-models/printtemplate.md) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
