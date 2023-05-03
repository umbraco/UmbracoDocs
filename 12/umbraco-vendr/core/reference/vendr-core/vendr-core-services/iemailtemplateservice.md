---
title: IEmailTemplateService
description: API reference for IEmailTemplateService in Vendr, the eCommerce solution for Umbraco
---
## IEmailTemplateService

Defines the Vendr Email Template service

```csharp
public interface IEmailTemplateService : ICachedEntityService<EmailTemplateReadOnly>, IService
```

**Inheritance**

* interface [ICachedEntityService&lt;TEntityType&gt;](../icachedentityservice-1/)
* interface [IService](../iservice/)

**Namespace**
* [Vendr.Core.Services](../)

### Methods

#### DeleteEmailTemplate (1 of 2)

Deletes a [`EmailTemplate`](../../vendr-core-models/emailtemplate/)

```csharp
public void DeleteEmailTemplate(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`EmailTemplate`](../../vendr-core-models/emailtemplate/) to delete |

---

#### DeleteEmailTemplate (2 of 2)

Deletes a [`EmailTemplate`](../../vendr-core-models/emailtemplate/)

```csharp
public void DeleteEmailTemplate(EmailTemplate entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`EmailTemplate`](../../vendr-core-models/emailtemplate/) to delete |


---

#### EmailTemplateExists

Check to see if a [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) exists in the given [`Store`](../../vendr-core-models/store/) with the given Alias

```csharp
public bool EmailTemplateExists(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entity belongs to |
| alias | The Alias of the [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entity to check |

**Returns**

Returns `true` if the [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) exists, otherwise returns `false`.


---

#### GetEmailTemplate (1 of 2)

Get a [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entity by ID

```csharp
public EmailTemplateReadOnly GetEmailTemplate(Guid id)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| id | The ID of the [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entity to fetch |

**Returns**

A [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entity

---

#### GetEmailTemplate (2 of 2)

Get a [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entity by [`Store`](../../vendr-core-models/store/) and Alias

```csharp
public EmailTemplateReadOnly GetEmailTemplate(Guid storeId, string alias)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entity belongs to |
| alias | The Alias of the [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entity to fetch |

**Returns**

A [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entity


---

#### GetEmailTemplates (1 of 2)

Get a list of all [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entities from the given [`Store`](../../vendr-core-models/store/)

```csharp
public IEnumerable<EmailTemplateReadOnly> GetEmailTemplates(Guid storeId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entities belong to |

**Returns**

A list of [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entities

---

#### GetEmailTemplates (2 of 2)

Get a list of [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entities with the given IDs

```csharp
public IEnumerable<EmailTemplateReadOnly> GetEmailTemplates(Guid[] ids)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| ids | The IDs of the [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entities to fetch |

**Returns**

A list of [`EmailTemplateReadOnly`](../../vendr-core-models/emailtemplatereadonly/) entities


---

#### SaveEmailTemplate

Saves a [`EmailTemplate`](../../vendr-core-models/emailtemplate/)

```csharp
public void SaveEmailTemplate(EmailTemplate entity)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| entity | The [`EmailTemplate`](../../vendr-core-models/emailtemplate/) to save |


---

#### SendEmail

Sends an email using the given [`EmailTemplate`](../../vendr-core-models/emailtemplate/) to an [`Order`](../../vendr-core-models/order/) customer using the [`Order`](../../vendr-core-models/order/) as the [`EmailTemplate`](../../vendr-core-models/emailtemplate/) model

```csharp
public bool SendEmail(EmailTemplateReadOnly emailTemplate, OrderReadOnly order)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| emailTemplate | The [`EmailTemplate`](../../vendr-core-models/emailtemplate/) to send |
| order | The [`Order`](../../vendr-core-models/order/) to use as the [`EmailTemplate`](../../vendr-core-models/emailtemplate/) model and from which to access the Customer email address to send the email to |

**Returns**

Returns `true` if the send was successful, otherwise returns `false`.


---

#### SendEmail&lt;TModel&gt;

Sends an email using the given [`EmailTemplate`](../../vendr-core-models/emailtemplate/) to the given email address, using the given model

```csharp
public bool SendEmail<TModel>(EmailTemplateReadOnly emailTemplate, TModel model, 
    string toEmailAddress, string languageIsoCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| TModel | The Type of the model for the [`EmailTemplate`](../../vendr-core-models/emailtemplate/) |
| emailTemplate | The [`EmailTemplate`](../../vendr-core-models/emailtemplate/) to send |
| model | The model instance for the [`EmailTemplate`](../../vendr-core-models/emailtemplate/) |
| toEmailAddress | The email address to send the email to |
| languageIsoCode | The ISO Code of the language to send the email in |

**Returns**

Returns `true` if the send was successful, otherwise returns `false`.


---

#### SortEmailTemplates

Sorts a list of [`EmailTemplate`](../../vendr-core-models/emailtemplate/) entities by ID according to the order of those IDs

```csharp
public void SortEmailTemplates(Guid[] sortedIds)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| sortedIds | The IDs of the [`EmailTemplate`](../../vendr-core-models/emailtemplate/) entities to sort, in the order by which to sort them |


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
