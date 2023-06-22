---
title: IEmailTemplateService
description: API reference for IEmailTemplateService in Umbraco Commerce
---
## IEmailTemplateService

Defines the Email Template service

```csharp
public interface IEmailTemplateService : ICachedEntityService<EmailTemplateReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](icachedentityservice-1.md)
* interface [IService](iservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### DeleteEmailTemplate (1 of 2)

Deletes a [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md)

```csharp
public void DeleteEmailTemplate(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) to delete |

---

#### DeleteEmailTemplate (2 of 2)

Deletes a [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md)

```csharp
public void DeleteEmailTemplate(EmailTemplate entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) to delete |


---

#### EmailTemplateExists

Check to see if a [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) exists in the given [`Store`](../umbraco-commerce-core-models/store.md) with the given Alias

```csharp
public bool EmailTemplateExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entity belongs to |
| alias | The Alias of the [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entity to check |

**Returns**

Returns `true` if the [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) exists, otherwise returns `false`.


---

#### GetEmailTemplate (1 of 2)

Get a [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entity by ID

```csharp
public EmailTemplateReadOnly GetEmailTemplate(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entity to fetch |

**Returns**

A [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entity

---

#### GetEmailTemplate (2 of 2)

Get a [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entity by [`Store`](../umbraco-commerce-core-models/store.md) and Alias

```csharp
public EmailTemplateReadOnly GetEmailTemplate(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entity belongs to |
| alias | The Alias of the [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entity to fetch |

**Returns**

A [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entity


---

#### GetEmailTemplates (1 of 2)

Get a list of all [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entities from the given [`Store`](../umbraco-commerce-core-models/store.md)

```csharp
public IEnumerable<EmailTemplateReadOnly> GetEmailTemplates(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entities belong to |

**Returns**

A list of [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entities

---

#### GetEmailTemplates (2 of 2)

Get a list of [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entities with the given IDs

```csharp
public IEnumerable<EmailTemplateReadOnly> GetEmailTemplates(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entities to fetch |

**Returns**

A list of [`EmailTemplateReadOnly`](../umbraco-commerce-core-models/emailtemplatereadonly.md) entities


---

#### SaveEmailTemplate

Saves a [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md)

```csharp
public void SaveEmailTemplate(EmailTemplate entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) to save |


---

#### SendEmail

Sends an email using the given [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) to an [`Order`](../umbraco-commerce-core-models/order.md) customer using the [`Order`](../umbraco-commerce-core-models/order.md) as the [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) model

```csharp
public bool SendEmail(EmailTemplateReadOnly emailTemplate, OrderReadOnly order)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| emailTemplate | The [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) to send |
| order | The [`Order`](../umbraco-commerce-core-models/order.md) to use as the [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) model and from which to access the Customer email address to send the email to |

**Returns**

Returns `true` if the send was successful, otherwise returns `false`.


---

#### SendEmail&lt;TModel&gt;

Sends an email using the given [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) to the given email address, using the given model

```csharp
public bool SendEmail<TModel>(EmailTemplateReadOnly emailTemplate, TModel model, 
    string toEmailAddress, string languageIsoCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| TModel | The Type of the model for the [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) |
| emailTemplate | The [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) to send |
| model | The model instance for the [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) |
| toEmailAddress | The email address to send the email to |
| languageIsoCode | The ISO Code of the language to send the email in |

**Returns**

Returns `true` if the send was successful, otherwise returns `false`.


---

#### SortEmailTemplates

Sorts a list of [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) entities by ID according to the order of those IDs

```csharp
public void SortEmailTemplates(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`EmailTemplate`](../umbraco-commerce-core-models/emailtemplate.md) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
